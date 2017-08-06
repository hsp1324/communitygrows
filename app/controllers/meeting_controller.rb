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
        update_meeting_time_date(:date, "date", @meeting.date, "MM/DD/YYYY", '%m/%d/%Y', Date)
        update_meeting_time_date(:time, "time", @meeting.time, "HH:MM AM/PM", '%I:%M %p', Time)
        update_meeting_hangout_agenda_location_description(:location, "location", @meeting.location)
        update_meeting_hangout_agenda_location_description(:description, "description", @meeting.description)
        update_meeting_hangout_agenda_location_description(:agenda, "agenda", @meeting.agenda)
        update_meeting_hangout_agenda_location_description(:hangout, "hangout", @meeting.hangout)

        ##############  before combine ###############
        # update_meeting_date()
        # update_meeting_time()    
        # # update_meeting_location()
        # # update_meeting_description()
        # update_meeting_locationORdescription(:location, "location", @meeting.location)
        # update_meeting_locationORdescription(:description, "description", @meeting.description)
        # # update_meeting_agenda()
        # # update_meeting_hangout()
        # update_meeting_hangout_agenda(:agenda, "agenda", @meeting.agenda)
        # update_meeting_hangout_agenda(:hangout, "hangout", @meeting.hangout)
        ##############  before combine ###############
        
        
        
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


    ################   update_meeting_time_date(object, object_str, meeting_object, valid_format, valid_input, time_date) #########
    # def update_meeting_date
    #     is_admin = admin_only('update meeting date')
    #     return if !is_admin
    #     meeting = params[:meeting]
    #     if meeting[:date].to_s == ''
    #         flash[:errors] = flash[:errors] + " date [Please fill in the date field.], "
    #         return
    #     end

    #     begin
    #         new_date = Date.strptime(meeting[:date], '%m/%d/%Y')
    #         if !(@meeting.date == new_date.strftime('%m/%d/%Y'))
    #             @meeting.update_attributes!(:date => new_date.strftime('%m/%d/%Y'))
    #             flash[:notice] = flash[:notice] + " date, "
    #         end
    #         return
    #     rescue ArgumentError
    #         flash[:errors] = flash[:errors] + " date [New date must be in MM/DD/YYYY format], "
    #         return
    #     end
    # end

    # def update_meeting_time
    #     is_admin = admin_only('update meeting time')
    #     return if !is_admin
    #     meeting = params[:meeting]
    #     if meeting[:time].to_s == ''
    #         flash[:errors] = flash[:errors] + " time [Please fill in the time field.], "
    #         return
    #     end
    #     begin
    #         new_time = Time.strptime(meeting[:time], '%I:%M %p')
    #         if !(@meeting.time == new_time.strftime('%I:%M %p'))
    #             @meeting.update_attributes!(:time => new_time.strftime('%I:%M %p'))
    #             flash[:notice] = flash[:notice] + " time, "
    #         end
    #         return
    #     rescue ArgumentError
    #         flash[:errors] = flash[:errors] + " time [New time must be in HH:MM AM/PM format], "
    #         return
    #     end
    # end
    ################   update_meeting_time_date(object, object_str, meeting_object, valid_format, valid_input, time_date) #########
    
    def update_meeting_time_date(object, object_str, meeting_object, valid_format, valid_input, time_date)
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

    ##################### update_meeting_locationORdescription(subject, object_str) ##############
    # def update_meeting_location
    #     is_admin = admin_only('update meeting location')
    #     return if !is_admin
    #     @meeting = Meeting.find(params[:id])
    #     meeting = params[:meeting]
    #     if meeting[:location].to_s == ''
    #         flash[:errors] = flash[:errors] + " location [Please fill in the location field.], "
    #         return
    #     else
    #         @meeting = Meeting.find(params[:id])
    #         meeting = params[:meeting]
    #         if !(@meeting.location == meeting[:location])
    #             @meeting.update_attributes!(:location => meeting[:location].to_s)
    #             flash[:notice] = flash[:notice] + " location, "
    #         end
    #         return
    #     end
    # end

    # def update_meeting_description
    #     is_admin = admin_only('update meeting description')
    #     return if !is_admin
    #     @meeting = Meeting.find(params[:id])
    #     meeting = params[:meeting]
    #     if meeting[:description].to_s == ''
    #         flash[:errors] = flash[:errors] + " description [Please fill in the description field.], "
    #         return
    #     else
    #         @meeting = Meeting.find(params[:id])
    #         meeting = params[:meeting]
    #         if !(@meeting.description == meeting[:description])
    #             @meeting.update_attributes!(:description => meeting[:description].to_s)
    #             flash[:notice] = flash[:notice] + " description, "
    #         end
    #         return
    #     end
    # end
    ##################### update_meeting_locationORdescription(object, object_str) ##############
    
    
    ##################### update_meeting_hangout_agenda_location_description(object, object_str, meeting_object) ##############
    # def update_meeting_locationORdescription(object, object_str, meeting_object)
    #     is_admin = admin_only('update meeting #{object_str}')
    #     return if !is_admin
        
    #     # @meeting = Meeting.find(params[:id])  # Already declared in update_meeting
    #     meeting = params[:meeting]
    #     if meeting[object].to_s == ''
    #         flash[:errors] = flash[:errors] + " #{object_str} [Please fill in the #{object_str} field.], "
    #         return
    #     else
    #         # already declared
    #         # @meeting = Meeting.find(params[:id])
    #         # meeting = params[:meeting]
    #         if !(meeting_object == meeting[object])
    #             @meeting.update_attributes!(object => meeting[object].to_s)
    #             flash[:notice] = flash[:notice] + " #{object_str}, "
    #         end
    #         return
    #     end
    # end
    
    # def update_meeting_hangout_agenda(object, object_str, meeting_object)
    #     is_admin = admin_only('update meeting #{object_str}')
    #     return if !is_admin
        
    #     # @meeting = Meeting.find(params[:id])  # Already declared in update_meeting
    #     meeting = params[:meeting]
    #     if meeting[object].to_s == ''
    #         # Implementer didn't include this flash message in hangout and agenda whereas Location and Description has
    #         # flash[:errors] = flash[:errors] + " #{object_str} [Please fill in the #{object_str} field.], "
    #         return
    #     elsif !(meeting[object]=~/.com(.*)/)
    #         flash[:errors] = flash[:errors] + " #{object_str} [Please enter a valid URL for #{object_str}.], "
    #         return
    #     else
    #         if !(meeting[object]=~/http(s)?:/)
    #             meeting[object]="http://"+meeting[object]
    #         end
    #         # already declared
    #         # @meeting = Meeting.find(params[:id])
    #         # meeting = params[:meeting]

    #         if !(meeting_object == meeting[object])
    #             @meeting.update_attributes!(object => meeting[object].to_s)
    #             flash[:notice] = flash[:notice] + " #{object_str}, "
    #         end
    #         return
    #     end
    # end
    ################## update_meeting_hangout_agenda_location_description(object, object_str, meeting_object) ) ################


    ################## update_meeting_hangout_agenda(object, object_str) ################
    # def update_meeting_agenda
    #     is_admin = admin_only('update meeting agenda')
    #     return if !is_admin
    #     @meeting = Meeting.find(params[:id])
    #     meeting = params[:meeting]
    #     if meeting[:agenda].to_s == ''
    #         return
    #     elsif !(meeting[:agenda]=~/.com(.*)/)
    #         flash[:errors] = flash[:errors] + " agenda [Please enter a valid URL for agenda.], "
    #         return
    #     else
    #         if !(meeting[:agenda]=~/http(s)?:/)
    #             meeting[:agenda]="http://"+meeting[:agenda]
    #         end
    #         @meeting = Meeting.find(params[:id])
    #         meeting = params[:meeting]
    #         if !(@meeting.agenda == meeting[:agenda])
    #             @meeting.update_attributes!(:agenda => meeting[:agenda].to_s)
    #             flash[:notice] = flash[:notice] + " agenda, "
    #         end
    #         return
    #     end
    # end

    # def update_meeting_hangout
    #     is_admin = admin_only('update meeting hangout')
    #     return if !is_admin
    #     @meeting = Meeting.find(params[:id])
    #     meeting = params[:meeting]
    #     if meeting[:hangout].to_s == ''
    #         return
    #     elsif !(meeting[:hangout]=~/.com(.*)/)
    #         flash[:errors] = flash[:errors] + " hangout [Please enter a valid URL for hangout.], "
    #         return
    #     else
    #         if !(meeting[:hangout]=~/http(s)?:/)
    #             meeting[:hangout]="http://"+meeting[:hangout]
    #         end
    #         @meeting = Meeting.find(params[:id])
    #         meeting = params[:meeting]
    #         if !(@meeting.hangout == meeting[:hangout])
    #             @meeting.update_attributes!(:hangout => meeting[:hangout].to_s)
    #             flash[:notice] = flash[:notice] + " hangout, "
    #         end
    #         return
    #     end
    # end
    ################## update_meeting_hangout_agenda(object, object_str) ################

end
