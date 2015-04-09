require 'yaml'

module GitCleanser
  RSpec.describe CLI do
    let(:stdin) { StringIO.new }
    let(:stdout) { StringIO.new }
    let(:stderr) { StringIO.new }
    let(:config) { double("config") }
    let(:config_loader) { instance_double("ConfigLoader", config: config) }
    let(:smart_thing) { instance_double("SmartThing") }
    let(:yaml_formatter) { instance_double("Formatter::YAML", format: "--- yaml") }
    subject { CLI.new([], stdin, stdout, stderr, Kernel, config_loader) }

    it "prints output as YAML" do
      allow(SmartThing).to receive(:new).and_return(smart_thing)
      allow(Formatter::YAML).to receive(:new).and_return(yaml_formatter)

      subject.execute!
      stdout.rewind
      output = stdout.read

      expect(output).to eq("--- yaml")
      expect(yaml_formatter).to have_received(:format).with(smart_thing)
    end

    it "passes the config to the SmartThing" do
      allow(smart_thing).to receive(:generated_but_not_ignored)
      allow(smart_thing).to receive(:ignored_but_not_generated)
      allow(SmartThing).to receive(:new).and_return(smart_thing)

      subject.execute!

      expect(SmartThing).to have_received(:new).with(config)
    end
  end
end
