Feature: Users should receive email notifications

	As a user,
	I want to receive notifications when and admin makes changes,
	So that I can stay updated with the organization

Background: users, announcements, and documents in database
  
  Given the following users exist:
    | email                    | admin      | created_at           | password     | password_confirmation     |
    | james@gmail.com          | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |
    | elmer@gmail.com          | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |
    | uglytommy@berkeley.edu   | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  |
  
  Given the following announcements exist:
    | title      | content          | created_at           | committee_type   |
    | aaaaaaa    | announceone      | 2016-03-17 17:44:13  | dashboard        |
    | bbbbbbb    | announcetwo      | 2016-03-14 15:32:00  | dashboard        |
    | ccccccc    | announcethree    | 2016-03-18 22:12:11  | dashboard        |
    | ddddddd    | announceonex     | 2016-03-19 17:44:13  | executive        |
    | eeeeeee    | announcetwoy     | 2016-03-20 15:32:00  | internal         |
    | fffffff    | announcethreez   | 2016-03-21 22:12:11  | external         |
  
   Given the following documents exist:
    | url            | title      | created_at           | committee_type   |
    | www.cs169.com  | aaaaaaa    | 2016-03-17 17:44:13  | dashboard        |
    | www.cs168.com  | bbbbbbb    | 2016-03-14 15:32:00  | dashboard        |
    | www.cs170.com  | ccccccc    | 2016-03-18 22:12:11  | dashboard        |
    | www.cs164.com  | ddddddd    | 2016-03-19 17:44:13  | executive        |
    | www.cs162.com  | eeeeeee    | 2016-03-20 15:32:00  | internal         |
    | www.cs161.com  | fffffff    | 2016-03-21 22:12:11  | external         |

  Given a logged in user
  And I am on the dashboard page

Scenario: An email should be sent if anyone creates an announcement to the internal subcommittee
  Given I am on the internal affairs committee page
  When I follow "Add new announcement"
  And I fill in "Title" with "Tilted"
  And I fill in "Content" with "I am"
  And I press "Submit" 
  Then I should see "email was successfully sent"

Scenario: An email should be sent if anyone creates an announcement to the external subcommittee
  Given I am on the external affairs committee page
  When I follow "Add new announcement"
  And I fill in "Title" with "Tilted"
  And I fill in "Content" with "I am"
  And I press "Submit" 
  Then I should see "email was successfully sent"
  
Scenario: An email should be sent if anyone creates an announcement to the executive subcommittee
  Given I am on the executive committee page
  When I follow "Add new announcement"
  And I fill in "Title" with "Tilted"
  And I fill in "Content" with "I am"
  And I press "Submit" 
  Then I should see "email was successfully sent"

Scenario: An email should be sent if anyone creates a document to the internal subcomittee
  Given I am on the internal affairs committee page
  When I follow "Add new document"
  And I fill in "title" with "Jack"
  And I fill in "url" with "www.cs169.com"
  And I press "Submit" 
  Then I should see "email was successfully sent"

Scenario: An email should be sent if anyone creates a document to the external subcomittee
  Given I am on the external affairs committee page
  When I follow "Add new document"
  And I fill in "title" with "Jack"
  And I fill in "url" with "www.cs169.com"
  And I press "Submit" 
  Then I should see "email was successfully sent"
  
Scenario: An email should be sent if anyone creates a document to the executive subcomittee
  Given I am on the executive committee page
  When I follow "Add new document"
  And I fill in "title" with "Jack"
  And I fill in "url" with "www.cs169.com"
  And I press "Submit" 
  Then I should see "email was successfully sent"

Scenario: An email should be sent if anyone makes changes to a document to the internal subcomittee
  Given I am on the internal affairs committee page
  When I follow "Edit Document"
  And I fill in "title" with "Jack"
  And I fill in "url" with "www.cs169.com"
  And I press "Submit" 
  Then I should see "email was successfully sent"

Scenario: An email should be sent if anyone makes changes to a document to the external subcomittee
  Given I am on the external affairs committee page
  When I follow "Edit Document"
  And I fill in "title" with "Jack"
  And I fill in "url" with "www.cs169.com"
  And I press "Submit" 
  Then I should see "email was successfully sent"
  
Scenario: An email should be sent if anyone makes changes to a document to the executive subcomittee
  Given I am on the executive committee page
  When I follow "Edit Document"
  And I fill in "title" with "Jack"
  And I fill in "url" with "www.cs169.com"
  And I press "Submit" 
  Then I should see "email was successfully sent"
  
Scenario: An email should be sent if anyone makes a change to an announcement to the internal subcommittee
  Given I am on the internal affairs committee page
  When I follow "Edit Announcement"
  And I fill in "Title" with "Tilted"
  And I fill in "Content" with "I am"
  And I press "Submit" 
  Then I should see "email was successfully sent"
  
Scenario: An email should be sent if anyone makes a change to an announcement to the external subcommittee
  Given I am on the external affairs committee page
  When I follow "Edit Announcement"
  And I fill in "Title" with "Tilted"
  And I fill in "Content" with "I am"
  And I press "Submit" 
  Then I should see "email was successfully sent"

Scenario: An email should be sent if anyone makes a change to an announcement to the executive sub-committee
  Given I am on the executive committee page
  When I follow "Edit Announcement"
  And I fill in "Title" with "Tilted"
  And I fill in "Content" with "I am"
  And I press "Submit" 
  Then I should see "email was successfully sent"
  


