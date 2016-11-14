class CategoryController < ActionController::Base
    layout "base"
    before_action :authenticate_user!

    def index
        if params[:sort_by] == 'name'
            Category.sort_by_name
        end
        @categories = Category.order("custom_order ASC").all
    end

    def new_category
        if !current_user.admin
            flash[:message] = "Only admins can create categories."
            redirect_to root_path
        end
    end
    
    def create_category
        if !current_user.admin
            flash[:message] = "Only admins can create categories."
            redirect_to root_path and return
        end
        category = params[:category]
        if category[:name].to_s == ""
            flash[:notice] = "Category name field cannot be blank."
            redirect_to new_category_path
        elsif Category.has_name?(category[:name])
            flash[:notice] = "The category name provided already exists. Please enter a different name."
            redirect_to new_category_path
        else
            category = params[:category]
            if category[:name].to_s == "" then
                flash[:notice] = "Please fill in the category name field."
                redirect_to new_category_path
            elsif Category.has_name?(category[:name]) then
                flash[:notice] = "The category name provided already exists. Please enter a different name."
                redirect_to new_category_path
            else
                Category.create!(:name => category[:name])
                flash[:notice] = "The category #{category[:name]} was successfully created!"
                redirect_to category_index_path
            end
        end
    end

    def edit_category
        if !current_user.admin
            flash[:message] = "Only admins can create categories."
            redirect_to root_path and return
        end
        @id = params[:id] 
        @category = Category.find(@id)
        @categories = Category.all
    end

    def update_category
        if !current_user.admin
            flash[:message] = "Only admins can create categories."
            redirect_to root_path and return
        end
        @category = Category.find(params[:id])
        category = params[:category]
        if category[:name].to_s == ''
            flash[:notice] = "Please fill in the category name field."
            redirect_to edit_category_path
        elsif Category.has_name?(category[:name].to_s)
            flash[:notice] = "The category name provided already exists. Please enter a different name."
            redirect_to edit_category_path
        else
            @category = Category.find(params[:id])
            category = params[:category]
            if category[:name].to_s == '' then
                flash[:notice] = "Please fill in the category name field."
                redirect_to edit_category_path
            elsif Category.has_name?(category[:name].to_s)
                flash[:notice] = "The category name provided already exists. Please enter a different name."
                redirect_to edit_category_path
            else
                @category.update_attributes!(:name => category[:name].to_s)
                flash[:notice] = "Categroy with name [#{@category.name}] updated successfully and email was successfully sent."
                redirect_to category_index_path
            end
        end
            
    end

    def delete_category
        if !current_user.admin
            flash[:message] = "Only admins can create categories."
            redirect_to root_path and return
        end
        @category = Category.find(params[:id])
        @category.destroy!
        flash[:notice] = "Category with name #{@category.name} deleted successfully."
        redirect_to category_index_path
    end

    def hide_category
        if !current_user.admin
            flash[:message] = "Only admins can create categories."
            redirect_to root_path and return
        end
        category = Category.find(params[:id])
        category.hide
        flash[:notice] = "#{category.name} successfully hidden."
        redirect_to category_index_path
    end

    def show_category
        if !current_user.admin
            flash[:message] = "Only admins can create categories."
            redirect_to root_path and return
        end
        category = Category.find(params[:id])
        category.show
        flash[:notice] = "#{category.name} successfully shown."
        redirect_to category_index_path
    end
    
    def update_category_order
        if request.xhr?
            Category.update_category_order(params[:category])
        end
    end

end