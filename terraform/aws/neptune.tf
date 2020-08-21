resource "aws_neptune_cluster" "default" {
  cluster_identifier                  = var.neptune-dbname
  engine                              = "neptune"
  backup_retention_period             = 5
  preferred_backup_window             = "07:00-09:00"
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = false
  apply_immediately                   = true
  storage_encrypted                   = false
}

resource "aws_neptune_cluster_instance" "default" {
  count                               = 1
  cluster_identifier                  = aws_neptune_cluster.default.id
  engine                              = "neptune"
  instance_class                      = "db.t3.medium" # Smallest instance type listed for neptune https://aws.amazon.com/neptune/pricing/
  apply_immediately                   = true
  #publicly_accessible                = true # No longer supported, API returns create error. See https://docs.aws.amazon.com/neptune/latest/userguide/api-instances.html#CreateDBInstance
}

resource "aws_neptune_cluster_snapshot" "default" {
  db_cluster_identifier               = aws_neptune_cluster.default.id
  db_cluster_snapshot_identifier      = "resourcetestsnapshot1"
}

