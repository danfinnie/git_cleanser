require 'slop'

module GitCleanser
  class CLI
    def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel, config_loader=ConfigLoader.new)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      @config = config_loader.config
    end

    def execute!
      smart_thing = SmartThing.new(@config)

      opts = Slop.parse @argv do |o|
        o.string '-f', '--format', 'output format'
      end

      formatter = case opts[:format]
                    when 'yaml'
                      Formatter::YAML
                    else
                      Formatter::Human
                    end

      @stdout.print formatter.new.format(smart_thing)
    end
  end
end
