require 'niff/dsl/dsl_builder'
require 'niff/dsl/volume'
require 'niff/container'

module Niff
  module DSL
    class ContainerBuilder < Niff::DSL::DSLBuilder
      include_command :volume, Niff::DSL::VolumeBuilder

      def image(i)
        @image = i
      end

      def image_version(v)
        @image_version = v
      end

      def arguments(*args)
        args = args.first if args.first.is_a?(Array)
        @args = args
      end

      def config_dir(dir)
        @config_dir = dir
      end

      def port(p)
        @port = p
      end

      def build
        Niff::Container.new(@name, 
                            @image, 
                            @image_version,
                            @arguments, 
                            @port,
                            @config_mount,
                            @env)
      end
    end
  end
end
