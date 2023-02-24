output "ssh_tfe_server" {
  value = "ssh ubuntu@${var.dns_hostname}.${var.dns_zonename}"
}

output "tfe_dashboard" {
  value = "https://${var.dns_hostname}.${var.dns_zonename}:8800"
}

output "tfe_appplication" {
  value = "https://${var.dns_hostname}.${var.dns_zonename}"
}

output "ssh_tfe_server_ip" {
  value = "ssh ubuntu@${aws_eip.tfe-eip.public_ip}"
}

output "restore_s3_bucket_to_rds_snapshot" {
  value = local.s3_bucket_restore_time
}

output "ssh_tf_client" {
  value = "ssh ubuntu@${var.dns_hostname}-client.${var.dns_zonename}"
}
