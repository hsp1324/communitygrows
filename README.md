# CommunityGrows Board Portal

[Imgur](http://i.imgur.com/KCYGEka.png)
## Client
Our client, the deputy director of Community Grows, needed us to help improve 3 main areas of previous legacy code base
Extensibility of the Board Portal: 
  * Centralization of work related technologies
  * Help members stay informed and up to date on the latest happenings within the organization and allow members to easily communicate to the larger community via announcement functions
    Technology
  * Our Board Portal was built on a Ruby backend, with CSS, HTML, JavaScript, JQuery. API employed: Google Calendar. 

## New Features: 
  * Committee Management Feature | allows admins of CGs to easily create, delete, update, modify, hide, restrict member access to each committee
  * Calendar Management Feature: Allow members/admins to create and manage multiple calendars that automatically updates and synchronizes in multiple locations
  * Meeting Management Feature: Allows admins to easily create a centralized location for meeting agenda/info, and google hangout access
  * Email Digest Feature: Sends digest Emails triggered on certain events within CGs
  * Document Archive/Transfer Feature: Allow admins to easily transfer, archive important documents to repository

##Technology
Our Board Portal was built on a Ruby backend, with CSS, HTML, JavaScript, JQuery. API employed: Google Calendar. 

##Authors
Will Park
Shawn Liu
Noah Ryan Lopez
Sunpyo Hong
Doongjo Shin
Wen Chien Yen [Wen's GitHub](https://github.com/forrestDinos2RGB)

##Pivotal Tracker

https://www.pivotaltracker.com/n/projects/2070613

##Heroku Deployment Link
https://mysterious-ridge-80338.herokuapp.com


[![Code Climate](https://codeclimate.com/github/hsp1324/communitygrows/badges/gpa.svg)](https://codeclimate.com/github/hsp1324/communitygrows)
[![Build Status](https://travis-ci.org/hsp1324/communitygrows.svg?branch=master)](https://travis-ci.org/hsp1324/communitygrows)
[![Test Coverage](https://codeclimate.com/github/hsp1324/communitygrows/badges/coverage.svg)](https://codeclimate.com/github/hsp1324/communitygrows)

## Heroku Deployment Procedure
1. Clone the Repository
2. heroku create
3. git push heroku master
4. heroku run rake db:migrate
5. heroku run rake db:seed
6. figaro heroku:set -e production

## Account Information
To log onto the heroku site, contact cyen7115@berkeley.edu for account info



