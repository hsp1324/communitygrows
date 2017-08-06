class MeetingController < ApplicationController
    layout "base"
    require 'time'
    require 'date'
    include AdminHelper
    include ControllerHelper
    include EmailHelper
    
    def index
        @meetings = Meeting.all
    end

    def new_meeting
    end

    def meeting_list
        @meetings = Meeting.all
    end

    def show
        @meeting = Meeting.find(params[:id])
    end

    def crud_meeting
        crud_action = params[:do_action]
        is_admin = admin_only('#{crud_action} meetings.')
        return if !is_admin
        meeting = params[:meeting]
        if crud_action == 'create'
            create_object(Meeting, meeting, new_meeting_path, meeting_index_path)
        elsif crud_action == 'update'
            update_object(Meeting, meeting, edit_meeting_path, meeting_index_path)
        elsif crud_action == 'delete'
            delete_object(Meeting)
            redirect_to meeting_index_path
        else
            redirect_to meeting_index_path
        end
    end


    def create_meeting
        params[:meeting].each do |fields|
        end 
        is_admin = admin_only('create meetings')
        return if !is_admin
        meeting = params[:meeting]

        if is_blank
            redirect_to new_meeting_path and return
        else
            date_valid = check_valid_format(Date, meeting[:date], "MM/DD/YYYY", '%m/%d/%Y', "date")
            time_valid = check_valid_format(Time, meeting[:time], "HH:MM AM/PM", '%I:%M %p', "time")
            if !(date_valid and time_valid)
                redirect_to new_meeting_path and return
            end
            meeting = params[:meeting]
            @new_meeting = Meeting.create(:name => meeting[:name], :date => Date.strptime(meeting[:date], '%m/%d/%Y').strftime('%m/%d/%Y'), :time => Time.strptime(meeting[:time], '%I:%M %p').strftime('%I:%M %p'), :location => meeting[:location], :description => meeting[:description])
            
            @new_meeting.create_mail_record(:description => "create")
            
            if Rails.env.production?
                send_meeting_email(@new_meeting)
            end
            
            flash[:notice] = "Meeting #{meeting[:name]} was successfully created!"
            redirect_to meeting_index_path
        end
    end
    
    def check_valid_format(time_date, meeting_arg, valid_format, valid_input, time_date_str)
        begin
            time_date.strptime(meeting_arg, valid_input)
            return true
        rescue ArgumentError
            flash[:notice] = "New #{time_date_str} must be in #{valid_format} format"
            return false
        end
    end
    
    def is_blank
        meeting = params[:meeting]
        if meeting[:name].to_s == ""
            flash[:notice] = "Meeting name field cannot be blank."
            return true
        elsif Meeting.has_name?(meeting[:name])
            flash[:notice] = "Meeting name provided already exists. Please enter a different name."
            return true
        elsif meeting[:description].to_s == ''
            flash[:notice] = "Please fill in the description field."
            return true
        elsif meeting[:location].to_s == ''
            flash[:notice] = "Please fill in the location field."
            return true
        elsif meeting[:time].to_s == ''
            flash[:notice] = "Please fill in the time field."
            return true
        elsif meeting[:date].to_s == ''
            flash[:notice] = "Please fill in the date field."
            return true
        end
    end

    def delete_meeting
        is_admin = admin_only('delete meetings')
        return if !is_admin
        delete_object(Meeting)
        redirect_to meeting_index_path
    end       

    def edit_meeting
        is_admin = admin_only('edit meetings')
        return if !is_admin
        edit_object(Meeting)
    end

    def update_meeting
        is_admin = admin_only('update meetings')
        return if !is_admin
        meeting_params = params[:meeting]
        @meeting = Meeting.find(params[:id])
        
        flash[:notice] = "Successfully Updated:"
        flash[:errors] = "Unsucessfull Updates:"
        if meeting_params[:name].to_s() == ''
            flash[:errors] = flash[:errors] + " name [Please Fill in name], "
        elsif !Meeting.has_name?(meeting_params[:name])
            @meeting.update_attributes!(:name => meeting_params[:name])
            flash[:notice] = flash[:notice] + " name, "
        end
        # update_meeting_date()
        # update_meeting_time()
        update_meeting_time_date("date")
        update_meeting_time_date("time")
        update_meeting_hangout_agenda_location_description(:location, "location", @meeting.location)
        update_meeting_hangout_agenda_location_description(:description, "description", @meeting.description)
        update_meeting_hangout_agenda_location_description(:agenda, "agenda", @meeting.agenda)
        update_meeting_hangout_agenda_location_description(:hangout, "hangout", @meeting.hangout)
        
        
        
        if @meeting.mail_record
            @meeting.mail_record.update_attribute(:description, "update")
        else
            @meeting.create_mail_record(:description => "update")
        end
        
        if Rails.env.production?
            send_meeting_update_email(@meeting)
        end
        
        redirect_to edit_meeting_path and return
    end

   
    def update_meeting_time_date(object_str)
        if object_str == 'date'
            object = :date
            meeting_object = @meeting.date
            valid_format = "MM/DD/YYYY"
            valid_input = '%m/%d/%Y'
            time_date = Date
        else
            object = :time
            meeting_object = @meeting.time
            valid_format = "HH:MM AM/PM"
            valid_input = '%I:%M %p'
            time_date = Time 
        end
        is_admin = admin_only('update meeting #{object_str}')
        return if !is_admin
        meeting = params[:meeting]
        if meeting[object].to_s == ''
            flash[:errors] = flash[:errors] + " #{object_str} [Please fill in the #{object_str} field.], "
            return
        end
        begin
            new_timeORdate = time_date.strptime(meeting[object], valid_input)
            if !(meeting_object == new_timeORdate.strftime(valid_input))
                @meeting.update_attributes!(object => new_timeORdate.strftime(valid_input))
                flash[:notice] = flash[:notice] + " #{object_str}, "
            end
            return
        rescue ArgumentError
            flash[:errors] = flash[:errors] + " #{object_str} [New #{object_str} must be in #{valid_format} format], "
            return
        end
    end
    
    
    def update_meeting_hangout_agenda_location_description(object, object_str, meeting_object)
        is_admin = admin_only('update meeting #{object_str}')
        return if !is_admin
        meeting = params[:meeting]
        if meeting[object].to_s == ''
            # agenda and hangout could be empty because they might haven't decided yet
            if (object_str == "agenda" or object_str == "hangout")
                return
            end
            flash[:errors] = flash[:errors] + " #{object_str} [Please fill in the #{object_str} field.], "
            
            return
        elsif !(meeting[object]=~/.com(.*)/) and (object_str == "agenda" or object_str == "hangout")
            flash[:errors] = flash[:errors] + " #{object_str} [Please enter a valid URL for #{object_str}.], "
            return
        else
            if !(meeting[object]=~/http(s)?:/) and (object_str == "agenda" or object_str == "hangout")
                meeting[object]="http://"+meeting[object]
            end

            if !(meeting_object == meeting[object])
                @meeting.update_attributes!(object => meeting[object].to_s)
                flash[:notice] = flash[:notice] + " #{object_str}, "
            end
            return
        end
    end

end
