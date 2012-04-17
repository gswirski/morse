Feature: user registration

  As a visitor
  I want to be able to register

  Scenario: visits register page
    When I visit register page
    Then I should see "Create account"
    And I should have new_user form

  Scenario: submits valid data
    When I visit register page
    And I fill in user_username with "lorem"
    And I fill in user_password with "ipsum"
    And I fill in user_password_confirmation with "ipsum"
    And I click submit button
    Then I should be signed in as "lorem"

  Scenario: submits no username
    When I visit register page
    And I fill in user_password with "ipsum"
    And I fill in user_password_confirmation with "ipsum"
    And I click submit button
    Then the form should be invalid

  Scenario: submits invalid passwords
    When I visit register page
    And I fill in user_password with "ipsum"
    And I fill in user_password_confirmation with "ipsum2"
    And I click submit button
    Then the form should be invalid
