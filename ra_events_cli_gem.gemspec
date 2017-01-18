# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ra_events_cli_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "ra_events_cli_gem"
  spec.version       = RaEventsCliGem::VERSION
  spec.authors       = ["John Fewell"]
  spec.email         = ["fewell@gmail.com"]

  spec.summary       = %q{Scrapes Residentadvisor.net using Nokogiri.}
  spec.description   = %q{Scrapes events from Residentadvisor.net for it's list of the top 10 cities in the world.}
  spec.homepage      = "https://github.com/johnfewell/ra_events_cli_gem"
  spec.license       = "MIT"
#  spec.files         = ["lib/ra_events_cli_gem/cli.rb", "lib/ra_events_cli_gem/events.rb", "lib/ra_events_cli_gem/scraper.rb", "lib/ra_events_cli_gem/version.rb", "lib/ra_events_cli_gem.rb"]


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
