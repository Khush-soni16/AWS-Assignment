resource "aws_ecr_repository" "app_repository" {
  name = "awsassignment-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "awsassignment-app"
    Environment = "dev"
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app_repository.repository_url
}
