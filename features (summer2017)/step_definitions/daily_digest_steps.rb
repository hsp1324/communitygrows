#This file contains all the step definitions necessary to test dail-digest-preference.feature

Given /the following users exist/ do |users_table|
    User.delete_all
    users_table.hashes.each do |user|
        User.create!(user)
    end
end

Given /^"([^\"]*)" logs in with password "([^\"]*)"$/ do |user_email, user_password|
  visit "/users/sign_in"
  visit "/users/sign_in"
  fill_in "user_email", :with => user_email
  fill_in "password", :with => user_password
  click_button "Log in"
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

And /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )select "([^\"]*)" from "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
end

And /^(?:|I )press "([^\"]*)"$/ do |button|
  click_button(button)
end

Then /^(?:|I )should see "([^\"]*)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq path_to(page_name)
end

Then /^(?:|I )should see "([^\"]*)"$/ do |text|
  expect(page).to have_content(text)
end