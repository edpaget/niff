require 'niff/dsl/environment'

describe Niff::DSL::EnvironmentBuilder do
  let(:eb) { Niff::DSL::EnvironmentBuilder.new(:test) }

  describe "#build" do
    it "should create a new environment" do
      expect(eb.build).to be_a(Niff::Environment)
    end
  end
end


