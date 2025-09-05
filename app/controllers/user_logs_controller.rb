class UserLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def export
    logs = UserLog.includes(:user, :diagram).order(created_at: :desc)

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["User ID", "User Name", "Diagram ID", "Diagram Name", "Action", "Timestamp"]

      logs.each do |log|
        csv << [
          log.user_id,
          log.user.name,
          log.diagram_id,
          log.diagram.name,
          log.action,
          log.created_at.strftime("%Y-%m-%d %H:%M:%S")
        ]
      end
    end

    send_data csv_data, filename: "ribbon_user_logs_#{Time.now.strftime("%Y%m%d")}.csv"
  end

  private

  def authorize_admin!
    unless current_user.has_role?('institution-admin') || current_user.super_admin
      redirect_to root_path, alert: "Not authorized."
    end
  end
end
