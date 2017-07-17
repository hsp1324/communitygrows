Feature: a user should be able to view the wordpress calendar on the dashboard

            As a user
            I want to be able to view the current calendar of events wordpress plugin on the 
dashboard

Background:

user is on the login page
Given a logged in user
And I am on the CommunityGrows dashboard
Given the following event exists:
| event name     | date        | 
| Seed Planting | 7-1-2017 |

Scenario:  Checking the calendar

            Then I should see "Events"
            And I should see "Seed Planting”
	And I should see “7-1-2017”