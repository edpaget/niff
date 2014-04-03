module Niff
  class Volume
    def initialize(name, mount, host_mount, filesystem, size, iops)
      @name = name
      @mount = mount
      @host_mount = host_mount
      @filesystem = filesystem
      @size = size
      @iops = iops
    end
  end
end
