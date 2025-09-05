class AdminMailer < ActionMailer::Base
  default from: "tea@ucdavis.edu"

  helper :application

  def new_user_waiting_for_approval(user)
    @user = user

    recipients = [];

    User.where(:institution => @user.institution).each do |u|
      if u.has_role?('user-approve') || u.has_role?('institution-admin')
        recipients << u.email
      end
    end

    if recipients.length == 0
      recipients.concat User.where(:super_admin => true).pluck(:email)
    end

    if recipients.length == 0
      recipients.concat ["matt.steinwachs@iamstem.ucdavis.edu"]
    end

    mail(:to => recipients, :subject => "Ribbon Tool - New User Approval Needed")
  end

  def approved_notify(user)
    @user = user

    mail(:to => @user.email, :subject => "Ribbon Tool - User Approved")
  end
end
