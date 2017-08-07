# by Tony
Feature: successfully comment on an announcement on the main dashboard
  
  As a user
  I want to comment on announcements
  So that the conversation between different users can be established

Background: user is on the main dashboard page and announcement is made
  Given the following committees exist:
    | name            | inactive | hidden    |
    | hoopla          | true     | false     |
    | crystal gems    | true     | false     |
    | backstreet boys | true     | false     |

  Given the following announcements exist:
    | title      | content          | created_at           | committee_id |
    | aaaaaaa    | announceone      | 2016-03-17 17:44:13  | 1            |
    | bbbbbbb    | announcetwo      | 2016-03-14 15:32:00  | 1            |
    | ccccccc    | announcethree    | 2016-03-18 22:12:11  | 1            |
    | ddddddd    | announceonex     | 2016-03-19 17:44:13  | 1            |
    | eeeeeee    | announcetwoy     | 2016-03-20 15:32:00  | 1            |
    | fffffff    | announcethreez   | 2016-03-21 22:12:11  | 1            |
  Given the following users exist:
    | name   | email             | admin      | created_at           | password     | password_confirmation     |
    | Zach   | zach@gmail.com    | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |
    | Tony   | tonylee@gmail.com | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |
    | Jae    | jae@berkeley.edu  | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  |
  Given a valid user
  And I am on the CommunityGrows dashboard page
  
# happy path
Scenario: User can see admin announcements, only the lastest 5 annuncement can be shown
  Then I should see "aaaaaaa"
  And I should see "ccccccc"

# happy path  
Scenario: User can see committee announcements
  Then I should see "ddddddd [hoopla]"
  And I should see "eeeeeee [hoopla]"
  And I should see "fffffff [hoopla]"

# happy path
Scenario: User clicks on announcement to view comments for given announcement
  When I follow "ddddddd [hoopla]"
  Then I should be on the comment page for "ddddddd"
  And I should see "Add new comment"
  Then I follow "Add new comment"
  And I fill in "comment_content" with "This is a test comment"
  And I press "Submit"
  Then I should be on the comment page for "ddddddd"
  And I should see "This is a test comment"
  Then I follow "Delete Comment"
  And I should not see "This is a test comment"
  
#sad path
Scenario: User should not be able to create a comment with empty content
  When I follow "ddddddd [hoopla]"
  Then I should be on the comment page for "ddddddd"
  And I should see "Add new comment"
  Then I follow "Add new comment"
  And I press "Submit"
  Then I should be on the new comment page for "ddddddd"
  And I should see "Comment cannot be blank."
  
