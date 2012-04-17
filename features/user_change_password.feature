Feature: User - change password

  As an user
  I want to be able to change my password

  Scenario: changed password successfully
    Given I have a user with username: "lorem" and password: "ipsum"
    And I signed in with "lorem" and "ipsum"
    When I change password from "ipsum" to "dolor"
    Then I should see "Password changed successfully"
    And I should not be signed in
    And I should be able to login with "lorem" and "dolor"

  Scenario: wrong password given
    Given I have a user with username: "lorem" and password: "ipsum"
    And I signed in with "lorem" and "ipsum"
    When I change password from "dolor" to "sit"
    Then I should see "Invalid password."
    And I should be signed in as "lorem"
    And I should not be able to login with "lorem" and "sit"