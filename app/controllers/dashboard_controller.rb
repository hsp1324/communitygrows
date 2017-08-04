class DashboardController < ActionController::Base
    layout "base"
    before_action :authenticate_user!
    
    def index
        #if user is not an admin
        @is_admin = true
        @is_admin = false if not User.find(current_user.id).admin
        puts ("user is an admin: #{@is_admin}")
        @announcement_list = Announcement.where(committee_type: "").order(created_at: :DESC)
        @subcomittee_announcements_list = Announcement.where.not(committee_type: "").order(created_at: :DESC)
    end
end