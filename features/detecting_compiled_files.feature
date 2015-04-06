Feature: Detecting compiled files
  When a file is compiled but not git ignored, let the user know.

  Background:
    Given a file named "git_cleanser.yml" with:
      """
      ---
      compiled_files_command: echo "object.o"
      """
    And an empty file named "object.o"

  Scenario:
    Given a file named ".gitignore" with:
      """
      *.o
      """
    When I run `git_cleanser`
    Then its output for "generated_but_not_ignored" should not contain "object.o"

  Scenario:
    Given an empty file named ".gitignore"
    When I run `git_cleanser`
    Then its output for "generated_but_not_ignored" should contain "object.o"
