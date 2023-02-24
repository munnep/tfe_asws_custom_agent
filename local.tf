locals {
  az1                    = "${var.region}a"
  az2                    = "${var.region}b"
  rds_snapshots          = toset(var.rds_snapshots)
  s3_bucket_restore_time = var.rds_snapshot_to_restore == null ? "There is no restore done" : module.snapshot_restore[0].restore_s3_bucket_to_rds_snapshot
}