class ReportsController < ApplicationController
  def index
    @users = User.all
    @diagrams = Diagram.all
    @institutions = Institution.all
  end
end
