class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user = current_user
    @user = user
  end

  def index?
    (
      current_user.has_role?('user-view') ||
      current_user_is_institution_admin ||
      current_user_is_super_admin
    )
  end

  def show?
    (
      (
        (
          user_is_current_user ||
          current_user.has_role?('user-view') ||
          current_user_is_institution_admin
        ) &&
        user_in_same_institution_as_current_user
      ) ||
      current_user_is_super_admin
    )
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    (
      (
        (
          user_is_current_user ||
          current_user.has_role?('user-update') ||
          current_user_is_institution_admin
        ) &&
        user_in_same_institution_as_current_user
      ) ||
      current_user_is_super_admin
    )
  end

  def edit?
    update?
  end

  def destroy?
    (
      (
        (
          current_user.has_role?('user-destroy') ||
          current_user_is_institution_admin
        ) &&
        user_in_same_institution_as_current_user
      ) ||
      current_user_is_super_admin
    )
  end

  def set_roles?
    (
      (
        (
          current_user.has_role?('user-set-roles') ||
          current_user_is_institution_admin
        ) &&
        user_in_same_institution_as_current_user
      ) ||
      current_user_is_super_admin
    )
  end

  def approve?
    (
      (
        (
          current_user.has_role?('user-approve') ||
          current_user_is_institution_admin
        ) &&
        user_in_same_institution_as_current_user
      ) ||
      current_user_is_super_admin
    )
  end

  def export_users_awaiting_approval?
    (
      (
        (
          current_user.has_role?('user-approve') ||
          current_user_is_institution_admin
        )
      ) ||
      current_user_is_super_admin
    )
  end

  def user_in_same_institution_as_current_user
    user.institution == current_user.institution
  end

  def current_user_is_super_admin
    current_user.super_admin
  end

  def current_user_is_institution_admin
    current_user.has_role? 'institution-admin'
  end

  def user_is_current_user
    user.id == current_user.id
  end

  def export_all?
    current_user.super_admin || current_user.has_role?('institution-admin')
  end

  class Scope < Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      if current_user.super_admin
        scope.all
      else
        scope.where(:institution_id => current_user.institution_id)
      end
    end
  end
end
