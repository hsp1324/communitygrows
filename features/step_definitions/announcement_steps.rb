# By Tony. Steps needed for user testing

Given /an announcement is made with "([^"]*)" as title and "([^"]*)" as content$/ do |title, content|
    Announcement.create(:title => title, :content => content, :committee_type => "dashboard")
end

When /click "([^"]*)" for "([^"]*)"$/ do |link, id|
    page.find_by_id(id.downcase).click
end


Given /the following announcements exist/ do |announcement_table|
    Announcement.delete_all
    announcement_table.hashes.each do |announcement|
        Announcement.create!(announcement)
    end
end


