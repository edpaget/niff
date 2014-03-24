# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'niff/version'

Gem::Specification.new do |spec|
  spec.name          = "niff"
  spec.version       = Niff::VERSION
  spec.authors       = ["Edward Paget"]
  spec.email         = ["ed.paget@gmail.com"]
  spec.summary       = %q{A small commandline tool to make aws and local provisioning simpler}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "thor", "~> 0.18.1"
  spec.add_dependency "aws-sdk", "~> 1.36.1"
  spec.add_dependency "berkshelf" 
  spec.add_dependency "docile"
  spec.add_dependency "docker-api", require: 'docker'
end
