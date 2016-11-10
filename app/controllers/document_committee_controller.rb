class DocumentCommitteeController < ActionController::Base
    layout "base"
    before_action :authenticate_user!
    
    def new_document
        
    end
    
    def create_document
        if params[:title].to_s == "" or params[:url].to_s == ""
            flash[:notice] = "Populate all fields before submission."
            redirect_to new_committee_document_path
        elsif !(params[:url]=~/.com(.*)/)
            flash[:notice] = "Please enter a valid URL."
            redirect_to new_committee_document_path
        else
            if !(params[:url]=~/http(s)?:/)
                params[:url]="http://"+params[:url]
            end
            @title = params[:title]
            @url = params[:url]
            @committee_type = params[:committee_type]
            Document.create!(:title => @title, :url => @url, :committee_type => @committee_type)
            flash[:notice] = 'Document List creation successful and email was successfully sent.'
            if Rails.env.production?
                User.all.each do |user|
                    committe_user_internal = ""
                    committe_user_external = ""
                    committe_user_executive = ""
                    if user.internal == true
                        committe_user_internal = "internal"
                    end
                    if user.external == true
                        committe_user_external = "external"
                    end
                    if user.executive == true
                        committe_user_executive = "executive"
                    end

                    if current_user.admin?
                         NotificationMailer.new_document_email(user, Document.find_by_title(@title)).deliver
                    elsif @committee_type == committe_user_internal or @committee_type == committe_user_external or @committee_type == committe_user_executive 
                         NotificationMailer.new_document_email(user, Document.find_by_title(@title)).deliver
                    end
                end
            end
            redirect_to subcommittee_index_path(@committee_type)
        end
    end
    def edit_document
        @document_list_id = params[:id]
        @document = Document.find @document_list_id
    end
    def update_document
        if params[:title].to_s == "" or params[:url].to_s == ""
            flash[:notice] = "Populate all fields before submission."
            redirect_to new_committee_document_path
        elsif !(params[:url]=~/.com(.*)/)
            flash[:notice] = "Please enter a valid URL."
            redirect_to new_committee_document_path
        else
            @title = params[:title]
            if !(params[:url]=~/http(s)?:/)
                params[:url]="http://"+params[:url]
            end
            @url = params[:url]
            @committee_type = params[:committee_type]
            @target_document = Document.find params[:document][:id]
            @target_document.update_attributes!(:title => @title, :url => @url, :committee_type => @committee_type)
            if Rails.env.production?
                User.all.each do |user|
                    committe_user_internal = ""
                    committe_user_external = ""
                    committe_user_executive = ""
                    if user.internal == true
                        committe_user_internal = "internal"
                    end
                    if user.external == true
                        committe_user_external = "external"
                    end
                    if user.executive == true
                        committe_user_executive = "executive"
                    end                    
                    if current_user.admin?
                         NotificationMailer.new_document_email(user, Document.find_by_title(@title)).deliver
                    elsif @committee_type == "committe_user_internal" or @committee_type == committe_user_external or @committee_type == committe_user_executive 
                         NotificationMailer.new_document_email(user, Document.find_by_title(@title)).deliver
                    end
                end
            end
            flash[:notice] = "Executive Document List with title [#{@target_document.title}] updated successfully and email was successfully sent."
            redirect_to subcommittee_index_path(@committee_type)
        end
    end
    def delete_document
        @committee_type = params[:committee_type]
        @target_document = Document.find params[:document_id]
        @target_document.destroy!
        flash[:notice] = "Executive Document List with title [#{@target_document.title}] deleted successfully"
        redirect_to subcommittee_index_path(@committee_type)
    end
end

