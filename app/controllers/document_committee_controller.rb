class DocumentCommitteeController < ActionController::Base
    protect_from_forgery
    layout "base"
    before_action :authenticate_user!
    include EmailHelper
    
    def new_document
        @committee_name = Committee.find(params[:committee_id]).name
    end
    
    def create_document
        @document_name = params[:title].to_s
        @committee_id = params[:committee_id]
        @committee = Committee.find(@committee_id)

        @document_exists = @committee.documents.find_by(title: @document_name)
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
            
            @new_doc = @committee.documents.create(:title => @title, :url => @url)
            flash[:notice] = 'Document List creation successful and email was successfully sent.'
            
            @new_doc.create_mail_record(:description => "create", :committee => @committee)
            
            if Rails.env.production?
                send_document_email(@new_doc)
            end
            
            redirect_to subcommittee_index_path(@committee_id)
        end
    end

    def edit_document
        @document_list_id = params[:id]
        @document = Document.find @document_list_id
    end
    
    def update_document
        @title = params[:title]
        @url = params[:url]
            
        if @title.to_s == "" or @url.to_s == ""
            flash[:notice] = "Populate all fields before submission."
            redirect_to new_committee_document_path
        elsif !(@url=~/.com(.*)/)
            flash[:notice] = "Please enter a valid URL."
            redirect_to new_committee_document_path
        else
            if !(@url =~/http(s)?:/)
                params[:url]="http://"+params[:url]
            end

            @committee_id = params[:committee_id]
            @committee = Committee.find(@committee_id)
            @target_document = Document.find params[:document][:id]
            @target_document.update_attributes!(:title => @title, :url => @url)
            
            if @target_document.mail_record
                @target_document.mail_record.update_attribute(:description, "update")
            else
                @target_document.create_mail_record(:description => "update", :committee => @committee)
            end
            
            if Rails.env.production?
                send_document_update_email(@target_document)
            end
            
            flash[:notice] = "#{@committee.name} Document List with title [#{@target_document.title}] updated successfully and email was successfully sent."
            redirect_to subcommittee_index_path(@committee_id)
        end
    end
    
    def delete_document
        @committee_id = params[:committee_id]
        @committee = Committee.find(@committee_id)
        @target_document = Document.find params[:document_id]
        @name = @target_document.title
        
        if @target_document.category
            @committee.documents.delete(params[:document_id])
        else
            @target_document.destroy
        end
        
        flash[:notice] = "#{@committee.name} Document List with title [#{@name}] deleted successfully"
        redirect_to subcommittee_index_path(@committee_id)
    end
    
    def transfer_document
        @single_transfer = params[:single_transfer]
        @committee_id = params[:committee_id]
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
        @title = params[:title]
        @committee_id = params[:committee_id]
        @committee = Committee.find(@committee_id)
        @documents = params[:document]
        if @documents != nil
            @documents.each_pair do |document_name, category_type|
                #if no selection, then skip
                next if category_type == "no selection"
                @doc = Document.find_by(:title => document_name, :committee_id => @committee_id)
                next if @doc.transfer == true
                
                @category = Category.find_by(:name => category_type)
                @doc.update_attribute(:category, @category)
                @doc.update_attribute :transfer, true
                
                if @doc.mail_record
                    @doc.mail_record.update_attributes(:description => "transfer", :category => @category)
                else
                    @doc.create_mail_record(:description => "transfer", :committee => @committee, :category => @category)
                end
                
                if Rails.env.production?
                    send_document_transfer_email(@doc)
                end
                
                flash[:notice] = "Documents were successfully transferred to Document Repository"
            end
        end
        redirect_to subcommittee_index_path(@committee_id)
    end
end

