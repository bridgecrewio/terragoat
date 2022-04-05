resource "alicloud_db_instance" "seeme" {
  # Is public due to Security IPS 0.0.0.0/0
  engine           = "MySQL"
  engine_version   = "5.6"
  instance_type    = "rds.mysql.t1.small"
  instance_storage = "10"
  tde_status       = "Enabled"
  security_ips = [
    "0.0.0.0",
    "10.23.12.24/24"
  ]
  parameters {
    name  = "innodb_large_prefix"
    value = "ON"
  }
  parameters {
    name  = "connect_timeout"
    value = "50"
  }
}
