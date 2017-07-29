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
    | title        |           url            | committee_type |
    | answer_key   |     cs169.testbank.com   | hoopla         |
    | Ruby_where   |     happypuppies.com     | hoopla         |
    | Dinos_green  |     noitaint.com         | hoopla         |
    | Mihcael Cera |     crystalfairy.com     | crystal gems   |

  Given the following categories exist:
    |     name     |     hidden     |  
    | purpleHeart  |     false      |
    | HansYOLO     |     false      |
    | callMeSue    |     false      | 
    
  Given a logged in admin "Uncle Iro"
  Given admin "Uncle Iro" is in the following committees: "hoopla, crystal gems"
  And a category called "Taos"
  And a category called "The Practice of Yogurt"
  And I am on the CommunityGrows dashboard page
  
Scenario: Visiting Committee hoopla page to see transfer buttons
  
  Given I am on subcommittee "hoopla" page
  Then I should see hoopla Subcommittee
  And I should see the following documents: "answer_key, Ruby_where, Dinos_green"
  And I should not see "Michael Cera"
  And I should see "Transfer answer_key"
  And I should see "Transfer Ruby_where"
  And I should see "Delete Dinos_green"
  And I should see "Edit answer_key"
  
Scenario: Transfering document Ruby_where to Document repository under category The Practice of Yogurt
  
  Given I am on subcommittee "hoopla" page
  When I press "Transfer Ruby_where"
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
  And I select "The Practice of Yogurt" from drop down menu "Ruby_where"
  #Transfer button
  When I press "Transfer all"
  Then I should see "Documents were successfully transferred to Document Repository"
  Given I am on the document repository page
  Then I should see "Ruby_where"
  
Scenario: Transfering multiple documents to Document Repository via the transfer documents button
  
  Given I am on subcommittee "hoopla" page
  When I press "Edit Announcement"
  #redirects to a new page
  Then I should see "Transfer Documents"
  And I should see "Ruby_where"
  And I should see "Dinos_green" 
  And I should see "answer_key"
  #Select from drop down menu
  And I select "The Practice of Yogurt" from drop down menu "Dinos_green"
  And I select "The Practice of Yogurt" from drop down menu "Ruby_where"
  And I select "The Practice of Yogurt" from drop down menu "answer_key"
  #Transfer button
  When I press "Transfer all"
  Then I should see "Documents were successfully transferred to Document Repository"
  Given I am on the document repostiroy page
  Then I should see "Ruby_where"
  Then I should see "Dinos_green"
  Then I should see "answer_key"
  
  
  
  