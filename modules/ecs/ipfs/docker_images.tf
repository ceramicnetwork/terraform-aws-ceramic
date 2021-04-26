data "docker_registry_image" "ipfs" {
  name = var.env == "prod" ? "ceramicnetwork/ipfs-daemon:latest" : "ceramicnetwork/ipfs-daemon:${var.env}"
}
