class DiagramPolicy < ApplicationPolicy
  attr_reader :user, :diagram

  def initialize(user, diagram)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @diagram = diagram
  end

  def index?
    true
  end

  def show?
    (
      (
        (
          diagram_is_shared_with_user ||
          diagram_is_created_by_user  ||
          user_is_institution_admin
        ) &&
        diagram_belongs_to_users_institution
      ) ||
      (
        diagram_is_shared_within_users_institution ||
        diagram_is_shared_with_all_institutions
      ) ||
      user_is_super_admin
    )
  end

  def create?
    (
      user.has_role?('diagram-create') ||
      user_is_institution_admin ||
      user_is_super_admin
    )
  end

  def new?
    create?
  end

  def update?
    (
      (
        (
          (
            diagram_is_created_by_user &&
            user.has_role?('diagram-update')
          ) ||
          user_is_institution_admin
        ) && diagram_belongs_to_users_institution
      ) ||
      user_is_super_admin
    )
  end

  def edit?
    update?
  end

  def destroy?
    (
      (
        (
          (
            diagram_is_created_by_user &&
            user.has_role?('diagram-destroy')
          ) ||
          user_is_institution_admin
        ) &&
        diagram_belongs_to_users_institution
      ) ||
      user_is_super_admin
    )
  end


  # custom actions
  def download?
    (
      (
        (
          diagram_is_created_by_user ||
          user_is_institution_admin ||
          (
            diagram_is_shared_with_user &&
            diagram_is_downloadable &&
            user.has_role?('diagram-download')
          )
        ) &&
        diagram_belongs_to_users_institution
      ) ||
      (
        diagram_is_shared_with_all_institutions &&
        diagram.downloadable
      ) ||
      user_is_super_admin
    )
  end

  def diagram_is_shared_with_user
    user.diagrams.include?(diagram) || diagram_is_shared_within_users_institution || diagram_is_shared_with_all_institutions
  end

  def diagram_is_created_by_user
    diagram.creator == user
  end

  def diagram_belongs_to_users_institution
    user.institution == diagram.institution
  end

  def diagram_is_shared_within_users_institution
    user.institution.diagrams.where(:share_with_all => true).includes(diagram)
  end

  def diagram_is_shared_with_all_institutions
    Diagram.where(:share_with_all_institutions => true).includes(diagram)
  end

  def diagram_is_downloadable
    diagram.downloadable
  end

  class Scope < Scope
    def resolve
      if user.has_role? 'institution-admin'
        user.institution.diagrams | Diagram.where(:share_with_all_institutions => true)
      else
        user.diagrams | user.authored_diagrams | user.institution.diagrams.where(:share_with_all => true)| Diagram.where(:share_with_all_institutions => true)
      end

    end
  end
end
