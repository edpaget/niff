require 'json'

module Niff
  class Node
    def initialize(name, ec2_opts, vb_opts, env)
      @name = name 
      @ec2_opts = ec2_opts
      @vb_opts = @vb_opts
      @containers = env[:containers]
    end

    def to_json(*args)
    end
  end
end
