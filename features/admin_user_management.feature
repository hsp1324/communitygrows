#Author: Zachary
Feature: Admin dashboard contains all necessary features
  
  As a user
  I want to make sure everything I want is on the Admin dashboard
  So I can view user management and announcement tools 
  
Background: users in database
  Given the following users exist:
    | name   | email             | admin      | created_at           | password     | password_confirmation     |
    | Zach   | zach@gmail.com    | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |
    | Tony   | tonylee@gmail.com | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |
    | Jae    | jae@berkeley.edu  | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  | 

  Given "zach@gmail.com" logs in with password "12341234"
  And I am on the CommunityGrows admin_dashboard page

# happy path
Scenario: Admin should see users on admin dashboard
  Then I should see "Zach"
  And I should see "Tony"

# happy path
Scenario: Admin can add new user to the database 
  When I follow "Add new user"
  Then I fill in "Name" with "Jack Sullivan"
  Then I fill in "Email" with "mg@mgmt.com"
  Then I fill in "Password" with "12345678"
  And I fill in "Password Confirmation" with "12345678"
  And I press "Submit"
  Then I should be on the admin_dashboard page
  And I should see "mg@mgmt.com"

# happy path  
Scenario: Admin can edit an existing user's email
  When I follow "Zach"
  Then I fill in "Email" with "zachary@gmail.com"
  And I press "Update User"
  Then I should be on the admin_dashboard page
  And I should see "zachary@gmail.com"
  And I should not see "zach@gmail.com"

# sad path  
Scenario: Admin fails to enter password during edit
  When I follow "Zach"
  Then I fill in "Email" with "zachary@gmail.com"
  And I press "Update Password"
  Then I should see "Password can't be blank"
  And I should be on the edit user page for "zach@gmail.com"

# sad path  
Scenario: Admin fails to enter password while adding new user 
  When I follow "Add new user"
  And I fill in "Email" with "bob@billy.com"
  And I press "Submit"
  Then I should see "Password can't be blank"

# happy path  
Scenario: Admin should see new user link
  Then I should see "Add new user"

# happy path  
Scenario: Admin should see last login data availabe for every user
  Then I should see "Created At"

Scenario: Admin cannot leave name field blank when adding new user
  When I follow "Add new user"
  Then I fill in "Name" with ""
  Then I fill in "Email" with "mg@mgmt.com"
  Then I fill in "Password" with "12345678"
  And I fill in "Password Confirmation" with "12345678"
  And I press "Submit"
  Then I should see "Name can't be blank"
  
Scenario: Admin cannot leave name field blank when editing new user
  When I follow "Zach"
  Then I fill in "Name" with ""
  Then I fill in "Email" with "mg@mgmt.com"
  And I press "Update User"
  Then I should see "Name can't be blank"
  

