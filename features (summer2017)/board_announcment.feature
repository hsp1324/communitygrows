Feature: a user should be able to post member announcements to everyone in the organization

	As a user
	I want to be able to successfully post a member announcement
	So that everyone can view the announcement

Background: user is on the board member dashboard page
	
	Given a logged in user
	Given a category called “Main Announcements”
	And I am on the board member dashboard page

Scenario: A message containing “_______” should be displayed with the date when a main announcement is made. “_______” when clicked should navigate to an Announcement page, where the title and body will be visible as well as an “Add new comment” button

	Given I am on the board member dashboard page
	When I follow “Add”
	When I fill in “Title” with “Test”
	When I fill in “Content” with “This is a test”
	When I select “Main” from “Committees”
	When I press “Submit” 
	Then I should see “Announcement creation successful and email was sent successfully.”