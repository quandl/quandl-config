$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'quandl/config/version'

Gem::Specification.new do |spec|
  spec.name          = 'quandl-config'
  spec.version       = Quandl::Configurable::VERSION
  spec.authors       = ['Najwa Azer']
  spec.email         = ['dev@quandl.com']
  spec.homepage      = 'https://github.com/quandl/quandl-config'
  spec.summary       = 'OpenStruct-based per-class configuration.'
  spec.description   = 'Load ERB-based YML files into open OpenStruct objects for ease of use.'
  spec.homepage      = 'https://github.com/quandl/quandl-config'
  spec.license       = 'MIT'

  spec.files         = Dir['{lib}/**/*', 'LICENSE.txt', 'README.md']
  spec.test_files    = Dir['{spec}/**/*']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-nc'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'pry-nav'
end
