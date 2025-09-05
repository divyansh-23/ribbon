class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?



  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception

  # Valid request formats
  respond_to :html, :json

  # Devise filters
  # before_action  :authenticate_user!, :user_signed_in?, :current_user, :user_session

  before_action :configure_permitted_parameters, :if => :devise_controller?

  rescue_from Pundit::NotAuthorizedError, :with => :user_not_authorized


  def after_sign_in_failure_path_for(resource_or_scope)
    new_user_registration_path
  end
  
  # def user_signed_in?
  #   #to modify
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :institution_id, :password, :password_confirmation, :username, :uid_number, :why_give_access, :how_did_you_learn_about])
  end

  def is_approved
    unless current_user.approved
      redirect_to not_approved_users_path
    end
  end

  def user_is_super_admin
    unless current_user.super_admin
      redirect_to diagrams_path, 
      :status => :unauthorized
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :institution_id, :password, :password_confirmation, :username, :uid_number, :why_give_access, :how_did_you_learn_about, :department, :title])
  end

  private


  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to "/"
  end

end
