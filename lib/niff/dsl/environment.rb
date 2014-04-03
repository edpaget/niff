require 'niff/dsl/dsl_builder'
require 'niff/dsl/service'
require 'niff/dsl/node'
require 'niff/dsl/container'
require 'niff/dsl/volume'
require 'niff/environment'

module Niff
  module DSL
    class EnvironmentBuilder < Niff::DSL::DSLBuilder
      include_command :service, Niff::DSL::ServiceBuilder
      include_command :node, Niff::DSL::ServiceBuilder
      include_command :container, Niff::DSL::ServiceBuilder
      include_command :volume, Niff::DSL::ServiceBuilder

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
