Feature: Marking Documents as Read/Unread
  
  As a user
  I want to toggle documents as read/unread
  So that all users knows who has read a document. 
  
  Background:
    Given a logged in user
    And a category called "Ctgy"
    And I am on the document repository page 
    When I follow "Add new file"
    Then I fill in "file_title" with "schedule"
    Then I fill in "file_url" with "mock.com/schedule"
    And I select "Ctgy" from "file_category_id"
    And I press "Submit"
    Then I should be on the document repository page
    And I should see "schedule"
    When I follow "schedule"
    
  Scenario: Should have Not Read as Default
    Then I should see "Not Read" in Read Status Table for user
    
  Scenario: Selecting mark as read should change Not Read to Read
    When I check "markasread"
    Then I should see "Read" in Read Status Table for user
  
  Scenario: I can see who has marked as read
    And I check "markasread"
    Given I am logged out
    Given a logged in admin
    And I am on the document repository page 
    When I follow "schedule"
    Then I should see "Read" in Read Status Table for user

  # Scenario: Only admin should see reset all reads reciepts button
  #   When I follow "schedule"
  #   Then I should not see "Reset Read Reciepts"
  #   Given a logged in admin
  #   And I am on the document repository page 
  #   When I follow "schedule"
  #   Then I should see "Reset Read Reciepts"
    
  # Scenario: Admin should be able to reset all reads to unread
  #   When I follow "schedule"
  #   And I check "Mark as read"
  #   Given a logged in admin
  #   And I am on the document repository page 
  #   When I follow "schedule"
  #   Given I click "Reset Read Reciepts"
  #   Then I should not see "Read"

Feature: Marking Documents as Read/Unread
  
  As a user
  I want to toggle documents as read/unread
  So that all users knows who has read a document. 

  Background:
    Given a logged in user
    And a category called "Ctgy"
    And I am on the document repository page 
    When I follow "Add new file"
    Then I fill in "file_title" with "schedule"
    Then I fill in "file_url" with "mock.com/schedule"
    And I select "Ctgy" from "file_category_id"
    And I press "Submit"
    Then I should be on the document repository page
    And I should see "schedule"
    When I follow "schedule"
    
  Scenario: Should have Not Read as Default
    Then I should see "Not Read" in Read Status Table for user  