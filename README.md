# terraform-aws-ceramic

Terraform scripts to set up Ceramic infrastructure.

## Usage

There is no root module available for use. Instead use one of the submodules like ECS:

```
module "ceramic" {
  source  = "ceramicnetwork/ceramic/aws//modules/ecs"
  version = "3.3.0"
  # insert variables here
}
```

## Pre-conditions

Make sure that the following AWS resources exist prior to the application of this Terraform module:
- VPC with 2 subnets in 2 AZs, each subnet tagged with `Ceramic` and the name of your environment, e.g. `dev`.
- S3 bucket for Ceramic/IPFS data store
- ECS cluster for Ceramic/IPFS services
- SSM parameter for your Infura RPC endpoint
- EFS volume for Ceramic logs
- ARN of S3 bucket to use as a backup for the IPFS repo (optional)

Also make sure that you add the appropriate CNAME entries to your DNS nameserver for the IPFS endpoints generated through the application of this module.

## Development

Start by installing [pre-commit](https://pre-commit.com/)

```shell
pre-commit install
```

### Known Issues

**Region is required**
When validating submodules you may see error messages like this:
> Error: Missing required argument
>
> The argument "region" is required, but was not set.

To suppress these, set an environment variable for `AWS_DEFAULT_REGION`
```shell
export AWS_DEFAULT_REGION=us-east-1
```

### Releases

We are using [release-it](https://github.com/release-it/release-it) to do releases and following [semver](https://semver.org/) versioning.

**Notes:**
- Releases must be made from the repository root directory to properly update CHANGELOG.md
- Release commits must be merged into the main branch

```shell
npm install --global release-it
cd terraform-aws-ceramic
release-it --dry-run
release-it
```

