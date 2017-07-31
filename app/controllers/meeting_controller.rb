class MeetingController < ApplicationController
    layout "base"
    require 'time'
    require 'date'
    include AdminHelper
    include ControllerHelper
    
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
        is_admin = admin_only('create committee')
        return if !is_admin
        meeting = params[:meeting]

        if meeting[:name].to_s == ""
            flash[:notice] = "Meeting name field cannot be blank."
            redirect_to new_meeting_path and return
        elsif Meeting.has_name?(meeting[:name])
            flash[:notice] = "Meeting name provided already exists. Please enter a different name."
            redirect_to new_meeting_path and return
        elsif meeting[:description].to_s == ''
            flash[:notice] = "Please fill in the description field."
            redirect_to new_meeting_path and return
        elsif meeting[:location].to_s == ''
            flash[:notice] = "Please fill in the location field."
            redirect_to new_meeting_path and return
        elsif meeting[:time].to_s == ''
            flash[:notice] = "Please fill in the time field."
            redirect_to new_meeting_path and return
        elsif meeting[:date].to_s == ''
            flash[:notice] = "Please fill in the date field."
            redirect_to new_meeting_path and return
        else

            begin
                Date.strptime(meeting[:date], '%m/%d/%Y')
            rescue ArgumentError
                flash[:notice] = "New date must be in MM/DD/YYYY format"
                redirect_to new_meeting_path and return
            end


            begin
                Time.strptime(meeting[:time], '%I:%M %p')
            rescue ArgumentError
                flash[:notice] = "New time must be in HH:MM AM/PM format"
                redirect_to new_meeting_path and return
            end

            meeting = params[:meeting]
            Meeting.create!(:name => meeting[:name], :date => Date.strptime(meeting[:date], '%m/%d/%Y').strftime('%m/%d/%Y'), :time => Time.strptime(meeting[:time], '%I:%M %p').strftime('%I:%M %p'), :location => meeting[:location], :description => meeting[:description])
            flash[:notice] = "Meeting #{meeting[:name]} was successfully created!"
            redirect_to meeting_index_path
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
        meeting = params[:meeting]
        update_object(Meeting, meeting, edit_meeting_path, edit_meeting_path)
    end

    def update_meeting_date
        is_admin = admin_only('update meeting date')
        return if !is_admin

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
        is_admin = admin_only('update meeting time')
        return if !is_admin

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
        is_admin = admin_only('update meeting location')
        return if !is_admin
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
        is_admin = admin_only('update meeting description')
        return if !is_admin
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
        is_admin = admin_only('update meeting agenda')
        return if !is_admin
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
        is_admin = admin_only('update meeting hangout')
        return if !is_admin
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
