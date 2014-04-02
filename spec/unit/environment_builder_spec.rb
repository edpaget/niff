require 'niff/dsl/environment'

describe Niff::DSL::EnvironmentBuilder do
  let(:eb) { Niff::DSL::EnvironmentBuilder.new('testing') }
  before(:each) { @e = eb }

  describe "#build" do
    it "should create a new environment of type" do
      type = double("Niff::Environment")
      expect(type).to receive(:new).with("testing", nil, nil)
      @e.build
    end
  end
end


