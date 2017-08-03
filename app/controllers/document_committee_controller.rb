class DocumentCommitteeController < ActionController::Base
    protect_from_forgery
    layout "base"
    before_action :authenticate_user!
    include EmailHelper
    
    def new_document
    end
    
    def create_document
        @document_name = params[:title].to_s
        @committee_type = params[:committee_type]
        @document_exists = Document.find_by(:title => @document_name, :committee_type => @committee_type)
        if @document_name == "" or params[:url].to_s == ""
            flash[:notice] = "Populate all fields before submission."
            redirect_to new_committee_document_path
        elsif !(params[:url]=~/.com(.*)/)
            flash[:notice] = "Please enter a valid URL."
            redirect_to new_committee_document_path
        elsif @document_exists
            flash[:notice] = "Document named #{@document_name} already exists."
            redirect_to new_committee_document_path
        else
            if !(params[:url]=~/http(s)?:/)
                params[:url]="http://"+params[:url]
            end
            @title = params[:title]
            @url = params[:url]
            
            @new_doc = Document.create(:title => @title, :url => @url, :committee_type => @committee_type)
            flash[:notice] = 'Document List creation successful and email was successfully sent.'
            
            MailRecord.create!(:record_type => "document", :record_id => @new_doc.id, :committee => @committee_type)
            
            if Rails.env.production?
                send_document_email(Committee.find_by(name: @committee_type), @new_doc)
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
            
            @prev_mailrecord = MailRecord.find_by(record_type: 'announcement', record_id: params[:id])
            if @prev_mailrecord
                @prev_mailrecord.touch
            else
                MailRecord.create!(:record_type => "document", :record_id => params[:id], :committee => @committee_type)
            end
            
            if Rails.env.production?
                send_document_update_email(Committee.find_by(name: @committee_type), @target_document)
            end
            flash[:notice] = "Executive Document List with title [#{@target_document.title}] updated successfully and email was successfully sent."
            redirect_to subcommittee_index_path(@committee_type)
        end
    end
    def delete_document
        @committee_type = params[:committee_type]
        @target_document = Document.find params[:document_id]
        @target_document.destroy!
        
        @prev_mailrecord =MailRecord.find_by(record_type: 'announcement', record_id: params[:id])
        if @prev_mailrecord
            @prev_mailrecord.destroy!
        end
        flash[:notice] = "Executive Document List with title [#{@target_document.title}] deleted successfully"
        redirect_to subcommittee_index_path(@committee_type)
    end
    
    def transfer_document
        @single_transfer = params[:single_transfer]
        @committee_type = params[:committee_type]
        # @all_categories = params[:all_categories]
        if @single_transfer == "true"
            @document_id = params[:id]
            @document = Document.find @document_id
        end
        @all_categories = [['no selection', 'no selection']]
        Category.all.each do |category|
            @all_categories << [category.name, category.name]
        end
    end
    
    #When you transfer files from committee page to document repository
    def transfer_file_to_repository
        @committee_type = params[:committee_type]
        @documents = params[:document]
        if @documents != nil
            @documents.each_pair do |document_name, category_type|
                #if no selection, then skip
                next if category_type == "no selection"
                @doc = Document.find_by(:title => document_name, :committee_type => @committee_type)
                #if document has been transferred, then skip
                next if @doc.transfer == true
                @file_params = {:url => @doc.url, :title => @doc.title}
                @category = Category.find_by(:name => category_type)
                @category.documents.create(@file_params)
                @doc.update_attribute :transfer, true
                flash[:notice] = "Documents were successfully transferred to Document Repository"
            end
        end
        redirect_to subcommittee_index_path(@committee_type)
    end
end

