require 'docile'
require 'niff/dsl/container'
require 'niff/dsl/dsl_builder'
require 'niff/node'

module Niff
  module DSL
    module NodeCommand
      def node(name, &block)
        if @env[:nodes].has_key?(name) && block_given?
          @env[:nodes][name]
        else
          @env[:nodes][name] = Docile.dsl_eval(NodeBuilder.new(name, @env),
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
        Niff::Node.new(@name, @env)
      end
    end
  end
end
