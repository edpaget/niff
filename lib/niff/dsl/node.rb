require 'docile'
require 'niff/dsl/container'
require 'niff/dsl/dsl_builder'
require 'niff/service'

module Niff
  module DSL
    module NodeCommand
      def node(name, &block)
        if @env[:environments].has_key?(name) && block_given?
          @env[:enviornments][:name]
        else
          @env[:environments][name] = Docile.dsl_eval(NodeBuilder.new(name, @env),
                                                      &block).build
        end
      end
    end

    class NodeBuilder < Niff::DSL::DSLBuilder
      include Niff::DSL::ContainerCommand

      def initialize(name, env={})
        super
      end

      def build
        Niff::Node.new(@name, env)
      end
    end
  end
end
