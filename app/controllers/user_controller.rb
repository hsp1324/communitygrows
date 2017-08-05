class UserController < ActionController::Base
    layout "base"
    before_action :authenticate_user!
    include EmailHelper
    include AnnouncementHelper
    
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :board_role, :current_company, :current_position,
        :about_me, :pic, :why_join, :internal, :external, :executive, :digest_pref, :ethnicity, :gender, expertise_ids:[])
    end
    
    def index
        @user = current_user
        if flash[:notice] == "Signed in successfully."
        end
    end

    def new_announcement
    end
    
    #create user main announcement
    def create_announcement
        create_announcement_helper
        return
    end
    
    def update_user_credentials
        @user = current_user
        if params[:picture]
            uploader = PictureUploader.new
            uploader.store!(params[:picture])
            path_name = "/uploads/" + params[:picture].original_filename
            params[:picture] = path_name
            @user.update_attributes(:picture => path_name)
        end
        if @user.update_attributes(user_params)
            bypass_sign_in(@user)
            flash[:notice] = []
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