module GitCleanser
  class SmartThing
    def initialize(config)
      @config = config
      @compiled_files = sh(@config['compiled_files_command']).split
      @ignored_and_untracked_files = git_ls_files(:ignored, :other)
      @ignored_but_tracked_files = git_ls_files(:ignored)
    end

    def generated_but_not_ignored
      @compiled_files - @ignored_and_untracked_files
    end

    def ignored_but_not_generated
      @ignored_and_untracked_files - @compiled_files
    end

    def ignored_but_tracked
      @ignored_but_tracked_files
    end

    private

    def git_ls_files *ruby_opts
      shell_opts = ruby_opts.map { |opt| "--#{opt}" }.join(" ")
      sh("git ls-files -z --exclude-standard #{shell_opts}").split("\0")
    end

    def sh(cmd)
      `#{cmd}`.tap do
        if $?.exitstatus > 0
          raise "Shell command failed: " + cmd
        end
      end
    end
  end
end
