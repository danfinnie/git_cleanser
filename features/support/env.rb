require 'aruba'
require 'aruba/cucumber'
require 'aruba/in_process'

require 'git_cleanser'

Aruba::InProcess.main_class = GitCleanser::CLI
Aruba.process = Aruba::InProcess
