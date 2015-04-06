Feature: Detecting compiled files
  When a file is compiled but not git ignored, let the user know.

  Scenario:
    Given a file named "git_cleanser.yml" with:
      """
      ---
      compiled_files_command: echo ignored.o committed.o
      """
    And a file named ".gitignore" with:
      """
      ignored.o
      """
    And an empty file named "ignored.o"
    And an empty file named "committed.o"
    When I run `git_cleanser`
    Then its output for "generated_but_not_ignored" should contain "committed.o"
    Then its output for "generated_but_not_ignored" should not contain "ignored.o"
