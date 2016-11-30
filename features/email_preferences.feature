Feature: Users are able to decide their email preferences

    As a user
    I want to update my email preference settings
    So that I can receive the emails I want to receive and not be overloaded with emails.
    
Background: users in databse
  Given the following users exist:
    | name   | email                    | admin      | created_at           | password     | password_confirmation     | internal     | external      | executive  |          
    | james  | james@gmail.com          | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |    false     |   true      |     true     |
    | elmer  | elmer@gmail.com          | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |    true      |   false      |     true    |
    | ugly   | uglytommy@berkeley.edu   | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  |    false     |   false      |     false   |
    # | email             | admin      | created_at           | password     | password_confirmation     |
    # | zach@gmail.com    | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |
    # | tonylee@gmail.com | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |
    # | jae@berkeley.edu  | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  |
  Given "james@gmail.com" logs in with password "12341234"
  And I am on the dashboard page

Scenario: Happy Path

  Given I am on the account details page for "james@gmail.com"

  When I check "user_internal"
  And I press "Update Digest"
  Then I should see "info was successfully updated."
  And I am on the account details page for "james@gmail.com"
  Then the "Internal:" checkbox should be checked
  
  Given I am on the account details page for "james@gmail.com"
  When I check "user_internal" 
  And I check "user_executive"
  And I press "Update Digest"
  Then I should see "info was successfully updated."
  And I am on the account details page for "james@gmail.com"
  Then the "user_internal" checkbox should be checked
  And the "Executive:" checkbox should be checked

  Given I am on the account details page for "james@gmail.com"
  When I check "user_external"
  And I press "Update Digest"
  Then I should see "info was successfully updated."
  And I am on the account details page for "james@gmail.com"
  Then the "External:" checkbox should be checked

  Given I am on the account details page for "james@gmail.com"
  When I check "user_internal"
  And I check "user_external"
  And I check "user_executive"
  And I press "Update Digest"
  Then I should see "info was successfully updated."
  And I am on the account details page for "james@gmail.com"
  Then the "Internal:" checkbox should be checked
  And the "Executive:" checkbox should be checked
  And the "External:" checkbox should be checked


  Given I am on the account details page for "james@gmail.com"
  When I check "user_external" 
  And I check "user_executive"
  And I press "Update Digest"
  Then I should see "info was successfully updated."
  And the "Executive:" checkbox should be checked
  And the "External:" checkbox should be checked
  
Scenario: Sad Path
  Given I am on the account details page for "james@gmail.com"
  When I uncheck "user_external"
  And I uncheck "user_internal"
  And I uncheck "user_executive"
  And I press "Update Digest"
  Then I should see "Please select at least your committee to receive emails from."
  And I am on the account details page for "james@gmail.com"
    
  
  
 
  
  
  