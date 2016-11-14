Given /the following documents exist/ do |documents_table|
    Document.delete_all
    documents_table.hashes.each do |document|
        Document.create!(document)
    end
end

Given /(?:|I )create a document called "([^"]*)" with url "([^"]*)" in category "([^"]*)"$/ do |name, url, category|
	Document.create!({name: name, url: url, category_id: Category.where(name: category).id})
end

Then /^(?:|I )should see "([^"]*)" in Read Status Table for user$/ do |status|
    expect(page.find("#1_read")).to have_content(status)
end

Then /^(?:|I )should see "([^"]*)" in Read Status Table for admin$/ do |status|
    expect(page.find("#1_read")).to have_content(status)
end

# Then /"([^"]*)" should be checked$/ do |element|
#     page.find("#markasread").checked?.should be_true
# end
