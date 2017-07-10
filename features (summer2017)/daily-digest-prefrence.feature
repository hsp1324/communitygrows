Feature: Users are able to decide their email preferences

    As a user
    So that I can receieve committee updates depending on my digest preference
    I would like to be able to select the frequency of when I receive email from committees
    
Background: users in databse
  Given the following users exist:
    | name     | email                    | admin      | created_at           | password     | password_confirmation     | internal     | external      | executive   |          
    | Ruby    | ruby@gmail.com          | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |    false     |   true      |     true    |
    | Jasper    | jasper@gmail.com          | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |    true      |   false      |     true    |
    | Daiya    | daiya@berkeley.edu   | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  |    false     |   false      |     false   |

  Given "ruby@gmail.com" logs in with password "12341234"
  And I am on the dashboard page

Scenario: Happy Path

  Given I am on the account details page for "ruby@gmail.com"

  When I select "Real Time" from "user_digest_pref"
  And I press "Update Digest"
  Then I should see "info was successfully updated"
  And I am on the account details page for "ruby@gmail.com"
  
  Given I am on the account details page for "ruby@gmail.com"
  When I select "Daily" from "user_digest_pref"
  And I press "Update Digest"
  Then I should see "info was successfully updated"
  And I am on the account details page for "ruby@gmail.com"

  Given I am on the account details page for "ruby@gmail.com"
  When I select "Weekly" from "user_digest_pref"
  And I press "Update Digest"
  Then I should see "info was successfully updated"
  And I am on the account details page for "ruby@gmail.com"
