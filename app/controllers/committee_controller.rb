class CommitteeController < ApplicationController
    layout "base"
    
    def index
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
        elsif Commitee.has_name?(committee[:name])
            flash[:notice] = "The committe name provided already exists. Please enter a different name."
            redirect_to new_committee_path
        else
            committee = params[:committee]
            if committee[:name].to_s == "" then
                flash[:notice] = "Please fill in the committee name field."
                redirect_to new_committee_path
            elsif Commitee.has_name?(committee[:name]) then
                flash[:notice] = "The committee name provided already exists. Please enter a different name."
                redirect_to new_committee_path
            else
                Commitee.create!(:name => committee[:name])
                flash[:notice] = "The committee #{committee[:name]} was successfully created!"
                redirect_to committee_index_path
            end
        end
    end
    
end
