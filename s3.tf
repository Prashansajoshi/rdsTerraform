resource "aws_s3_bucket" "prashansa_static_website_s3_bucket" {
  bucket = "prashansa-s3-static-website-bucket" 
  # force_destroy = true

  tags = {
  Name = "prashansa_s3_bucket"
  owner = "prashansa.joshi"
  environment = "dev"
  silo = "intern2"
  }
}

resource "aws_s3_bucket_ownership_controls" "prashansa_s3_ownership_controls" {
  bucket = aws_s3_bucket.prashansa_static_website_s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "prashansa_aws_s3_bucket_public_access_block" {
  bucket = aws_s3_bucket.prashansa_static_website_s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "prashansa_aws_s3_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.prashansa_s3_ownership_controls,
    aws_s3_bucket_public_access_block.prashansa_aws_s3_bucket_public_access_block
  ]

  bucket = aws_s3_bucket.prashansa_static_website_s3_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "prashansa_hosting_aws_s3_bucket_policy" {
  bucket = aws_s3_bucket.prashansa_static_website_s3_bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" = "Allow",
        "Principal" = "*",
        "Action" = "s3:GetObject",
        "Resource" = "${aws_s3_bucket.prashansa_static_website_s3_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "prashansa_hosting_bucket_website_configuration" {
  bucket = aws_s3_bucket.prashansa_static_website_s3_bucket.id
  
  index_document {
    suffix = "index.html"
  }
   error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "prashansa_hosting_bucket_files" {
  bucket = aws_s3_bucket.prashansa_static_website_s3_bucket.id

  for_each = module.template_files.files

  key = each.key
  content_type = each.value.content_type

  source = each.value.source_path
  content = each.value.content

  etag = each.value.digests.md5  
}

module "template_files"{
  source = "hashicorp/dir/template"
  base_dir = "${path.module}/rds_terraform"
}