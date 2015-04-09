module GitCleanser
  class CLI
    def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel, config_loader=ConfigLoader.new)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      @config = config_loader.config
    end

    def execute!
      smart_thing = SmartThing.new(@config)
      @stdout.print Formatter::YAML.new.format(smart_thing)
    end
  end
end
