require 'docile'
require 'niff/dsl/dsl_builder'
require 'niff/container'

module Niff
  module DSL
    module ContainerCommand
      def container(name, &block)
        if @env[:containers][name] && block_given?
          @env[:containers][name] = @env[:containers][name]
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

      def image(i)
        @image = i
      end

      def image_verison(v)
        @image_version = v
      end

      def arguments(*args)
        args = args.first if args.first.is_a?(Array)
        @args = args
      end

      def config_mount(**dirs)
        @config_mount = dirs
      end

      def config_uri(uri)
        @config_uri = uri
      end

      def build
        Niff::Container.new(@name, 
                            @image, 
                            @image_version,
                            @arguments, 
                            @config_mount, 
                            @config_uri)
      end
    end
  end
end
