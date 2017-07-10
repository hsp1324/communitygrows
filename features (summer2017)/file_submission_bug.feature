Feature: a user should be able to sucssefully upload a file to the document repository

	As a user
	I want to be able sucessfully submit a file to the document repository
	So that my fellow board members can vew the document

Background: user is on the document repository page
  Given a logged in user
  Given a category called "About Community Grows"
  And I am on the document repository page

Scenario: A message containg "______ was successfully created and email was succesfully sent." should be dsplayed when a new file is uploaded

	Given I am on the document repository page
	When I follow "Add new file"
	And I fill in "Title" with "Test"
	And I fill in "URL" with "www.google.com"
	And I select "About Community Grows" from "file_category_id"
	And I press "Submit"
	Then I should see "Test was successfully created and email was succesfully sent."