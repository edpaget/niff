require 'docile'
require 'niff/dsl/service'
require 'niff/dsl/node'
require 'niff/dsl/container'
require 'niff/dsl/dsl_builder'
require 'niff/environment'

module Niff
  module DSL
    module EnvironmentCommand
      def environment(name, &block)
        if @env[:environments].has_key?(name) && block_given?
          @env[:environments][name]
        else
          @env[:environments][name] = Docile.dsl_eval(EnvironmentBuilder.new(name, @env),
                                                      &block).build
        end
      end
    end

    class EnvironmentBuilder < Niff::DSL::DSLBuilder
      include Niff::DSL::ServiceCommand
      include Niff::DSL::NodeCommand
      include Niff::DSL::ContainerCommand

      def initialize(name, env={})
        super 
        @docker_conn = {}
      end

      def domain(d)
        @domain = d
      end

      def docker_uri(u)
        @docker_conn[:uri] = u
      end

      def docker_auth(user, pass)
        @docker_conn[:user] = user
        @docker_conn[:pass] = pass
      end

      def build
        Niff::Environment.new(@name,
                              @domain,
                              @docker_conn,
                              @env)
      end
    end
  end
end  
