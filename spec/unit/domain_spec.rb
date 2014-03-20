require 'niff/domain'
require 'docile'

describe Niff::Domain do
  let(:domain) { Niff::Domain.new("example", "com", {}, {}, {}) }
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
      Niff::Domain.domain("example.com") { tld "test" }
    end

    it 'should return a Niff::Domain object' do
      expect(Niff::Domain.domain("example.com") { tld "test" }).to be_a(Niff::Domain)
    end
  end

  describe "#to_json" do
    it 'should return a valid json string' do
      expect(domain.to_json).to eq("{\"name\":\"example\",\"tld\":\"com\",\"environments\":{},\"nodes\":{},\"clusters\":{}}")
    end
  end

  describe "#qualify" do
    before(:each) do
      @d = domain
      @e = class Env; include Niff::Environment; end.new("test", nil, nil)
      RSpec::Mocks::TestDouble.extend_onto(@e, "TestEnvironment")
      expect(@e).to receive(:qualify).with(@d).and_return(".example.com")
    end

    it 'should return the fqdn when is given the symbol name of an environment' do
      @d.instance_variable_set(:@environments, {production: @e})
      expect(@d.qualify(:production)).to eq(".example.com")
    end

    it 'should return the fqdn when given an instance of environment' do
      expect(@d.qualify(@e)).to eq(".example.com")
    end 
  end
end

