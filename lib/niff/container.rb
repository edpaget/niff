module Niff
  class Container
    def initialize(name, image, image_version, arguments, port, config_dir, env)
      @name = name
      @image = image
      @image_version = image_version
      @args = arguments
      @port = port
      @conf = config_dir
      @volumes = env[:volumes]
    end
  end
end
