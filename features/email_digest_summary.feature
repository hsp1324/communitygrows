#cs169, Summer 2017 ^_^
Feature: Users with daily digest preference will receive a summary of all emails received

	As an admin
	I want to receive a summarized version of all emails
	So that I can lessen the load of emails I receive

Background: an admin is currently on the dashboard
	
	Given the following committees exist
    | name            | inactive  | hidden    |
    | hoopla          | false     | false     |
    | crystal gems    | false     | false     |
    | backstreet boys | false     | false     |
	Given a logged in admin "Capybara"
	Given admin "Capybara" is in the following committees: "hoopla, crystal gems"
	
	And I am on the CommunityGrows dashboard page
    

Scenario: When I create main announcement, I should see a new MailRecord object for main announcement

	When I follow "Add"
	When I fill in "Title" with "I am groot!"
	When I fill in "Content" with "who is groot?"
	When I press "Submit"
	Then I should see a MailRecord object with attribute "announcement_id" and description "add"

Scenario: When I create a subcommittee announcements, I should see a new MailRecord object for subcommittee announcement
	
	Given I am on subcommittee "hoopla" page
	# Then I should see "You do not have access to this committee."
	#Check if redirects to flash message!
	When I follow "Add new announcement"
  	And I fill in "Title" with "Purple"
  	And I fill in "Content" with "I am"
  	And I press "Submit" 
  	Then I should see a MailRecord object with attribute "announcement_id" and description "add"

Scenario: When I create a subcommittee document, I should see a MailRecord object for subcommittee document
	Given I am on subcommittee "hoopla" page
  	When I follow "Add new document"
	And I fill in "title" with "Jack"
  	And I fill in "url" with "www.cs169.com"
  	And I press "Submit" 
  	Then I should see a MailRecord object with attribute "document_id" and description "add"

Scenario: When I create a meeting, I should see a Meeting object for subcommittee document
	Given I am on the meeting management page
	When I follow "New Meeting"
	And I fill in "Meeting Name" with "Important Meeting"
	And I fill in "Meeting Date" with "2017/08/05"
	And I fill in "Meeting Location" with "Soda Hall"
	And I fill in "Meeting Description" with "Code party!!"
	Then I should see a MailRecord object with attribute "meeting_id" and description "add"