require 'json'

module Niff
  class Node
    def initialize(name, env)
      @name = name 
      @containers = env[:containers]
    end

    def to_json(*args)
    end
  end
end
