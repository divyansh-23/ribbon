module ApplicationHelper
    def after_sign_in_failure_path_for(resource_or_scope)
        new_user_registration_path # Adjust this to wherever you want users to be redirected on failure
    end
end
