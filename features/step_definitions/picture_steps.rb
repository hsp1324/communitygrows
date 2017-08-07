When(/^I load "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
  fo = File.open(Rails.root + arg2, 'w')
  fo.close
  attach_file(arg1.to_sym, File.join(Rails.root, arg2))
end

Then(/^I should see a picture "([^"]*)"$/) do |arg1|
  page.find('#profpic')['src'].should have_content arg1
end