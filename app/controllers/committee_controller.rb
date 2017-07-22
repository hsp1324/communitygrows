class CommitteeController < ApplicationController
    layout "base"
    
    def index
        @committees = Committee.all
    end

    def new_committee
    end

    def create_committee
    	if !current_user.admin
            flash[:message] = "Only admins can create committees."
            redirect_to root_path and return
        end
        committee = params[:committee]
        if committee[:name].to_s == ""
            flash[:notice] = "Committee name field cannot be blank."
            redirect_to new_committee_path
        elsif Committee.has_name?(committee[:name])
            flash[:notice] = "Committee name provided already exists. Please enter a different name."
            redirect_to new_committee_path
        else
            committee = params[:committee]
            if committee[:name].to_s == "" then
                flash[:notice] = "Please fill in the committee name field."
                redirect_to new_committee_path
            elsif Committee.has_name?(committee[:name]) then
                flash[:notice] = "Committee name provided already exists. Please enter a different name."
                redirect_to new_committee_path
            else
                Committee.create!(:name => committee[:name])
                flash[:notice] = "Committee #{committee[:name]} was successfully created!"
                redirect_to committee_index_path
            end
        end
    end

    def delete_committee
        if !current_user.admin
            flash[:message] = "Only admins can create committees."
            redirect_to root_path and return
        end
        @id = params[:id] 
        @committee = Committee.find(@id)
        @committee.destroy!
        flash[:notice] = "Committee with name #{@committee.name} deleted successfully."
        redirect_to committee_index_path
    end       

    def edit_committee
        if !current_user.admin
            flash[:message] = "Only admins can create committees."
            redirect_to root_path and return
        end
        @id = params[:id] 
        @committee = Committee.find(@id)
        @committees = Committee.all
    end

    def update_committee
        if !current_user.admin
            flash[:message] = "Only admins can create committees."
            redirect_to root_path and return
        end
        @committee = Committee.find(params[:id])
        committee = params[:committee]
        if committee[:name].to_s == ''
            flash[:notice] = "Please fill in the committee name field."
            redirect_to edit_committee_path
        elsif Committee.has_name?(committee[:name].to_s)
            flash[:notice] = "Committee name provided already exists. Please enter a different name."
            redirect_to edit_committee_path
        else
            @committee = Committee.find(params[:id])
            committee = params[:committee]
            if committee[:name].to_s == '' then
                flash[:notice] = "Please fill in the committee name field."
                redirect_to edit_committee_path
            elsif Committee.has_name?(committee[:name].to_s)
                flash[:notice] = "Committee name provided already exists. Please enter a different name."
                redirect_to edit_committee_path
            else
                @committee.update_attributes!(:name => committee[:name].to_s)
                flash[:notice] = "Committee with name [#{@committee.name}] updated successfully and email was successfully sent."
                redirect_to committee_index_path
            end
        end

    end
    
end
