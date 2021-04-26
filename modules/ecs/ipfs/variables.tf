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

variable "ecs_cluster_arn" {
  type        = string
  description = "ARN of cluster to place IPFS ECS service inside"
}

variable "ecs_cpu" {
  type        = number
  description = "Fargate vCPU threads allocated to the Ceramic gateway instance"
}

variable "ecs_log_group_name" {
  type        = string
  description = ""
}

variable "ecs_log_stream_prefix" {
  type        = string
  description = ""
}

variable "ecs_memory" {
  type        = number
  description = "Fargate memory allocated to the Ceramic gateway instance"
}

variable "ecs_task_execution_role_arn" {
  type        = string
  description = "ARN for ecsTaskExecutionRole"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Ids for the VPC private subnets"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Ids for the VPC public subnets"
}

variable "s3_replica_arn" {
  type        = string
  description = "ARN of S3 replica bucket. Required if create_s3_backend is true."
}

variable "s3_replication_role_arn" {
  type        = string
  description = "ARN of S3 replication IAM role. Required if create_s3_backend is true."
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

variable "additional_namespace" {
  type        = string
  description = "Additional namespace string to differentiate deployments"
}

# TODO: Handle this
# variable "create_cluster" {
#   type        = string
#   description = "True if IPFS should run in its own cluster"
# }

variable "create_s3_backend" {
  type        = bool
  description = "False to pass an s3 bucket created elsewhere"
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

variable "s3_bucket_arn" {
  type        = string
  description = "ARN of S3 bucket to use as a backend"
}

variable "s3_bucket_id" {
  type        = string
  description = "Id of S3 bucket to use as a backend"
}

variable "subdomain_namespace" {
  type        = string
  description = "Namespace to add to subdomain. E.g. ipfs-<subdomain_namespace>-dev.3boxlabs.com"
}
