module Niff
  module DSL
    class DSLBuilder
      def initialize(name, env={})
        @name = name
        @env = {
          nodes: Hash.new { |h,k| env[:nodes][k] },
          environments: Hash.new { |h,k| env[:environments][k] },
          services: Hash.new { |h,k| env[:services][k] },
          containers: Hash.new { |h,k| env[:containers][k] }
        }
      end
    end
  end
end
