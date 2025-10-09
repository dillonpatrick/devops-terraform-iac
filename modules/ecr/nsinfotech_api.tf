resource "aws_ecr_repository" "nsinfotech-api" {
  name                 = "nsinfotech-api"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true
  region               = "us-east-2"

  image_scanning_configuration {
    scan_on_push = true
  }
}
