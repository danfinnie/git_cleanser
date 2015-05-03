require 'yaml'

module GitCleanser
  RSpec.describe CLI do
    let(:stdin) { StringIO.new }
    let(:stdout) { StringIO.new }
    let(:stderr) { StringIO.new }
    let(:config) { double("config") }
    let(:config_loader) { instance_double("ConfigLoader", config: config) }
    let(:smart_thing) { instance_double("SmartThing") }
    let(:formatter) { double("Formatter") }
    let(:argv) { [] }
    subject { CLI.new(argv, stdin, stdout, stderr, Kernel, config_loader) }

    describe "output formats" do
      before do
        allow(SmartThing).to receive(:new).and_return(smart_thing)
      end

      context "when fomat is YAML" do
        let(:argv) { ["--format=yaml"] }
        it "prints YAML output" do
          allow(Formatter::YAML).to receive(:new).and_return(formatter)
          allow(formatter).to receive(:format).and_return("--- yaml")

          subject.execute!
          stdout.rewind
          output = stdout.read

          expect(output).to eq("--- yaml\n")
          expect(formatter).to have_received(:format).with(smart_thing)
        end
      end

      context "when no format is passed" do
        it "prints human readable output" do
          allow(Formatter::Human).to receive(:new).and_return(formatter)
          allow(formatter).to receive(:format).and_return("Anglais")

          subject.execute!
          stdout.rewind
          output = stdout.read

          expect(output).to eq("Anglais\n")
          expect(formatter).to have_received(:format).with(smart_thing)
        end
      end
    end

    it "passes the config to the SmartThing" do
      allow(smart_thing).to receive(:generated_but_not_ignored).and_return([])
      allow(smart_thing).to receive(:ignored_but_not_generated).and_return([])
      allow(smart_thing).to receive(:ignored_but_tracked).and_return([])
      allow(SmartThing).to receive(:new).and_return(smart_thing)

      subject.execute!

      expect(SmartThing).to have_received(:new).with(config)
    end
  end
end
