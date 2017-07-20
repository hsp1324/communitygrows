#cs169, Summer 2017 ^_^
Feature: Users with daily digest preference will receive a summary of all emails received

	As a user
	I want to receive a summarized version of all emails
	So that I can lessen the load of emails I receive

Background: user in database
  Given the following users exist:
    | name     | email                    | admin      | created_at           | password     | password_confirmation     | internal     | external      | executive   |  digest_pref  |  
    | Purple    | purple@gmail.com          | true       | 2016-03-17 17:44:13  | 12341234     | 12341234                  |    false     |   true      |     true    | daily     |             
  
  Given it is currently "1" day ago
  Given "purple@gmail.com" logs in with password "12341234"
 	And an announcement is made with purpleHeart as title and purp as contents
 	And an announcement is made with goldenTree as title and trees as contents

Scenario: Check email database before email being sent 
    Given it is currently midnight the next day
    Then the database should have email with title purpleHeart and content purp
    And the database should have email with title goldenTree and content trees

Scenario: Daily digest email for two emails is sent
	Given it is currently noon the next day
	Then I should receive an email
	Then I should see title purpleHeart
	And I should see content purp
	And I sould see title goldenTree
	And I shold see content trees
	Then the database should not have email with title purpleHeart and content purp
	And the database should not have email with title goldenTree and content trees
	










