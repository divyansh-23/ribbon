require 'application_helpers'
class CustomFailureApp < Devise::FailureApp
    def redirect_url
      return "dv"

      if (warden_message == :unauthenticated) || (warden_message == :not_approved)
        new_user_registration_path 
      else
        super
      end
    end
  
    def respond
      if http_auth?
          http_auth
      else
          redirect_to new_user_registration_path
      end
    end
end  
