output "alb_dns_name_external" {
  value       = aws_lb.external.dns_name
  description = "DNS name of external (internet-facing) load balancer"
}

output "alb_dns_name_internal" {
  value       = module.alb_internal[0].this_lb_dns_name
  description = "DNS name of internal load balancer"
}

output "api_url_internal" {
  value       = var.use_ssl ? "https://${local.domain_name_internal}:${local.api_port}" : "http://${module.alb_internal[0].this_lb_dns_name}:${local.api_port}"
  description = "API URL for internal load balancer"
}

output "domain_name_internal" {
  value       = local.domain_name_internal
  description = "Domain name for internal load balancer"
}

output "domain_name_external" {
  value       = local.domain_name_external
  description = "Domain name for external (internet-facing) load balancer"
}
