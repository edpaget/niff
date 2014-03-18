require 'docile'

require 'niff/node'
require 'niff/cluster'

require 'json'

module Niff
  class DomainBuilder
    def initialize(name)
      @name = name
      @local_tld = 'local'
      @staging_prefix = 'staging'
      @nodes = []
      @clusters = []
    end

    def local_tld(ltld)
      if "." == ltld[0]
        @local_tld = ltld[1..-1]
      else
        @local_tld = ltld
      end
    end

    def staging_prefix(p)
      @staging_prefix = p
    end

    def node(name, &block)
      @nodes << Docile.dsl_eval(Niff::NodeBuilder.new(name, self), &block).build
    end

    def cluster(name, &block)
      @clusters << Docile.dsl_eval(Niff::ClusterBuilder.new(name, self), &block).build
    end

    def build
      Niff::Domain.new(@name, 
                       @local_tld, 
                       @staging_prefix, 
                       @nodes, 
                       @clusters)
    end
  end

  class Domain
    def self.from_file(path)
      self.class_eval(File.read(path))
    end

    def self.domain(name, &block)
      Docile.dsl_eval(Niff::DomainBuilder.new(name), &block).build
    end

    def initialize(name,
                   local_tld,
                   staging_prefix,
                   nodes,
                   clusters)
      @name = name
      @local_tld = local_tld
      @staging_prefix = staging_prefix
      @nodes = nodes
      @clusters = clusters
    end

    def qualify(env)
      self.send("qualify_#{env.to_s}".to_sym)
    end

    def to_json(*args)
      {
        name: @name,
        local_tld: @local_tld,
        staging_prefix: @staging_prefix,
        nodes: @nodes,
        clusters: @clusters,
      }.to_json(*args)
    end

    private

    def qualify_production
      "." + @name
    end

    def qualify_staging
      "." + @staging_prefix + qualify_production
    end

    def qualify_vagrant
      segments = @name.split(".")
      segments = segments[0..-2]
      segments << @local_tld
      "." + segments.join(".")
    end
  end
end

