require 'aruba'
require 'aruba/cucumber'
require 'aruba/in_process'

require 'git_cleanser'

Aruba::InProcess.main_class = GitCleanser::CLI
Aruba.process = Aruba::InProcess

# Around does not work in this case, so store the temp directory
# in a global variable to clean it up later.
Before do
  $tmp_dir = Dir.mktmpdir("git_cleanser_test")
  system "git init -q", chdir: $tmp_dir
  @dirs = [$tmp_dir]
end

After '~@no-clobber' do
  FileUtils.rm_r($tmp_dir, secure: true)
end
