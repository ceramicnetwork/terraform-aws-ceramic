terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.31.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.10.0"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}
