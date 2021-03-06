require File.expand_path('../lib/coverart/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'coverart'
  s.version       = CoverArt::VERSION

  s.authors       = ['Savater Sebastien']
  s.email         = 'savater.sebastien@gmail.com'

  s.homepage      = 'http://github.com/inkstak/coverart'
  s.summary       = 'A tiny client for the Cover Art Archive web service'
  s.license       = 'MIT'

  s.files         = %w(Gemfile LICENSE README.md coverart.gemspec)
  s.files        += Dir.glob('lib/**/*')

  s.add_dependency 'faraday'
end
