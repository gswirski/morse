Given /^I have a user with username: "([^"]*)" and password: "([^"]*)"$/ do |username, password|
  @user = User.create(username: username, password: password)
end

When /^I visit register page$/ do
  visit(new_user_path)
end

When /^I visit login page$/ do
  visit(new_session_path)
end

Then /^I should be authenticated user$/ do
  page.should have_content("User was successfully created.")
end

Then /^I should be signed in as ([\w]+)$/ do |username|
  page.find(".user-actions").should have_content(username)
end

Then /^I should not be signed in$/ do
  page.should_not have_css(".icon-off")
  page.should have_css(".unlogged")
end
