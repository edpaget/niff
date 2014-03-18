require 'thor'
require "berkshelf/thor"

class Cli < Thor

  desc "upload ENVIRONMENT", "upload the specified chef cookbook to a given environment"
  def upload
  end
end
