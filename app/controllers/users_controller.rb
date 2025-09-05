class UsersController < ApplicationController
  require 'csv'

  before_action :set_user, :only => [:show, :edit, :update, :destroy]
  before_action :set_users, :only => [:index]

  #Enforces access right checks for individuals resources
  after_action :verify_authorized

  # Enforces access right checks for collections
  after_action :verify_policy_scoped, :only => :index

  def index
    authorize User
    if params[:approved] == "false"
      @users = @users.where(:approved => false)
    end

    respond_with(@users)
  end

  def show
    respond_with(@user)
  end

  def new
    @user = User.new

    authorize @user

    respond_with(@user)
  end

  def edit
  end

  #Not called. Replaced by
  def create
    @user = User.new(user_params)

    authorize @user
    @user.save

    respond_with(@user)
  end

  def update
    was_approved = @user.approved
    if @user.update_attributes(user_params)
      if policy(current_user).set_roles?
        set_roles
      end

      if policy(current_user).approve?
        if !was_approved && @user.approved# && @user.confirmed?
          AdminMailer.approved_notify(@user).deliver
        end
      end

      share

      flash[:notice] = "#{controller_name.classify} successfully updated."
    end

    respond_with(@user)
  end

  def export_users_awaiting_approval
    authorize User

    output_csv = CSV.generate({:force_quotes => true}) do |csv|
      csv << %w(name email title department signup_date)
      User.where(:approved => false).where(:institution_id => current_user.institution_id).each do |user|
        csv << [user.name, user.email, user.title, user.department, user.created_at.strftime("%F")]
      end
    end

    send_data(output_csv, :type => 'text/csv', :disposition => :attachment, :filename => "ribbon_users_awaiting_approval_as_of_#{DateTime.now.strftime("%F")}.csv")

  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  def export_all
    authorize User  # Pundit authorization

    users = policy_scope(User)

    csv_data = CSV.generate(headers: true) do |csv|
      csv << [
        "ID", "Institution ID", "Super Admin", "Name", "Email", "Title", "Department", "Username",
        "UID Number", "Approved", "Sign In Count", "Last Sign In At",
        "Created At", "Updated At"
      ]

      users.each do |user|
        csv << [
          user.id,
          user.institution_id,
          user.super_admin,
          user.name,
          user.email,
          user.title,
          user.department,
          user.username,
          user.uid_number,
          user.approved,
          user.sign_in_count,
          user.last_sign_in_at&.in_time_zone("Eastern Time (US & Canada)")&.strftime("%Y-%m-%d %H:%M"),
          user.created_at&.in_time_zone("Eastern Time (US & Canada)")&.strftime("%Y-%m-%d %H:%M"),
          user.updated_at&.in_time_zone("Eastern Time (US & Canada)")&.strftime("%Y-%m-%d %H:%M")
        ]
      end
    end

    send_data csv_data, filename: "all_users_#{Time.now.strftime('%Y%m%d')}.csv"
  end

  private
    def set_user
      @user = User.find(params[:id])
      authorize @user
    end

    def set_users
      @users = policy_scope(User)
    end

    def set_roles
      @user.role_list.each do |role|
        @user.remove_role role
      end

      if params[:roles]
        puts params[:roles]
        params[:roles].split(",").each do |role|
          if policy(:role).set_role?(role)
            @user.add_role role
          end
        end
      end
    end

    def share
      @user.diagrams = []
      if params[:user_diagrams]
        params[:user_diagrams].each do |diagrams_id|
          if @user.institution.diagrams.map(&:id).include?(diagrams_id.to_i)
            UserDiagram.new(:diagram_id => diagrams_id.to_i, :user_id => @user.id).save!
          end
        end
      end
    end

    def user_params
      if current_user.super_admin
        params.require(:user).permit(:institution_id, :name, :email, :title, :department, :approved, :roles)
      else
        params.require(:user).permit(:name, :email, :title, :department, :approved, :roles)
      end
    end
end
