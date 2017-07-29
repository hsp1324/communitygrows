Feature: Announcement CRUD actions supported on admin dashboard
  
  As an admin
  I want to make sure every announcements that I update should be reflected
  So that users can see them on their dashboard
  
Background: admin is on the admin dashboard
  
  Given a logged in admin
  And I am on the CommunityGrows admin_dashboard page

# happy path
Scenario: should be able to add an announcement
  Then I should see "New Announcement"
  When I follow "New Announcement"
  And I fill in "Title" with "newnew title"
  And I fill in "Content" with "newnew content"
  And I press "Submit"
  Then I should see "Announcement creation successful and email was sent successfully."
  Then I should see "newnew title"

# happy path
Scenario: should be able to edit a created announcement
  Then I should see "New Announcement"
  When I follow "New Announcement"
  And I fill in "Title" with "newnew title"
  And I fill in "Content" with "newnew content"
  And I press "Submit"
  Then I should see "Announcement creation successful and email was sent successfully."
  And I should see "newnew title"
  When I follow first "Edit Announcement"
  Then I fill in "Title" with "edited title"
  Then I fill in "Content" with "edited content"
  And I press "Submit"
  Then I should see "edited title"

# happy path
@javascript
Scenario: should be able to delete a created announcement
  Then I should see "New Announcement"
  When I follow "New Announcement"
  And I fill in "Title" with "newnew title"
  And I fill in "Content" with "new content"
  And I press "Submit"
  Then I should see "Announcement creation successful and email was sent successfully."
  Then I should see "newnew title"
  Then I should see "Delete Announcement"
  When I follow first "Delete Announcement"
  And I confirm popup
  Then I should see "Announcement with title [newnew title] deleted successfully"
  Then I should not see "Delete Announcement"

# no sad path because the design of CRUD is specifically open to the admin's discretion
