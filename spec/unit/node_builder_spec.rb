require 'niff/dsl/node'

describe Niff::DSL::NodeBuilder do
  let(:builder) { Niff::DSL::NodeBuilder.new("name", double("Niff::Cluster")) }

  it 'should have a hostname equal to the given node name' do
    expect(builder.instance_variable_get(:@name)).to eq(builder.instance_variable_get(:@hostname))
  end

  it 'should have a hash for virtualbox options' do
    expect(builder.instance_variable_get(:@vb_opts)).to be_a(Hash)
    expect(builder.instance_variable_get(:@vb_opts)).to be_empty
  end

  describe '#instance_type' do
    it 'should set the instance_type' do
      b = builder
      b.instance_type("m1.small")
      expect(b.instance_variable_get(:@type)).to eq("m1.small")
    end
  end

  describe "#virtual_box_opts" do
    it 'should set the virtual_box_opts' do
      b = builder
      b.virtual_box_opts({memory: 2048, cpus: 2})
      expect(b.instance_variable_get(:@vb_opts)).to eq({memory: 2048, cpus: 2})
    end
  end

  describe "#hostname" do
    it 'should set the hostname' do
      b = builder
      b.hostname("blah")
      expect(b.instance_variable_get(:@hostname)).to eq("blah")
    end
  end

  describe "#build" do
    it 'should create a new Niff::Node' do
      expect(builder.build).to be_a(Niff::Node)
    end
  end
end
