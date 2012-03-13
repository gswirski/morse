Feature: Syntax highlighting

  I want to see codes in a beautiful way

  Scenario Outline: It highlights code correctly
    Given I have a paste with name: "<name>", syntax: "<syntax>", code: "<code>"
    When I visit paste page
    Then the code should be <result>

  Scenarios:
    | name  | syntax | code                     | result      |
    | a.cpp |        | int main() { return 0; } | highlighted |
    |       | cpp    | int main() { return 0; } | highlighted |
    | a.cpp | cpp    | int main() { return 0; } | highlighted |
    | a.cpp | text   | int main() { return 0; } | plain text  |
    | a.cpp | nyan   | int main() { return 0; } | plain text  |
    |       |        | int main() { return 0; } | plain text  |
