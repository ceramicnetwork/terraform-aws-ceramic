# terraform-aws-ceramic

Terraform scripts to set up Ceramic infrastructure.

**WORK IN PROGRESS**

## Usage

There is no root module available for use. Instead use one of the submodules like ECS:

```
module "ceramic" {
  source  = "ceramicnetwork/ceramic/aws//modules/ecs"
  version = "0.0.1"
  # insert variables here
}
```
