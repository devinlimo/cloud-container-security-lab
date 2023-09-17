# Set up S3 bucket for Mongodb backups
resource "aws_s3_bucket" "mongodb_backups-1" {
  bucket = "mongodb-backups-1"

  tags = {
    Name = "mongodb backups-1"
  }

}

resource "aws_s3_bucket_ownership_controls" "mongodb_ownership" {
  bucket = aws_s3_bucket.mongodb_backups-1.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "mongodb_public" {
  bucket = aws_s3_bucket.mongodb_backups-1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "public_read" {
  depends_on = [ 
    aws_s3_bucket_ownership_controls.mongodb_ownership,
    aws_s3_bucket_public_access_block.mongodb_public,
   ]
  bucket = aws_s3_bucket.mongodb_backups-1.id
  acl = "public-read"
}