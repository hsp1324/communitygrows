class AdminController < ActionController::Base
    layout "base"
    #before_action :authenticate_user!, :authorize_user
    include EmailHelper
    
    def authorize_user
        if not User.find(current_user.id).admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to "/dashboard" and return
        return true
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
        authenticate_user!
        authorize_user
        @users = User.all
        @announcement_list = Announcement.where(committee_type: "").order(created_at: :DESC)
        # if !current_user.admin
        #     flash[:message] = "Access not granted. Please sign in again."
        #     redirect_to("/users/sign_in")
        # end
        
        
    end
    
    def edit_user
        authenticate_user!
        authorize_user
        @user = User.find params[:id]
    end
    
    def update_user
        authenticate_user!
        authorize_user
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
        authenticate_user!
        authorize_user
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
        authenticate_user!
        authorize_user
        
        #default: render 'new' template
    end
    
    def delete_user
        authenticate_user!
        authorize_user
        @user = User.find params[:id]
        @user.destroy
        redirect_to admin_index_path
    end
    
    def new_announcement
        authenticate_user!
    end
    
    def create_announcement
        authenticate_user!
        @title = announcement_params[:title]
        @content = announcement_params[:content]
        @type = ""
        @new_announce = Announcement.create(:title => @title, :content => @content, :committee_type => @type)
        MailRecord.create!(:record_type => "announcement", :record_id => @new_announce.id, :committee => @type)
        if Rails.env.production?
            send_announcement_email("", @new_announce)
        end
        flash[:notice] = 'Announcement creation successful and email was sent successfully.'
        redirect_to('/admin')
    end
    
    def edit_announcement
        authenticate_user!
        authorize_user
        @id = params[:id]
        @target_announcement = Announcement.find @id
    end
    
    def update_announcement
        authenticate_user!
        authorize_user
        @target_announcement = Announcement.find params[:id]
        @target_announcement.update_attributes!(announcement_params)
        
        @prev_mailrecord = MailRecord.find_by(record_type: 'announcement', record_id: params[:id])
        if @prev_mailrecord
            @prev_mailrecord.touch
        else
            MailRecord.create!(:record_type => "announcement", :record_id => params[:id], :committee => @target_announcement.committee_type)
        end
        
        if Rails.env.production?
            send_announcement_update_email("", @target_announcement)
        end
        
        flash[:notice] = "Announcement with title [#{@target_announcement.title}] updated successfully and email was sent successfully"
        redirect_to(admin_index_path)
    end
    
    def delete_announcement
        authenticate_user!
        authorize_user
        @target_announcement = Announcement.find params[:id]
        @target_announcement.destroy!
        
        @prev_mailrecord = MailRecord.find_by(record_type: 'announcement', record_id: params[:id])
        if @prev_mailrecord
            @prev_mailrecord.destroy!
        end
        
        flash[:notice] = "Announcement with title [#{@target_announcement.title}] deleted successfully"
        redirect_to(admin_index_path)
    end
    
    def update_calendar
        flash[:notice] = 'New Calendar Creation successful'
        authenticate_user!
        authorize_user
        Calendar.destroy_all
        @new_calendar = Calendar.create!(calendar_params)
        flash[:notice] = 'New Calendar Creation successful'
        redirect_to('/admin')
    end
end

