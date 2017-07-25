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
    
    def new_announcement
    end
    
    def create_announcement
        @title = announcement_params[:title]
        @content = announcement_params[:content]
        @type = ""
        @new_announce = Announcement.create(:title => @title, :content => @content, :committee_type => @type)
        MailRecord.create!(:record_type => "announcement", :record_id => @new_announce.id, :committee => @type)
        if Rails.env.production?
            send_announcement_email("", @new_announce)
        end
        flash[:notice] = 'Announcement creation successful and email was sent successfully.'
    end
    
    def update_user_credentials
        @user = current_user
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