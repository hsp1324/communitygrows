class AnnouncementController < ActionController::Base
    protect_from_forgery with: :exception
    layout "base"
    before_action :authenticate_user!
    include EmailHelper

    def show_announcements
       #@announcements = Announcement.where(committee_type: params[:categories])
       @announcements = Announcement.all
    end

    def new_announcement
    end
        
    def create_announcement
        @title = params[:title]
        @committee_type = params[:committee_type]
        if @title.nil? || @title.empty?
            flash[:notice] = "Title field cannot be left blank."
            redirect_to new_committee_announcement_path(@committee_type) and return
        end
        @content = params[:content]
        Announcement.create!(:title => @title, :content => @content, :committee_type => @committee_type)
        if Rails.env.production?
            send_announcement_email(@committee_type,@title)
        end
        flash[:notice] = "#{@committee_type.capitalize} Announcement creation successful and email was successfully sent."
        redirect_to subcommittee_index_path(:committee_type => @committee_type)
    end
        
    def edit_announcement
        @announcement_id = params[:announcement_id]
        @announcement = Announcement.find @announcement_id
    end
    
    def update_announcement
        @target_announcement = Announcement.find params[:announcement][:id]
        @title = params[:title]
        @content = params[:content]
        @announcement_id = params[:announcement_id]
        @committee_type = params[:committee_type]
        if @title.nil? || @title.empty?
            flash[:notice] = "Title field cannot be left blank."
            redirect_to edit_committee_announcement_path(@committee_type, @announcement_id) and return
        end
        @target_announcement.update_attributes!(:title => @title, :content => @content, :committee_type => @committee_type)
        if Rails.env.production?
            send_announcement_update_email(@committee_type,@title)
        end
        flash[:notice] = "Announcement with title [#{@target_announcement.title}] updated successfully and email was successfully sent"
        redirect_to subcommittee_index_path(@committee_type)
    end
    
    def delete_announcement
        @target_announcement = Announcement.find params[:announcement_id]
        @committee_type = params[:committee_type]
        @target_announcement.destroy!
        flash[:notice] = "Executive Announcement with title [#{@target_announcement.title}] deleted successfully"
        redirect_to subcommittee_index_path(@committee_type)
    end
    
    def search_announcements
        @search = params[:search]
        @announcements = Announcement.where("title LIKE ?", "%#{@search}%")
        render :show_announcements
    end

end

