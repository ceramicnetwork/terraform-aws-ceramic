/***** Common *****/

variable "aws_region" {
  type        = string
  description = "AWS region. Must match region of vpc_id and public_subnet_ids."
}

variable "az_count" {
  type        = number
  description = "Number of availability zones to use"
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

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet ids for the VPC"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of ALB subnet ids"
}

variable "base_namespace" {
  type        = string
  description = "Base namespace"
}

variable "ssl_certificate_arn" {
  type        = string
  description = "ARN of SSL certificate"
}

variable "default_tags" {
  type        = map(any)
  description = "Tags"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "image_tag" {
  type        = string
  description = "Image tag"
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name of ECS cluster"
}

/***** Ceramic *****/

variable "ceramic_cors_allowed_origins" {
  type        = string
  description = "Web browser CORS allowed origins"
}

variable "ceramic_anchor_service_api_url" {
  type        = string
  description = "URL for Ceramic Anchor Service API"
}

variable "ceramic_eth_rpc_url" {
  type        = string
  description = "Ethereum RPC URL. Must match anchor service ETH network"
}

variable "ceramic_task_count" {
  type        = number
  description = "Number of Ceramic ECS tasks to run in the ECS service"
  default     = 1
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

variable "ceramic_efs_logs_volume_name" {
  type        = string
  description = "Name of EFS volume for Ceramic logs"
}

/***** IPFS *****/

variable "ipfs_ecs_memory" {
  type        = number
  description = "Memory allocation per IPFS API instance"
  default     = 8192
}

variable "ipfs_task_count" {
  type        = number
  description = "Number of IPFS ECS tasks to run in the ECS service"
  default     = 1
}

variable "ipfs_cpu" {
  type        = number
  description = "vCPU units to allocate to the IPFS ECS task"
  default     = 1024 # 1024 = 1 vCPU
}
