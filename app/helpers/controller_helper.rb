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
                Committee.create!(:name => object[:name],  :description => object[:description], :hidden => true, :inactive => true)
            elsif type == Category
                Category.create!(:name => object[:name])
            elsif type == Meeting
                Meeting.create!(:name => object[:name])
            elsif type == Calendar
                if object[:link].to_s == ""
                    flash[:notice] = "#{type.string_title} link field cannot be blank."
                    redirect_to fail_redirect_path and return
                end
                Calendar.create!(:name => object[:name], :link => object[:link], :hidden => true)
            end
            flash[:notice] = "#{type.string_title} #{object[:name]} was successfully created!"
            redirect_to success_redirect_path
        end
    end
    
    def update_object(type, object, fail_redirect_path, success_redirect_path)
        @found_object = type.find(params[:id])
        if object[:name].to_s == ''
            flash[:notice] = "Please fill in the #{type.string_lower} name field."
            redirect_to fail_redirect_path and return
        end
        
        if type == Calendar and object[:link].to_s == ''
            flash[:notice] = "Please fill in the #{type.string_lower} link field."
            redirect_to fail_redirect_path and return
        end
                
        if type == Calendar
            if @found_object.link != object[:link].to_s
                @found_object.update_attributes!(:link => object[:link].to_s)
            end
            if @found_object.name != object[:name].to_s
                @found_object.update_attributes!(:name => object[:name].to_s)
            end
        else
            if type.has_name?(object[:name].to_s)
                if type == Committee && @found_object.description != object[:description]
                    @found_object.update_attributes!(:description => object[:description].to_s)
                    flash[:notice] = "#{type.string_title} with name [#{@found_object.name}] updated successfully and email was successfully sent."
                    redirect_to success_redirect_path and return
                end
                flash[:notice] = "#{type.string_title} name provided already exists. Please enter a different name."
                redirect_to fail_redirect_path and return
            end
            if type == Committee
                @found_object.update_attributes!(:name => object[:name].to_s, :description => object[:description].to_s)
            else
                @found_object.update_attributes!(:name => object[:name].to_s)
            end
        end
        
        flash[:notice] = "#{type.string_title} with name [#{@found_object.name}] updated successfully and email was successfully sent."
        redirect_to success_redirect_path and return
    end
    
    def edit_object(type)
        @id = params[:id] 
        if type == Category
            @category = Category.find(@id)
            @categories = Category.all
        elsif type == Committee
            @committee = Committee.find(@id)
            @committees = Committee.all
        elsif type == Meeting
            @meeting = Meeting.find(@id)
            @meetings = Meeting.all
        elsif type == Calendar
            @calendar = Calendar.find(@id)
            @calendars = Calendar.all
        end
    end
    
    
    def do_action(type, action, redirect_path)
        found_object = type.find(params[:id])
        if action == 'inactive'
            found_object.inactivate
            flash[:notice] = "#{found_object.name} successfully made inactive."
        elsif action == 'active'
            found_object.activate
            flash[:notice] = "#{found_object.name} successfully made active."
        elsif action == 'hide'
            found_object.hide 
            flash[:notice] = "#{found_object.name} successfully hidden."
        elsif action == 'show'
            found_object.show
            flash[:notice] = "#{found_object.name} successfully shown."
        end
        redirect_to redirect_path
    end
end