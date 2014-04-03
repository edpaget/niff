require 'niff/dsl/dsl_builder'
require 'niff/volume'

module Niff
  module DSL
    class VolumeBuilder < Niff::DSL::DSLBuilder
      def mount(m)
        @mount = m
      end

      def host_mount(hm)
        @host_mount = hm
      end
      
      def filesystem(fs)
        @filesystem = fs
      end

      def size(gs) #in gigabytes
        @size = gs
      end

      def iops(io)
        @iops = io
      end

      def build
        Niff::Volume.new(@name, @mount, @host_mount, @filesystem, @size, @iops)
      end
    end
  end
end

