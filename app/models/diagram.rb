class Diagram < ActiveRecord::Base
  belongs_to :institution

  has_many :user_diagrams, :dependent => :delete_all
  has_many :users, :through => :user_diagrams

  has_many :data_files, :dependent => :destroy
  has_many :user_logs, dependent: :destroy

  belongs_to :creator, :class_name => "User"
  belongs_to :last_used_by, class_name: 'User', optional: true

  accepts_nested_attributes_for :data_files, :reject_if => proc { |attributes| attributes['data_file'].blank? || attributes['name'].blank? }

  validates_presence_of :name, :category

  validates_presence_of :data_files

  has_many_attached :data_files

  # has_many :data_files
  acts_as_taggable
end
