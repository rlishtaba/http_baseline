# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'http_baseline/version'

Gem::Specification.new do |spec|
  spec.name        = 'http_baseline'
  spec.version     = HttpBaseline::VERSION
  spec.authors     = ['Roman Lishtaba']
  spec.email       = %w(roman@lishtaba.com)
  spec.description = %q{Baseline library}
  spec.summary     = %q{Baseline library for automation}
  spec.homepage    = 'https://github.com/rlishtaba'
  spec.license     = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(env lib)

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'rspec'
  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'builder'
  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'jsonpath'
  spec.add_development_dependency 'rspec_junit_formatter'
  
  spec.add_dependency 'faraday'
  spec.add_dependency 'addressable'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'hashie'

end
