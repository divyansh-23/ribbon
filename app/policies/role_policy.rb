#Headless Pundit Policy for managing role related premissions

class RolePolicy < Struct.new(:user, :role)

  def set_role?(role_name)
    user.super_admin || user.has_role?('institution-admin') || user.has_role?(role_name)
  end
end