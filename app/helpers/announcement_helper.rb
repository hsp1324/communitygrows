module AnnouncementHelper
    def create_announcement_helper
        @title = announcement_params[:title]
        @content = announcement_params[:content]
        @emergency = announcement_params[:emergency]
        @new_announce = Announcement.create(:title => @title, :content => @content, :emergency => @emergency)
        # checks if it is not an emergency, create a mail record
        if @emergency == "0"
            @new_announce.create_mail_record(:description => "create")
            flash[:notice] = 'Announcement creation successful and email was sent successfully.'
        else
            flash[:notice] = 'Emergency announcement creation successful and email was sent successfully.'
        end
        
        if Rails.env.production?
            if @emergency == "0"
                send_announcement_email(@new_announce)
            else
                send_emergency_announcement_email(@new_announce)
            end
        end
        if @from == "dashboard"
            redirect_to('/dashboard') and return
        else
            redirect_to('/admin') and return
        end 
    end
    
    def announcement_params
        params.require(:announcement).permit(:title, :content, :emergency)
    end
end