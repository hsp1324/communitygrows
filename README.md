

# CommunityGrows App

###Business
Our customer needs a singular location that boardmembers can go to view updates and notifications made by sub-committees and/or boardmembers. We are improving upon a portal that encapsulates all notification threads and information into one central location. 

http://www.communitygrows.org/

###Pivotal Tracker Project

https://www.pivotaltracker.com/n/projects/2070613

###Heroku Deployment Link
https://community-grows.herokuapp.com/



######## ITER 1-1 SUMMER 2017 INFO FOR READERS ############

Mocks: https://drive.google.com/drive/folders/0B_hIfVG6z2pZZXBrUVB5OFloc0U?usp=sharing

Pivotal Tracker: https://www.pivotaltracker.com/n/projects/2070613

Note: all feature files and step defintions written for iter1-1 by the summer 17 community grows team can be found in the "features (summer2017)" folder


[![Code Climate](https://codeclimate.com/github/hsp1324/communitygrows/badges/gpa.svg)](https://codeclimate.com/github/hsp1324/communitygrows)
[![Build Status](https://travis-ci.org/hsp1324/communitygrows.svg?branch=master)](https://travis-ci.org/hsp1324/communitygrows)
[![Test Coverage](https://codeclimate.com/github/hsp1324/communitygrows/badges/coverage.svg)](https://codeclimate.com/github/hsp1324/communitygrows)

####### ITER DEPLOY SUMMER 2017 INFO FOR READERS ##############
1. Clone the Repository
2. heroku create
3. git push heroku master
4. heroku run rake db:migrate
5. heroku run rake db:seed
6. figaro heroku:set -e production