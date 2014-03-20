require 'docile'

require 'niff/node'
require 'niff/cluster'
require 'niff/environment'

require 'json'

module Niff
  class DomainBuilder
    def initialize(name)
      @name = name
      @tld = "org"
      @nodes = {}
      @clusters = {}
      @environments = {}
    end

    def tld(t)
      @tld = t
    end

    def node(name, &block)
      @nodes[name] = Docile.dsl_eval(Niff::NodeBuilder.new(name, self), &block).build
    end

    def cluster(name, &block)
      @clusters[name] = Docile.dsl_eval(Niff::ClusterBuilder.new(name, self), &block).build
    end

    def environment(name, &block)
      @environments[name] = Docile.dsl_eval(Niff::EnvironmentBuilder.new(name), &block).build
    end

    def build
      Niff::Domain.new(@name, 
                       @tld,
                       @environments,
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

    def initialize(name, tld, environments, nodes, clusters)
      @name = name
      @tld = tld
      @environments = environments
      @nodes = nodes
      @clusters = clusters
    end

    def qualify(env)
      env = get_environment(env)
      env.qualify(self)
    end

    def to_json(*args)
      {
        name: @name,
        tld: @tld,
        environments: @environments,
        nodes: @nodes,
        clusters: @clusters,
      }.to_json(*args)
    end
    
    private 

    def get_environment(env)
      if env.is_a?(String) || env.is_a?(Symbol)
        @environments[env]     
      else
        env
      end
    end
  end
end

