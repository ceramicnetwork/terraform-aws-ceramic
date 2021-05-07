variable "alb_subnet_ids" {
  type        = any
  description = "List of public subnet ids for internet-facing ALB."
}

variable "aws_region" {
  type        = string
  description = "AWS region. Must match region of vpc_id and alb_subnet_ids."
}

variable "ceramic_image_tag" {
  type        = string
  description = "Image tag for Ceramic Docker Hub image"
  default     = "latest"
}

variable "cors_allowed_origins" {
  type        = string
  description = "Web browser CORS allowed origins"
}

variable "ceramic_cpu" {
  type        = number
  description = "vCPU units to allocate to the Ceramic daemon ECS task"
  default     = 1024 # 1024 = 1 vCPU
}

variable "ceramic_memory" {
  type        = number
  description = "Memory to allocate to the Ceramic daemon ECS task"
  default     = 2048 # 2048 MiB = 2 GB
}

variable "network" {
  type        = string
  description = "Ceramic network"
}

variable "ceramic_task_count" {
  type        = number
  description = "Number of Ceramic ECS tasks to run in the ECS service"
  default     = 1
}

variable "namespace" {
  type        = string
  description = "Namespace for Ceramic resources"
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

variable "cluster_name" {
  type        = string
  description = "When create_cluster is true, name of ECS cluster"
  default     = "ceramic"
}

variable "create_ceramic_efs_volume" {
  type        = bool
  description = "True to create EFS volume for Ceramic logs"
  default     = true
}

variable "ceramic_efs_logs_volume_id" {
  type        = string
  description = "When create_cermic_efs_volume is false, id of EFS volume for Ceramic logs"
  default     = ""
}

variable "create_cluster" {
  type        = bool
  description = "True to create a new ECS cluster for Ceramic and IPFS"
  default     = true
}

variable "create_ceramic_service" {
  type        = bool
  description = "True to create a new ECS service"
  default     = true
}

variable "ceramic_enable_debug" {
  type        = bool
  description = "True to enable Ceramic debug"
  default     = true
}

variable "enable_verbose" {
  type        = bool
  description = "True to enable verbose logging"
  default     = true
}

variable "directory_namespace" {
  type        = string
  description = "Directory for logs and state"
  default     = ""
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags"
  default = {
    Terraform = "true"
  }
}

variable "eth_rpc_url" {
  type        = string
  description = "Ethereum RPC URL. Must match anchor service ETH network"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet ids for the VPC"
}

variable "run_as_gateway" {
  type        = bool
  description = "Run Ceramic as a gateway"
  default     = false
}

variable "service_name" {
  type        = string
  description = "When create_ceramic_service is true, name of ECS service"
  default     = "ceramic-daemon"
}

variable "anchor_service_api_url" {
  type        = string
  description = "URL for Ceramic Anchor Service API"
}

variable "ceramic_service_security_group_ids" {
  type        = list(string)
  description = "When create_ceramic_service_security_groups is false, list of security group ids for ECS service tasks"
  default     = []
}

variable "service_subnet_ids" {
  type        = any
  description = "When create_ceramic_service is true, list of subnet ids for the ECS service tasks. Generally the service will use private subnets and tasks will be access via a load balancer."
}

variable "ssl_certificate_arn" {
  type        = string
  description = "ARN of SSL certificate"
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

variable "env" {
  type        = string
  description = "Environment name"
}

variable "image_tag" {
  type        = string
  description = "Image tag"
}

