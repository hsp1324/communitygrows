Feature: A user should be able to update job description on profile
 
  As a user
  I want to be able to update job description on profile 
  So that other members can see my profile

Background: user is on the homepage

  Given a logged in user
  And I am on the CommunityGrows home page

Scenario: Edit job description and successfully save 
  
  Given I follow "Account Details"
  Then I should see "Edit Account Info"
  And I should see "Email:"
  And I should see "Gender:"
  And I should see "Ethnicity:"
  And I should see "Current Company:"
  And I should see "Current Position:"
  And I should see "About Me:"
  And I should see "Why I Joined Community Grows:"
  And I should see "Areas of Expertise"
  And I should see "Constituency"
  And I should see "Job Information"
  And I should see "Current Company"
  And I should see "Current Position"
  
  When I fill in "Current Company" with "sun company"
  And I fill in "Current Position" with "sun position"
  And I press "Update Info"
  
  Then I should see "info was successfully updated"
  # And I should see "sun company"
  # And I should see "sun position"
  
  Given I am on the User Profiles page
  Then I follow "Test Test"
  Then I should see "dummy@dummy.com"
  # And I should see "sun company"
  And I should see "sun position"
