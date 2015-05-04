Feature: Detecting uncompiled files
  When a file is not compiled, but is tracked, let the user know.
  So that they can make it automatically compiled.

  Scenario:
    Given a file named "git_cleanser.yml" with:
      """
      ---
      compiled_files_command: echo generated.js
      """
    And an empty file named ".gitignore"
    And an empty, tracked file named "generated.js"
    And an empty, tracked file named "spontaneous-generation.js"
    When I run `git_cleanser --format=yaml`
    Then the exit status should be 0

    And its output for "generated_but_not_ignored" should contain "generated.js"
    And its output for "generated_but_not_ignored" should not contain "spontaneous-generation.js"

    And its output for "ignored_but_not_generated" should be empty

    And its output for "ignored_but_tracked" should be empty

    And its output for "uncompiled" should contain "spontaneous-generation.js"
    And its output for "uncompiled" should not contain "generated.js"
