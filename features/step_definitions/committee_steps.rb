# By Sunpyo. Steps needed for Committee testing
Given /the following committees exist/ do |committees_table|
    # Committee.delete_all
    committees_table.hashes.each do |committee|
        Committee.create!(committee)
    end
end