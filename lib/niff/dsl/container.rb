require 'docile'
require 'niff/dsl/dsl_builder'
require 'niff/service'

module Niff
  module DSL
    module ContainerCommand
      def container(name, &block)
        if @env[:environments].has_key?(name) && block_given?
          @env[:enviornments][:name]
        else
          @env[:environments][name] = Docile.dsl_eval(ContainerBuilder.new(name, @env),
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
