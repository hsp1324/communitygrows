Given /a category called "([^"]*)"$/ do |category_name|
	Category.create!({:name => category_name, :hidden => false})
end

When /(?:|I )drag the category "([^"]*)" to the top slot$/ do |category_name|
	pending
end

When /(?:|I )drag the document "([^"]*)" into the category "([^"]*)"$/ do |document_name, category_name|
	pending
end
