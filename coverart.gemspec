# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)
require "coverart/version"

Gem::Specification.new do |s|
  s.name    = "coverart"
  s.version = Coverart::VERSION

  s.authors = ["Savater Sebastien"]
  s.email   = "github.60k5k@simplelogin.co"

  s.homepage = "http://github.com/inkstak/coverart"
  s.licenses = ["MIT"]
  s.summary  = "A tiny client for the Cover Art Archive web service"

  s.files         = Dir["lib/**/*"] + %w[LICENSE README.md]
  s.require_paths = ["lib"]

  s.add_dependency "faraday"

  s.add_development_dependency "bundler"
  s.add_development_dependency "gem-release"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "rubocop-rake"
  s.add_development_dependency "rubocop-rspec"
  s.add_development_dependency "rubocop-performance"
  s.add_development_dependency "standard"
  s.add_development_dependency "webmock"
  s.add_development_dependency "zeitwerk"
end
