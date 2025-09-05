class ReportsControllerPolicy < ApplicationPolicy
  def initialize(user, controller)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @controller = controller
  end

  def index?
    user_is_super_admin
  end  
end