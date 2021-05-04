data "docker_registry_image" "ceramic" {
  name = "ceramicnetwork/js-ceramic:${var.image_tag}"
}
