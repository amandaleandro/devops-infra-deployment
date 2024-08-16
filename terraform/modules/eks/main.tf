variable "vpc_id" {
  description = "ID of the VPC"
}

resource "aws_eks_cluster" "cluster" {
  name     = "my-cluster"
  role_arn  = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids = [
      aws_subnet.public.id,
      aws_subnet.private.id,
    ]
  }
}

resource "aws_iam_role" "eks_role" {
  name = "eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
}
