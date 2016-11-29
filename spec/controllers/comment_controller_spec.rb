require 'rails_helper'

describe CommentController do
    fixtures :users
    before(:all) do
        @a = FactoryGirl.create(:announcement)    
    end 
    before(:each) do
        sign_in users(:tester)
    end
    describe 'render index' do
        it 'renders index template' do
            get :index , params: {announcement_id: @a.id}
            expect(response).to render_template(:index)
        end
    end
    describe 'new action' do
        it 'renders new comment template' do
            get :new_comment, params: {announcement_id: @a.id}
            expect(response).to render_template(:new_comment)
        end
    end
    describe 'create comment' do
        it 'creates a valid comment' do
            post :create_comment, params: {announcement_id: @a.id, comment: {content: 'hi', user_id: users(:tester).id}}
            expect(response).to redirect_to(comment_path(@a.id))
        end
        it 'creates an invalid comment' do
            post :create_comment, params: {announcement_id: @a.id, comment: {content: '', user_id: users(:tester).id}}
            expect(flash[:notice]).to include("Comment cannot be blank.")
            expect(response).to redirect_to(new_comment_path(@a.id))
        end
    end
    describe 'delete comment' do
        it 'deletes' do
            post :create_comment, params: {announcement_id: @a.id, comment: {content: 'hi', user_id: users(:tester).id}}
            delete :delete_comment, params: {comment_id: @a.comments.first.id, announcement_id: @a.id}
            expect(response).to redirect_to(comment_path(@a.id))
        end
    end
end
