require 'docile'
require 'niff/node'
require 'json'

module Niff
  class ClusterBuilder
    def initialize(name, domain)
      @name = @name
      @domain = domain
      @nodes = {}
    end

    def type(t)
      @type = t
    end

    def node(name, &block)
      @nodes[name] = Docile.dsl_eval(Niff::NodeBuilder.new(name, self), &block).build
    end

    def build
      Niff::Cluster.new(@name, @domain, @nodes)
    end
  end

  class Cluster
    def initialize(name, domain, nodes)
      @name = name
      @domain = domain
      @nodes = nodes
    end

    def qualify(env)
      @domain.qualify(env)
    end

    def to_json(*args)
      {
        name: @name,
        nodes: @nodes
      }.to_json(*args)
    end
  end
end
