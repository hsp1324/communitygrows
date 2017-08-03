class SubcommitteeController < ActionController::Base
    layout "base"
    before_action :authenticate_user!
    
    def index
        if !Committee.find_by_name(params[:committee_type]).users.include?(current_user)
            flash[:alert] = "You do not have access to this committee. Please contact Kelly for access. You will be unable to add/edit committee Announcements and Documents."
        end
    	@inactive = Committee.find_by_name(params[:committee_type]).inactive
        @committee_type = params[:committee_type]
        if @inactive
    		flash[:inactive] = "#{@committee_type} is currently inactive. You will be unable to add/edit committee Announcements and Documents."
        end
        @notmember = !Committee.find_by_name(params[:committee_type]).users.include?(current_user)
        @announcements = Announcement.where(committee_type: @committee_type).order(created_at: :DESC)
        @document_list = Document.where(committee_type: @committee_type).order(created_at: :DESC)
    end
    
end
