Feature: Document transfer from Committee Documents to Document Repository
  As a user, 
  I want to be able to transfer documents from the committee page to the document repostiry
  So that documents can be archived for future access
  
Background:
  Given the following committees exist:
    | name            | inactive | hidden    |
    | hoopla          | false    | false     |
    | crystal gems    | false    | false     |

  Given the following documents exist
    | title        |           url            |
    | answer_key   |     cs169.testbank.com   |
    | Ruby_where   |     happypuppies.com     |
    | Dinos_green  |     noitaint.com         |
    | Michael Cera |     crystalfairy.com     |

  Given the following categories exist:
    |     name     |     hidden     |  
    | purpleHeart  |     false      |
    | HansYOLO     |     false      |
    | callMeSue    |     false      | 
  
  Given committee "hoopla" has documents: "answer_key, Ruby_where, Dinos_green"
  Given committee "crystal gems" has documents: "Michael Cera"
  Given a logged in admin "Uncle Iro"
  Given admin "Uncle Iro" is in the following committees: "hoopla, crystal gems"
  And a category called "Taos"
  And a category called "The Practice of Yogurt"
  And I am on the CommunityGrows dashboard page
  
Scenario: Visiting Committee hoopla page
  
  Given I am on subcommittee "hoopla" page
  Then I should see "Hoopla Committee"
  And I should see "answer_key"
  And I should see "Ruby_where"
  And I should see "Dinos_green"
  And I should not see "Michael Cera"
  
Scenario: Transfering document Ruby_where to Document repository under category The Practice of Yogurt
  
  Given I am on subcommittee "hoopla" page
  When I follow second "Transfer Document" 
  #redirects to a new page
  Then I should see "Transfer Documents"
  Then I should see "Ruby_where"
  #buttons and columns
  And I should see "Document"
  And I should see "Category"
  And I should see "Transfer"
  #existing categories in a drop down menu
  Then I should see "purpleHeart"
  Then I should see "HansYOLO"
  Then I should see "callMeSue"
  Then I should see "Taos"
  Then I should see "The Practice of Yogurt"
  #Select from drop down menu "The Practice of Yogurt"
  And I select "The Practice of Yogurt" from drop down menu "Ruby_where" on transfer documents page
  #Transfer button
  When I press "Submit"
  Then I should see "Documents were successfully transferred to Document Repository"
  Then I should see "Archived"
  Given I am on the document repository page
  Then I should see "Ruby_where"
  
Scenario: Transfering multiple documents to Document Repository via the transfer documents button
  
  Given I am on subcommittee "hoopla" page
  When I follow "Transfer All Documents"
  #redirects to a new page
  Then I should see "Transfer Documents"
  And I should see "Ruby_where"
  And I should see "Dinos_green" 
  And I should see "answer_key"
  #Select from drop down menu
  And I select "The Practice of Yogurt" from drop down menu "Dinos_green" on transfer documents page
  And I select "The Practice of Yogurt" from drop down menu "Ruby_where" on transfer documents page
  And I select "The Practice of Yogurt" from drop down menu "answer_key" on transfer documents page
  #Transfer button
  When I press "Submit"
  Then I should see "Documents were successfully transferred to Document Repository"
  Given I am on the document repository page
  Then I should see "Ruby_where"
  Then I should see "Dinos_green"
  Then I should see "answer_key"

Scenario: Clicking on a document in a committee page should redirect to document information page
  
  Given I am on subcommittee "hoopla" page
  When I follow "Ruby_where"
  Then I should be on the doc info page for "Ruby_where"
  # Then I should see "Ruby_where" Information

@javascript 
Scenario: Making changes to a document from the document repository should be reflected in the same document when navigating to document info page via committee page
  Given I am on subcommittee "hoopla" page
  When I follow second "Transfer Document"
  And I select "The Practice of Yogurt" from drop down menu "Ruby_where" on transfer documents page
  When I press "Submit"
  Given I am on the document repository page
  When I follow "Ruby_where"
  When I check "markasread"
  When I press "Click to Edit Document"
  And I fill in "Title" with "a"
  And I press "Save changes"
  Given I am on subcommittee "hoopla" page
  When I follow "a"
  Then I should see "Read"
  Then I should see "a"
