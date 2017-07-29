class MeetingController < ApplicationController
    layout "base"
    require 'time'
    require 'date'
    
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


    def create_meeting
        params[:meeting].each do |fields|
            puts "#meeting field: #{fields}"
        end 
    	if !current_user.admin
            flash[:message] = "Only admins can create meetings."
            redirect_to root_path and return
        end
        meeting = params[:meeting]
        if meeting[:name].to_s == ""
            flash[:notice] = "Meeting name field cannot be blank."
            redirect_to new_meeting_path
        elsif Meeting.has_name?(meeting[:name])
            flash[:notice] = "Meeting name provided already exists. Please enter a different name."
            redirect_to new_meeting_path
        else
            meeting = params[:meeting]
            Meeting.create!(:name => meeting[:name])
            flash[:notice] = "Meeting #{meeting[:name]} was successfully created!"
            redirect_to meeting_index_path
        end
    end

    def delete_meeting
        if !current_user.admin
            flash[:message] = "Only admins can create Meetings."
            redirect_to root_path and return
        end
        @id = params[:id] 
        @meeting = Meeting.find(@id)
        @meeting.destroy!
        flash[:notice] = "Meeting with name #{@meeting.name} deleted successfully."
        redirect_to meeting_index_path
    end       

    def edit_meeting
        if !current_user.admin
            flash[:message] = "Only admins can create meetings."
            redirect_to root_path and return
        end
        @id = params[:id] 
        @meeting = Meeting.find(@id)
        @meetings = Meeting.all
    end

    def update_meeting
        if !current_user.admin
            flash[:message] = "Only admins can create meetings."
            redirect_to root_path and return
        end
        @meeting = Meeting.find(params[:id])
        meeting = params[:meeting]
        if meeting[:name].to_s == ''
            flash[:notice] = "Please fill in the meeting name field."
            redirect_to edit_meeting_path
        elsif Meeting.has_name?(meeting[:name].to_s)
            flash[:notice] = "Meeting name provided already exists. Please enter a different name."
            redirect_to edit_meeting_path
        else
            @meeting = Meeting.find(params[:id])
            meeting = params[:meeting]
            @meeting.update_attributes!(:name => meeting[:name].to_s)
            flash[:notice] = "Meeting with name [#{@meeting.name}] updated successfully."
            redirect_to edit_meeting_path
        end
    end

    def update_meeting_date
        if !current_user.admin
            flash[:message] = "Only admins can create meetings."
            redirect_to root_path and return
        end

        @meeting = Meeting.find(params[:id])
        meeting = params[:meeting]

        if meeting[:date].to_s == ''
            flash[:notice] = "Please fill in the date field."
            redirect_to edit_meeting_path and return
        end

        begin
            new_date = Date.strptime(meeting[:date], '%m/%d/%Y')
            @meeting.update_attributes!(:date => new_date.strftime('%m/%d/%Y'))
            flash[:notice] = "Meeting [#{@meeting.name}] date updated successfully."
            redirect_to edit_meeting_path and return
        rescue ArgumentError
            flash[:notice] = "New date must be in MM/DD/YYYY format"
            redirect_to edit_meeting_path and return
        end
    end

    def update_meeting_time
        if !current_user.admin
            flash[:message] = "Only admins can create meetings."
            redirect_to root_path and return
        end

        @meeting = Meeting.find(params[:id])
        meeting = params[:meeting]

        if meeting[:time].to_s == ''
            flash[:notice] = "Please fill in the time field."
            redirect_to edit_meeting_path and return
        end

        begin
            new_time = Time.strptime(meeting[:time], '%I:%M %p')
            @meeting.update_attributes!(:time => new_time.strftime('%I:%M %p'))
            flash[:notice] = "Meeting [#{@meeting.name}] time updated successfully."
            redirect_to edit_meeting_path and return
        rescue ArgumentError
            flash[:notice] = "New time must be in HH:MM AM/PM format"
            redirect_to edit_meeting_path and return
        end
    end


    def update_meeting_location
        if !current_user.admin
            flash[:message] = "Only admins can create meetings."
            redirect_to root_path and return
        end
        @meeting = Meeting.find(params[:id])
        meeting = params[:meeting]
        if meeting[:location].to_s == ''
            flash[:notice] = "Please fill in the location field."
            redirect_to edit_meeting_path
        else
            @meeting = Meeting.find(params[:id])
            meeting = params[:meeting]
            @meeting.update_attributes!(:location => meeting[:location].to_s)
            flash[:notice] = "Meeting with name [#{@meeting.name}] location updated successfully."
            redirect_to edit_meeting_path
        end
    end

    def update_meeting_description
        if !current_user.admin
            flash[:message] = "Only admins can create meetings."
            redirect_to root_path and return
        end
        @meeting = Meeting.find(params[:id])
        meeting = params[:meeting]
        if meeting[:description].to_s == ''
            flash[:notice] = "Please fill in the description field."
            redirect_to edit_meeting_path
        else
            @meeting = Meeting.find(params[:id])
            meeting = params[:meeting]
            @meeting.update_attributes!(:description => meeting[:description].to_s)
            flash[:notice] = "Meeting with name [#{@meeting.name}] description updated successfully."
            redirect_to edit_meeting_path
        end
    end

    def update_meeting_agenda
        if !current_user.admin
            flash[:message] = "Only admins can create meetings."
            redirect_to root_path and return
        end
        @meeting = Meeting.find(params[:id])
        meeting = params[:meeting]
        if meeting[:agenda].to_s == ''
            flash[:notice] = "Please fill in the agenda field."
            redirect_to edit_meeting_path
        elsif !(meeting[:agenda]=~/.com(.*)/)
            flash[:notice] = "Please enter a valid URL for agenda."
            redirect_to edit_meeting_path
        else
            if !(meeting[:agenda]=~/http(s)?:/)
                meeting[:agenda]="http://"+meeting[:agenda]
            end
            @meeting = Meeting.find(params[:id])
            meeting = params[:meeting]
            @meeting.update_attributes!(:agenda => meeting[:agenda].to_s)
            flash[:notice] = "Meeting with name [#{@meeting.name}] agenda updated successfully."
            redirect_to edit_meeting_path
        end
    end

    def update_meeting_hangout
        if !current_user.admin
            flash[:message] = "Only admins can create meetings."
            redirect_to root_path and return
        end
        @meeting = Meeting.find(params[:id])
        meeting = params[:meeting]
        if meeting[:hangout].to_s == ''
            flash[:notice] = "Please fill in the hangout field."
            redirect_to edit_meeting_path
        elsif !(meeting[:hangout]=~/.com(.*)/)
            flash[:notice] = "Please enter a valid URL for hangout link."
            redirect_to edit_meeting_path
        else
            if !(meeting[:hangout]=~/http(s)?:/)
                meeting[:hangout]="http://"+meeting[:hangout]
            end
            @meeting = Meeting.find(params[:id])
            meeting = params[:meeting]
            @meeting.update_attributes!(:hangout => meeting[:hangout].to_s)
            flash[:notice] = "Meeting with name [#{@meeting.name}] hangout updated successfully."
            redirect_to edit_meeting_path
        end
    end

end
