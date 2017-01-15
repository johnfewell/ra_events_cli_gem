# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'darksky_cli_app/version'

Gem::Specification.new do |spec|
  spec.name          = "ra_events_cli_gem"
  spec.version       = RAEventsCliGem::VERSION
  spec.authors       = ["John Fewell"]
  spec.email         = ["fewell@gmail.com"]

  spec.summary       = %q{Scrapes the weather from darksky.net for a given location.}
  spec.description   = %q{Using Nokogiri and Geocoder}
  spec.homepage      = "https://github.com/johnfewell/darksky-cli-app"
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

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
