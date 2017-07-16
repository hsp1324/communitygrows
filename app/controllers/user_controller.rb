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
        @type = "dashboard"
        Announcement.create!(:title => @title, :content => @content, :committee_type => @type)
        if Rails.env.production?
            User.all.each do |user|
                if user.digest_pref == "daily"
                    NotificationMailer.announcement_email(user, Announcement.find_by_title(@title)).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
                elsif user.digest_pref == "weekly"
                    NotificationMailer.announcement_email(user, Announcement.find_by_title(@title)).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
                else
                    NotificationMailer.announcement_email(user, Announcement.find_by_title(@title)).deliver
                end
            end
        end
        flash[:notice] = 'Announcement creation successful and email was sent successfully.'
        redirect_to('/admin')
    end
    
    def edit_announcement
        @id = params[:id]
        @target_announcement = Announcement.find @id
    end
    
    def update_announcement
        @target_announcement = Announcement.find params[:id]
        @target_announcement.update_attributes!(announcement_params)
        if Rails.env.production?
            User.all.each do |user|
                if user.digest_pref == "daily"
                    NotificationMailer.announcement_update_email(user, @target_announcement).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
                elsif user.digest_pref == "weekly"
                    NotificationMailer.announcement_update_email(user, @target_announcement).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
                else
                    NotificationMailer.announcement_update_email(user, @target_announcement).deliver
                end
            end
        end
        flash[:notice] = "Announcement with title [#{@target_announcement.title}] updated successfully and email was sent successfully"
        redirect_to(admin_index_path)
    end
    
    def delete_announcement
        @target_announcement = Announcement.find params[:id]
        @target_announcement.destroy!
        flash[:notice] = "Announcement with title [#{@target_announcement.title}] deleted successfully"
        redirect_to(admin_index_path)
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