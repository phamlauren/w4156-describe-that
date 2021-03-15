require 'aws-sdk-s3'

module S3FileHelper

  ##
  # Uploads a file to the S3 server defined in the environment variables.
  # Params:
  # +desired_name+:: the desired name/key that the uploaded file should be given within the bucket.
  # +file_io_contents+:: the contents of the object to be uploaded. Can be `String`, `StringIO`, or `File`.
  # +metadata+:: any metadata to be stored with the object (Should be a `Hash<String, String>`. Optional: May be nil).
  def self.upload_file(desired_name, file_io_contents, metadata = nil)
    # init the client, resource, bucket, and target object
    client = Aws::S3::Client.new
    resource = Aws::S3::Resource.new(client: client)
    bucket = resource.bucket(ENV["S3_BUCKET_NAME"])
    obj = bucket.object(desired_name)

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
    puts e.inspect
    false
  end

  ##
  # Generates a pre-signed URL for a file within the defined bucket.
  # Params:
  # +file_name+:: the name/key of the target file within the bucket.
  # +validity_sec+:: the validity of the generated link in seconds. (Default: 300. May not exceed 1 week.)
  def self.get_presigned_dl_url_for_file(file_name, validity_sec = 300)
    s3 = Aws::S3::Client.new
    signer = Aws::S3::Presigner.new(client: s3)

    signer.presigned_url(
      :get_object,
      bucket: ENV['S3_BUCKET_NAME'],
      key: file_name,
      expires_in: validity_sec  # can be up to one week
    )
  end
end
