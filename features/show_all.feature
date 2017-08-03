Feature: a user should be able to view all announcements, both main and subcommittee

	As a user
	I want to be able to view all main and subcommittee announcements
	So that I can stay informed about my organization

Background: user is on the board member dashboard page

    Given the following committees exist:
        | name            | inactive | hidden    |
        | hoopla          | false     | false     |
        | crystal gems    | true     | false     |
        | backstreet boys | true     | false     |
    Given a logged in admin
    And I am on the CommunityGrows home page

Scenario: Most Recent Main Announcements / Show All
	Given I am on the dashboard page
	When I follow "Add"
	When I fill in "Title" with "Test #1"
	When I press "Submit"
	Given I am on the dashboard page
	When I follow "Add"
	When I press "Submit"
	Given I am on the dashboard page
	When I follow "Add"
	When I press "Submit"
	Given I am on the dashboard page
	When I follow "Add"
	When I press "Submit"
	Given I am on the dashboard page
	When I follow "Add"
	When I press "Submit"
	Given I am on the dashboard page
	When I follow "Add"
	When I fill in "Title" with "Test #2"
	When I press "Submit"
	Given I am on the dashboard page
	Then I should not see "Test #1"
	Then I should see "Test #2"
	Then I should see "Show All"
	When I follow "Show All"
	Then I should see "All Announcements"
	Then I should see "Test #1"
	Then I should see "Test #2"

Scenario: Most Recent Subcommittee Announcements / Show All

	Given I am on the committee management page
    And I follow second "hoopla"
    And I should see "Add Admin to hoopla"
    And I press "Add Admin to hoopla"
    And I should see "Admin successfully added to hoopla."
	# Given the "sample_user" user in "hoopla" committee
	
	Given I follow "hoopla"
	And I should see "Subcommittee"
	And I should see "Add new announcement"
	When I follow "Add new announcement"
	When I fill in "Title" with "Test #3"
	When I press "Submit"
	When I follow "Add new announcement"
	When I fill in "Title" with "Test #4"
	When I press "Submit"
	When I follow "Add new announcement"
	When I fill in "Title" with "Test #5"
	When I press "Submit"
	When I follow "Add new announcement"
	When I fill in "Title" with "Test #6"
	When I press "Submit"
	When I follow "Add new announcement"
	When I fill in "Title" with "Test #7"
	When I press "Submit"
	When I follow "Add new announcement"
	When I fill in "Title" with "Test #8"
	When I press "Submit"
	And I am on the CommunityGrows home page
	
	Then I should not see "Test #3"
	Then I should see "Test #8"
	Then I should see "Show All"
	When I follow "Show All"
	Then I should see "All Announcements"
	Then I should see "Test #3"
	Then I should see "Test #8"

