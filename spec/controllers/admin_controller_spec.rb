require 'spec_helper'
require "rails_helper"

describe AdminController do
    fixtures :users
    fixtures :committees
    fixtures :participations
    fixtures :meetings
    before(:each) do
        sign_in users(:tester)
        # allow to do production mode
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
		@test_admin = User.find_by(name: "Rspec_admin")
		@test_committee = Committee.find_by(name: "sun")
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
            post :create_user, params: {user: user_params, :picture => fixture_file_upload('images/goku.jpg', 'image/jpg'), check: {"297062136": 1}}
            expect(flash[:notice]).to eq("admin@rspec.com was successfully created.")
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
            put :update_user, params: {id: users(:tester).id, user: user_params, check: {"297062136": 1}}
            expect(response).to redirect_to(:admin_index)
        end
        
        it 'should upload picture' do
            sign_in users(:tester)
			test_user = User.find_by(name: "Rspec_user")
			test_admin = User.find_by(name: "Rspec_admin")
			allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
# 			puts test_user.id #: 227792459
# 			puts test_admin.id #: 1011897928
# 			puts @test_committee.id # 297062136
            user_params = {name: "sun", email: "tester@rspec.com", password: "communitygrowsrocks", password_confirmation: "communitygrowsrocks"}
            put :update_user, params: {id: users(:tester).id, user: user_params, picture: fixture_file_upload('images/goku.jpg', 'image/jpg'), check: {"297062136": 1}}
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