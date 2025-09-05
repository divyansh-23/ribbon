class HomeController < ApplicationController
  # skip_before_action :is_approved
  # skip_before_action :set_timezone
  # skip_filter :user_time_zone

  def home
    @announcements = [Announcement.order(:created_at).where(:admin_only => false).last]

    if current_user.has_role? "institution-admin" || current_user.super_admin?
      @announcements << Announcement.order(:created_at).where(:admin_only => true).last
    end

    @announcements.compact!

    diagrams = policy_scope(Diagram)
    @categories = diagrams.map(&:category).uniq

  end

  def news
    @announcements = Announcement.order(:created_at)
    unless current_user.has_role? "institution-admin" || current_user.super_admin?
      @announcements = @announcements.where(:admin_only => false)
    end
  end
end
