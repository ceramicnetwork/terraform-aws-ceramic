output "alb_dns_name_external" {
  value       = module.alb.this_lb_dns_name
  description = "DNS name of external (internet-facing) load balancer"
}

output "efs_security_group_id" {
  value       = aws_security_group.efs.id
  description = "Id for EFS security group"
}
