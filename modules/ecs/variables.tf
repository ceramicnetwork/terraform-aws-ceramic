/***** Common *****/

variable "acm_certificate_arn" {
  type        = string
  description = "ARN of ACM SSL certificate"
}

variable "aws_region" {
  type        = string
  description = "AWS region. Must match region of vpc_id and public_subnet_ids."
}

variable "base_namespace" {
  type        = string
  description = "Base namespace"
}

variable "default_tags" {
  type        = map(any)
  description = "Tags"
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name of ECS cluster"
}

variable "env" {
  type        = string
  description = "Environment name used for namespacing"
}

variable "image_tag" {
  type        = string
  description = "Image tag"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet ids for the VPC"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of ALB subnet ids"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of S3 bucket to use as a backend for Ceramic and IPFS"
}

variable "vpc_security_group_id" {
  type        = string
  description = "VPC security group id"
}

variable "vpc_id" {
  type        = string
  description = "Id of VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "Default CIDR block of the VPC"
}

/***** Ceramic *****/

variable "ceramic_anchor_service_api_url" {
  type        = string
  description = "URL for Ceramic Anchor Service API"
}

variable "ceramic_cors_allowed_origins" {
  type        = string
  description = "Web browser CORS allowed origins"
}

variable "ceramic_cpu" {
  type        = number
  description = "vCPU units to allocate to the Ceramic daemon ECS task"
  default     = 1024 # 1024 = 1 vCPU
}

variable "ceramic_efs_logs_fs_id" {
  type        = string
  description = "ID of EFS volume for Ceramic logs"
}

variable "ceramic_efs_logs_fs_name" {
  type        = string
  description = "Name of EFS volume for Ceramic logs"
}

variable "ceramic_eth_rpc_url" {
  type        = string
  description = "Ethereum RPC URL. Must match anchor service ETH network"
}

variable "ceramic_memory" {
  type        = number
  description = "Memory allocation per Ceramic daemon ECS task"
  default     = 2048
}

variable "ceramic_network" {
  type        = string
  description = "Ceramic network (e.g. testnet-clay)"
}

variable "ceramic_task_count" {
  type        = number
  description = "Number of Ceramic ECS tasks to run in the ECS service"
  default     = 1
}

/***** IPFS *****/

variable "ipfs_cpu" {
  type        = number
  description = "vCPU units to allocate to the IPFS ECS task"
  default     = 1024 # 1024 = 1 vCPU
}

variable "ipfs_debug_env_var" {
  type        = string
  description = "Value of DEBUG env var"
  default     = "*error"
}

variable "ipfs_domain_name" {
  type        = string
  description = "Domain name, including TLD"
}

variable "ipfs_memory" {
  type        = number
  description = "Memory allocation per IPFS API instance"
  default     = 2048
}

variable "ipfs_task_count" {
  type        = number
  description = "Number of IPFS ECS tasks to run in the ECS service"
  default     = 1
}
