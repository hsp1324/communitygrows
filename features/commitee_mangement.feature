Feature: Committee Management
  
  As an admin
  I want to add, remove, edit, hide or show, active or inactive committees
  So that documents can be sorted more effectively
  
  
Background:
  
    Given the following committees exist:
        | name            | inactive | hidden    |
        | hoopla          | true     | false     |
        | crystal gems    | true     | false     |
        | backstreet boys | true     | false     |
        
    Given the following users exist:
        | name   | email             | admin      | created_at           | password     | password_confirmation     |
        | Zach   | zach@gmail.com    | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |
        | Tony   | tonylee@gmail.com | false      | 2016-03-14 15:32:00  | 43124312     | 43124312                  |
        | Jae    | jae@berkeley.edu  | false      | 2016-03-18 22:12:11  | 54175417     | 54175417                  |          
    Given "zach@gmail.com" logs in with password "12341234"
    And I am on the CommunityGrows home page


Scenario: Existance of committee management in drop down
    Given I am on the CommunityGrows home page
    Then I should see "Admin Dashboard"
    # Then I should see "Committee Management" in "Admin" tab


Scenario: Visiting committee management page
    Given I am on the CommunityGrows committee management page
    Then I should see "Committee Management"
    And I should see "hoopla"
    And I should see "crystal gems"
    And I should see "backstreet boys"
    And I should see "New Committee"
    And I should see "Activate hoopla"
    And I should see "Delete crystal gems"
    And I should see "Hide backstreet boys"
    

Scenario: Create new committee
    Given I am on the committee management page
    When I follow "New Committee"
    And I fill in "Committee Name" with "Good Committee"
    And I press "Submit"
    Then I am on the committee management page
    And I should see "Good Committee"
    And I should see "Delete Good Committee"
    And I should see "Show Good Committee"
    And I should see "Activate Good Committee"
    
    Given I am on the CommunityGrows admin_dashboard page
    Then I should not see "Good Committee"
    

Scenario: Edit committee   
    Given I am on the committee management page
    When I follow second "hoopla"
    And I should see "Edit"
    And I fill in "Committee Name" with "Great hoopla"
    And I press "Update Committee"
    Then I am on the committee management page
    And I should see "Great hoopla"
    And I should see "Delete Great hoopla"
    And I should see "Hide Great hoopla"
    And I should see "Activate Great hoopla"
    
    Given I am on the CommunityGrows home page
    Then I should see "Great hoopla"
    When I follow "Great hoopla"
    Then I should see "You do not have access to this committee. Please contact Kelly for access."
    And I should not see "Add new announcement"
    And I should not see "Add new document"
    
    
Scenario: Delete committee  
    Given I am on the CommunityGrows admin_dashboard page
    Then I should see "hoopla"
    Given I am on the committee management page
    And I should see "Delete hoopla"
    When I press "Delete hoopla"
    And I confirm popup
    Then I should see "Committee with name hoopla deleted successfully."
    Given I am on the CommunityGrows admin_dashboard page
    Then I should not see "hoopla"
    

Scenario: Hide and Show committee  
    Given I am on the committee management page
    And I should see "Hide hoopla"
    When I press "Hide hoopla"
    # And I am on the committee management page
    Then I should see "hoopla successfully hidden."
    And I should see "hoopla"
    And I should see "Delete hoopla"
    And I should see "Show hoopla"
    And I should see "Activate hoopla"
    Given I am on the CommunityGrows admin_dashboard page
    And I should not see "hoopla"
    
    Given I am on the committee management page
    And I should see "Show hoopla"
    When I press "Show hoopla"
    # And I am on the committee management page
    Then I should see "hoopla successfully shown."
    And I should see "Hide hoopla"
    Given I am on the CommunityGrows admin_dashboard page
    And I should see "hoopla"


Scenario: Activate and Inactivate committee  
    Given I am on the committee management page
    And I should see "Activate hoopla"
    When I press "Activate hoopla"
    Then I should see "hoopla successfully made active."
    And I am on the committee management page
    And I should see "hoopla"
    And I should see "Delete hoopla"
    And I should see "Hide hoopla"
    And I should see "Inactivate hoopla"
    Given I am on the CommunityGrows admin_dashboard page
    And I should see "hoopla"
    When I follow first "hoopla"
    Then I should see "You do not have access to this committee. Please contact Kelly for access."
    Given I am on the committee management page
    And I follow second "hoopla"
    And I should see "Zach"
    When I choose all of the damn checkboxes
    And I press "Submit"
    When I follow first "hoopla"
    And I should see "Add new announcement"
    And I should see "Add new document"
    
    Given I am on the committee management page
    And I should see "Inactivate hoopla"
    When I press "Inactivate hoopla"
    Then I should see "hoopla successfully made inactive."
    Given I am on the CommunityGrows admin_dashboard page
    Then I should see "hoopla"
    When I follow "hoopla"
    Then I should see "hoopla is currently inactive"
    And I should not see "Add new announcement"
    And I should not see "Add new document"
    
    
# sad path
Scenario: should not be able to edit committee name to be blank 
    Given I am on the committee management page
    Then I should see "backstreet boys"
    And I should see "backstreet boys"
    When I follow second "backstreet boys"
    And I fill in "Committee Name" with ""
    And I press "Update Committee"
    Then I should see "Please fill in the committee name field."

    
Scenario: should not be able to create committee name to be blank or already existed name
    Given I am on the committee management page
    Then I should see "New Committee"
    When I follow "New Committee"
    And I fill in "Committee Name" with ""
    And I press "Submit"
    Then I should see "Committee name field cannot be blank."
    When I fill in "Committee Name" with "hoopla"
    And I press "Submit"
    Then I should see "Committee name provided already exists. Please enter a different name."

Scenario: Users should be able to add a committee description, and the description should be reflected on the committees page

    Given I am on the committee management page
    When I follow second "hoopla"
    And I should see "Edit"
    And I fill in "Committee Name" with "Great hoopla"
    And I fill in "Committee Description" with "Great dinos"
    When I choose all of the damn checkboxes
    And I press "Update Committee"

    Given I am on the CommunityGrows home page
    Then I should see "Great hoopla"
    When I follow "Great hoopla"
    And I should see "Committee Description"
    And I should see "Great dinos"

    
    