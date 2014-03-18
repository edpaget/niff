require 'niff/cluster'
require 'docile'

describe Niff::ClusterBuilder do
  let(:cluster_builder) { Niff::ClusterBuilder.new("name", double("Niff::Domain")) }

  it 'should have an empty list of node' do
    expect(cluster_builder.instance_variable_get(:@nodes)).to be_an(Array)
    expect(cluster_builder.instance_variable_get(:@nodes)).to be_empty
  end

  describe "#type" do 
    it 'should set the cluster type' do
      c = cluster_builder
      c.type(:type)
      expect(c.instance_variable_get(:@type)).to eq(:type)
    end
  end

  describe "#node" do
    it "should execute the node builder dsl with the given block" do
      node_builder = double("Niff::NodeBuilder")
      expect(Docile).to receive(:dsl_eval).and_return(node_builder)
      expect(node_builder).to receive(:build)
      cluster_builder.node("noodle") { hostname "ramen" }
    end

    it "should add the node the node list" do
      c = cluster_builder 
      c.node("noodle") { hostname "ramen" }
      expect(c.instance_variable_get(:@nodes)).to have(1).items
    end
  end

  describe "#build" do
    it 'should return a new Niff::Cluster' do
      expect(cluster_builder.build).to be_a(Niff::Cluster)
    end
  end
end

describe Niff::Cluster do
  let(:cluster) { Niff::Cluster.new("name", double("Niff::Domain"), []) }

  describe "#to_json" do
    it "should produce a valid json respentation" do
      p cluster
      expect(cluster.to_json).to eq("{\"name\":\"name\",\"nodes\":[]}")
    end
  end
end
