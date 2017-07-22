Feature: Committee Management
  
  As an admin
  I want to add, remove, edit, In hide, or show categories
  So that documents can be sorted more effectively
  
  
Background:
  
    Given the following committees exist:
        | name            | inactive | hidden    |
        | hoopla          | true     | false     |
        | crystal gems    | true     | false     |
        | backstreet boys | true     | false     |
    Given a logged in admin
    And I am on the CommunityGrows home page


Scenario: Existance of committee management in drop down
    Given I am on the CommunityGrows home page
    Then I should see "Admin Dashboard"
    # Then I should see "Committee Management" in "Admin" tab


Scenario: Visiting committee managment page
    Given I am on the CommunityGrows committee management page
    Then I should see "Committee Management"
    And I should see "hoopla"
    And I should see "crystal gems"
    And I should see "backstreet boys"
    And I should see "Delete crystal gems"
    And I should see "Hide Hoopla"
    And I should see "Deactivate backstreet boys"
    And I should see "New Committee"
    

Scenario: Create new committee
    Given I am on the committee management page
    When I follow "New Committee"
    And I fill in "Committee Name" with "Good Committee"
    And I press "Submit"
    Then I am on the committee managment page
    And I should see "Good Committee"
    And I should see "Delete Good Committee"
    And I should see "Hide Good Committee"
    And I should see "Deactivate Good Committee"
    
    Given I am on the CommunityGrows admin_dashboard page
    Then I should see "Good Committee" in "Committees" tab
    Then I should see "Add new document"
    

Scenario: Edit committee    
    When I follow first "hoopla"
    And I fill in "Category Name" with "Great hoopla"
    And I press "Submit"
    Then I am on the committee managment page
    And I should see "Great hoopla"
    And I should see "Delete Great hoopla"
    And I should see "Hide Great hoopla"
    And I should see "Deactivate Great hoopla"
    
    Given I am on the CommunityGrows home page
    Then I should see "Great hoopla" in "Committees" tab
    When I follow "Great hoopla" in "Committees" tab
    Then I should see "Great hoopla is inactivate."
    Then I should see "Add new document"
    
    
Scenario: Delete committee  
    Given I am on the committee management page
    When I press "Delete hoopla"
    And I confirm popup
    Then I should see "Committee with name hoopla deleted successfully."
    Given I am on the CommunityGrows admin_dashboard page
    Then I should not see "hoopla" in "Committees" tab
    

Scenario: Hide and Show committee  
    Given I am on the committee management page
    When I press "Hide hoopla"
    And I am on the committee management page
    Then I should see "hoopla successfully hidden."
    And I should see "hoopla"
    And I should see "Delete hoopla"
    And I should see "Show hoopla"
    And I should see "Deactivate hoopla"
    And I should not see "hoopla" in "Committees" tab
    
    When I press "Show hoopla"
    And I am on the committee management page
    Then I should see "hoopla successfully hidden."
    And I should see "hoopla"
    And I should see "hoopla" in "Committees" tab


Scenario: Inactivate and Deactivate committee  
    Given I am on the committee management page
    When I press "Deactivate hoopla"
    Then I should see "hoopla successfully deactivated."
    And I am on the committee management page
    And I should see "hoopla"
    And I should see "Delete hoopla"
    And I should see "Hide hoopla"
    And I should see "Inactivate hoopla"
    And I should see "hoopla" in "Committees" tab
    When I follow "hoopla" in "Committees" tab
    Then I should see "hoopla is deactivate."
    Then I should not see "Add new document"
    
    Given I am on the committee management page
    When I press "Inactivate hoopla"
    Then I should see "hoopla successfully inactivated."
    And I am on the committee management page
    Then I should see "hoopla" in "Committees" tab
    When I follow "hoopla" in "Committees" tab
    Then I should see "hoopla is inactivate."
    Then I should see "Add new document"
    
    
# sad path
Scenario: should not be able to edit committee name to be blank
    Given I am on the committee management page
    Then I should see "hoopla"
    When I follow first "hoopla"
    And I fill in "Category Name" with ""
    And I press "Submit"
    Then I should see "Please fill in the committee name field."
    And I am on the committee management page
    
Scenario: should not be able to create committee name to be blank
    Given I am on the committee management page
    Then I should see "New Committee"
    When I follow "New Committee"
    And I fill in "Committee Name" with ""
    And I press "Submit"
    Then I should see "Please fill in the committee name field."
    And I am on the committee management page