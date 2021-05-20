data "docker_registry_image" "ipfs" {
  name = "ceramicnetwork/ipfs-daemon:${var.image_tag}"
}
