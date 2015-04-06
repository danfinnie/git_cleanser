module GitCleanser
  class SmartThing
    def initialize(config)
      @config = config
      @compiled_files = sh(@config['compiled_files_command']).split
      @ignored_and_untracked_files = sh("git ls-files -z --ignored --exclude-standard --other").split("\0")
    end

    def generated_but_not_ignored
      @compiled_files - @ignored_and_untracked_files
    end

    def ignored_but_not_generated
      @ignored_and_untracked_files - @compiled_files
    end

    private

    def sh(cmd)
      `#{cmd}`.tap do
        if $?.exitstatus > 0
          raise "Shell command failed: " + cmd
        end
      end
    end
  end
end
