terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.27"
    }
  }

  required_version = ">=0.14"
}

# Step 1 - Define the provider
provider "aws" {
  region = "us-east-1"
}

# Step 12 - Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Step 12 - Use remote state to retrieve the data
data "terraform_remote_state" "public_subnet" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "acs730-week3-gjpatel3"                  // Bucket from where to GET Terraform State
    key    = "assign2/prod/network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                              // Region where bucket created
  }
}

# Step 12 - Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Define tags locally
locals {
  default_tags = merge(var.default_tags, { "env" = var.env })
  name_prefix  = "${var.prefix}-${var.env}"

}

#Create a webserver1-2 also webserver1 is bastionhost for privat-subnet servers
resource "aws_instance" "acs730-webserver" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = lookup(var.instance_type, var.env)
  count         = length(data.terraform_remote_state.public_subnet.outputs.public_subnet_ids)
  key_name      = aws_key_pair.web_key.key_name
  subnet_id     = data.terraform_remote_state.public_subnet.outputs.public_subnet_ids[count.index]
  security_groups             = [aws_security_group.web_sg_public.id]
  associate_public_ip_address = true

  
  user_data = count.index < 2 ? templatefile("${path.module}/install_httpd.sh.tpl",
    {
      env    = upper(var.env),
      prefix = upper(var.prefix)
    }
  ) : ""


  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-Amazon-Linux-Webserver"
      "Role" = count.index < 2 ? "WebServerON" : "WebServerOFF"
    }
  )
}




# Creating servers in private subnets
resource "aws_instance" "acs730gp" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  count                       = length(data.terraform_remote_state.public_subnet.outputs.private_subnet_ids)
  key_name                    = aws_key_pair.web_key.key_name
  subnet_id                   = data.terraform_remote_state.public_subnet.outputs.private_subnet_ids[count.index]
  security_groups             = [aws_security_group.web_sg.id]
  associate_public_ip_address = false


  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-Amazon-Linux-Private"
    }
  )
}


# Security Group
resource "aws_security_group" "web_sg_public" {
  name        = "allow_http_ssh"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.public_subnet.outputs.vpc_id

  ingress {
    description      = "HTTP from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-SG-Public-nonprod"
    }
  )
}

# Security Group
resource "aws_security_group" "web_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.public_subnet.outputs.vpc_id

  ingress {
    from_port = "22"
    to_port   = "22"
    protocol  = "tcp"

    security_groups = [
      "${aws_security_group.web_sg_public.id}",
    ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-SG-Private-nonprod"
    }
  )

}


# Step 5 - Adding SSH key to Amazon EC2
resource "aws_key_pair" "web_key" {
  key_name   = var.prefix
  public_key = file("${var.prefix}.pub")
}