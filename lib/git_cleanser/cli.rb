require 'yaml'
require 'paint'

module GitCleanser
  class CLI
    def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      @config = YAML.load(File.read("git_cleanser.yml"))
    end

    def execute!
      compiled_files = sh(@config['compiled_files_command']).split
      ignored_and_untracked_files = sh("git ls-files -z --ignored --exclude-standard --other").split("\0")
      @stdout.puts YAML.dump("generated_but_not_ignored" => compiled_files - ignored_and_untracked_files)
    end

    private

    def sh(cmd)
      `#{cmd}`.tap do
        if $?.exitstatus > 0
          @stdout.puts Paint["Shell command failed: ", :red] + " " + cmd
          exit 1
        end
      end
    end
  end
end
