Feature: a user should be able to view a calendar on the dashboard

            As a user
            I want to be able to view the current calendar on the dashboard

Background:
Given a logged in user
And I am on the CommunityGrows dashboard page

Scenario:  Checking the calendar

	Then I should see "Calendar"