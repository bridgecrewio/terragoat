resource "aws_s3_bucket" "sd-ml-experiment" {
  provider      = aws.us-east-1
  arn           = "arn:aws:s3:::sd-ml-experiment"
  bucket        = "sd-ml-experiment"
  force_destroy = false
  request_payer = "BucketOwner"
  tags          = {}


}

resource "aws_s3_bucket_policy" "sd-ml-experiment" {
  provider = aws.us-east-1
  bucket   = aws_s3_bucket.sd-ml-experiment.id
  policy   = file("policy-sd-ml-experiment.json")
}
