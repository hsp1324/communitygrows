class DashboardController < ActionController::Base
    layout "base"
    before_action :authenticate_user!
    
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
end
