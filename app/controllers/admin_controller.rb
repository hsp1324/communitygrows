class AdminController < ActionController::Base
    layout "base"
    before_action :authenticate_user!, :authorize_user
    include EmailHelper
    include AnnouncementHelper
    
    def authorize_user
        if not User.find(current_user.id).admin
            flash[:message] = "Access not granted. Please sign in again."
            redirect_to "/dashboard" and return
        end
        return true
    end
    
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :title, :board_role, :current_company,
        :current_position, :about_me, :why_join, :interests_skills, :admin, expertise_ids:[])
    end
    
    def announcement_params
        params.require(:announcement).permit(:title, :content, :emergency)
    end
    
    def index
        authenticate_user!
        authorize_user
        @users = User.all
        @announcement_list = Announcement.where(committee_id: nil).order(created_at: :DESC)
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
            form_data = []
            params[:check].each_pair do |committee_id, checked|
                form_data<<(committee_id)
            end
            
            @user.committees.each do |committee|
                if form_data.include? committee.id
                    form_data.delete(committee.id)
                else
                    old_record = @user.mail_records.find_by(committee_id: committee.id)
                    if old_record
                        @user.mail_records.delete(old_record)
                        old_record.destroy
                    end
                    @user.committees.delete(committee)
                end
            end
            
            form_data.each do |id|
                committee = Committee.find(id)
                @user.committees<<(committee)
                @user.mail_records<<(MailRecord.create(:description => "add", :committee => committee))
                if Rails.env.production?
                    send_member_email(committee, [@user.id])
                end
            end
            
            if params[:picture]
                uploader = PictureUploader.new
                uploader.store!(params[:picture])
                path_name = "/uploads/" + params[:picture].original_filename
                new_path_name = "/uploads/" + Random.new_seed.to_s + params[:picture].original_filename
                File.rename("public" + path_name, "public"+ new_path_name)
                path_name =  new_path_name
                params[:picture] = path_name
                @user.update_attributes(:picture => path_name)
            end
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
            params[:check].each_pair do |committee_id, checked|
                committee = Committee.find(committee_id)
                @user.committees<<(committee)
                @user.mail_records<<(MailRecord.create(:description => "add", :committee => committee))
                if Rails.env.production?
                    send_member_email(committee, [@user.id])
                end
            end
            
            if params[:picture]
                uploader = PictureUploader.new
                uploader.store!(params[:picture])
                path_name = "/uploads/" + params[:picture].original_filename
                new_path_name = "/uploads/" + Random.new_seed.to_s + params[:picture].original_filename
                File.rename("public" + path_name, "public"+ new_path_name)
                path_name =  new_path_name
                params[:picture] = path_name
                @user.update_attributes(:picture => path_name)
            end
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
    
    #show new_announcement page for admin before creating
    def new_announcement
        @from = params[:from]
    end
    
    #creating main announcement as admin
    def create_announcement
        @from = params[:from]
        create_announcement_helper
        return
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
        
        if @target_announcement.mail_record
            @target_announcement.mail_record.update_attribute(:description, "update")
        else
            @target_announcement.create_mail_record(:description => "update")
        end
        
        if Rails.env.production?
            send_announcement_update_email(@target_announcement)
        end
        
        flash[:notice] = "Announcement with title [#{@target_announcement.title}] updated successfully and email was sent successfully"
        redirect_to(admin_index_path)
    end
    
    def delete_announcement
        authenticate_user!
        authorize_user
        @target_announcement = Announcement.find params[:id]
        @name = @target_announcement.title
        
        @target_announcement.destroy
        
        flash[:notice] = "Announcement with title [#{@name}] deleted successfully"
        redirect_to(admin_index_path)
    end
    
end

