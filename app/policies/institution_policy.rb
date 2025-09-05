class InstitutionPolicy < ApplicationPolicy
  attr_reader :user, :institution

  def initialize(user, institution)

    @user = user
    @institution = institution
  end

  def index?
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    user_is_super_admin
  end

  def show?
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    user_is_super_admin
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    user_is_super_admin
  end

  def edit?
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    user_is_super_admin
  end

  def destroy?
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    user_is_super_admin
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
