output "alb_dns_name_external" {
  value       = module.alb.this_lb_dns_name
  description = "DNS name of external (internet-facing) load balancer"
}
