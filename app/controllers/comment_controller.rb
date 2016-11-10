class CommentController < ApplicationController
    layout "base"
    before_action :authenticate_user!
    
    def comment_params
        params.require(:comment).permit(:content, :announcement_id)
    end
    
    def index
        @announcement_id = params[:announcement_id]
        @emailhash = Hash.new
        Comment.where(announcement_id: @announcement_id).find_each do |comment|
            @email = "Deleted"
            if User.where(:id => comment.user_id).present?
                @email = User.find(comment.user_id).email
            end
            @emailhash[comment] = @email
        end
            
        @announcement = Announcement.find @announcement_id
    end
    
    def new_comment
        @announcement_id = params[:announcement_id]
    end
    
    
    def create_comment
        @id = params[:announcement_id]
        @content = comment_params[:content]
        if @content.nil? || @content.empty?
            flash[:notice] = "Comment cannot be blank."
            redirect_to new_comment_path(@id) and return
        end
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
