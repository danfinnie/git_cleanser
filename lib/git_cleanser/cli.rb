module GitCleanser
  class CLI
    KEYS = ["generated_but_not_ignored", "ignored_but_not_generated"]

    def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel, config_loader=ConfigLoader.new)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      @config = config_loader.config
    end

    def execute!
      smart_thing = SmartThing.new(@config)
      output = KEYS.inject({}) { |memo, this| memo[this] = smart_thing.public_send(this); memo }
      @stdout.puts YAML.dump(output)
    end
  end
end
