class CalendarController < ApplicationController
    layout "base"
    before_action :authenticate_user!, :authorize_user
    include AdminHelper
    include ControllerHelper
    
    def index
        authenticate_user!
        authorize_user
        @calendars = Calendar.all
    end
    
    def color_id(color)
        colors = ["#D3D3D3", "#7FFFD4", "#0000FF", "#000080", "#800080", "#FF1493", "#EE82EE", "#006400", "#008000", "#9ACD32", "#FFA500", "#FF0000", "#A52A2A", "#DEB887", "#F5F5DC"]
        return colors.index(color)
    end
    
    def create_calendar
        authenticate_user!
        authorize_user
        is_admin = admin_only('create calendar')
        return if !is_admin
        calendar = params[:calendar]
        create_object(Calendar, calendar, new_calendar_path, calendar_index_path)
    end
    
    def delete_calendar
        authenticate_user!
        authorize_user
        is_admin = admin_only('delete calendar')
        return if !is_admin
        delete_object(Calendar)
        redirect_to calendar_index_path
    end       

    def edit_calendar
        authenticate_user!
        authorize_user
        is_admin = admin_only('edit calendar')
        @previous = color_id(Calendar.find(params[:id]).color)
        puts @previous
        puts "TESTING TESTING HEY HEY HEY TESTING \n\n\n\n\n  TELKSJFLAJPIEWJFPIEWAHJKAHKDSGH:KAWHEFPIA"
        return if !is_admin
        edit_object(Calendar)
    end

    def update_calendar
        authenticate_user!
        authorize_user
        is_admin = admin_only('update calendar')
        return if !is_admin
        @previous = color_id(Calendar.find(params[:id]).color)
        @calendar = Calendar.find(params[:id])
        calendar = params[:calendar]
        update_object(Calendar, calendar, edit_calendar_path, calendar_index_path)
    end
    
    def action_calendar
        authenticate_user!
        authorize_user
        my_action = params[:do_action]
        is_admin = admin_only('#{my_action} calendar')
        return if !is_admin
        do_action(Calendar, my_action, calendar_index_path)
    end
    
    
end
