Feature: Output formats
  Both computers and humans can parse this output

  Scenario: Default is human readable
    Given a file named "git_cleanser.yml" with:
      """
      ---
      compiled_files_command: echo style.css
      """
    And an empty file named "style.css"
    When I run `git_cleanser`
    Then the output should contain:
      """
      These files are ignored, but not compiled (maybe they should be added to the compiled files list?):
        (no files)
      """
    And the output should contain:
      """
      These files are compiled but not ignored (maybe they should be added to .gitignore?):
        style.css
      """

  Scenario: YAML is available with an option
    Given a file named "git_cleanser.yml" with:
      """
      ---
      compiled_files_command: echo style.css
      """
    And an empty file named "style.css"
    When I run `git_cleanser --format=yaml`
    Then its output is YAML
