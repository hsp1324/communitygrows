module AdminHelper
    def authorize_user
        if not User.find(current_user.id).admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to "/dashboard" and return
        end
        return true
    end
    
    def admin_only(action)
        if !current_user.admin
            flash[:message] = "Only admins can #{action}"
            # return false
            redirect_to root_path and return
        else
            return true
        end
    end
end
