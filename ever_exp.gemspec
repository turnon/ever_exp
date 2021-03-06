# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ever_exp/version'

Gem::Specification.new do |spec|
  spec.name          = 'ever_exp'
  spec.version       = EverExp::VERSION
  spec.authors       = ['ken']
  spec.email         = ['block24block@gmail.com']

  spec.summary       = 'parse files exported from evernote'
  spec.homepage      = 'https://github.com/turnon/ever_exp'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_dependency 'nokogiri', '~> 1.6'
end
