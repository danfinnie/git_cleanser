Feature: Detecting compiled files
  In order to be notified on files a
  As a kitten

  Scenario:
    Given a file named "git_config.yml" with:
      """
      ---
      compiled_files_command: echo "object.o"
      """
    And a file named ".gitignore" with:
      """
      object.o
      """
    When I run `git_cleanser`
    Then the output should contain "Hello from git_cleanser"
