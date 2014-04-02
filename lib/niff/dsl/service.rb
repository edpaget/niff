require 'docile'
require 'niff/dsl/node'
require 'niff/dsl/container'
require 'niff/dsl/dsl_builder'
require 'niff/service'

module Niff
  module DSL
    module ServiceCommand
      def environment(name, &block)
        if @env[:environments].has_key?(name) && block_given?
          @env[:enviornments][:name]
        else
          @env[:environments][name] = Docile.dsl_eval(ServiceBuilder.new(name, @env),
                                                      &block).build
        end
      end
    end

    class ServiceBuilder < Niff::DSL::DSLBuilder
      include Niff::DSL::NodeCommand
      include Niff::DSL::ContainerCommand

      def initialize(name, env={})
        super
      end

      def build
        Niff::Service.new(@name, @env)
      end
    end
  end
end
