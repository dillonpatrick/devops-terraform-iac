resource "aws_s3_bucket" "remote_state_config" {
  bucket        = "nsinfotech-terraform-remote-state"
  force_destroy = true
}
