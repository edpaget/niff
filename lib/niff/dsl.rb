require 'niff/dsl/environment'
require 'niff/dsl/service'
require 'niff/dsl/container'
require 'niff/dsl/node'

module Niff
  class DSL
    include Niff::DSL::EnvironmentCommand
    include Niff::DSL::ServiceCommand
    include Niff::DSL::ContainerCommand
    include Niff::DSL::NodeCommand

    def initialize()
      @env = {
        environments: {},
        nodes: {},
        services: {},
        containers: {}
      }
    end

    def from_file(path)
      self.class_eval(File.read(path))
    end

  end
end
