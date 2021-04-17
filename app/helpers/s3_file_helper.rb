require 'aws-sdk-s3'

module S3FileHelper
  @@MAX_PRESIGNED_URL_VALIDITY = 7.day.to_i
  @@MIN_PRESIGNED_URL_VALIDITY = 20.minute.to_i

  # Uploads a file to the S3 server defined in the environment variables.
  #
  # @param desired_name [String] The desired name/key that the uploaded file should be given within the bucket.
  # @param file_io_contents [StringIO, File, String] The contents of the object to be uploaded.
  # @param metadata [Hash<String, String>] Any metadata to be stored with the object. (Optional)
  # @return [Boolean] True if uploaded succeeded. False if not.
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

  # Deletes a given file from the S3 server.
  #
  # @param name_of_file [String] The name of the file within the S3 server.
  def self.delete_file(name_of_file)
    client = Aws::S3::Client.new
    resource = Aws::S3::Resource.new(client: client)
    bucket = resource.bucket(ENV["S3_BUCKET_NAME"])
    obj = bucket.object(name_of_file)

    obj.delete
    nil
  end

  # Generates a pre-signed URL for a file within the defined bucket.
  #
  # @param file_name [String] The name/key of the target file within the bucket.
  # @param validity_sec [Float] The validity of the generated link in seconds. (Default: 300. May not exceed 1 week.)
  # @return [String] The ephemeral download URL.
  #   Note that a URL will always be generated regardless of whether or not the requested file actually exists in the bucket.
  def self.get_presigned_dl_url_for_file(file_name, validity_sec = 300)
    s3 = Aws::S3::Client.new
    signer = Aws::S3::Presigner.new(client: s3)

    # if the requested validity is over 1 week, cap it at 1 week
    if validity_sec > @@MAX_PRESIGNED_URL_VALIDITY
      validity_sec = @@MAX_PRESIGNED_URL_VALIDITY
    end

    # if the requested validity is under 20 minutes, force it to be 20 minutes
    if validity_sec < @@MIN_PRESIGNED_URL_VALIDITY
      validity_sec = @@MIN_PRESIGNED_URL_VALIDITY
    end

    signer.presigned_url(
      :get_object,
      bucket: ENV['S3_BUCKET_NAME'],
      key: file_name,
      expires_in: validity_sec  # can be up to one week
    )
  end
end
