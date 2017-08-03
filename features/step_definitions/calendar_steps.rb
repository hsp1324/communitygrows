Given /the following calendars exist/ do |calendar_table|
    # Committee.delete_all
    calendar_table.hashes.each do |calendar|
        Calendar.create!(calendar)
    end
end

Then /^"([^"]*)" should be selected for  "([^"]*)"$/ do |value, field|
  pending
end

Then /^there should be a iframe with id "([^"]*)"$/ do |cal|
	page.should have_css(cal)
end
