require 'net/smtp'

module Net
  class SMTP
    def tls?
      true
    end
  end
end

#Rails.application.configure do
#  puts "_____________"
#  puts ENV["SES_USER"]
#
#  config.action_mailer.delivery_method = :smtp
#  config.action_mailer.smtp_settings = {
#      :address => 'email-smtp.us-west-2.amazonaws.com',
#      :authentication => :login,
#      :user_name => ENV["SES_USER"],#Rails.application.secrets.ses_user_name,
#      :password => ENV["SES_SECRET"],#Rails.application.secrets.ses_secret_key,
#      :enable_starttls_auto => true,
#      :port => 465
#  }
#end