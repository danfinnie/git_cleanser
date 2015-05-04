Feature: Detecting compiled files
  When a file is compiled but not git ignored, let the user know.

  Scenario:
    Given a file named "git_cleanser.yml" with:
      """
      ---
      compiled_files_command: echo ignored_and_generated.o committed.o
      """
    And a file named ".gitignore" with:
      """
      ignored_and_generated.o
      ignored_not_generated.o
      """
    And an empty file named "ignored_and_generated.o"
    And an empty file named "ignored_not_generated.o"
    And an empty, tracked file named "committed.o"
    When I run `git_cleanser --format=yaml`
    Then the exit status should be 0

    And its output for "generated_but_not_ignored" should contain "committed.o"
    And its output for "generated_but_not_ignored" should not contain "ignored_and_generated.o"
    And its output for "generated_but_not_ignored" should not contain "ignored_not_generated.o"

    And its output for "ignored_but_not_generated" should contain "ignored_not_generated.o"
    And its output for "ignored_but_not_generated" should not contain "ignored_and_generated.o"
    And its output for "ignored_but_not_generated" should not contain "committed.o"

    And its output for "ignored_but_tracked" should be empty
