# By Tommy and Jack
Feature: User profile page
  
  As a user or admin
  I want to go to the user profiles page
  So that  I can view all members  in the organization
  
Background:
  Given PENDING
  Given a logged in user "Tommy"
  And a logged in user "Jack"
  And a logged in user
  And I am on the CommunityGrows home page
  Given I am on the User Profiles page
  
Scenario: A user should see all members on the User Profiles page
  Then I should see "Tommy"
  Then I should see "Jack"
  Then I should see "Dummy"
 
Scenario: A user should see the basic info of a user 
  Then I should see "Jack"
  And I should see "jack@dummy.com"
  And I should see "CommitteName"
  And I should see "Title"
  
Scenario: A user should be able to go to the user info page for a user
  Then I follow "Jack"
  Then I should be on the user info page for Jack
  
  
  
  
  
  
  
    