require 'niff/cluster'

describe Niff::Cluster do
  let(:cluster) { Niff::Cluster.new("name", double("Niff::Domain"), {})}

  describe "#to_json" do
    it "should produce a valid json respentation" do
      expect(cluster.to_json).to eq("{\"name\":\"name\",\"nodes\":{}}")
    end
  end

  describe "#qualify" do
    it "should call domain parent with the given environment" do
      c = cluster
      expect(c.instance_variable_get(:@domain)).to receive(:qualify)
        .with(:production).and_return(".example.com")

      expect(c.qualify(:production)).to eq(".example.com")
    end
  end
end

