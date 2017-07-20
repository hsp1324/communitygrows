Feature: a user should be able to view all announcements, both main and subcommittee

	As a user
	I want to be able to view all main and subcommittee announcements
	So that I can stay informed about my organization

Background: user is on the board member dashboard page

	Given a logged in user
	And I am on the board member dashboard page

Scenario: Most Recent Main Announcements / Show All
	
	Given I am on the board member dashboard page
	When I press "Add"
	When I fill in "Title" with "Test #1"
	When I press "Submit"
	When I press "Add"
	When I press "Submit"
	When I press "Add"
	When I press "Submit"
	When I press "Add"
	When I press "Submit"
	When I press "Add"
	When I press "Submit"
	When I press "Add"
	When I fill in "Title" with "Test #2"
	When I press "Submit"
	Then I should not see "Test #1"
	Then I should see "Test #2"
	Then I should see "Show All"
	When I press "Show All"
	Then I should see "All Announcements"
	Then I should see "Test #1"
	Then I should see "Test #2"

Scenario: Most Recent Subcommittee Announcements / Show All

	Given I am on the internal subcommittee page
	When I press "Add new announcement"
	When I fill in "Title" with "Test #3"
	When I press "Submit"
	When I press "Add new announcement"
	When I fill in "Title" with "Test #4"
	When I press "Submit"
	When I press "Add new announcement"
	When I fill in "Title" with "Test #5"
	When I press "Submit"
	When I press "Add new announcement"
	When I fill in "Title" with "Test #6"
	When I press "Submit"
	When I press "Add new announcement"
	When I fill in "Title" with "Test #7"
	When I press "Submit"
	When I press "Add new announcement"
	When I fill in "Title" with "Test #8"
	When I press "Submit"
	Then I should not see "Test #3"
	Then I should see "Test #8"
	Then I should see "Show All"
	When I press "Show All"
	Then I should see "All Announcements"
	Then I should see "Test #3"
	Then I should see "Test #8"

