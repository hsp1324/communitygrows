class CommitteeController < ApplicationController
    layout "base"
    before_action :authenticate_user!, :authorize_user
    include AdminHelper
    include ControllerHelper
    include EmailHelper
    
    def index
        @committees = Committee.all
    end

    def new_committee
    end
    
    def crud_committee
        crud_action = params[:do_action]
        is_admin = admin_only('#{crud_action} committee.')
        return if !is_admin
        committee = params[:committee]
        if crud_action == 'create'
            create_object(Committee, committee, new_committee_path, committee_index_path)
        elsif crud_action == 'update'
            old_committee = Committee.find(params[:id])
            
            name_change = false
            description_change = false
            
            if old_committee.name != committee[:name]
                name_change = true
                old_name = old_committee.name
                old_record = MailRecord.find_by("description LIKE ?", 'name%')
                description = "name " + old_committee.name
                if old_record == nil
                    old_committee.mail_records<<(MailRecord.create(:description => description))
                else
                    old_record.touch
                end
                
            end
            
            if old_committee.description != committee[:description]
                description_change = true
                old_record = MailRecord.find_by(description: "description")
                if old_record == nil
                    old_committee.mail_records<<(MailRecord.create(:description => "description"))
                else
                    old_record.touch
                end
            end
            
            if Rails.env.production?
                if name_change and description_change
                    send_committee_update_email(old_committee, old_name, committee[:name], committee[:description])
                elsif name_change
                    send_committee_name_update_email(old_committee, old_name, committee[:name])
                elsif description_change
                    send_committee_description_update_email(old_committee, committee[:description])
                end
            end
            
            update_object(Committee, committee, edit_committee_path, committee_index_path)
        elsif crud_action == 'delete'
            committee = Committee.find(params[:id])
            committee.announcements.destroy_all
            committee.documents.where(category_id: nil).destroy_all
            committee.mail_records.where(category_id: nil).destroy_all

            delete_object(Committee)
            redirect_to committee_index_path
        else
            redirect_to committee_index_path
        end
    end
    
    def create_committee
        is_admin = admin_only('create committee')
        return if !is_admin
        committee = params[:committee]
        create_object(Committee, committee, new_committee_path, committee_index_path)

        # if committee[:name].to_s == ""
        #     flash[:notice] = "Committee name field cannot be blank."
        #     redirect_to new_committee_path
        # elsif Committee.has_name?(committee[:name])
        #     flash[:notice] = "Committee name provided already exists. Please enter a different name."
        #     redirect_to new_committee_path
        # else
        #     Committee.create!(:name => committee[:name], :hidden => true, :inactive => true)
        #     flash[:notice] = "Committee #{committee[:name]} was successfully created!"
        #     redirect_to committee_index_path
        # end
    end

    def delete_committee
        is_admin = admin_only('delete committee')
        return if !is_admin
        delete_object(Committee)
        redirect_to committee_index_path
    end       

    def edit_committee
        is_admin = admin_only('edit committee')
        return if !is_admin
        edit_object(Committee)
    end

    def update_committee
        is_admin = admin_only('update committee')
        return if !is_admin
        committee = params[:committee]
        update_object(Committee, committee, edit_committee_path, committee_index_path)

    end

    # def hide_committee
    #     is_admin = admin_only('hide committee')
    #     return if !is_admin
    #     do_action(Committee, 'hide', committee_index_path)
    #     # redirect_to committee_index_path
    # end

    # def show_committee
    #     is_admin = admin_only('show committee')
    #     return if !is_admin
    #     act = params[:do_action]
    #     puts "*"*100
    #     puts "do_action: #{act}"
    #     puts "*"*100
    #     do_action(Committee, 'show', committee_index_path)
    #     # redirect_to committee_index_path
    # end

    # def inactivate_committee
    #     is_admin = admin_only('inactivate committee')
    #     return if !is_admin
    #     do_action(Committee, 'inactive', committee_index_path)
    #     # redirect_to committee_index_path
    # end

    # def activate_committee
    #     is_admin = admin_only('activate committee')
    #     return if !is_admin
    #     do_action(Committee, 'active', committee_index_path)
    #     # redirect_to committee_index_path
    # end
    
    def action_committee
        my_action = params[:do_action]
        is_admin = admin_only('#{my_action} committee.')
        return if !is_admin
        do_action(Committee, my_action, committee_index_path)
        # redirect_to committee_index_path
    end
    
    #added the two methods below for adding and removing committee members
    def update_members
        is_admin = admin_only('remove committee members.')
        return if !is_admin
        committee = Committee.find(params[:id])
        
        
        #As a result of the below line, params[:members] should be passed in as an array of numbers (member ids) from edit_committee.html.haml
        form_data = []
        if !params[:check].nil?
            params[:check].each_pair do |user_id, checked|
                form_data<<(user_id)
            end
        end
        
        
        committee.users.each do |user|
            if form_data.include? user.id
                form_data.delete(user.id)
            else
                old_record = user.mail_records.find_by(committee_id: committee.id)
                if old_record
                    user.mail_records.delete(old_record)
                    old_record.destroy
                end
                user.committees.delete(committee)
            end
        end
        
        if Rails.env.production?
            send_member_email(committee, form_data)
        end
        
        form_data.each do |id|
            member = User.find(id) 
            committee.users<<(member)
            member.mail_records<<(MailRecord.create(:description => "add", :committee => committee))
        end
        
        # remove user from committee with activerecord model query
        # Participation.where(user_id: user.id).where(committee_id: committee.id).destroy!
        
        #Participation.find_by(committee_id: committee.id, user_id: user.id).destroy        
        flash[:notice] = "Successfully updated members in #{committee.name}."
        redirect_to edit_committee_path and return
    end

    # def add_member
    #     is_admin = admin_only('add committee members.')
    #     return if !is_admin
    #     committee = Committee.find(params[:id])
    #     user = User.find(params[:user_id])
    #     #add user to committee with activerecord model query
    #     #Participation.create!(:user_id => user.id, :committee_id => committee.id, :joined_at => DateTime.now, :created_at => DateTime.now, :updated_at => DateTime.now)
    #     committee.users<<(user)
        
    #     user.mail_records<<(MailRecord.create(:description => "added", :committee => committee))
        
    #     if Rails.env.production?
    #         send_member_email(committee, user)
    #     end
            
    #     flash[:notice] = "#{user.name} successfully added to #{committee.name}."
    #     redirect_to edit_committee_path and return
    # end
    
end
