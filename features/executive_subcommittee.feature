Feature: successfully working on executive subcommittee
  
  As a user
  I want to perform announcement actions and document actions on the executive subcommittee page
  So that I can see those on the executive subcommittee page

Background: user is on the executive page
  
  Given a logged in user
  And I am on the executive committee page

# happy path
Scenario: should be able to add an announcement
  Then I should see "Add new announcement"
  When I follow "Add new announcement"
  And I fill in "Title" with "new title"
  And I fill in "Content" with "new content"
  And I press "Submit"
  Then I should see "new title"
  And I should see "new content"
  
# sad path
Scenario: user tries to create an announcement with a blank title
  Then I should see "Add new announcement"
  When I follow "Add new announcement"
  Then I fill in "Content" with "announcement with no title"
  And I press "Submit"
  Then I should be on the new announcement page for "executive"
  And I should see "Title field cannot be left blank."

# happy path
Scenario: should be able to edit a created announcement
  Then I should see "Add new announcement"
  When I follow "Add new announcement"
  And I fill in "Title" with "new title"
  And I fill in "Content" with "new content"
  And I press "Submit"
  Then I should see "Edit Announcement"
  When I follow first "Edit Announcement"
  And I fill in "Title" with "edited title"
  And I fill in "Content" with "edited content"
  And I press "Submit"
  Then I should see "edited title"
  And I should see "edited content"
  
# sad path
Scenario: user should not be able to edit an existing announcement and submit with empty title field
  Then I should see "Add new announcement"
  When I follow "Add new announcement"
  And I fill in "Title" with "newtitle"
  And I fill in "Content" with "new content"
  And I press "Submit"
  Then I follow first "Edit Announcement"
  And I fill in "Title" with ""
  And I fill in "Content" with "here is the new edited content"
  And I press "Submit"
  Then I should be on the edit announcement page for "newtitle"
  And I should see "Title field cannot be left blank."

# happy path
@javascript
Scenario: should be able to delete a created announcement
  Then I should see "Add new announcement"
  When I follow "Add new announcement"
  And I fill in "Title" with "new title"
  And I fill in "Content" with "new content"
  And I press "Submit"
  Then I should see "new title"
  And I should see "new content"
  Then I follow "Delete Announcement"
  And I confirm popup
  Then I should not see "new content"
  
# happy path
Scenario: should be able to add a document
  Then I should see "Add new document"
  When I follow "Add new document"
  And I fill in "Title" with "new title"
  And I fill in "URL" with "newurl.com"
  And I press "Submit"
  Then I should see "new title"

# happy path
Scenario: should be able to edit a created document
  Then I should see "Add new document"
  When I follow "Add new document"
  And I fill in "Title" with "new title"
  And I fill in "URL" with "newurl.com"
  And I press "Submit"
  Then I should see "Edit Document"
  When I follow first "Edit Document"
  And I fill in "Title" with "edited title"
  And I fill in "url" with "newurl.com"
  And I press "Submit"
  Then I should see "edited title"

# happy path
@javascript
Scenario: should be able to delete a created document
  Then I should see "Add new document"
  When I follow "Add new document"
  And I fill in "Title" with "new title"
  And I fill in "URL" with "newurl.com"
  And I press "Submit"
  Then I should see "new title"
  Then I should see "Delete Document"
  When I follow first "Delete Document"
  And I confirm popup
  Then I should not see "newurl"