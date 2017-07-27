Feature: Calendar Management

            As an admin
            I want to add, remove, hide and show google calendars
            So that the calendar on the dashboard can be more flexible

Background:
  
    Given the following calendars exist:
        | name            | link           | hidden    |
        | Public Events   | www.google.com | false     |
    Given a logged in admin
    And I am on the CommunityGrows home page


Scenario: Existance of calendar management in drop down
    Given I am on the CommunityGrows home page
    Then I should see "Admin Dashboard"
    Then I should see "Calendar Management"


Scenario: Visiting calendar management page
    Given I am on the CommunityGrows calendar management page
    Then I should see "Committee Management"
    And I should see "Public Events"
    
#Happy Path
Scenario: Create new calendar
    Given I am on the calendar management page
    When I follow "New Calendar"
    And I fill in "Calendar Name" with "Fundraiser"
    And I fill in "Link" with "www.google.com"
    And I press "Submit"
    Then I am on the calendar management page
    And I should see "Fundraiser"
    And I should see "Delete Fundraiser"
    And I should see "Hide Fundraiser"
    And I should see "Edit Fundraiser"

#Sad Path
Scenario: Create new calendar with a blank name
    Given I am on the calendar management page
    When I follow "New Calendar"
    And I fill in "Calendar Name" with ""
    And I fill in "Link" with "www.google.com"
    And I press "Submit"
    Then I am on the new calendar page
    And I should see "Please enter a valid name"

#Sad Path
Scenario: Create new calendar with a blank link
    Given I am on the calendar management page
    When I follow "New Calendar"
    And I fill in "Calendar Name" with "Fundraiser"
    And I fill in "Link" with ""
    And I press "Submit"
    Then I am on the new calendar page
    And I should see "Please enter a valid link"

#Happy Path
Scenario: Edit calendar   
    Given I am on the calendar management page
    When I follow "Edit Public"
    And I should see "Edit"
    And I fill in "Calendar Name" with "Private"
    And I press "Submit"
    Then I am on the committee management page
    And I should see "Private"
    And I should see "Delete Private"
    And I should see "Hide Private"
    And I should see "Edit Private"
    
#Sad Path
Scenario: Edit calendar   
    Given I am on the calendar management page
    When I follow "Edit Public"
    And I should see "Edit"
    And I fill in "Calendar Name" with ""
    And I press "Submit"
    Then I am on the edit calendar page
    And I should see "Please enter a non-empty name"
    
Scenario: Delete calendar
    Given I am on the calendar management page
    And I should see "Delete Public"
    When I press "Delete Public"
    And I confirm popup
    Then I should see "Calendar Public Events was deleted successfully."

Scenario: Hide and Show Calendar  
    Given I am on the calendar management page
    And I should see "Hide calendar"
    When I press "Hide Public Events"
    Then I should see "Public Events successfully hidden."
    And I should see "Show Public Events"
    
    When I press "Show Public Events"
    Then I should see "Public Events successfully shown."
    And I should see "Hide Public Events"

    