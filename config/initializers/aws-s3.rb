require 'aws-sdk'

Aws.config.update(
  endpoint: ENV['S3_ENDPOINT_URL'],
  region: ENV['S3_BUCKET_REGION'],
  credentials: Aws::Credentials::new(ENV['S3_ACCESS_KEY'], ENV['S3_SECRET_KEY']),
  force_path_style: true
)
