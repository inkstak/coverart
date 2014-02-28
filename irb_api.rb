# To run this file over irb:
#   bundle exec irb -r './irb_api.rb'
#

require 'coverart'
require 'faraday_middleware'
require 'active_support'

puts "Examples :" +
  "\napi.front '76df3287-6cda-33eb-8e9a-044b5e15ffdd'" +
  "\napi.back '99b09d02-9cc9-3fed-8431-f162165a9371'" +
  "\napi.group '76df3287-6cda-33eb-8e9a-044b5e15ffdd'"

def api
  @api ||= CoverArt::Client.new do |f|
    f.response :caching do
      ActiveSupport::Cache.lookup_store :file_store, './tmp/cache', namespace: 'covertart', expires_in: 3600
    end
  end
end
