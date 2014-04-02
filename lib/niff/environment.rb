require 'json'

module Niff
  class Environment
    def initialize(name, domain, docker_conn, env)
      @name = name
      @domain = @domain
      @docker_conn = @docker_conn
      @services = @env[:services]
    end

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

