provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "acs730-week3-gjpatel3"                                        // Bucket where to SAVE Terraform State
    key    = "assign2/prod/network/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                                    // Region where bucket is created
  }
}