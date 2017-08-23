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
    
#Sad Path
Scenario: Create new calendar with a blank name
    Given I am on the calendar management page
    When I follow "New Calendar"
    And I fill in "Calendar Name" with ""
    And I fill in "Public Calendar Address" with "www.google.com"
    And I press "Submit"
    And I should see "Calendar name field cannot be blank."

#Sad Path
Scenario: Create new calendar with a blank link
    Given I am on the calendar management page
    When I follow "New Calendar"
    And I fill in "Calendar Name" with "Fundraiser"
    And I fill in "Public Calendar Address" with ""
    And I press "Submit"
    And I should see "Calendar link field cannot be blank."

#Happy Path
Scenario: Edit calendar   
    Given I am on the calendar management page
    When I follow "Public Events"
    And I should see "Edit"
    And I fill in "Calendar Name" with "Private"
    And I press "Update Calendar"
    Then I am on the calendar management page
    And I should see "Private"
    And I should see "Delete Private"
    And I should see "Hide Private"
    
#Sad Path
Scenario: Edit calendar   
    Given I am on the calendar management page
    When I follow "Public Events"
    And I should see "Edit"
    And I fill in "Calendar Name" with ""
    And I press "Update Calendar"
    And I should see "Please fill in the calendar name field."
    
Scenario: Delete calendar
    Given I am on the calendar management page
    And I should see "Delete Public Events"
    When I press "Delete Public Events"
    And I confirm popup
    Then I should see "Calendar with name Public Events deleted successfully."

Scenario: Hide and Show Calendar  
    Given I am on the calendar management page
    And I should see "Hide Public Events"
    When I press "Hide Public Events"
    Then I should see "Public Events successfully hidden."
    And I should see "Show Public Events"
    
    When I press "Show Public Events"
    Then I should see "Public Events successfully shown."
    And I should see "Hide Public Events"

    