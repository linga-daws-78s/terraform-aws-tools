terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.48.0"
    }
  }

backend "s3" {
  bucket ="lingaiah-remote-state"
  key="jenkins"
  region="us-east-1"
  dynamodb_table="lingaiah-locking"
  }
}
#provide authentication here
provider "aws" {
  # Configuration options
  region = "us-east-1"
}

