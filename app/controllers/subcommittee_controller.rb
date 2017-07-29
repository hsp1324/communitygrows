class SubcommitteeController < ActionController::Base
    layout "base"
    before_action :authenticate_user!
    
    def index
        # puts "**********************"
        # puts "committee type is #{params[:committee_type]}"
        if !Committee.find_by_name(params[:committee_type]).users.include?(current_user)
            flash[:alert] = "You do not have access to this committee. Please contact Kelly for access."
            redirect_to dashboard_index_path
            return
        end
    	@inactive = Committee.find_by_name(params[:committee_type]).inactive
        @committee_type = params[:committee_type]
        if @inactive
    		flash[:inactive] = "#{@committee_type} is currently inactive"
        end
        @announcements = Announcement.where(committee_type: @committee_type).order(created_at: :DESC)
        @document_list = Document.where(committee_type: @committee_type).order(created_at: :DESC)
    end
    
end
