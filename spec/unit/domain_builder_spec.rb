require 'niff/domain'
require 'docile'

describe Niff::DomainBuilder do
  let(:domain_builder) { Niff::DomainBuilder.new("example") }
  before(:each) { @d = domain_builder }

  it 'should have a name' do
    expect(domain_builder.instance_variable_get(:@name)).to eq("example")
  end

  it 'should set a default tld' do
    expect(domain_builder.instance_variable_get(:@tld)).to eq("org")
  end

  it 'should have an empty node list' do
    expect(domain_builder.instance_variable_get(:@nodes)).to be_a(Hash)
    expect(domain_builder.instance_variable_get(:@nodes)).to be_empty
  end

  it 'should have an empty cluster list' do
    expect(domain_builder.instance_variable_get(:@clusters)).to be_a(Hash)
    expect(domain_builder.instance_variable_get(:@clusters)).to be_empty
  end

  it 'should have an empty environment list' do
    expect(domain_builder.instance_variable_get(:@environments)).to be_a(Hash)
    expect(domain_builder.instance_variable_get(:@environments)).to be_empty
  end

  describe "#tld" do
    it 'should set the tld' do
      @d.tld("com")
      expect(@d.instance_variable_get(:@tld)).to eq("com")
    end
  end

  describe "#node" do
    it "should execute the node builder dsl with the given block" do
      node_builder = double("Niff::NodeBuilder")
      expect(Docile).to receive(:dsl_eval).and_return(node_builder)
      expect(node_builder).to receive(:build)
      domain_builder.node("noodle") { hostname "ramen" }
    end

    it "should add the node the node list" do
      @d.node("noodle") { hostname "ramen" }
      expect(@d.instance_variable_get(:@nodes)).to have(1).items
    end
  end

  describe "#cluster" do
    it "should execute the cluster builder dsl with the given block" do
      cluster_builder = double("Niff::ClusterBuilder")
      expect(Docile).to receive(:dsl_eval).and_return(cluster_builder)
      expect(cluster_builder).to receive(:build)
      domain_builder.cluster("noodle") { type :autoscaling }
    end

    it "should add the node the node list" do
      @d.cluster("noodle") { type :autoscaling }
      expect(@d.instance_variable_get(:@clusters)).to have(1).items
    end
  end

  describe "#environment" do
    it "should execute the environment builder dsl with the given block" do
      environment_builder = double("Niff::environmentBuilder")
      expect(Docile).to receive(:dsl_eval).and_return(environment_builder)
      expect(environment_builder).to receive(:build)
      domain_builder.environment("noodle") { type double("Niff::Environment") }
    end

    it "should add the node the node list" do
      environment_builder = double("Niff::environmentBuilder")
      environment_builder.stub(:build).and_return(:item)
      (Docile).stub(:dsl_eval).and_return(environment_builder)
      @d.environment("noodle") { type double("Niff::Environment") }
      expect(@d.instance_variable_get(:@environments)).to have(1).items
    end
  end

  describe "#build" do
    it "should return a new Niff::Domain object" do
      expect(domain_builder.build).to be_a(Niff::Domain)
    end
  end
end

