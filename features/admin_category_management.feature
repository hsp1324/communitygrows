Feature: Category Management
  
  As an admin
  I want to add, remove, edit, hide, or show categories
  So that documents can be sorted more effectively
  
Background: admin is on the admin dashboard and a category has been created
  Given a logged in admin
  And I am on the category management page
  Then I should see "New Category"
  When I follow "New Category"
  And I fill in "Category Name" with "Good Category"
  And I press "Submit"

# happy path
Scenario: should be able to add a category
  Then I should see "Good Category"


# happy path
Scenario: should be able to edit a created category
  Then I should see "Good Category"
  When I follow first "Good Category"
  And I fill in "Category Name" with "CATegory"
  And I press "Submit"
  Then I should see "CATegory"

# sad path
Scenario: should not be able to edit category names to be blank
  Then I should see "Good Category"
  When I follow first "Good Category"
  And I fill in "Category Name" with ""
  And I press "Submit"
  Then I should see "Please fill in the category name field."

# happy path
@javascript
Scenario: should be able to delete a created category
  When I press "Delete Good Category"
  And I confirm popup
  Then I should see "Good Category deleted successfully."

# happy path
Scenario: should be able to hide a category
  When I press "Hide Good Category"
  And I am on the document repository page
  Then I should not see "Good Category"

# happy path
Scenario: should be able to show a hidden category
  When I press "Hide Good Category"
  And I am on the document repository page
  Then I should not see "Good Category"
  When I am on the category management page
  When I press "Show Good Category"
  And I am on the document repository page
  Then I should see "Good Category"

# no sad path because the design of CRUD is specifically open to the admin's discretion
