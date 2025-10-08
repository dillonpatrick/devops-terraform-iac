module "iam_oidc_provider" {
  source = "terraform-aws-modules/iam/aws//modules/iam-oidc-provider"

  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "github_actions" {
  name = "github_actions"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "sts:AssumeRoleWithWebIdentity",
          "Principal" : {
            "Federated" : "arn:aws:iam::044302809047:oidc-provider/token.actions.githubusercontent.com"
          },
          "Condition" : {
            "StringEquals" : {
              "token.actions.githubusercontent.com:aud" : [
                "sts.amazonaws.com"
              ]
            },
            "StringLike" : {
              "token.actions.githubusercontent.com:sub" : [
                "repo:dillonpatrick/*"
              ]
            }
          }
        }
      ]
    }
  )
}

resource "aws_iam_role_policy" "ecr_policy" {
  name = "ecr_policy"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "IAM"
        Action = [
          "iam:PassRole",
          "iam:CreateServiceLinkedRole"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "ECR"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:GetAuthorizationToken",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid = "AppRunner"
        Action = [
          "apprunner:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
