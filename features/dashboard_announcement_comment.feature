# by Tony
Feature: successfully comment on an announcement on the main dashboard
  
  As a user
  I want to comment on announcements
  So that the conversation between different users can be established

Background: user is on the main dashboard page and announcement is made
  
  Given the following announcements exist:
    | title      | content          | created_at           | committee_type   |
    | aaaaaaa    | announceone      | 2016-03-17 17:44:13  | dashboard        |
    | bbbbbbb    | announcetwo      | 2016-03-14 15:32:00  | dashboard        |
    | ccccccc    | announcethree    | 2016-03-18 22:12:11  | dashboard        |
    | ddddddd    | announceonex     | 2016-03-19 17:44:13  | executive        |
    | eeeeeee    | announcetwoy     | 2016-03-20 15:32:00  | internal         |
    | fffffff    | announcethreez   | 2016-03-21 22:12:11  | external         |
  Given a logged in user
  And I am on the CommunityGrows dashboard page
  
# happy path
Scenario: User can see admin announcements
  Then I should see "aaaaaaa"
  And I should see "bbbbbbb"
  And I should see "ccccccc"

# happy path  
Scenario: User can see committee announcements
  Then I should see "ddddddd [executive]"
  And I should see "eeeeeee [internal]"
  And I should see "fffffff [external]"

# happy path
Scenario: User clicks on announcement to view comments for given announcement
  When I follow "ddddddd [executive]"
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
  When I follow "ddddddd [executive]"
  Then I should be on the comment page for "ddddddd"
  And I should see "Add new comment"
  Then I follow "Add new comment"
  And I press "Submit"
  Then I should be on the new comment page for "ddddddd"
  And I should see "Comment cannot be blank."
  
