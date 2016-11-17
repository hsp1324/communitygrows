require 'spec_helper'
require "rails_helper"

RSpec.describe "Admin announcements/calendar", :type => :request do
  describe "CommunityGrows website" do
    before 'should redirect to the dashboard when user is signed in' do
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
    
    it 'should make a new announcement and edit it' do
      visit '/admin'
      
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
    
    #it 'should update or register a calendar', :pending => true do
      #visit '/admin'
      
      #fill_in "calendar_html", :with => 'info'
      #click_button "Update Google Calendar"
      #expect(page).to have_content("New Calendar Creation successful")
    #end
  end
end
