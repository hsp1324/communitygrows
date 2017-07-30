class CategoryController < ActionController::Base
    protect_from_forgery#, :with => :exception
    layout "base"
    before_action :authenticate_user!
    include AdminHelper
    include ControllerHelper

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
        create_object(Category, category, new_category_path, category_index_path)
        # if category[:name].to_s == ""
        #     flash[:notice] = "Category name field cannot be blank."
        #     redirect_to new_category_path
        # elsif Category.has_name?(category[:name])
        #     flash[:notice] = "The category name provided already exists. Please enter a different name."
        #     redirect_to new_category_path
        # else
        #     category = params[:category]
        #     Category.create!(:name => category[:name])
        #     flash[:notice] = "The category #{category[:name]} was successfully created!"
        #     redirect_to category_index_path
        # end
        
    end

    def update_category
        is_admin = admin_only('update categories.')
        return if !is_admin
        category = params[:category]
        update_object(Category, category, edit_category_path, category_index_path)
    end
    
    def edit_category
        is_admin = admin_only('edit categories.')
        return if !is_admin
        edit_object(Category)
    end
    
    
    def update_category_order
        if request.xhr?
            Category.update_category_order(params[:table])
        end
    end

    def delete_category
        is_admin = admin_only('delete categories.')
        return if !is_admin
        delete_object(Category)
        redirect_to category_index_path
    end

    def hide_category
        is_admin = admin_only('hide categories.')
        return if !is_admin
        hide_show_object(Category, 'hide', category_index_path)
        # redirect_to category_index_path
    end

    def show_category
        is_admin = admin_only('show categories.')
        return if !is_admin
        hide_show_object(Category, 'show', category_index_path)
        # redirect_to category_index_path
    end
    
    def update_category_order
        if request.xhr?
            Category.update_category_order(params[:category])
        end
    end

end