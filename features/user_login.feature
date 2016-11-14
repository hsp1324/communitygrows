# by Tony
Feature: successfully login 
  
  As a user
  I want to log in with my credentials
  So that I can access the dashboard

Background: user is on the login page
  Given a valid user
  And I am on the CommunityGrows home page

# happy path
Scenario: successfully login with a user credential
  When I fill in "user_email" with "dummy@dummy.com"
  And I fill in "password" with "dummypass"
  And I press "Log in"
  Then I should see "Board Member Dashboard"

# sad path  
Scenario: unsuccessfully login with a wrong username
  When I fill in "user_email" with "dummy@dummy.co"
  And I fill in "user_password" with "dummypass"
  And I press "Log in"
  Then I should see "Invalid Email or password."

# sad path
Scenario: unsuccessfully login with a wrong password
  When I fill in "user_email" with "dummy@dummy.co"
  And I fill in "user_password" with "wrong_password"
  And I press "Log in"
  Then I should see "Invalid Email or password."

# happy path
Scenario: user already signed in will be redirected to the dashboard
  When I fill in "user_email" with "dummy@dummy.com"
  And I fill in "user_password" with "dummypass"
  And I press "Log in"
  Then I should see "Board Member Dashboard"
  And I am on the CommunityGrows home page
  Then I should see "Board Member Dashboard"

# sad path
Scenario: unsuccessfully login with empty fill-in's
  When I fill in "user_email" with ""
  And I fill in "user_password" with ""
  And I press "Log in"
  Then I should see "Invalid Email or password."
  

  