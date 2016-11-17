Feature: Category Interaction
  
  As an admin
  I want to be able click and drag categories and documents to make changes to their order
  So that I can intuitively manipulate the organization of the portal
  
Background: admin is on the admin dashboard and a category has been created
  Given the following categories exist:
    | name                |
    | Good Category       |
    | Better Category     |
    | Incredible Category |
  And a logged in admin
  And I am on the category management page

# happy path
Scenario: should be able to sort categories alphabetically
  When I follow "Sort Categories By Name"
  And I am on the document repository page
  Then I should see "Better Category" before "Good Category"
  And I should see "Good Category" before "Incredible Category"

# happy path
@javascript
Scenario: should be able to sort categories manually
  When I drag the category "Incredible Category" to the top slot
  And I am on the document repository page
  # Then I should see "Incredible Category" before "Good Category"
  # And I should see "Good Category" before "Better Category"

# happy path
@javascript
Scenario: should be able to drag documents between categories
  Given I create a document called "document" with url "doc.com/bestdoc" in category "Good Category"
  And I create a document called "doc2" with url "fun.com/goodness" in category "Incredible Category"
  #Given I am on the document repository page
  #And I follow "Add new file"
  #And I follow "Add new file"
  #And I fill in "file_title" with "document"
  #And I fill in "file_url" with "doc@word.com/bestdoc"
  #And I select "Better Category" from "file_category_id"
  #And I press "Submit"
  And I am on the category management page
  When I drag the document "document" into the category "Better Category"
  And I drag the document "doc2" into the category "Better Category"
  And I am on the document repository page
  # And I take a screenshot called "~/wtf.png"
  # Then I should see the document "document" in the category "Better Category"
  # And I should see the document "doc2" in the category "Better Category"
