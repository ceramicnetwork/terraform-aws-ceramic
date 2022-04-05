data "docker_registry_image" "ipfs" {
  name = "ceramicnetwork/go-ipfs-daemon:${var.image_tag}"
}
