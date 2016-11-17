Given /^the following categories exist:$/ do |category_table|
    Category.delete_all
    category_table.hashes.each do |category|
        Category.create!(category)
    end
end

Given /^a category called "([^\"])"$/ do |category|
    Category.create!(category)
end

When /^I drag the category "([^\"]*)" to the top slot$/ do |category|
    top_slot = page.first('table')
    item_to_drag = page.first('th', text: category)
    item_to_drag.drag_to top_slot
end

When /^I drag the document "([^\"]*)" into the category "([^\"]*)"$/ do |document, category|
    target_category = page.first('th', text: category)
    document_to_drag = page.first('td', text: document)
    document_to_drag.drag_to target_category
end

Then /^I should see the document "([^\"]*)" in the category "([^\"]*)"$/ do |document, category|
    cat = page.find('div', id: "category_#{Category.find_by(name: category).id}")
    expect(cat).to have_content(document)
end

When /you show me category "([^\"]*)"$/ do |category|
    puts Category.find_by(name: category).id
end