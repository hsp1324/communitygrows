module ControllerHelper
    def delete_object(type)
        @id = params[:id] 
        @item = type.find(@id)
        @item.destroy!
        flash[:notice] = "#{type.string_title} with name #{@item.name} deleted successfully."
    end

    def create_object(type, object, fail_redirect_path, success_redirect_path)
        if object[:name].to_s == ""
            flash[:notice] = "#{type.string_title} name field cannot be blank."
            redirect_to fail_redirect_path
        elsif type.has_name?(object[:name])
            flash[:notice] = "#{type.string_title} name provided already exists. Please enter a different name."
            redirect_to fail_redirect_path
        else
            if type == Committee
                Committee.create!(:name => object[:name],  :hidden => true, :inactive => true)
            elsif type == Category
                Category.create!(:name => object[:name])
            else
                Meeting.create!(:name => object[:name])
            end
            flash[:notice] = "#{type.string_title} #{object[:name]} was successfully created!"
            redirect_to success_redirect_path
        end
    end
    
    def update_object(type, object, fail_redirect_path, success_redirect_path)
        @found_object = type.find(params[:id])
        if object[:name].to_s == ''
            flash[:notice] = "Please fill in the #{type.string_lower} name field."
            redirect_to fail_redirect_path
        elsif type.has_name?(object[:name].to_s)
            flash[:notice] = "#{type.string_title} name provided already exists. Please enter a different name."
            redirect_to fail_redirect_path
        else
            @found_object.update_attributes!(:name => object[:name].to_s)
            flash[:notice] = "#{type.string_title} with name [#{@found_object.name}] updated successfully and email was successfully sent."
            redirect_to success_redirect_path
        end
    end
    
    def edit_object(type)
        @id = params[:id] 
        @found_object = type.find(@id)
        @found_objects = type.all
    end
    
    def hide_show_object(type, hide_or_show, redirect_path)
        found_object = type.find(params[:id])
        if hide_or_show == 'hide'
            found_object.hide 
            flash[:notice] = "#{found_object.name} successfully hidden."
        else
            found_object.show
            flash[:notice] = "#{found_object.name} successfully shown."
        end
        redirect_to redirect_path
    end
end