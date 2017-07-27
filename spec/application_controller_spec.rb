require 'spec_helper'
require "rails_helper"

RSpec.describe "User security", :type => :request do
  describe "CommunityGrows website" do
    it 'should redirect to the login unless the user is logged in' do
      get '/'
      expect(response).to redirect_to('/users/sign_in')
    end
    it 'should redirect to the login when unsigned user is trying to access the dashboard' do
      get '/dashboard'
      expect(response).to redirect_to('/users/sign_in')
    end
    # it 'should redirect to the login when unsigned user is trying to access the executive subcommittee' do
    #   get '/subcommittee_index/executive'
    #   expect(response).to redirect_to('/users/sign_in')
    # end
    # it 'should redirect to the login when unsigned user is trying to access the external subcommittee' do
    #   get '/subcommittee_index/external'
    #   expect(response).to redirect_to('/users/sign_in')
    # end
    # it 'should redirect to the login when unsigned user is trying to access the internal subcommittee' do
    #   get '/subcommittee_index/internal'
    #   expect(response).to redirect_to('/users/sign_in')
    # end
    it 'should redirect to the login when unsigned user is trying to access the documents' do
      get '/documents'
      expect(response).to redirect_to('/users/sign_in')
    end
    it 'should redirect to the login when unsigned user is trying to access the admin' do
      get '/admin'
      expect(response).to redirect_to('/users/sign_in')
    end
    it 'should redirect to the dashboard when user is signed in' do
      curr = User.create!(:name => "Rspec", :email => "admin@communitygrows.org", :password => "communitygrowsrocks", :password_confirmation => "communitygrowsrocks", :admin => true)
      visit "/users/sign_in"
      fill_in :user_email,    :with => curr.email
      fill_in :user_password, :with => curr.password
      click_button "Log in"
      expect(page).to have_content("Dashboard")
      
      # then go back to the root again
      visit "/"
      expect(page).to have_content("Dashboard")
    end
    
  end
end
