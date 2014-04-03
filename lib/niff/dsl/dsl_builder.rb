require 'docile'

module Niff
  module DSL
    module Command 
      def include_command(cmd, klass)
        define_method(cmd.to_s + "s") do |names|
          names.each {|n| self.send(cmd, n)}
        end

        define_method(cmd) do |name, &block|
          if block.nil?
            @env[cmd][name] = @env[cmd][name]
          else
            @env[cmd][name] = Docile.dsl_eval(klass.new(name), &block).build
          end
        end
      end
    end

    class DSLBuilder
      extend Command
      def initialize(name, env={})
        @name = name
        @env = {
          node: Hash.new { |h,k| env[:node][k] },
          environment: Hash.new { |h,k| env[:environment][k] },
          service: Hash.new { |h,k| env[:service][k] },
          container: Hash.new { |h,k| env[:container][k] },
          volume: Hash.new { |h,k| env[:volume][k] }
        }
      end
    end
  end
end
