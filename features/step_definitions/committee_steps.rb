# By Sunpyo. Steps needed for Committee testing
Given /the following committees exist/ do |committees_table|
    # Committee.delete_all
    committees_table.hashes.each do |committee|
        Committee.create!(committee)
    end
end

# By Wen. Assign users to given committee
# sets up a member inside of a committee
Given /^user "([^\"]*)" is in committee "([^\"]*)"$/ do |user_name, committee_name|
    User.find_by(name: user_name).committees << Committee.find_by(name: committee_name)
end

Given /^admin (.*) is in committee (.*)$/ do |user_name, committee_name|
    User.find_by(name: user_name, admin: true).committees << Committee.find_by(name: committee_name)
end

Given /^user "([^\"]*)" is in the following committees: "([^\"]*)"$/ do |user_name, committees|
    committees.split(',').each do |committee_name|
        committee_name = committee_name.strip
        step "user #{user_name} is in committee #{committee_name}"
    end
end 

Given /^admin "([^\"]*)" is in the following committees: "([^\"]*)"$/ do |admin_name, committees|
    committees.split(',').each do |committee|
        step "admin #{admin_name} is in committee #{committee.strip}"
    end
end

#By Wen. Drop down menu for file transfer selection
And /^(?:|I )should see document "([^\"]*)"$/ do |document_name|
    pending
end

And /^(?:|I )should see the following documents: "([^\"]*)"$/ do |documents|
    pending
end 

And /^(?:|I )select "([^\"]*)" from drop down menu "([^\"]*)"/ do |category_name, document_name|
    pending
end






