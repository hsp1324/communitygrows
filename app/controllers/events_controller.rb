class EventsController < ApplicationController
    protect_from_forgery with: :exception
    layout "base"
    before_action :authenticate_user!
    include EmailHelper

    def event_params
        params.require(:event).permit(:title, :location, :description, :date, :url)
    end
    
    def new
    end
    
    def create
        @title = event_params[:title]
        @location = event_params[:location]
        @description = event_params[:description]
        @date = event_params[:date]
        
        if @title.empty?
            flash[:notice] = "Title field cannot be left blank."
            redirect_to a_new_event_path and return
        end
        
        if @date.empty?
            flash[:notice] = "Date field cannot be left blank."
            redirect_to a_new_event_path and return
        end
        begin
            if !Date.valid_date? *@date.split('-').map(&:to_i)
                flash[:notice] = "Date must be formated as YYYY-MM-DD  HH:mm(AM/PM) no parentheses"
                redirect_to a_new_event_path and return
            end
        rescue ArgumentError
            flash[:notice] = "Date was not correctly formatted, please follow provided format."
            redirect_to a_new_event_path and return
        end

        @event = Event.create(event_params)

        if Rails.env.production?
            NotificationMailer.new_event_email(User.find_by_email("james.jiang@berkeley.edu"), @event).deliver

            User.all.each do |user|
                if user.digest_pref == "daily"
                    NotificationMailer.new_event_email(user, @event).deliver!(wait_until: Time.now.tomorrow.noon())
                elsif user.digest_pref == "weekly"
                    # NotificationMailer.new_event_email(user, @event).deliver!(wait_until: Time.now.next_week.noon())
                else
                    NotificationMailer.new_event_email(user, @event).deliver
                end
            end
        end
        @event.save!
        flash[:notice] = "Event titled #{@title} created successfully and email was successfully sent."
        redirect_to admin_index_path
    end
    
    def edit
        @event = Event.find params[:id]
    end

    def update
        @event = Event.find params[:id]
        @title = event_params[:title]
        @date = event_params[:date]
        if @title.empty?
            flash[:notice] = "Title field cannot be left blank."
            redirect_to edit_event_path(@event.id) and return
        end
        
        if @date.empty?
            flash[:notice] = "Date field cannot be left blank."
            redirect_to edit_event_path(@event.id) and return
        end
        begin
            if !Date.valid_date? *@date.split('-').map(&:to_i)
                flash[:notice] = "Date must be formated as YYYY-MM-DD  HH:mm(AM/PM) no parentheses"
                redirect_to edit_event_path(@event.id) and return
            end
        rescue ArgumentError
            flash[:notice] = "Date was inproperly formatted, please follow provided format."
            redirect_to edit_event_path(@event.id) and return
        end
        
        flash[:notice] = "Event was updated and email was successfully sent."
        @event.update_attributes!(event_params)
        if Rails.env.production?
            User.all.each do |user| 
                if user.digest_pref == "daily"
                    NotificationMailer.event_update_email(user, @event).deliver!(wait_until: Time.now.tomorrow.noon())
                elsif user.digest_pref == "weekly"
                    NotificationMailer.event_update_email(user, @event).deliver!(wait_until: Time.now.next_week.noon())
                else
                    NotificationMailer.event_update_email(user, @event).deliver
                end
            end
        end
        redirect_to admin_index_path 
    end
    
    def delete
        @event = Event.find params[:id]
        @event.destroy
        redirect_to admin_index_path
    end
    
end
