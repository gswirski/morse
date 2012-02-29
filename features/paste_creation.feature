Feature: Visitor creates paste

  As a visitor
  I want to paste codes

  Scenario: Create paste form
    When I visit the home page
    Then I should see "New paste"
    And I should have new_paste form

  Scenario Outline: submits code
    When I visit the home page
    And I fill in paste_name with "<name>"
    And I select paste_syntax to "<syntax>"
    And I fill in paste_code with "<code>"
    And I click submit button
    Then the result should be <result>
    And I should see "<code>"

  Scenarios:
    | name  | syntax | code                     | result   |
    | a.cpp | C++    | int main() { return 0; } | success  |
    | a.cpp | C++    |                          | error    |
