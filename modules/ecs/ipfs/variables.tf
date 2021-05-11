/* Given */

variable "acm_certificate_arn" {
  type        = string
  description = "ARN of AWS ACM certificate. Required if include_https_listeners is true."
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "az_count" {
  type        = number
  description = "Number of availability zones to use"
}

variable "namespace" {
  type        = string
  description = "Namespace for IPFS resources"
}

variable "base_tags" {
  type        = any
  description = "Tags to merge with local defaults"
}

variable "domain" {
  type        = string
  description = "Domain for certificate"
}

variable "ecs_count" {
  type        = number
  description = "Number of instances to run"
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name of IPFS cluster"
}

variable "ecs_cpu" {
  type        = number
  description = "Fargate vCPU threads allocated to the Ceramic gateway instance"
}

variable "ecs_log_group_name" {
  type        = string
  description = ""
}

variable "ecs_memory" {
  type        = number
  description = "Fargate memory allocated to the Ceramic gateway instance"
}

variable "ecs_service_name" {
  type        = string
  description = "Name of ECS service"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags"
  default = {
    Terraform = "true"
  }
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Ids for the VPC private subnets"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Ids for the VPC public subnets"
}

variable "use_ssl" {
  type        = bool
  description = "True if this module should use SSL. Parent must provide ACM certificate."
}

variable "vpc_cidr_block" {
  type        = string
  description = "Default CIDR block of the VPC"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "vpc_security_group_id" {
  type        = string
  description = "Id of VPC default security group"
}

/* Specified */

variable "enable_external_api" {
  type        = bool
  description = "True to enable IPFS API on external ALB"
}

variable "enable_external_gateway" {
  type        = bool
  description = "True to enable IPFS Gateway on external ALB"
}

variable "enable_internal_api" {
  type        = bool
  description = "True to enable IPFS API on internal ALB"
}

variable "enable_internal_gateway" {
  type        = bool
  description = "True to enable IPFS Gateway on internal ALB"
}

variable "enable_internal_swarm" {
  type        = bool
  description = "True to enable IPFS Swarm on internal ALB. Note: Swarm is always enabled for the external ALB."
}

variable "enable_pubsub" {
  type        = bool
  description = "True to enable IPFS PubSub"
}

variable "dht_server_mode" {
  type        = bool
  description = "True to enable DHT server mode to query and respond to queries"
}

variable "debug" {
  type        = string
  description = "IPFS debug env var"
}

variable "directory_namespace" {
  type        = string
  description = "Directory for logs and state"
  default     = ""
}

variable "image_tag" {
  type        = string
  description = "Image tag"
}
