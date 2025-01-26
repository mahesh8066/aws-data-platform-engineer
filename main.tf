provider "aws" {
  region = "us-east-1"
}

# Provision S3 Bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = "unique-example-bucket-20258066"
  
}

# IAM Role for Lambda Execution
resource "aws_iam_role" "lambda_execution_role" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_lambda_function" "example_lambda" {
  filename      = "./lambda.zip"

  function_name = "example-lambda"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  environment {
    variables = {
      LOG_LEVEL = "info"
    }
  }

  source_code_hash = filebase64sha256("lambda.zip")
}

# Attach necessary policies to Lambda execution role
resource "aws_iam_role_policy_attachment" "lambda_execution_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_execution_role.name
}
