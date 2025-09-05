if Rails.env == "production"
  # set credentials from ENV hash
  S3_CREDENTIALS = {
    :access_key_id => ENV['S3_KEY'],
    :secret_access_key => ENV['S3_SECRET'],
    :bucket => ENV['S3_BUCKET'],
    :s3_region => ENV['S3_REGION'],
    :region => ENV['S3_REGION']
  }
else
  # get credentials from YML file
  S3_CREDENTIALS = {
    :access_key_id => ENV['RIB_S3_KEY'],
    :secret_access_key => ENV['RIB_S3_SECRET'],
    :bucket => 'data_files', #ENV['RIB_S3_BUCKET'],
    :s3_region => ENV['RIB_S3_REGION'],
    :region => ENV['RIB_S3_REGION']
  }
end