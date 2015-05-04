module GitCleanser
  module Formatter
    describe YAML do
      describe "#format" do
        let(:smart_thing) { instance_double("SmartThing") }
        subject { YAML.new.format(smart_thing) }

        before do
          allow(smart_thing).to receive(:generated_but_not_ignored).and_return(["file1", "file2"])
          allow(smart_thing).to receive(:ignored_but_not_generated).and_return(["file3", "file4"])
          allow(smart_thing).to receive(:ignored_but_tracked).and_return(["file5", "file6"])
          allow(smart_thing).to receive(:uncompiled).and_return(["file7", "file8"])
        end

        it "returns output as YAML" do
          output = ::YAML.load(subject)

          expect(output["generated_but_not_ignored"]).to eq ["file1", "file2"]
          expect(output["ignored_but_not_generated"]).to eq ["file3", "file4"]
          expect(output["ignored_but_tracked"]).to eq ["file5", "file6"]
          expect(output["uncompiled"]).to eq ["file7", "file8"]
        end

        it "removes trailing newlines because we add one in CLI" do
          expect(subject).not_to end_with("\n")
        end
      end
    end
  end
end
