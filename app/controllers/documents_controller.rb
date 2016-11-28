class DocumentsController < ActionController::Base
    protect_from_forgery with: :exception
    layout "base"
    before_action :authenticate_user!
    
    def file_params
      params.require(:file).permit(:title, :url, :committee_type, :category_id)
    end
  
    def index
        # @documents = Document.all
        # @document_list = Document.order(updated_at: :DESC)
        @categories = Category.order("custom_order ASC").all
        @curr_user = current_user
    end
    
    def info_file
        @id = params[:format] 
        @file = Document.find @id
        @categories = Category.all
        @users = User.all.order(:email)
        @who_has_read = @file.users
    end
    
    def create_file
        @file = params[:file]
        if @file[:title].to_s == "" or @file[:url].to_s == ""
            flash[:notice] = "Populate all fields before submission."
            redirect_to new_file_path
        elsif !(@file[:url] =~ /[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}[-a-zA-Z0-9@:%_\+.~#=\?\&\/]+/)
            flash[:notice] = "Please enter a valid URL."
            redirect_to new_file_path
        else 
            if !(@file[:url]=~/http(s)?:/)
                @file[:url]="http://"+@file[:url]
            end
            category = Category.find(@file[:category_id])
            @file = category.documents.create!(file_params)
            if Rails.env.production?
                send_doccom_email()
            end
            flash[:notice] = "#{@file.title} was successfully created and email was succesfully sent."
            redirect_to documents_path 
        end
    end
    
    def send_doccom_email
        User.all.each do |user|
            NotificationMailer.document_update_email(user, Document.find_by_title(@title)).deliver

            NotificationMailer.document_update_email(user, Document.find_by_title(@title)).deliver_later!(wait_until: 5.minutes.from_now)

            if user.digest_pref == "daily"
                NotificationMailer.new_document_email(user, Document.find_by_title(@file[:title])).deliver_later!(wait_until: Time.now.tomorrow.noon())
            elsif user.digest_pref == "weekly"
                NotificationMailer.new_document_email(user, Document.find_by_title(@file[:title])).deliver_later!(wait_until: Time.now.next_week.noon())
            else
                NotificationMailer.new_document_email(user, Document.find_by_title(@file[:title])).deliver
            end
        end
    end
    # def edit_file
    #    @id = params[:format] 
    #    @file = Document.find @id
    # end
    
    def update_file
        @target_file = Document.find params[:format]
        @file = params[:file]
        if @file[:title].to_s == "" or @file[:url].to_s == ""
            flash[:notice] = "Populate all fields before submission."
            redirect_to info_file_path(params[:format])
        elsif !(@file[:url] =~ /[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}[-a-zA-Z0-9@:%_\+.~#=\?\&\/]+/)
            flash[:notice] = "Please enter a valid URL."
            redirect_to info_file_path(params[:format])
        else
            if !(@file[:url]=~/http(s)?:/)
                @file[:url]="http://"+@file[:url]
            end
            category = Category.find(@file[:category_id])
            @target_file.update_attributes!(file_params)
            category.documents << @target_file
            if Rails.env.production?
                send_doccom_email_update()
            end
            flash[:notice] = "Document with title [#{@target_file.title}] updated successfully and email was successfully sent."
            redirect_to(documents_path)
        end
    end
    
    def send_doccom_email_update
        User.all.each do |user|
            if user.digest_pref == "daily"
                NotificationMailer.document_update_email(user, Document.find_by_title(@file[:title])).deliver_later!(wait_until: Time.now.tomorrow.noon())
            elsif user.digest_pref == "weekly"
                NotificationMailer.document_update_email(user, Document.find_by_title(@file[:title])).deliver_later!(wait_until: Time.now.next_week.noon())
            else
                NotificationMailer.document_update_email(user, Document.find_by_title(@file[:title])).deliver
            end
        end
    end 
    
    def delete_file
        @file_to_delete = Document.find params[:format]
        @file_to_delete.destroy!
        flash[:notice] = "Document with title [#{@file_to_delete.title}] deleted successfully."
        redirect_to documents_path
    end
    
    def new_file
        #default: render 'new' template
        @categories = Category.all
    end
    
    def mark_as_read
        @file = Document.find params[:id]
        if current_user.documents.exists?(@file.id)
            current_user.documents.delete(@file.id)
            render json: { document: "[#{@file.title}]", result: "Not Read", user: current_user.id}
        else
            current_user.documents<<(@file)
            render json: { document: "[#{@file.title}]", result: "Read", user: current_user.id}
        end
    end
    
    def update_document_order
        if request.xhr?
            Document.update_document_order(params[:category].to_a[0].split(" ")[0], params[:document])
        end 
    end
    
end