require 'niff/domain'
require 'docile'

describe Niff::DomainBuilder do
  let(:domain_builder) { Niff::DomainBuilder.new("example.com") }

  it 'should have a name' do
    expect(domain_builder.instance_variable_get(:@name)).to eq("example.com")
  end

  it 'should set a default local_tld' do
    expect(domain_builder.instance_variable_get(:@local_tld)).to eq(".local")
  end

  it 'should set a default staging_prefix' do
    expect(domain_builder.instance_variable_get(:@staging_prefix)).to eq("staging")
  end

  it 'should have an empty node list' do
    expect(domain_builder.instance_variable_get(:@nodes)).to be_an(Array)
    expect(domain_builder.instance_variable_get(:@nodes)).to be_empty
  end

  it 'should have an empty cluster list' do
    expect(domain_builder.instance_variable_get(:@clusters)).to be_an(Array)
    expect(domain_builder.instance_variable_get(:@clusters)).to be_empty
  end

  describe "#local_tld" do
    it 'should set the local tld' do
      d = domain_builder
      d.local_tld(".hyperlocal")
      expect(d.instance_variable_get(:@local_tld)).to eq(".hyperlocal")
    end
  end

  describe "#staging_prefix" do
    it 'should set the staging_prefix' do
      d = domain_builder
      d.staging_prefix("alltheworlds")
      expect(d.instance_variable_get(:@staging_prefix)).to eq("alltheworlds")
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
      d = domain_builder 
      d.node("noodle") { hostname "ramen" }
      expect(d.instance_variable_get(:@nodes)).to have(1).items
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
      d = domain_builder 
      d.cluster("noodle") { type :autoscaling }
      expect(d.instance_variable_get(:@clusters)).to have(1).items
    end
  end

  describe "#build" do
    it "should return a new Niff::Domain object" do
      expect(domain_builder.build).to be_a(Niff::Domain)
    end
  end
end

describe Niff::Domain do
  let(:domain) { Niff::Domain.new("example.com", ".local", "staging", [], []) }
  describe "::from_file" do
    it 'should load and execute dsl file' do
      expect(File).to receive(:read).with("./cluster.rb").and_return('domain "example.com"')
      expect(Niff::Domain).to receive(:class_eval).with('domain "example.com"')
      Niff::Domain.from_file("./cluster.rb")
    end
  end

  describe "::domain" do
    it 'should execute dsl' do
      domain_builder = double("Niff::DomainBuilder")
      expect(Docile).to receive(:dsl_eval).and_return(domain_builder)
      expect(domain_builder).to receive(:build)
      Niff::Domain.domain("example.com") { local_tld "test" }
    end

    it 'should return a Niff::Domain object' do
      expect(Niff::Domain.domain("example.com") { local_tld ".test" }).to be_a(Niff::Domain)
    end
  end

  describe "#to_json" do
    it 'should return a valid json string' do
      expect(domain.to_json).to eq("{\"name\":\"example.com\",\"local_tld\":\".local\",\"staging_prefix\":\"staging\",\"nodes\":[],\"clusters\":[]}")
    end
  end
end
