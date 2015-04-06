module GitCleanser
  class CLI
    def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel, config_loader=ConfigLoader.new)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      @config = config_loader.config
    end

    def execute!
      smart_thing = SmartThing.new(@config)
      @stdout.puts YAML.dump("generated_but_not_ignored" => smart_thing.generated_but_not_ignored)
    end
  end
end
