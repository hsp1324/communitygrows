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
    Given the following users exist:
        | name   | email             | admin      | created_at           | password     | password_confirmation     |
        | Zach   | zach@gmail.com    | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |
        | Tony   | tonylee@gmail.com | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |
        | Jae    | jae@berkeley.edu  | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  |          
    Given "zach@gmail.com" logs in with password "12341234"
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
    When I choose all of the damn checkboxes
    And I press "Submit"
	# Given the "sample_user" user in "hoopla" committee
	
	Given I follow "hoopla"
	And I should see "Hoopla Committee"
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

