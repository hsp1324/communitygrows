class UserController < ActionController::Base
    layout "base"
    before_action :authenticate_user!
    
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :board_role, :current_company, :current_position,
        :about_me, :why_join, :internal, :external, :executive, :digest_pref, :ethnicity, :gender, expertise_ids:[])
    end
    
    def index
        @user = current_user
        if flash[:notice] == "Signed in successfully."
            flash[:notice] = nil
        end
    end
    
    def update_user_credentials
        @user = current_user
        if @user.update_attributes(user_params)
            bypass_sign_in(@user)
            flash[:notice] = []
            if (@user.internal != true) && (@user.external != true) && (@user.executive != true)
                flash[:notice] = ["Please select at least your committee to receive emails from."]
            end
            flash[:notice] << "#{@user.name}'s info was successfully updated." 
        else
            flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        end
        redirect_to user_credentials_path
    end
    
    # def updateEmailPreferences
    #     @user = current_user
    #     if @user.update_attributes(user_params)
    #         if (@user.internal != true) && (@user.external != true) && (@user.executive != true)
    #             flash[:notice] = "Please select at least your committee to receive emails from."
    #         else
    #             flash[:notice] = "Your email preference settings have been updated."
    #         end
    #     else
    #         flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
    #     end
    #     redirect_to user_credentials_path    
    #  end
end