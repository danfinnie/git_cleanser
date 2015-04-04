# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_cleanser/version'

Gem::Specification.new do |spec|
  spec.name          = "git_cleanser"
  spec.version       = GitCleanser::VERSION
  spec.authors       = ["Dan Finnie"]
  spec.email         = ["dan@danfinnie.com"]
  spec.summary       = "Iteratively remove compiled files from your git repository"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "cucumber", "~> 1.3.19"
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "aruba", "~> 0.6.2"
end
