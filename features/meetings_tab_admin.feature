Feature: Meetings Tab

	As an admin
    I want a meetigs management page
	Where I can control a centralized meetings tab on the board portal
	So that boarder memebres can view upcoming events, their dates, their times, their descriptions, their adgeneds and join in the meeting via google hangouts once the meeting has started

Background:
	
	Given the following meetings exist:
		| name   | description      | date    | time   | location         | adgenda          | hangouts        |
        | hoopla | "hoops are cool" | 7/22/17 | 4:44pm | "124 Rainbow RD" | "www.google.com" | ""              |
        | ooopla | "ooops are cool" | 7/23/17 | 4:43pm | "123 Rainbow RD" | "www.google.com" | "www.google.com"|
        | poopla | "poops are cool" | 7/24/17 | 4:42pm | "122 Rainbow RD" | "www.google.com" | "www.google.com"|
    Given a logged in user
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
    And I fill in "Meeting Name" with "noola"
    And I fill in "Agenda" with "www.google.com"
    And I fill in "Date" with "7/22/17"
    And I fill in "Time" with "4:44"
    And I fill in "Hangout" with "www.google.com"
    And I press "Submit"
    Then I am on the meeting management page
    And I should see "noola"
    And I should see "Delete noola"

Scenario: Delete meeting  
    Given I am on the meeting management page
    Then I should see "poopla"
    And I should see "Delete poopla"
    When I press "Delete poopla"
    And I confirm popup
    Then I should see "Meeting with name poopla deleted successfully."
    And I should not see "poopla"

    Given I am on the CommunityGrows home page
    Then I should see "Meetings"
    When I follow "Meetings"
    Then I should not see "poopla"

Scenario: Edit meeting   
    Given I am on the meeting management page
    When I follow "hoopla"
    Then I should see "Edit"
    When I fill in "Committee Name" with "Great hoopla"
    And I press "Submit"
    Then I am on the meeting management page
    And I should see "Great hoopla"
    And I should see "Delete Great hoopla"
    
    Given I am on the CommunityGrows home page
    Then I should see "Meetings"
    When I follow "Meetings"
    Then I should see "Great hoopla"

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
    
Scenario: Viewing meeting details, with inactive google hangout link
    Given I am on the meetings page
    When I follow "hoopla"
    Then I should see "hoopla details"
    And I should see "hoops are cool"
    And I should see "www.google.com"
    And I should see "124 Rainbow RD"
    And I should see "Meeting Pending"

Scenario: Viewing meeting details, with active google hangout link
	Given I am on the meetings page
    When I follow "ooopla"
    Then I should see "ooopla details"
    And I should see "ooops are cool"
    And I should see "www.google.com"
    And I should see "123 Rainbow RD"
    And I should see "Join"