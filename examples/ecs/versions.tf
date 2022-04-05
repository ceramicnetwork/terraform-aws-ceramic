terraform {
  required_version = ">= 0.13, < 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.20.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.10.0"
    }
  }
}
