terraform {
  required_version = ">= 0.13, < 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.10.0"
    }
  }
}
