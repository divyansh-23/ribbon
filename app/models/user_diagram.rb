class UserDiagram < ActiveRecord::Base
  belongs_to :user
  belongs_to :diagram

  validates_uniqueness_of :user, :scope => :diagram
end
