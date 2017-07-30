class CalendarController < ApplicationController
    layout "base"
    include AdminHelper
    include ControllerHelper
    
    def index
        @calendars = Calendar.all
    end
    
    def create_calendar
        is_admin = admin_only('create calendar')
        return if !is_admin
        calendar = params[:calendar]
        create_object(Calendar, calendar, new_calendar_path, calendar_index_path)
    end
    
    def delete_calendar
        is_admin = admin_only('delete calendar')
        return if !is_admin
        delete_object(Calendar)
        redirect_to calendar_index_path
    end       

    def edit_calendar
        is_admin = admin_only('edit calendar')
        return if !is_admin
        edit_object(Calendar)
    end

    def update_calendar
        is_admin = admin_only('update calendar')
        return if !is_admin
        calendar = params[:calendar]
        update_object(Calendar, calendar, edit_calendar_path, calendar_index_path)
    end
    
    def action_calendar
        my_action = params[:do_action]
        is_admin = admin_only('#{my_action} calendar')
        return if !is_admin
        do_action(Calendar, my_action, calendar_index_path)
    end
    
    
end
