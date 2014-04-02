require 'docile'
require 'niff/dsl/dsl_builder'
require 'niff/container'

module Niff
  module DSL
    module ContainerCommand
      def container(name, &block)
        if @env[:containers].has_key?(name) && block_given?
          @env[:containers][:name]
        else
          @env[:containers][name] = Docile.dsl_eval(ContainerBuilder.new(name, @env),
                                                      &block).build
        end
      end
    end

    class ContainerBuilder < Niff::DSL::DSLBuilder
      def initialize(name, env={})
        super
      end

      def build
        Niff::Container.new(@name)
      end
    end
  end
end
