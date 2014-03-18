require 'niff/node'

describe Niff::Node do
  let(:node) { Niff::Node.new("test", "zoo-test", {}, "m1.small", "test", double("Node::Cluster")) }

  describe "#fqdn" do
    it "should return the node's fully qualified domain name" do
      n = node
      expect(n.instance_variable_get(:@parent)).to receive(:qualify)
        .with(:production)
        .and_return(".example.com")
      expect(n.fqdn(:production)).to eq("test.example.com")
    end
  end

  describe "#to_json" do
    it "should return the node as valid json" do
      expect(node.to_json).to eq("{\"name\":\"test\",\"cookbook\":\"zoo-test\",\"vb_opts\":{},\"instance_type\":\"m1.small\",\"hostname\":\"test\"}")

    end
  end
end
