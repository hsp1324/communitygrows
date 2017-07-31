module AdminHelper
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
