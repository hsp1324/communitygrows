class CommentController < ApplicationController
    layout "base"
    before_filter :authenticate_user!
    
    def announcement_params
        params.require(:announcement).permit(:id, :title, :content)
    end
    
    def comment_params
        params.require(:comment).permit(:content, :user_id)
    end
    
    def index
        @comments = Comment.all
        @announcement_id = params[:announcement_id]
        @announcement = Announcement.find @announcement_id
    end
    
    def new_comment
        @announcement_id = params[:announcement_id]
        @comment = Comment.new
    end
    
    
    def create_comment
        @id = params[:announcement_id]
        @content = comment_params[:content]
        @comment = Comment.create(:content => @content, :user_id => current_user.id, :announcement_id => @id)
        @comment.save!
        redirect_to comment_path(@id) 
    end
    
    
    def delete_comment
        @target_comment = Comment.find params[:comment_id]
        @target_comment.destroy!
        @id = params[:announcement_id]
        redirect_to comment_path(@id)
        
    end
    
end