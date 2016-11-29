Feature: User info
  
  As a user
  I want to be able click on a my user profile
  So that I can see and edit my information

Background:
  # Given PENDING
  
  # Given the following users exist:
  #  | email              | admin      | created_at           | password     | password_confirmation     |
  #  | jack@gmail.com     | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |
  #  | tommy@gmail.com    | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |
  #  | test@berkeley.edu  | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  | 
  # Given a logged in user
  # And I am on the CommunityGrows home page
  # When I follow "User Profiles"
  
Scenario: On the correct user profile page
  # When I follow "Jack"
  # Then I should see "Jack's Profile"
  
Scenario: Information fields exist
  # Then I should see "About Me"
  # Then I should see "Why I joined CommunityGrows"
  # Then I should see "Interests"

Scenario: I am able to edit my own information
  # When I follow "Dummy"
  # Then I should see "Save Profile"
  
Scenario: I am not able to edit other people's info
  # When I follow "Jack"
  # Then I should not see "Save Profile"
  
Scenario: Admin's can edit any users info
  # Given I am logged out
  # Given a logged in admin
  # Given I am on the User Profiles page
  # When I follow "Jack"
  # Then I should see "Save Profile"
  
  