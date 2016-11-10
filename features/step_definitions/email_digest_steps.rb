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