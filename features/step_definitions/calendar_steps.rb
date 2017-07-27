Given /the following calendar exists/ do |calendar|
    pending
end

Given /the following calendars exist/ do |calendar_table|
    calendar_table.hashes.each do |calendar|
        pending
    end
end


Then /^there should be a iframe with id "([^"]*)"$/ do |cal|
	page.should have_css(cal)
end