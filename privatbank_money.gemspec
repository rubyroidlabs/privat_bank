# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'privat_bank/version'

Gem::Specification.new do |spec|
  spec.name          = 'privat_bank'
  spec.version       = PrivatBank::VERSION
  spec.authors       = ['Eugene Haisenka']
  spec.email         = ['eugene.haisenka@rubyroidlabs.com']
  spec.summary       = 'Money gem bank implementation for Privat Bank'
  spec.description   = 'PrivatBank extends Money::Bank::VariableExchange and gives you access to the Privatbank currency exchange rates.'
  spec.homepage      = 'https://github.com/rubyroidlabs/privat_bank'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'money', '>=5.0'
end
