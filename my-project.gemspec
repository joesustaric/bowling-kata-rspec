lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'ten_pin/version'

# http://guides.rubygems.org/specification-reference/

Gem::Specification.new do |s|
  s.name          = 'ten-pin'
  s.version       = TenPin::VERSION
  s.summary       = 'Play a game of Ten Pin Bowling ont he command line.'
  s.description   = 'Play games of Ten Pin Bowling using the command line. Automagically or interactively..'
  s.authors       = ['Joe Sustaric']
  s.email         = ['joe8307@gmail.com']
  s.files         = Dir['lib/**/*'] + Dir['bin/*'] + ['README.md'] # Plus other files needed
  s.test_files    = Dir['spec/**/*']
  s.homepage      = 'https://github.com/joesustaric/ten-pin'
  s.license       = 'MIT'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  # Below Add any Development and runtime dependencies
   s.add_development_dependency 'rspec', '~> 3.5.0'
   s.add_development_dependency 'rubocop', '~> 0.42.0'
   s.add_development_dependency 'pry', '~> 0.10.4'
   s.add_development_dependency 'guard-rspec', '~> 4.7.3'
   s.add_development_dependency 'rake', '~> 10.5.0'
   #s.add_runtime_dependency 'something', '~> 1.0.0'
end
