class SubcommitteeController < ActionController::Base
    layout "base"
    before_action :authenticate_user!
    
    def index
        @committee=Committee.find(params[:committee_id])
        if !@committee.users.include?(current_user)
            flash[:alert] = "You do not have access to this committee. Please contact Kelly for access. You will be unable to add/edit committee Announcements and Documents."
        end
    	@inactive = @committee.inactive
        @committee_type = @committee.name
        if @inactive
    		flash[:inactive] = "#{@committee_type} is currently inactive. You will be unable to add/edit committee Announcements and Documents."
        end
        @notmember = !@committee.users.include?(current_user)
        @announcements = @committee.announcements.order(created_at: :DESC)
        @document_list = @committee.documents.order(created_at: :DESC)
    end
    
end
