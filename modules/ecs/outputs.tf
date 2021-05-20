output "ceramic_alb_dns_name_external" {
  value       = module.ceramic.alb_dns_name_external
  description = "DNS name of external (internet-facing) load balancer for Ceramic"
}

output "ipfs_alb_dns_name_external" {
  value       = module.ipfs.alb_dns_name_external
  description = "DNS name of external (internet-facing) load balancer for IPFS"
}

output "ipfs_alb_dns_name_internal" {
  value       = module.ipfs.alb_dns_name_internal
  description = "DNS name of internal load balancer for IPFS"
}

output "ipfs_api_url_internal" {
  value       = module.ipfs.api_url_internal
  description = "API URL for internal load balancer for IPFS"
}

output "ipfs_domain_name_internal" {
  value       = module.ipfs.domain_name_internal
  description = "Domain name for internal load balancer for IPFS"
}

output "ipfs_domain_name_external" {
  value       = module.ipfs.domain_name_external
  description = "Domain name for external (internet-facing) load balancer for IPFS"
}
