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

## Development

Start by installing [pre-commit](https://pre-commit.com/)

```shell
pre-commit install
```

### Releases

We are using [release-it](https://github.com/release-it/release-it) to do releases and following [semver](https://semver.org/) versioning.

Note: Release commits must be merged into the main branch.

```shell
npm install --global release-it
release-it --dry-run
release-it
```

