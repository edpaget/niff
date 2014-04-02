require 'niff/dsl/environment'
require 'niff/dsl/service'
require 'niff/dsl/container'
require 'niff/dsl/node'

module Niff
  class DSLExec
    include Niff::DSL::EnvironmentCommand
    include Niff::DSL::ServiceCommand
    include Niff::DSL::ContainerCommand
    include Niff::DSL::NodeCommand

    attr_reader :env

    def initialize()
      @env = {
        environments: {},
        nodes: {},
        services: {},
        containers: {}
      }
    end

    def self.from_file(path)
      envs = self.new
      envs.instance_eval(File.read(path))
      envs.env[:environments]
    end
  end
end
