require 'yaml'

module GitCleanser
  RSpec.describe CLI do
    let(:stdin) { StringIO.new }
    let(:stdout) { StringIO.new }
    let(:stderr) { StringIO.new }
    let(:config) { double("config") }
    let(:config_loader) { instance_double("ConfigLoader", config: config) }
    let(:smart_thing) { instance_double("SmartThing") }
    subject { CLI.new([], stdin, stdout, stderr, Kernel, config_loader) }

    it "prints output as YAML" do
      allow(smart_thing).to receive(:generated_but_not_ignored).and_return(["file1", "file2"])
      allow(SmartThing).to receive(:new).and_return(smart_thing)

      subject.execute!

      stdout.rewind
      output = YAML.load(stdout.read)
      expect(output["generated_but_not_ignored"]).to eq ["file1", "file2"]
    end

    it "passes the config to the SmartThing" do
      allow(smart_thing).to receive(:generated_but_not_ignored)
      allow(SmartThing).to receive(:new).and_return(smart_thing)

      subject.execute!

      expect(SmartThing).to have_received(:new).with(config)
    end
  end
end
