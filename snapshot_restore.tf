resource "aws_db_snapshot" "test" {
  for_each               = local.rds_snapshots
  db_instance_identifier = aws_db_instance.default.id
  db_snapshot_identifier = each.value
}

module "snapshot_restore" {
  count                      = var.rds_snapshot_to_restore == null ? 0 : 1
  source                     = "./modules/snapshot_restore"
  rds_snapshot_to_restore_id = aws_db_snapshot.test[var.rds_snapshot_to_restore].id
  tfe-bucket                 = aws_s3_bucket.tfe-bucket.bucket
}


resource "aws_db_instance" "restore" {
  count                       = var.rds_snapshot_to_restore == null ? 0 : 1
  allocated_storage           = 10
  engine                      = "postgres"
  engine_version              = "12.8"
  instance_class              = "db.t3.large"
  username                    = "postgres"
  password                    = var.rds_password
  parameter_group_name        = "default.postgres12"
  skip_final_snapshot         = true
  db_name                     = "tfe"
  publicly_accessible         = false
  snapshot_identifier         = aws_db_snapshot.test[var.rds_snapshot_to_restore].id
  vpc_security_group_ids      = [aws_security_group.default-sg.id]
  db_subnet_group_name        = aws_db_subnet_group.default.name
  identifier                  = "${var.tag_prefix}-rds-snapshot-restore"
  allow_major_version_upgrade = true
  tags = {
    "Name" = var.tag_prefix
  }

  depends_on = [
    aws_s3_object.certificate_artifacts_s3_objects
  ]
}

