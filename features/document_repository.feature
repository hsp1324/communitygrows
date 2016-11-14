Feature: successfully CRUD on the document repository
  
  As a user
  I want to perform CRUD actions on the document repository
  So that I can not only access the information but contribute to them

Background: user is on the document repository page
  Given a logged in user
  And a category called "Ctgy"
  And I am on the document repository page

# happy path
Scenario: User can add a new document
  When I follow "Add new file"
  Then I fill in "file_title" with "schedule"
  Then I fill in "file_url" with "mock.com/schedule"
  And I select "Ctgy" from "file_category_id"
  And I press "Submit"
  Then I should be on the document repository page
  And I should see "schedule"

# sad path
Scenario: User can't add a new document without proper file name
  When I follow "Add new file"
  Then I fill in "file_url" with "mock.com/schedule"
  And I select "Ctgy" from "file_category_id"
  And I press "Submit"
  And I should see "Populate all fields before submission."
  

