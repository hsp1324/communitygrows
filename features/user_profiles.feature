# By Tommy and Jack
Feature: User profile page
  
  As a user or admin
  I want to go to the user profiles page
  So that  I can view all members  in the organization
  
Background:
  Given a logged in user
  Given a valid user "Tommy"
  And a valid user "Jack"
  And I am on the CommunityGrows home page
  Given I am on the User Profiles page
  
Scenario: A user should see all members on the User Profiles page
  Then I should see "Tommy"
  Then I should see "Jack"
  Then I should see "Test Test"
 
Scenario: A user should see the basic info of a user 
  Then I should see "Jack"
  And I should see "jack@dummy.com"
  And I should see "Committee"
  And I should see "Board Role"
  
Scenario: A user should be able to go to the user info page for a user
  Then I follow "Jack"
  Then I should see "About Me"
  #Then I should see on the user info page for "Jack"
  
Scenario: User information is visible on the user profile page
  Given I follow "Jack"
  Then I should see "A college student"

Scenario: User should see their expertises
  Then I follow "Jack"
  And I should see "Areas of Expertise"
  
Scenario: User should see their constituencies
  Then I follow "Jack"
  And I should see "Constituency"

Scenario: User should see race and ethnicity
  Then I follow "Jack"
  And I should see "Ethnicity" 
  
Scenario: User should be able to see their job info
  Given I follow "Jack"
  Then I should see "Job Information"
   And I should see "Current Company"
  And I should see "Current Position"
