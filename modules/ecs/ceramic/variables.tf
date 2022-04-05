/* Given */

variable "aws_region" {
  type        = string
  description = "AWS region. Must match region of vpc_id and public_subnet_ids."
}

variable "anchor_service_api_url" {
  type        = string
  description = "URL for Ceramic Anchor Service API"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ARN of SSL certificate"
}

variable "base_tags" {
  type        = any
  description = "Tags to merge with local defaults"
}

variable "ceramic_enable_debug" {
  type        = bool
  description = "True to enable Ceramic debug"
  default     = true
}

variable "ceramic_load_balancer_contents" {
  type        = list(any)
  description = "If create_ceramic_service is true, list of load balancer contents to add to ECS service"
  default     = []
}

variable "ceramic_port" {
  type        = number
  description = "Port number to serve Ceramic daemon on"
  default     = 7007
}

variable "ceramic_service_security_group_ids" {
  type        = list(string)
  description = "When create_ceramic_service_security_groups is false, list of security group ids for ECS service tasks"
  default     = []
}

variable "cors_allowed_origins" {
  type        = string
  description = "Web browser CORS allowed origins"
}

variable "directory_namespace" {
  type        = string
  description = "Directory for logs and state"
  default     = ""
}

variable "ecs_count" {
  type        = number
  description = "Number of Ceramic ECS tasks to run in the ECS service"
  default     = 1
}

variable "ecs_cpu" {
  type        = number
  description = "vCPU units to allocate to the Ceramic daemon ECS task"
  default     = 1024 # 1024 = 1 vCPU
}

variable "ecs_memory" {
  type        = number
  description = "Memory to allocate to the Ceramic daemon ECS task"
  default     = 2048 # 2048 MiB = 2 GB
}

variable "ecs_service_name" {
  type        = string
  description = "Name of ECS service"
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name of ECS cluster"
}

variable "efs_logs_fs_id" {
  type        = string
  description = "ID of EFS volume for Ceramic logs"
}

variable "efs_logs_fs_name" {
  type        = string
  description = "Name of EFS volume for Ceramic logs"
}

variable "enable_verbose" {
  type        = bool
  description = "True to enable verbose logging"
  default     = true
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "ecs_log_group_name" {
  type = string
}

variable "ecs_log_prefix" {
  type    = string
  default = "ceramic"
}

variable "eth_rpc_url" {
  type        = string
  description = "Ethereum RPC URL. Must match anchor service ETH network"
}

variable "image_tag" {
  type        = string
  description = "Image tag"
}

variable "ipfs_api_url" {
  type        = string
  description = "API URL for IPFS"
}

variable "namespace" {
  type        = string
  description = "Namespace for Ceramic resources"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet ids for the VPC"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet ids for internet-facing ALB."
}

variable "s3_bucket_arn" {
  type        = string
  description = "ARN of S3 bucket to use as a backend"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name (aka id) of S3 bucket to use as a backend"
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

/* Chosen */
