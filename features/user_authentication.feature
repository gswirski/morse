Feature: User authentication

  As a visitor
  I want to authenticate myself
  In order to list my previous pastes

  Scenario: visits login page
    When I visit login page
    Then I should see "Login"
    And I should have new_session form

  Scenario: logins successfully
    Given I have a user with username: "lorem" and password: "ipsum"
    When I visit login page
    And I fill in user_username with "lorem"
    And I fill in user_password with "ipsum"
    And I click submit button
    Then I should see "Signed in successfully."
    And I should be signed in as "lorem"

  Scenario Outline: login failure
    Given I have a user with username: "lorem" and password: "ipsum"
    When I visit login page
    And I fill in user_username with "<username>"
    And I fill in user_password with "<password>"
    And I click submit button
    Then I should see "Invalid username or password."
    And I should not be signed in

  Scenarios:
    | username | password |
    | lorem    |          |
    | lorem    | dolor    |
    |          | ipsum    |
    | dolor    | ipsum    |
