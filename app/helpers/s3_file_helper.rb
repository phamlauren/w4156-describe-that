require 'aws-sdk-s3'
require 'securerandom'

module S3FileHelper
  def upload_file(desired_name, file_io_contents)
    s3 = Aws::S3::Client.new
    obj = s3.bucket(ENV["S3_BUCKET_NAME"]).object(desired_name)
    obj.put(body: file_io_contents)  # file_io_contents IS FROM params[:file].to_io
    true
  rescue StandardError => e
    # TODO: Log error?
    false
  end

  def get_presigned_dl_url_for_file(file_loc)

  end
end
