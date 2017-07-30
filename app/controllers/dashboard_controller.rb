class DashboardController < ActionController::Base
    layout "base"
    before_action :authenticate_user!
    
    def index
        @announcement_list = Announcement.where(committee_type: "").order(created_at: :DESC)
        @subcomittee_announcements_list = Announcement.where.not(committee_type: "").order(created_at: :DESC)
    end
end