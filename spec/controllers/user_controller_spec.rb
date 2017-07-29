require 'rails_helper'
require 'spec_helper'

describe UserController do
    fixtures :users
    before(:each) do
        sign_in users(:tester)
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
    
          
            click_link "Add"
            expect(page).to have_content("Title")
            expect(page).to have_content("Content")
            fill_in "Title", :with => 'abcd'
            fill_in "Content", :with => 'bcd'
            click_button "Submit"
            expect(page).to have_content("abcd")
            expect(page).to have_content("bcd")
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

RSpec.describe "User announcements/calendar", :type => :request do
  describe "CommunityGrows website" do
    before 'should redirect to the dashboard when user is signed in' do
      curr = User.create!(:name => "Rspec", :email => "admin@communitygrows.org", :password => "communitygrowsrocks", :password_confirmation => "communitygrowsrocks", :admin => true)
      visit "/users/sign_in"
      fill_in :user_email,    :with => curr.email
      fill_in :user_password, :with => curr.password
      click_button "Log in"
      expect(page).to have_content("Dashboard")

      
      click_link "New Announcement"
      expect(page).to have_content("Title")
      expect(page).to have_content("Content")
      fill_in "Title", :with => 'abcd'
      fill_in "Content", :with => 'bcd'
      click_button "Submit"
      expect(page).to have_content("abcd")
      expect(page).to have_content("bcd")
      
      click_link "Edit Announcement", match: :first
      expect(page).to have_content("Title")
      expect(page).to have_content("Content")
      fill_in "Title", :with => 'ccc'
      fill_in "Content", :with => 'ddddd'
      click_button "Submit"
      expect(page).to have_content("ccc")
      expect(page).to have_content("ddddd")
      click_link "Delete Announcement", match: :first
      expect(page).to have_content("Announcement Management")
    end
    
  end
end
