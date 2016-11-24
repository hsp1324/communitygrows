class UserProfilesController < ApplicationController
    layout "base"
    
    def index
        @users = User.all
    end
    
    def user_profile
        @user = User.find(params[:id])
    end
    
end
