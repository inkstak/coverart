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

  s.add_dependency "faraday", "~> 2.5"
end
