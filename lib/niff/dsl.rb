require 'docile'
require 'niff/node'
require 'niff/domain'
require 'niff/cluster'

module Niff
  module Dsl
    def node(cluster=nil, &block)
      Docile.dsl_eval(Niff::NodeBuilder.new(cluster), &block).build
    end

    def domain(name, &block)
      Docile.dsl_eval(Niff::DomainBuilder.new(name), &block).build
    end

    def cluster(type, &block)
      Docile.dsl_eval(Niff::ClusterBuilder.new(type), &block).build
    end
  end
end
