module "ceramic" {
  source = "../../modules/ecs/ceramic"

  aws_region            = "us-east-2"
  cors_allowed_origins  = "*"
  namespace             = "ceramic-elp-test"            # TODO: change to ceramic-example-1
  network               = "elp"              # TODO: change to commented out with mainnet
  service_subnet_ids    = []   # TODO: required
  eth_rpc_url           = "https://mainnet.infura.io/v3/b6685df41e1647c4be0046dfa62a020b"
  private_subnet_ids    = []
  ssl_certificate_arn   = ""
  vpc_security_group_id = ""
  vpc_id                = ""
  env                   = "elp"
  vpc_cidr_block        = ""

  # Creates
  # create_ceramic_alb = true
  # create_ceramic_alb_access_logs_bucket = true
  # create_ceramic_efs_volume = true
  # create_cluster = true
  # create_ceramic_service = true
  # create_ceramic_service_security_groups = true

  # Dependencies
  # alb_subnet_ids = []

  # Optional
  # ceramic_alb_access_logs_bucket_id = ""
  # ceramic_cpu = 1024
  # ceramic_efs_logs_volume_id = ""
  image_tag = "latest"
  # ceramic_load_balancer_contents = []
  # ceramic_memory = 2048
  # cluster_name = "ceramic-mainnet"
  # ceramic_port = 7007
  # service_name = "ceramic-daemon"
  # ceramic_service_security_group_ids = []
  # ceramic_task_count = 1
  # default_tags = {
  #   Terraform = "true"
  #   Ceramic = "mainnet"
  # }
  # load_balancer_arn = ""
  # run_as_gateway = false
}
