Given /the following meetings exist/ do |meetings_table|
    meetings_table.hashes.each do |meeting|
        Meeting.create!(meeting)
    end
end