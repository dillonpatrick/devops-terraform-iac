resource "aws_ecr_repository" "nsinfotech-api" {
  name                 = "nsinfotech-api"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}
