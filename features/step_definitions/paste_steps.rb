Given /^I have a paste with name: "([^"]*)", syntax: "([^"]*)", code: "([^"]*)"$/ do |name, syntax, code|
  @paste = Paste.create(name: name, syntax: syntax, code: code)
end

When /^I visit the (?:root|home) page$/ do
  visit('/')
end

When /^I visit paste page$/ do
  visit(paste_path(@paste))
end

When /^I fill in ([\w]+) with "([^"]*)"$/ do |name, value|
  page.fill_in name, :with => value
end

When /^I select ([\w]+) to "([^"]*)"$/ do |name, value|
  page.select value, :from => name
end

When /^I click submit button$/ do
  page.find('input[type=submit]').click
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should have ([\w]+) form$/ do |name|
  page.should have_selector("form")
end

Then /^the result should be success$/ do
  page.should have_content("Paste was successfully created.")
end

Then /^the result should be error$/ do
  page.should have_content("An error occurred")
end

Then /^the code should be highlighted$/ do
  page.should have_css(".kt")
end

Then /^the code should be plain text$/ do
  page.should_not have_css(".kt")
end
