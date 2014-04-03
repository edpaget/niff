require 'niff/dsl/dsl_builder'
require 'niff/dsl/environment'
require 'niff/dsl/service'
require 'niff/dsl/node'
require 'niff/dsl/container'
require 'niff/dsl/volume'

module Niff
  class DSLExec
    extend Niff::DSL::Command
    include_command :environment, Niff::DSL::EnvironmentBuilder
    include_command :service, Niff::DSL::ServiceBuilder
    include_command :node, Niff::DSL::ServiceBuilder
    include_command :container, Niff::DSL::ServiceBuilder
    include_command :volume, Niff::DSL::ServiceBuilder

    attr_reader :env

    def initialize()
      @env = {
        environment: {},
        node: {},
        service: {},
        container: {},
        volume: {}
      }
    end

    def self.from_file(path)
      envs = self.new
      envs.instance_eval(File.read(path))
      envs.env[:environment]
    end
  end
end
