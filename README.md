# terraform-aws-ceramic

Terraform scripts to set up Ceramic infrastructure.

**WORK IN PROGRESS**

## Usage

There is no root module available for use. Instead use one of the submodules like ECS:

```
module "ceramic" {
  source  = "ceramicnetwork/ceramic/aws//modules/ecs"
  version = "2.0.0"
  # insert variables here
}
```

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

