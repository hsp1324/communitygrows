class CategoryController < ActionController::Base
    protect_from_forgery#, :with => :exception
    layout "base"
    before_action :authenticate_user!

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
        if params[:doc_order]
            category = Category.find(params[:doc_order][:category])
            Category.sort_docs(category, params[:doc_order][:order])
            redirect_to category_index_path
        end
        if params[:sort_by] == 'name'
            Category.sort_by_name
            redirect_to category_index_path
        else
            @categories = Category.order("custom_order ASC").all
        end
    end

    def new_category
        is_admin = admin_only('create categories.')
        return if !is_admin
    end
    
    def create_category
        is_admin = admin_only('create categories.')
        return if !is_admin

        category = params[:category]
        if category[:name].to_s == ""
            flash[:notice] = "Category name field cannot be blank."
            redirect_to new_category_path
        elsif Category.has_name?(category[:name])
            flash[:notice] = "The category name provided already exists. Please enter a different name."
            redirect_to new_category_path
        else
            category = params[:category]
            Category.create!(:name => category[:name])
            flash[:notice] = "The category #{category[:name]} was successfully created!"
            redirect_to category_index_path
        end
    end

    def update_category
        is_admin = admin_only('update categories.')
        return if !is_admin
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
            @category.update_attributes!(:name => category[:name].to_s)
            flash[:notice] = "Categroy with name [#{@category.name}] updated successfully and email was successfully sent."
            redirect_to category_index_path
        end
            
    end
    
    def edit_category
        is_admin = admin_only('edit categories.')
        return if !is_admin
        @id = params[:id] 
        @category = Category.find(@id)
        @categories = Category.all
    end
    
    
    def update_category_order
        if request.xhr?
            Category.update_category_order(params[:table])
        end
    end

    def delete_category
        is_admin = admin_only('delete categories.')
        return if !is_admin
        @category = Category.find(params[:id])
        @category.destroy!
        flash[:notice] = "Category with name #{@category.name} deleted successfully."
        redirect_to category_index_path
    end

    def hide_category
        is_admin = admin_only('hide categories.')
        return if !is_admin
        category = Category.find(params[:id])
        category.hide
        flash[:notice] = "#{category.name} successfully hidden."
        redirect_to category_index_path
    end

    def show_category
        is_admin = admin_only('show categories.')
        return if !is_admin
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