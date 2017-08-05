require 'rails_helper'
require 'spec_helper'

describe UserController do
    fixtures :users
    before(:each) do
        sign_in users(:user)
    end
    describe 'index' do
        it 'renders index page' do
            get :index, params: {user_id: users(:tester).id}
            expect(response).to render_template(:index)
        end
    end
    
    
    describe "CommunityGrows website" do
        it 'user should make a new announcement' do
            curr = User.create!(:name => "Rspec_user", :email => "usser@cg.org", :password => "communitygrowsrocks", :password_confirmation => "communitygrowsrocks", :admin => false)
            visit "/users/sign_in"
            fill_in :user_email,    :with => curr.email
            fill_in :user_password, :with => curr.password
            click_button "Log in"
            expect(page).to have_content("Dashboard")
            
            # "announcement"=>{"title"=>"123123", "content"=>"123123", "emergency"=>"0"}
            
            post :create_announcement, params: {announcement: {title: "testing user announcement", content: "testing user content", emergency: 0}}
            expect(response).to redirect_to(admin_index_path)
            # expect(page).to have_content(:dashboard)
            # click_link "Add"
            # expect(page).to have_content("Title")
            # expect(page).to have_content("Content")
            # fill_in "Title", :with => 'abcd'
            # fill_in "Content", :with => 'bcd'
            # click_button "Submit"
            # expect(page).to have_content("testing user announcement")
            # expect(page).to have_content("testing user content")
    end
    
  end    
    
    
    
    describe 'update' do
        it 'should redirect to account info page on success' do
            user_params = {name: "Rspec", email: "tester@rspec.com", password: "communitygrowsrocks", password_confirmation: "communitygrowsrocks"}
            put :update_user_credentials, params: {user_id: users(:tester).id, user: user_params}
            expect(response).to redirect_to(update_user_credentials_path)
        end
        it 'should redirect to account info page on failure of inputting password' do
            user_params = {name: "Rspec", email: "tester@rspec.com", password: "", password_confirmation: ""}
            put :update_user_credentials, params: {user_id: users(:tester).id, user: user_params}
            expect(response).to redirect_to(update_user_credentials_path)
        end
        it 'should redirect to account info page on failure of inputting name' do
            user_params = {name: "", email: "tester@rspec.com", password: "communitygrowsrocks", password_confirmation: "communitygrowsrocks"}
            put :update_user_credentials, params: {user_id: users(:tester).id, user: user_params}
            expect(response).to redirect_to(update_user_credentials_path)
        end
    end
    describe 'updateEmailPreferences' do
        it 'Should update email preferences' do
            user_params = {name: "Rspec", :email => "tester@rspec.com", :password => "communitygrowsrocks", :password_confirmation => "communitygrowsrocks",:internal=>"true"}
            post :update_user_credentials, params: {user_id: users(:tester).id, :user => user_params}
            expect(response).to redirect_to(update_user_credentials_path)   
        end
        it 'Should not update email preferences' do
            user_params = {name: "Rspec", email: "tester@rspec.com", password: "communitygrowsrocks", password_confirmation: "communitygrowsrocks", internal: "false", external: "false", executive: "false"}
            post :update_user_credentials, params: {user_id: users(:tester).id, user: user_params}
            expect(response).to redirect_to(update_user_credentials_path)
            expect(flash[:notice]).to include(/Please select at least your committee to receive emails from./)      
        end
    end
end


