require 'niff/dsl/dsl_builder'
require 'niff/dsl/node'
require 'niff/dsl/container'
require 'niff/dsl/volume'
require 'niff/service'

module Niff
  module DSL
    class ServiceBuilder < Niff::DSL::DSLBuilder
      include_command :node, Niff::DSL::NodeBuilder
      include_command :container, Niff::DSL::ContainerBuilder
      include_command :volume, Niff::DSL::VolumeBuilder

      def initialize(name, env={})
        super
      end

      def build
        Niff::Service.new(@name, @env)
      end
    end
  end
end
