Feature: a user should be able to view the wordpress calendar on the dashboard

            As a user
            I want to be able to view the current calendar of events wordpress plugin on the 
dashboard

Background:
Given a logged in user
And I am on the CommunityGrows dashboard page

Scenario:  Checking the calendar

	Then there should be a iframe with id "#cal"