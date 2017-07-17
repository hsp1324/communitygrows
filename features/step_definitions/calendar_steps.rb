Then /^there should be a iframe with id "([^"]*)"$/ do |cal|
	page.should have_css(cal)
end