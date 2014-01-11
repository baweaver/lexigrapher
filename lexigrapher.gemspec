# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lexigrapher/version'

Gem::Specification.new do |spec|
  spec.name          = "lexigrapher"
  spec.version       = Lexigrapher::VERSION
  spec.authors       = ["Brandon Weaver"]
  spec.email         = ["keystonelemur@gmail.com"]
  spec.description   = %q{Find the type of data a string contains}
  spec.summary       = %q{Takes a string and attempts to find a data type for it using method fallthrough}
  spec.homepage      = "https://github.com/baweaver/lexigrapher"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
