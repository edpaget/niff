require 'niff/cluster'

describe Niff::Cluster do
  let(:cluster) { Niff::Cluster.new("name", double("Niff::Domain"), []) }

  describe "#to_json" do
    it "should produce a valid json respentation" do
      p cluster
      expect(cluster.to_json).to eq("{\"name\":\"name\",\"nodes\":[]}")
    end
  end
end

