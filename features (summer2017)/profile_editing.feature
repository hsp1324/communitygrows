Feature: A user should be able to update job description on profile
 
  As a user
  I want to be able to update job description on profile 
  So that other members can see my profile

Background: user is on the homepage

  Given a logged in user
  And  I am on the home page 

Scenario: Edit job description and successfully save 
  
  Given I am on the community grows home page
  When I follow "Account Details"
  Then I should be on the edit account info page
  When I fill in job description with "Test"
  And I press "Save changes"
  Then I expect to see "Change saved"
