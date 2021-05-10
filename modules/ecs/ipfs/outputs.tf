output "announce_address_list" {
  value = local.announce_address_list
}

output "api_port" {
  value = local.api_port
}

output "gateway_port" {
  value = local.gateway_port
}

output "alb_internal_dns_name" {
  value = module.alb_internal[0].lb_dns_name
}

output "alb_external_dns_name" {
  value = aws_lb.external.dns_name
}

output "domain_name_internal" {
  value = local.domain_name_internal
}

output "domain_name_external" {
  value = local.domain_name_external
}

output "api_url_internal" {
  value = var.use_ssl ? "https://${local.domain_name_internal}:${local.api_port}" : "http://${module.alb_internal[0].this_lb_dns_name}:${local.api_port}"
}

output "gateway_url_internal" {
  value = var.use_ssl ? "https://${local.domain_name_internal}:${local.gateway_port}" : "http://${module.alb_internal[0].this_lb_dns_name}:${local.gateway_port}"
}

output "swarm_ws_url_external" {
  value = var.use_ssl ? "https://${local.domain_name_external}:${local.swarm_ws_port}" : "http://${aws_lb.external.dns_name}:${local.swarm_ws_port}"
}

output "swarm_ws_url_internal" {
  value = var.use_ssl ? "https://${local.domain_name_internal}:${local.swarm_ws_port}" : "http://${module.alb_internal.this_lb_dns_name}:${local.swarm_ws_port}"
}

output "hostname_internal" {
  value       = module.alb_internal[0].lb_dns_name
  description = "Hostname of internal ALB"
}

output "hostname_external" {
  value       = aws_lb.external.dns_name
  description = "Hostname of external ALB"
}
