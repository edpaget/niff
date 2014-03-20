require 'niff/environment'

describe Niff::Environment do
  class Env
    include Niff::Environment

    def initialize(n, s, t)
      @name = n
      @subdomain = s
      @tld = t
    end
  end

  describe "#qualify" do
    it "should return the fqdn for the environment given a domain" do
      dom = double("Niff::Domain", {tld: "com", name: "blah"})
      expect(Env.new(:staging, "test", nil)
              .qualify(dom)).to eq(".test.blah.com")
      expect(Env.new(:staging, "test", "local")
              .qualify(dom)).to eq(".test.blah.local")
      expect(Env.new(:staging, nil, "local")
              .qualify(dom)).to eq(".blah.local")
    end
  end

end
