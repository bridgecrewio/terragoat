
resource "aws_iam_role" "new_iam_role" {
  name = "my-new-iam-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["s3:ListBucket"], 
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}