When /^(?:|I )hover "([^"]*)"$/ do |menu|
  page.execute_script '$("#menu").trigger("mouseover")'
end