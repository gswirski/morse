Given /^I have a paste with name: "([^"]*)", syntax: "([^"]*)", code: "([^"]*)"$/ do |name, syntax, code|
  @paste = Paste.create(name: name, syntax: syntax, code: code)
end

When /^I visit paste page$/ do
  visit(paste_path(@paste))
end

Then /^the result should be success$/ do
  page.should have_content("Paste was successfully created.")
end

Then /^the result should be error$/ do
  page.should have_css(".alert")
end

Then /^the code should be highlighted$/ do
  page.should have_css(".kt")
end

Then /^the code should be plain text$/ do
  page.should_not have_css(".kt")
end
