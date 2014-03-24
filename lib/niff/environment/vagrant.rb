require 'niff/environment'
require 'erb'

module Niff
  module Environment
    class Vagrant
      include Niff::Environment

      class ErbRender
        @@ip_address = 2
        def initialize(node, env, config)
          @aws_access_key_id = config[:aws_access_key]
          @aws_secret_access_key = config[:aws_secret_key]
          @name = node.name.to_sym
          @hostname = nost.hostname
          @fqdn = node.qualify(env)
          @cookbook = node.cookbook
          @vb_opts = node.vb_opts
          @ip = config[:ip_prefix] + @@ip_address.to_s
          @ip_address += 1
        end

        def render(template)
          template.result(binding)
        end
      end

      def initialize(n, s, t)
        @name = n
        @subdomain = s
        @tld = t
      end

      def create_environment(domain, config=nil)
        @config = config || @config
        nodes = domain.nodes
        nodes.concat(domain.clusters
                      .map{|c| c.nodes}.reduce([],&:concat))
        boxes = nodes.map{|n| create_box(n)}.join("\n\n")
        v = vagrantfile.result(OpenStruct.new(boxes: boxes)
                            .instance_eval { binding })
        File.write(".niff/Vagrantfile", "w") { |f| f.write(v) }
      end

      def start_environment(*node_names)
        cmd = "VAGRANT_CWD=.niff/ vagrant up"
        names = node_names.map(&:to_s).join(" ")
        cmd.concat(" " + names) unless names.empty?
        exec(cmd)
      end

      private

      def vagrantfile
        @vagrantfile = ERB.new(
          File.join(File.dirname(File.expand_path(__FILE__)), '/resources/vagrant/vagrantfile.erb')
        )
      end

      def box_description 
        @box_description ||= ERB.new(
          File.join(File.dirname(File.expand_path(__FILE__)), '/resources/vagrant/box.erb')
        )
      end

      def create_box(node)
        ErbRender.new(node, self, @config).render(box_description)
      end
    end
  end
end
