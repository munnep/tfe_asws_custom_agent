variable "rds_snapshot_to_restore_id" {
}

variable "tfe-bucket" {
}

locals {
  s3_bucket_restore_snapshot_rds = formatdate("MM-DD-YYYY hh:mm:ss +1", timeadd(data.aws_db_snapshot.specific.snapshot_create_time, "1h"))
}

data "aws_db_snapshot" "specific" {
   db_snapshot_identifier = var.rds_snapshot_to_restore_id
}

output "restore_s3_bucket_to_rds_snapshot" {
  value = "s3-pit-restore -b ${var.tfe-bucket} -B ${var.tfe-bucket} -t ${local.s3_bucket_restore_snapshot_rds}"
}
