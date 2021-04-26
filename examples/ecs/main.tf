provider "aws" {
  region = "us-east-2"
}

module "ecs" {
  source = "../../modules/ecs"

  aws_region                   = "us-east-2"
  ceramic_cors_allowed_origins = "*"
  ceramic_namespace            = "ceramic-elp-1" # TODO: change to ceramic-example-1
  ceramic_network              = "elp"           # TODO: change to commented out with mainnet
  ceramic_service_subnet_ids   = []              # TODO: required
  eth_rpc_url                  = ""              # TODO: remove
  private_subnet_ids           = []

  # Creates
  # create_ceramic_alb = true
  # create_ceramic_alb_access_logs_bucket = true
  # create_ceramic_efs_volume = true
  # create_cluster = true
  # create_ceramic_service = true
  # create_ceramic_service_security_groups = true

  # Dependencies
  alb_subnet_ids = []

  # Optional
  # ceramic_alb_access_logs_bucket_id = ""
  # ceramic_cpu = 1024
  # ceramic_efs_logs_volume_id = ""
  # ceramic_image_tag = "latest"
  # ceramic_load_balancer_contents = []
  # ceramic_memory = 2048
  # cluster_name = "ceramic-mainnet"
  # ceramic_port = 7007
  # ceramic_service_name = "ceramic-daemon"
  # ceramic_service_security_group_ids = []
  # ceramic_task_count = 1
  # default_tags = {
  #   Terraform = "true"
  #   Ceramic = "mainnet"
  # }
  # load_balancer_arn = ""
  # run_as_gateway = false
}
