When /(.*) should receive: (.*) email/ do |email, preference_list|
	u = User.find_by(email:email)
	print(u)
	preference_list.split(",").each do |p|
		if p[1,p.length-2] == "internal"
			expect(u.internal).to be(false)
		end
	end
end

When /I should see correct flash message "([^"]*)"$/ do |message|
	expect(page).to have_css('flashNotice',text: message)
end

#New tests for iter 2-1

Then /I should receive an email/ do 
	pending
end

Then /I should see title "([^"]*)"$/ do |title|
	pending
end

Then /I should see content "([^"]*)"$/ do |content|
	pending
end

Then /the database should( not)? have email with title "([^"]*)" and content "([^"]*)"$/ do |title, content|
	pending 
end

#New Tests for iter 2-2
Then /I should see a MailRecord object with attribute "([^"]*)" and description "([^"]*)"$/ do |attr, desc|
	MailRecord.where.not(attr, nil).find_by(description: desc)
end
