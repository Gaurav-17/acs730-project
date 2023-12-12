terraform {
  backend "s3" {
    bucket = "acs730-proj-gjpatel4"                    // Bucket where to SAVE Terraform State
    key    = "assign2/prod/webserver/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                // Region where bucket is created
  }
}
