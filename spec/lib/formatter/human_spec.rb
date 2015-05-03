module GitCleanser
  module Formatter
    describe Human do
      it "produces equivalent output to the YAML formatter" do
        expect(Human::KEYS.keys).to eq YAML::KEYS
      end
    end
  end
end
