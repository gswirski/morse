When /^I visit the (?:root|home) page$/ do
  visit('/')
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should have ([\w]+) form$/ do |name|
  page.should have_selector("form")
end

When /^I fill in ([\w]+) with "([^"]*)"$/ do |name, value|
  page.fill_in name, :with => value
end

When /^I select ([\w]+) to "([^"]*)"$/ do |name, value|
  page.select value, :from => name
end

When /^I click submit button$/ do
  page.click_button "Paste code"
end

Then /^the result should be redirect$/ do
  page.should have_content("You have created paste successfully")
end

Then /^the result should be error$/ do
  page.should have_content("An error occurred")
end
