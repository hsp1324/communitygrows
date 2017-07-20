Feature: Commitee CRUD Actions
  
  As a software engineer
  I want to create, read, update, hide, deactivate or show commitees
  And sure the changes are reflected in the database

Background: admin is on the commitee mangement page and make a variety of changes to the current categories

Given a logged in admin
And I am on the commitee management page
And the following commitees exist: "Crystal Gems", "Backstreet Boys", "hoopla"

Scenario: Create new commitee

When I follow "New Commitee"
And I fill in "Commitee Name" with "Ninja Turtles"
And I press "Submit"
Then the table Commitee "should" contain "title: Ninja Turtles"


Scenario: Hide commitee

When I follow "Hide Crystal Gems"
Then I should see "Crystal Gems successfully hidden"
And the table Commitee "should not" contain "title: Crystal Gems, hidden: true"

Scenario: Rename commitee

When I follow "Crystal Gems"
And I fill in "Commitee Name" with "Rose Quartz"
And I press "Submit"
Then I should see "Rose Quartz"
And the table Commitee "should" contain "title: Rose Quartz"

Scenario: Delete commitee

When I follow "Delete Backstreet Boy"
And I press "ok"
Then I should see "Commitee with name Backstreet Boys deleted successfully"
And the table Commitee "should not" contain "title: Backstreet Boys"

Scenario: Deactivate commitee

When I follow "Deactivate hoopla"
Then I should see "hoopla successfully deactivated"
And the table Commitee "should" contain "title: hoopla, inactive: true"

Scenario: Activate commitee

When I follow "Activate hoopla"
Then I should see "hoopla successfully activated"
And the table Commitee "should" contain "title: hoopla, inactive: false"









