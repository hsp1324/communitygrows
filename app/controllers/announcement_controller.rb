class AnnouncementController < ActionController::Base
    protect_from_forgery with: :exception
    layout "base"
    before_action :authenticate_user!
    include EmailHelper

    def show_announcements
       @announcements = Announcement.all
    end

    def new_announcement
        @committee_name = Committee.find(params[:committee_id]).name
    end
        
    def create_announcement
        @title = params[:title]
        @committee_id = params[:committee_id]
        @committee = Committee.find(@committee_id)
        if @title.nil? || @title.empty?
            flash[:notice] = "Title field cannot be left blank."
            redirect_to new_committee_announcement_path(@committee_type) and return
        end
        @content = params[:content]
        @new_announce = @committee.announcements.create(:title => @title, :content => @content)
        
        MailRecord.create!(:record_type => "announcement", :record_id => @new_announce.id, :committee => @committee_type)
        
        if Rails.env.production?
            send_announcement_email(Committee.find_by(name: @committee_type), @new_announce)
        end
        flash[:notice] = "#{@committee.name} Announcement creation successful and email was successfully sent."
        redirect_to subcommittee_index_path(:committee_id => @committee_id)
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
        @committee_id = params[:committee_id]
        @committee = Committee.find(@committee_id)
        
        if @title.nil? || @title.empty?
            flash[:notice] = "Title field cannot be left blank."
            redirect_to edit_committee_announcement_path(@committee_id, @announcement_id) and return
        end
        @target_announcement.update_attributes!(:title => @title, :content => @content)
        
        @prev_mailrecord = MailRecord.find_by(record_type: 'announcement', record_id: @announcement_id)
        if @prev_mailrecord
            @prev_mailrecord.touch
        else
            MailRecord.create!(:record_type => "announcement", :record_id => @announcement_id, :committee => @target_announcement.committee_type)
        end
        
        if Rails.env.production?
            send_announcement_update_email(Committee.find_by(name: @committee_name), @target_announcement)
        end
        
        flash[:notice] = "Announcement with title [#{@target_announcement.title}] updated successfully and email was successfully sent"
        redirect_to subcommittee_index_path(@committee_id)
    end
    
    def delete_announcement
        @target_announcement = Announcement.find params[:announcement_id]
        @committee_id = params[:committee_id]
        @target_announcement.destroy!
        @committee = Committee.find(@committee_id)
        
        @prev_mailrecord = MailRecord.find_by(record_type: 'announcement', record_id: params[:announcement_id])
        if @prev_mailrecord
            @prev_mailrecord.destroy!
        end
        
        flash[:notice] = "#{@committee.name} Announcement with title [#{@target_announcement.title}] deleted successfully"
        redirect_to subcommittee_index_path(@committee_id)
    end
    
    def search_announcements
        @search = params[:search]
        @announcements = Announcement.where("title LIKE ?", "%#{@search}%")
        render :show_announcements
    end

end

