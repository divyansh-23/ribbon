class DataFile < ActiveRecord::Base
  belongs_to :diagram

  has_attached_file :data_file,
  s3_headers: lambda { |_attachment|
    {
      'Content-Type' => 'application/json'
    }
  },
  storage: :s3,
  s3_credentials: Proc.new{|a| a.instance.s3_credentials },
  path: "archive/data_files/:diagram_id/:id/:filename", # Modified path
  s3_permissions: :private

  validates_attachment :data_file, content_type: { content_type: ['application/json'] }

  private

  Paperclip.interpolates :institution  do |attachment, style|
    attachment.instance.diagram.institution.name
  end

  Paperclip.interpolates :creator_id  do |attachment, style|
    attachment.instance.diagram.creator_id
  end

  Paperclip.interpolates :diagram_id  do |attachment, style|
    attachment.instance.diagram.id
  end

  Paperclip.interpolates :data_file_id  do |attachment, style|
    attachment.instance.id
  end
end