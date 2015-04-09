module GitCleanser
  module Formatter
    describe YAML do
      describe "#format" do
        let(:smart_thing) { instance_double("SmartThing") }
        subject { YAML.new }
        it "returns output as YAML" do
          allow(smart_thing).to receive(:generated_but_not_ignored).and_return(["file1", "file2"])
          allow(smart_thing).to receive(:ignored_but_not_generated).and_return(["file3", "file4"])

          encoded_output = subject.format(smart_thing)
          output = ::YAML.load(encoded_output)

          expect(output["generated_but_not_ignored"]).to eq ["file1", "file2"]
          expect(output["ignored_but_not_generated"]).to eq ["file3", "file4"]
        end
      end
    end
  end
end
