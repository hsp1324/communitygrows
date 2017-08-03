Feature: dashboard contains all necessary information
  
  As a user
  I want to make sure everything I want is on the dashboard
  So I can view panels and go to other tabs
  
Background: user is on the login page
  Given a logged in user
  And I am on the CommunityGrows dashboard page

# happy path
Scenario: see all the tabs
  And I should see "Dashboard"
  Then I should see "Documents"
  And I should see "Committee"
  And I should see "User Profiles"
  And I should see "Account Details"

# happy path  
Scenario: see all the panels
  Then I should see "Main Announcements"
  #And I should see "Calendar"
  And I should see "Date"
  And I should see "Title"

# happy path
Scenario: document tab works successfully
  When I follow "Documents"
  Then I should see "Document Repository"


# sad path  
Scenario: admin tab should not work successfully because you are not admin
  Then I should not see "Admin Dashboard"
  
Scenario: Anyone can access the user profile page
  When I follow "User Profiles"
  Then I should be on the User Profiles page
