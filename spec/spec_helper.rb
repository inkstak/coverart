require 'rubygems'
require 'bundler/setup'
require 'coverart'
require 'webmock/rspec'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.order = 'random'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def stub_get path, return_hash
  stub_request(:get, CoverArt::Client::ENDPOINT + path).
    with(headers: {
      'Accept'          =>'*/*',
      'Accept-Encoding' =>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'      =>'Faraday v0.9.0'
    }).
    to_return(return_hash)
end

def fixture file
  File.read(File.expand_path('../fixtures', __FILE__) + '/' + file)
end
