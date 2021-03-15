require 'aws-sdk-s3'

module S3FileHelper
  def self.upload_file(desired_name, file_io_contents, metadata = nil)
    s3 = Aws::S3::Client.new
    obj = s3.bucket(ENV["S3_BUCKET_NAME"]).object(desired_name)

    # file_io_contents IS FROM params[:file].to_io. Can be String, StringIO, or File.
    if metadata.nil?
      response = obj.put(body: file_io_contents)
    else
      response = obj.put(body: file_io_contents, metadata: metadata)
    end

    # check if successfully uploaded
    if response.etag
      true
    else
      false
    end
  rescue StandardError => e
    # TODO: Log error?
    false
  end

  def self.get_presigned_dl_url_for_file(file_name, validity_sec = 300)
    s3 = Aws::S3::Client.new
    signer = Aws::S3::Presigner.new(client: s3)

    signer.presigned_url(
      :get_object,
      bucket: ENV['S3_BUCKET_NAME'],
      key: file_name,
      use_accelerate_endpoint: true,
      expires_in: validity_sec
    )
  end
end
