class UserController < ActionController::Base
    layout "base"
    before_filter :authenticate_user!
    
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :internal, :external, :executive)
    end
    
    def index
        @user = current_user
        if flash[:notice] == "Signed in successfully."
            flash[:notice] = nil
        end
    end
    
    def update

        @user = current_user
        if @user.update_attributes(user_params)
            bypass_sign_in(@user)
            flash[:notice] = "#{@user.email}'s credentials were successfully updated."
            redirect_to user_credentials_path
        else
            flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
            redirect_to user_credentials_path    
        end
    end

    def updateEmailPreferences
        @user = current_user
        
        if @user.update_attributes(user_params)
            if (@user.internal != true) && (@user.external != true) && (@user.executive != true)
                flash[:notice] = "Please select at least your committee to receive emails from."
            else
                flash[:notice] = "Your email preference settings have been updated."
            end
        else
            flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        end
        redirect_to user_credentials_path    
     end

end