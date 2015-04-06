require 'yaml'

module GitCleanser
  class ConfigLoader
    def config
      @config ||= YAML.load(File.read("git_cleanser.yml"))
    end
  end
end
