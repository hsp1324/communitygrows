Feature: Meetings Tab

	As an admin
    I want a meetings management page
	Where I can control a centralized meetings tab on the board portal
	So that boarder memebres can view upcoming events, their dates, their times, their descriptions, their adgeneds and join in the meeting via google hangouts once the meeting has started

Background:
	
	Given the following meetings exist:
		| name   | description      | date    | time   | location         | agenda           | hangout          |
        | hoopla | "hoops are cool" | 7/22/17 | 4:44pm | "124 Rainbow RD" | "www.google.com" | ""               |
        | ooopla | "ooops are cool" | 7/23/17 | 4:43pm | "123 Rainbow RD" | "www.google.com" | "www.google.com" |
        | poopla | "poops are cool" | 7/24/17 | 4:42pm | "122 Rainbow RD" | "www.google.com" | "www.google.com" |
    Given a logged in admin
    And I am on the CommunityGrows home page


Scenario: Existance of meeting management in admin drop down
    Given I am on the CommunityGrows home page
    Then I should see "Meeting Management"

Scenario: Visiting meeting management page
    Given I am on the meeting management page
    Then I should see "Meeting Management"
    And I should see "ooopla"
    And I should see "poopla"
    And I should see "New Meeting"
    And I should see "Delete poopla"
    And I should see "Delete ooopla"
    And I should see "Delete hoopla"

Scenario: Create new meeting
    Given I am on the meeting management page
    When I follow "New Meeting"
    And I fill in "Meeting Name" with "Bad Meeting"
    And I fill in "Meeting Date" with "07/22/2017"
    And I fill in "Meeting Time" with "4:44 PM"
    And I fill in "Meeting Location" with "123 Rainbow RD"
    And I fill in "Meeting Description" with "the quick brown fox jumps"
    And I press "Submit"
    Then I am on the meeting management page
    And I should see "Bad Meeting"
    And I should see "Delete Bad Meeting"

Scenario: Delete meeting  
    Given I am on the meeting management page
    Then I should see "poopla"
    And I should see "Delete poopla"
    When I press "Delete poopla"
    And I confirm popup
    Then I should see "Meeting with name poopla deleted successfully."

Scenario: Edit meeting   
    Given I am on the meeting management page
    Then I should see "hoopla"
    When I follow "hoopla"
    And I fill in "Meeting Name" with "Great hoopla"

    And I fill in "Meeting Date" with "07/22/2018"

    And I fill in "Meeting Time" with "4:45 PM"

    And I fill in "Meeting Location" with "124 Rainbow RD"

    And I fill in "Meeting Description" with "the quick brown fox jumps"

    And I fill in "Meeting Agenda" with "www.google.com"

    And I fill in "Meeting Hangout Link" with "www.google.com"
    And I press "Update Meeting"

    Given I am on the meeting management page
    And I should see "Great hoopla"
    And I should see "Delete Great hoopla"
    
    Given I am on the CommunityGrows home page
    Then I should see "Meetings"
    When I follow "Meetings"
    Then I should see "Great hoopla"
    And I should see "07/22/2018"
    And I should see "4:45 PM"
    When I follow "Great hoopla"
    Then I should see "the quick brown fox jumps"
    And I should see "124 Rainbow RD"
    And I should see "Agenda"
    And I should see "Join Meeting"

Scenario: Vsiting the meetings page
    When I follow "Meetings"
    Then I should see "Upcoming Meetings"
    And I should see "hoopla"
    And I should see "ooopla"
    And I should see "poopla"
    And I should see "4:44pm"
    And I should see "4:43pm"
    And I should see "4:42pm"
    And I should see "7/22/17"
    And I should see "7/23/17"
    And I should see "7/24/17"

Scenario: Viewing meeting details, with active google hangout link
	Given I am on the meetings page
    When I follow "ooopla"
    Then I should see "ooops are cool"
    And I should see "Agenda"
    And I should see "123 Rainbow RD"
    And I should see "Join Meeting"