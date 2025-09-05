class Institution < ActiveRecord::Base
  has_many :users, :dependent => :delete_all
  has_many :diagrams, :dependent => :delete_all

  def users_awaiting_approval
    users.where(:approved => false)
  end
end
