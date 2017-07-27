#/features/step_definitions/admin_steps.rb
# By Tony. Steps needed for user testing
Given /^a valid admin$/ do
  @user = User.create!({
             :name => "Admin",
             :email => "admindummy@dummy.com",
             :password => "admindummypass",
             :password_confirmation => "admindummypass",
             :admin => true
           })
end
# By Wen
Given /^a valid admin ([a-zA-z]*)$/ do |name|
  @user = User.create!({
             :name => name,
             :email => "admindummy@dummy.com",
             :password => "admindummypass",
             :password_confirmation => "admindummypass",
             :admin => true
           })
end

Given /^a logged in admin$/ do
  step "a valid admin"
  visit "/users/sign_in"
  fill_in "user_email", :with => "admindummy@dummy.com"
  fill_in "password", :with => "admindummypass"
  click_button "Log in"
end

# By Wen
Given /^a logged in admin "([^"]*)"$/ do |name|
  step "a valid admin #{name}"
  visit "/users/sign_in"
  fill_in "user_email", :with => "admindummy@dummy.com"
  fill_in "password", :with => "admindummypass"
  click_button "Log in"
end