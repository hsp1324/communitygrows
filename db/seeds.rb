# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
curr = User.create!(:name => "Admin John", :email => "shawnpliu@berkeley.edu", :password => "communitygrowsrocks", :password_confirmation => "communitygrowsrocks", 
:admin => true)
curr1 = User.create!(:name => "User Jane", :email => "mail.community.grows.gmail.com", :password => "communitygrowsrocks", :password_confirmation => "communitygrowsrocks", 
:admin => false)

Committee.delete_all
committee1 = Committee.create!(:name => "Sun committee", :inactive => true, :hidden => false)

Document.delete_all
Category.delete_all
Category.create!(:name => "About Community Grows")
Category.create!(:name => "Board Overview")
Category.create!(:name => "Budgets and Finances")
Category.create!(:name => "AB Meetings")
Category.create!(:name => "Board Resources")

# Expertises
Expertise.delete_all
Expertise.create!(:name => "Accounting", :constituency => false)
Expertise.create!(:name => "Advertising", :constituency => false)
Expertise.create!(:name => "Admin/Management", :constituency => false)
Expertise.create!(:name => "Communications/Social Media", :constituency => false)
Expertise.create!(:name => "Computers/Technology", :constituency => false)
Expertise.create!(:name => "Community Ambassador", :constituency => false)
Expertise.create!(:name => "Entrepreneurship", :constituency => false)
Expertise.create!(:name => "Finance/Investment", :constituency => false)
Expertise.create!(:name => "Fundraising", :constituency => false)
Expertise.create!(:name => "Grant Writing", :constituency => false)
Expertise.create!(:name => "Governance", :constituency => false)
Expertise.create!(:name => "Hospitality", :constituency => false)
Expertise.create!(:name => "Human Resources", :constituency => false)
Expertise.create!(:name => "Insurance/Risk Management", :constituency => false)
Expertise.create!(:name => "Legal", :constituency => false)
Expertise.create!(:name => "Marketing/Sales", :constituency => false)
Expertise.create!(:name => "Operations", :constituency => false)
Expertise.create!(:name => "Organizational Development", :constituency => false)
Expertise.create!(:name => "Non-Profit Consulting/Coaching", :constituency => false)
Expertise.create!(:name => "Public Speaking", :constituency => false)
Expertise.create!(:name => "Public Relations", :constituency => false)
Expertise.create!(:name => "Membership/Volunteer", :constituency => false)
Expertise.create!(:name => "Research/Evaluation", :constituency => false)
Expertise.create!(:name => "Special Program Focus (e.g., education, health, public policy, social services)", :constituency => false)
Expertise.create!(:name => "Strategic Planning", :constituency => false)
Expertise.create!(:name => "Other", :constituency => false)

Expertise.create!(:name => "Business", :constituency => true)
Expertise.create!(:name => "Government", :constituency => true)
Expertise.create!(:name => "Program Participant", :constituency => true)
Expertise.create!(:name => "Community Member", :constituency => true)
Expertise.create!(:name => "Academia", :constituency => true)
Expertise.create!(:name => "NonProfit", :constituency => true)
Expertise.create!(:name => "Other", :constituency => true)


