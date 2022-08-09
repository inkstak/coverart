# frozen_string_literal: true

require "bundler/setup"
Bundler.setup

require "coverart"
require "webmock/rspec"

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.order = "random"
  config.expect_with :rspec do |expect|
    expect.syntax = :expect
  end
end

def stub_client_request(path)
  stub_request(:get, "#{CoverArt::Client::ENDPOINT}#{path}")
end

def fixture(file)
  File.read(File.expand_path("../fixtures", __FILE__) + "/" + file)
end
