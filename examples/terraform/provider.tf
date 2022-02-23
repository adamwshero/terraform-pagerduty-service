terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    pagerduty = {
      source  = "PagerDuty/pagerduty"
      version = "1.9.6"
    }
  }
}

provider "pagerduty" {
  token = var.token
}

provider "aws" {
  region  = var.env["region"]
  profile = var.env["profile"]
}
