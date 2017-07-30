Feature: Meetings Tab

	As a board member
	I want a centralized mettings tab on the board portal
	So that I can view upcoming events, their dates, their times, their 
	descriptions, their adgeneds and join in the meeting via google hangouts once the meeting has started

Background:
	
	Given the following meetings exist:
		| name   | description      | date    | time   | location         | agenda           | hangout          |
        | hoopla | "hoops are cool" | 7/22/17 | 4:44pm | "124 Rainbow RD" | "www.google.com" | ""               |
        | ooopla | "ooops are cool" | 7/23/17 | 4:43pm | "123 Rainbow RD" | "www.google.com" | "www.google.com" |
        | poopla | "poops are cool" | 7/24/17 | 4:42pm | "122 Rainbow RD" | "www.google.com" | "www.google.com" |
    Given a logged in user
    And I am on the CommunityGrows home page


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
    