require 'json'

module Niff
  class NoEnvironmentTypeSpecified < StandardError
  end
  
  class EnvironmentBuilder
    def initialize(name, type=nil) 
      @name = name
      @type = type
    end

    def subdomain(s)
      @subdomain = s
    end

    def tld(t)
      @tld = t
    end

    def type(t)
      @type = t
    end

    def build
      raise NoEnvironmentTypeSpecified.new unless @type
      @type.new(@name, @subdomain, @tld)
    end
  end

  module Environment
    def qualify(domain)
      tld = @tld || domain.tld
      d = String.new
      d.concat("." + @subdomain) if @subdomain
      d.concat(".") 
      d.concat(domain.name + "." + tld)
    end

    def create_environment
      # override
    end

    def start_environment(*node_names)
      # override
    end

    def stop_environment(*node_names)
      # override
    end
  end
end

