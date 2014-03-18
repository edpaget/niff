require 'niff/domain'
require 'docile'

describe Niff::Domain do
  let(:domain) { Niff::Domain.new("example.com", "local", "staging", [], []) }
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
      expect(domain.to_json).to eq("{\"name\":\"example.com\",\"local_tld\":\"local\",\"staging_prefix\":\"staging\",\"nodes\":[],\"clusters\":[]}")
    end
  end

  describe "#qualify" do
    it 'should return the domain name when environment is production' do
      expect(domain.qualify(:production)).to eq(".example.com")
    end

    it 'should return the domain with the staging prefix when environment is staging' do
      expect(domain.qualify(:staging)).to eq(".staging.example.com")
    end

    it 'should return the domain with the local tld when the environment is vagrant' do
      expect(domain.qualify(:vagrant)).to eq(".example.local")
    end
  end
end

