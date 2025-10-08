terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.15.0"
    }
  }
  backend "s3" {
    bucket = "nsinfotech-terraform-remote-state"
    key = "nsinfotech.tfstate"
    region = "us-east-2"
  }
}


provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      IAC = true
    }
  }
}
