require 'niff/environment'
require 'docker'

module Niff
  module Environment
    class Docker
      include Niff::Environment

      def initialize(n, s, t)
        @name = n
        @subdomain = s
        @tld = t
        @image = Docker::Image.build_from_dir(
          File.join(File.dirname(File.expand_path(__FILE__)), '/resources/docker')
        )
      end

      def create_environment(domain)

      end

      private 

      def setup_command(node)
        "/bin/bash -c /setup.sh -H #{node.hostname} -e #{self.name.to_s} -c #{node.cookbook}"
      end

      def create_container!(node)
        fqdn = node.qualify(self)
        container = @image.run(setup_command(node))
        [fqdn, container]
      end
    end
  end
end
