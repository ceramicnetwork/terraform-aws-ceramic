/* Given */

variable "acm_certificate_arn" {
  type        = string
  description = "ARN of AWS ACM certificate. Required if include_https_listeners is true."
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "base_namespace" {
  type        = string
  description = "Base namespace"
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
  type = string
}

variable "ecs_log_prefix" {
  type    = string
  default = "ipfs"
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

variable "namespace" {
  type        = string
  description = "Namespace for IPFS resources"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Ids for the VPC private subnets"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Ids for the VPC public subnets"
}

variable "s3_bucket_arn" {
  type        = string
  description = "ARN of S3 bucket to use as a backend"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name (aka id) of S3 bucket to use as a backend"
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

variable "efs_security_group_id" {
  type        = string
  description = "Id for EFS security group"
}

/* Specified */

variable "enable_alb_logging" {
  type        = bool
  description = "True to enable ALB logs (stored in a new S3 bucket)"
}

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

variable "enable_pubsub" {
  type        = bool
  description = "True to enable IPFS PubSub"
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

variable "use_s3_blockstore" {
  type        = bool
  description = "True for storing IPFS blocks in S3, false for storing them in an EFS volume"
}

variable "default_log_level" {
  type        = string
  description = "IPFS default log level"
  default     = "info"
}

variable "use_existing_peer_identity" {
  type        = string
  description = "Use existing IPFS peer identity"
  default     = false
}
