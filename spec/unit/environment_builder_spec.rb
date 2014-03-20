require 'niff/environment'

describe Niff::EnvironmentBuilder do
  let(:eb) { Niff::EnvironmentBuilder.new('testing') }
  before(:each) { @e = eb }

  describe "#subdomain" do
    it "should add a subdomain to the builder" do
      @e.subdomain("sub")
      expect(@e.instance_variable_get:@subdomain).to eq("sub")
    end
  end

  describe "#tld" do
    it "should add a tld to the builder" do
      @e.tld("tld")
      expect(@e.instance_variable_get(:@tld)).to eq("tld")
    end
  end

  describe "#type" do
    it "should add a type to the builder" do
      type = double("Niff::Environment")
      @e.type(type)
      expect(@e.instance_variable_get(:@type)).to eq(type)
    end
  end

  describe "#build" do
    it "should throw an error if not type isn't specified" do
      expect{eb.build}.to raise_error(Niff::NoEnvironmentTypeSpecified)
    end

    it "should create a new environment of type" do
      type = double("Niff::Environment")
      @e.type(type)
      expect(type).to receive(:new).with("testing", nil, nil)
      @e.build
    end
  end
end


