# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'turrialba/version'

Gem::Specification.new do |spec|
  spec.name          = "turrialba"
  spec.version       = Turrialba::VERSION
  spec.authors       = ["Fernando Valverde Arredondo"]
  spec.email         = ["fdov88@gmail.com"]

  spec.summary       = "A Ruby interface to the Turrialba API."
  spec.description   = "A Ruby interface to the Turrialba API."
  spec.homepage      = "https://github.com/fdoxyz/turrialba-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.14.0"
  spec.add_dependency 'naught', '~> 1.0'
  spec.add_dependency 'memoizable', '~> 0.4.0'
  spec.add_dependency 'json', '~> 2.0.0'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
