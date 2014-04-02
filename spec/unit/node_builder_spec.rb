require 'niff/dsl/node'

describe Niff::DSL::NodeBuilder do
  let(:builder) { Niff::DSL::NodeBuilder.new("name", double("Niff::Cluster")) }

  describe "#build" do
    it 'should create a new Niff::Node' do
      expect(builder.build).to be_a(Niff::Node)
    end
  end
end
