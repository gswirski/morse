Given /^I have a user with username: "([^"]*)" and password: "([^"]*)"$/ do |username, password|
  @user = User.create(username: username, password: password)
end

Given /^I signed in with "([^"]*)" and "([^"]*)"$/ do |username, password|
  visit new_session_path
  fill_in "user_username", with: username
  fill_in "user_password", with: password
  page.find("input[type=submit]").click
end

When /^I change password from "([^"]*)" to "([^"]*)"$/ do |current, new|
  visit edit_user_path
  fill_in "user_current_password", with: current
  fill_in "user_password", with: new
  fill_in "user_password_confirmation", with: new
  page.find("input[type=submit]").click
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

Then /^I should be signed in as "([^"]*)"$/ do |username|
  page.find(".user-actions").should have_content(username)
end

Then /^I should not be signed in$/ do
  page.should_not have_css(".icon-off")
  page.should have_css(".unlogged")
end

Then /^I should be able to login with "([^"]*)" and "([^"]*)"$/ do |username, password|
  visit new_session_path
  fill_in "user_username", with: username
  fill_in "user_password", with: password
  page.find("input[type=submit]").click
  page.find(".user-actions").should have_content(username)
end

Then /^I should not be able to login with "([^"]*)" and "([^"]*)"$/ do |username, password|
  visit new_session_path
  fill_in "user_username", with: username
  fill_in "user_password", with: password
  page.find("input[type=submit]").click
  page.find(".user-actions").should_not have_content(username)
end

Then /^the form should be invalid$/ do
  page.should have_css("#errorExplanation")
end
