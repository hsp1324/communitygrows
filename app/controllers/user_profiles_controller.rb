class UserProfilesController < ApplicationController
    layout "base"
    before_action :authenticate_user!
    
    def index
        @users = User.all
    end
    
    def user_profile
        @user = User.find(params[:id])
        @areasOfExpertise = @user.expertises.where(:constituency => false)
        @constituencies = @user.expertises.where(:constituency => true)
    end
    
end
