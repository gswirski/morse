When /^I visit register page$/ do
  visit(new_user_path)
end

Then /^I should be authenticated user$/ do
  page.should have_content("User was successfully created.")
end