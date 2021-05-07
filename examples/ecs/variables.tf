/***** Common *****/


variable "aws_region" {
  type        = string
  description = "AWS region. Must match region of vpc_id and alb_subnet_ids."
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

variable "base_namespace" {
  type        = string
  description = "Base namespace"
}


/***** Ceramic *****/


variable "ceramic_cors_allowed_origins" {
  type        = string
  description = "Web browser CORS allowed origins"
}

variable "ceramic_cluster_name" {
  type        = string
  description = "Name of ECS cluster"
}

variable "ceramic_certificate_arn" {
  type        = string
  description = "ARN of Ceramic SSL certificate"
}

variable "ceramic_network" {
  type        = string
  description = "Ceramic network"
}

variable "ceramic_anchor_service_api_url" {
  type        = string
  description = "URL for Ceramic Anchor Service API"
}

variable "ceramic_eth_rpc_url" {
  type        = string
  description = "Ethereum RPC URL. Must match anchor service ETH network"
}

variable "ceramic_service_name" {
  type        = string
  description = "Name of Ceramic ECS service"
}

variable "ceramic_service_subnet_ids" {
  type        = any
  description = "List of subnet ids for the Ceramic ECS service tasks"
}

variable "ceramic_alb_subnet_ids" {
  type        = any
  description = "List of public subnet ids for internet-facing ALB."
}


/***** IPFS *****/


variable "ipfs_certificate_arn" {
  type        = string
  description = "ARN of IPFS SSL certificate"
}

variable "ipfs_ecs_memory" {
  type        = number
  description = "Memory allocation per IPFS API instance"
  default     = 8192
}