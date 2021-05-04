# Ensure s3 and dynamodb tables are already created before apply
terraform {
  backend "s3" {
    bucket         = "ceramic-elp-tfm-state"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "ceramic-elp-tfm-state-locking"
  }
}
