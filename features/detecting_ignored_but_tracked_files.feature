Feature: Detecting ignored but tracked files
  When a file is is in the git ignore but also tracked, let the user know.

  Scenario:
    Given a file named "git_cleanser.yml" with:
      """
      ---
      compiled_files_command: echo ignored.o ignored.tracked.o tracked.o
      """
    And a file named ".gitignore" with:
      """
      ignored.o
      ignored.tracked.o
      """
    And an empty file named "ignored.o"
    And an empty, tracked file named "tracked.o"
    And an empty, tracked file named "ignored.tracked.o"
    When I run `git_cleanser --format=yaml`
    Then the exit status should be 0

    And its output for "ignored_but_tracked" should contain "ignored.tracked.o"
    And its output for "ignored_but_tracked" should not contain "tracked.o"
    And its output for "ignored_but_tracked" should not contain "ignored.o"

    And its output for "generated_but_not_ignored" should contain "ignored.tracked.o"
    And its output for "generated_but_not_ignored" should contain "tracked.o"
    And its output for "generated_but_not_ignored" should not contain "ignored.o"

    And its output for "ignored_but_not_generated" should be empty
