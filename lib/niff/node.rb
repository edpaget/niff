require 'json'

module Niff
  class NodeBuilder
    def initialize(name, parent)
      @name = name
      @hostname = name
      @parent = parent
      @vb_opts = {}
    end

    def instance_type(t)
      @type = t
    end

    def virtual_box_opts(opts={})
      @vb_opts = opts
    end

    def cookbook(c)
      @cookbook = c
    end

    def hostname(h)
      @hostname = h
    end

    def build
      Niff::Node.new(@name,
                     @cookbook, 
                     @vb_opts, 
                     @type, 
                     @hostname,
                     @parent)
    end
  end


  class Node
    attr_reader :name, :cookbook, :vb_opts, :instance_type, :hostname

    def initialize(name,
                   cookbook, 
                   virtual_box_opts, 
                   ec2_instance,
                   hostname,
                   parent)
      @name = name 
      @cookbook = cookbook
      @vb_opts = virtual_box_opts
      @instance_type = ec2_instance
      @hostname = hostname
      @parent = parent
    end

    def fqdn(env)
      @hostname + @parent.qualify(env)
    end

    def to_json(*args)
      {
        name: @name,
        cookbook: @cookbook,
        vb_opts: @vb_opts,
        instance_type: @instance_type,
        hostname: @hostname
      }.to_json(*args)
    end
  end
end
