require 'niff/dsl/dsl_builder'
require 'niff/dsl/container'
require 'niff/dsl/volume'
require 'niff/node'

module Niff
  module DSL
    class NodeBuilder < Niff::DSL::DSLBuilder
      include_command :volume, Niff::DSL::VolumeBuilder
      include_command :container, Niff::DSL::ContainerBuilder

      def initialize(name, env={})
        super
        @ec2_opts = {}
        @vb_opts = {}
      end

      def ec2_type(t)
        @ec2_opts[:type] = t
      end

      def ec2_id(id)
        @ec2_opts[:id] = id
      end

      def ec2_name(n)
        @ec2_opts[:name] = n
      end

      def vb_memory(mem)
        @vb_opts[:memory] = mem
      end

      def vb_cpus(cpu_no)
        @vb_opts[:cpus] = cpu_no
      end

      def build
        Niff::Node.new(@name, 
                       @ec2_opts,
                       @vb_opts,
                       @env)
      end
    end
  end
end
