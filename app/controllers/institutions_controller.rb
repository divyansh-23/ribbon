class InstitutionsController < ApplicationController
  before_action :set_institution, :only => [:show, :edit, :update, :destroy]
  before_action :set_institutions, :only => [:index]

  before_action :user_is_super_admin, :except => :create

  # skip_before_action :authenticate_user!, :only => :create
  # skip_before_action :user_signed_in?, :only => :create
  # skip_before_action :current_user, :only => :create
  # skip_before_action :user_session, :only => :create

  #Enforces access right checks for individuals resources
  after_action :verify_authorized

  # Enforces access right checks for collections
  after_action :verify_policy_scoped, :only => :index


  def index
    authorize Institution
    respond_with(@institutions)
  end

  def show
    respond_with(@institution)
  end

  def new
    @institution = Institution.new
    authorize @institution
    respond_with(@institution)
  end

  def edit
  end

  def create
    @institution = Institution.new(institution_params)
    authorize @institution

    @institution.save!

    render json: @institution
  end

  def update
    @institution.update(institution_params)
    flash[:notice] = "#{controller_name.classify} successfully updated."
    respond_with(@institution)
  end

  def destroy
    @institution.destroy
    respond_with(@institution)
  end

  private
    def set_institution
      @institution = Institution.find(params[:id])
      authorize @institution
    end

    def set_institutions
      @institutions = policy_scope(Institution)
    end

    def institution_params
      params.require(:institution).permit(:name)
    end
end
