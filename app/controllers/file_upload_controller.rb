class FileUploadController < ApplicationController
    def new
    end
  
    def create
      s3 = Aws::S3::Resource.new(credentials: Rails.application.config.x.aws_credentials)
      bucket = s3.bucket('edanalytics-localstoragebucket-1sg7f85taw0qq')
  
      file = params[:file]
      obj = bucket.object(file.original_filename)
      obj.upload_file(file.tempfile.path)
  
      redirect_to root_path, notice: 'File uploaded successfully!'
    end
  end
  