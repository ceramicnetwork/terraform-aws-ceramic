terraform {
  required_version = ">= 0.15.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.36.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.10.0"
    }
  }
}
