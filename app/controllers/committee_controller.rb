class CommitteeController < ApplicationController
    layout "base"
    
    def admin_only(action)
        if !current_user.admin
            flash[:message] = "Only admins can #{action}"
            # return false
            redirect_to root_path and return
        else
            return true
        end
    end
    
    def index
        @committees = Committee.all
    end

    def new_committee
    end
    
    def create_committee
        is_admin = admin_only('create committee')
        return if !is_admin
        committee = params[:committee]
        if committee[:name].to_s == ""
            flash[:notice] = "Committee name field cannot be blank."
            redirect_to new_committee_path
        elsif Committee.has_name?(committee[:name])
            flash[:notice] = "Committee name provided already exists. Please enter a different name."
            redirect_to new_committee_path
        else
            Committee.create!(:name => committee[:name], :hidden => true, :inactive => true)
            flash[:notice] = "Committee #{committee[:name]} was successfully created!"
            redirect_to committee_index_path
        end
    end

    def delete_committee
        is_admin = admin_only('delete committee')
        return if !is_admin
        @id = params[:id] 
        @committee = Committee.find(@id)
        @committee.destroy!
        flash[:notice] = "Committee with name #{@committee.name} deleted successfully."
        redirect_to committee_index_path
    end       

    def edit_committee
        is_admin = admin_only('edit committee')

        return if !is_admin
        @id = params[:id] 
        @committee = Committee.find(@id)
        @committees = Committee.all
    end

    def update_committee

        is_admin = admin_only('update committee')

        return if !is_admin
        @committee = Committee.find(params[:id])
        committee = params[:committee]
        if committee[:name].to_s == ''
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

    def hide_committee

        is_admin = admin_only('hide committee')

        return if !is_admin
        committee = Committee.find(params[:id])
        committee.hide 
        flash[:notice] = "#{committee.name} successfully hidden."
        redirect_to committee_index_path
    end

    def show_committee

        is_admin = admin_only('show committee')

        return if !is_admin
        committee = Committee.find(params[:id])
        committee.show
        flash[:notice] = "#{committee.name} successfully shown."
        redirect_to committee_index_path
    end

    def inactivate_committee

        is_admin = admin_only('inactivate committee')

        return if !is_admin
        committee = Committee.find(params[:id])
        committee.inactivate
        flash[:notice] = "#{committee.name} successfully made inactive."
        redirect_to committee_index_path
    end

    def activate_committee

        is_admin = admin_only('activate committee')

        return if !is_admin
        committee = Committee.find(params[:id])
        committee.activate
        flash[:notice] = "#{committee.name} successfully made active."
        redirect_to committee_index_path
    end
    
    #added the two methods below for adding and removing committee members
    def remove_member

        is_admin = admin_only('remove committee members.')

        return if !is_admin
        committee = Committee.find(params[:id])
        user = User.find(params[:user_id])
        # remove user from committee with activerecord model query
        # Participation.where(user_id: user.id).where(committee_id: committee.id).destroy!
        
        Participation.find_by(committee_id: committee.id, user_id: user.id).destroy!
        flash[:notice] = "#{user.name} successfully removed from #{committee.name}."
        redirect_to edit_committee_path and return
    end

    def add_member

        is_admin = admin_only('add committee members.')

        return if !is_admin
        committee = Committee.find(params[:id])
        user = User.find(params[:user_id])
        #add user to committee with activerecord model query
        Participation.create!(:user_id => user.id, :committee_id => committee.id, :joined_at => DateTime.now, :created_at => DateTime.now, :updated_at => DateTime.now)
        flash[:notice] = "#{user.name} successfully added to #{committee.name}."
        redirect_to edit_committee_path and return
    end
    
end
