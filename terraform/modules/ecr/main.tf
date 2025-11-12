# modules/ecr/main.tf

resource "aws_ecr_repository" "app_repository" {
  name                 = "awsassignment-app"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  lifecycle {
    ignore_changes = [name]
  }
}

# Handle case where ECR already exists
#data "aws_ecr_repository" "existing" {
 # name = "awsassignment-app"
#}

output "repository_url" {
  value = try(
    aws_ecr_repository.app_repository.repository_url,
    data.aws_ecr_repository.existing.repository_url
  )
}
