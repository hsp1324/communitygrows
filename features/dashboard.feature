Feature: dashboard contains all necessary information
  
  As a user
  I want to make sure everything I want is on the dashboard
  So I can view panels and go to other tabs
  
Background: user is on the login page
  Given a logged in user
  And I am on the CommunityGrows dashboard page

# happy path
Scenario: see all the tabs
  Then I should see "Documents"
  And I should see "Executive"
  And I should see "External"
  And I should see "Internal"
  And I should see "User Profiles"

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

# happy path
Scenario: subcomittee tab works successfully
  When I follow "Executive"
  Then I should see "Executive"

# happy path  
Scenario: subcomittee tab works successfully
  When I follow "External"
  Then I should see "External"

# happy path  
Scenario: subcomittee tab works successfully
  When I follow "Internal"
  Then I should see "Internal"

# sad path  
Scenario: admin tab should not work successfully because you are not admin
  Then I should not see "Admin Dashboard"
  
Scenario: Anyone can access the user profile page
  When I follow "User Profiles"
  Then I should be on the User Profiles page
