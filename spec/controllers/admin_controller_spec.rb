require 'spec_helper'
require "rails_helper"

describe AdminController do
    fixtures :users
    before(:each) do

    end
    describe 'new_user' do
        it 'renders new user page' do
            sign_in users(:tester)
            get :new_user
            expect(response).to render_template(:new_user)
        end
        it 'redirects to index page on success' do
            sign_in users(:tester)
            user_params = {:name => "rspec", :email => "admin@rspec.com", :password => "communitygrowsrocks", :password_confirmation => "communitygrowsrocks", :admin => true}
            post :create_user, params: {user: user_params}
            expect(response).to redirect_to(:admin_index)
        end
        
    end    
    describe 'delete_user' do
        it 'deletes a user' do
            sign_in users(:tester)
            delete :delete_user, params: {id: users(:user).id}
            expect(response).to redirect_to(:admin_index)
        end
    end
    
    describe 'index' do
        it 'redirects non-admin users' do
            sign_in users(:user)
            get :index
            expect(response).to redirect_to('/dashboard')
            sign_out users(:user)
        end
        it 'allows admin users' do
            sign_in users(:tester)
            get :index
            expect(response).to render_template(:index)
        end
    end
    
    describe 'edit_user' do
        it 'renders edit user page' do
            sign_in users(:tester)
            get :edit_user, params: {id: users(:tester).id}
            expect(response).to render_template(:edit_user)
        end
        it 'should redirect to edit user page' do
            sign_in users(:tester)
            put :update_user, params: {id: users(:tester).id}
            expect(response).to redirect_to(:edit_user)
        end
        it 'redirects to index page on success' do
            sign_in users(:tester)
            user_params = {name: "rspec", email: "admin@rspec.com", password: "communitygrowsrocks", password_confirmation: "communitygrowsrocks", admin: true}
            put :update_user, params: {id: users(:tester).id, user: user_params}
            expect(response).to redirect_to(:admin_index)
        end
    end
    
    describe 'login user' do
        it 'Cannot access to Admin page' do
            sign_in users(:user)
            get :index
            expect(flash[:message]).to eq("Access not granted. Please sign in again.") 
        end
    end

end