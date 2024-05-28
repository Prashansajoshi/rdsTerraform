output "website_url" {
    description = "The URL of the static website"
    value      = aws_s3_bucket_website_configuration.prashansa_hosting_bucket_website_configuration.website_endpoint
}

output "template_files_debug" {
  value = module.template_files.files
}
