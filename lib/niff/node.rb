require 'json'

module Niff
  class NodeBuilder
    def initialize(name, parent)
      @name = name
      @hostname = name
      @parent = parent
    end

    def instance_type(t)
      @type = t
    end

    def virtual_box_opts(opts={}, &block)
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
                     @domain,
                     @cluster)
    end
  end


  class Node
    def initialize(name,
                   cookbook, 
                   virtual_box_opts, 
                   ec2_instance,
                   hostname,
                   domain,
                   cluster=nil)
      @name = name 
      @cookbook = cookbook
      @vb_opts = virtual_box_opts
      @instance_type = ec2_instance
      @hostname = hostname
    end

    def fqdn(env)
      @hostname + parent.qualify(env)
    end

    def to_json(*args)
      {
        name: @name,
        cookbook: @cookbook,
        vb_opts: @vb_opts,
        instance_type: @instance_type,
        hostname: @hostname
      }.to_json
    end
  end
end
