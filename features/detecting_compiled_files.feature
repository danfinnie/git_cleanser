Feature: Detecting compiled files
  When a file is compiled but not git ignored, let the user know.

  Background:
    Given a file named "git_cleanser.yml" with:
      """
      ---
      compiled_files_command: echo "object.o"
      """
    And an empty file named "object.o"
    And I successfully run `git init`

  Scenario:
    Given a file named ".gitignore" with:
      """
      *.o
      """
    When I run `git_cleanser`
    Then the output should not contain "object.o"

  Scenario:
    Given an empty file named ".gitignore"
    When I run `git_cleanser`
    Then the output should contain "object.o"
