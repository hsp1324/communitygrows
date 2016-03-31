require 'spec_helper'
require "rails_helper"

RSpec.describe "Admin announcements", :type => :request do
  describe "CommunityGrows website" do
    before 'should redirect to the dashboard when user is signed in' do
      curr = User.create!(:email => "admin@communitygrows.org", :password => "communitygrowsrocks", :password_confirmation => "communitygrowsrocks", :admin => true)
      visit "/users/sign_in"
      fill_in "Email",    :with => curr.email
      fill_in "Password", :with => curr.password
      click_button "Log in"
      page.should have_content("Dashboard")
      
      # then go back to the root again
      visit "/"
      page.should have_content("Dashboard")
    end
    
    it 'should make a new announcement and edit it' do
      visit '/admin'
      
      click_link "New Announcement"
      page.should have_content("Title")
      page.should have_content("Content")
      fill_in "Title", :with => 'abcd'
      fill_in "Content", :with => 'bcd'
      click_button "Submit"
      page.should have_content("abcd")
      page.should have_content("bcd")
      
      click_link "Edit Announcement", match: :first
      page.should have_content("Title")
      page.should have_content("Content")
      fill_in "Title", :with => 'ccc'
      fill_in "Content", :with => 'ddddd'
      click_button "Submit"
      page.should have_content("ccc")
      page.should have_content("ddddd")
      
      click_link "Delete Announcement", match: :first
      page.should have_content("Announcement Management")
    end
  end
end