class AdminController < ActionController::Base
    layout "base"

    
    def authorize_user
        if not User.find(current_user.id).admin
            redirect_to "/dashboard"
        end
    end
    
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :title, :committee, :board_role, :current_company,
        :current_position, :about_me, :why_join, :interests_skills, :internal, :external, :executive, :admin, expertise_ids:[])
    end

    def calendar_params
        params.require(:calendar).permit(:html)
    end
    
    def announcement_params
        params.require(:announcement).permit(:title, :content)
    end
    
    def index
        @users = User.all
        @announcement_list = Announcement.where(committee_type: "dashboard").order(created_at: :DESC)
        if !current_user.admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to("/users/sign_in")
        end
        @events = Event.order(date: :DESC)
    end
    
    def edit_user
        before_action :authenticate_user!, :authorize_user
        @user = User.find params[:id]
    end
    
    def update_user
        before_action :authenticate_user!, :authorize_user
        @user = User.find params[:id]
        begin
            @user.update_attributes!(user_params)
        rescue Exception
            flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
            redirect_to edit_user_path(@user.id)
        else
            flash[:notice] = "#{@user.email} was successfully updated."
            redirect_to admin_index_path
        end
        #check params for null password fields
        #if either is null, flash notification saying must fill in fields
    end
    
    def create_user
        before_action :authenticate_user!, :authorize_user
        #try and catch
        begin
            @user = User.create(user_params)
            @user.save!
        rescue Exception => e
            flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
            redirect_to new_user_path
        else
            flash[:notice] = "#{@user.email} was successfully created."
            redirect_to admin_index_path 
        end
    end
    
    def new_user
        before_action :authenticate_user!, :authorize_user
        #default: render 'new' template
    end
    
    def delete_user
        before_action :authenticate_user!, :authorize_user
        @user = User.find params[:id]
        @user.destroy
        redirect_to admin_index_path
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
        before_action :authenticate_user!, :authorize_user
        @id = params[:id]
        @target_announcement = Announcement.find @id
    end
    
    def update_announcement
        before_action :authenticate_user!, :authorize_user
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
        before_action :authenticate_user!, :authorize_user
        @target_announcement = Announcement.find params[:id]
        @target_announcement.destroy!
        flash[:notice] = "Announcement with title [#{@target_announcement.title}] deleted successfully"
        redirect_to(admin_index_path)
    end
    
    def update_calendar
        before_action :authenticate_user!, :authorize_user
        Calendar.destroy_all
        @new_calendar = Calendar.create!(calendar_params)
        flash[:notice] = 'New Calendar Creation successful'
        redirect_to('/admin')
    end
end

