# Cover Art

A tiny client for the [Cover Art Archive](http://coverartarchive.org) web service.

[![Gem Version](https://badge.fury.io/rb/coverart.png)](http://badge.fury.io/rb/coverart)

### Ruby Version

Ruby version 1.9.0+ required.

### Installation

Is this really necessary to explain ?

    gem install coverart


### Usage

Read the [JSON API manual](http://wiki.musicbrainz.org/Cover_Art_Archive/API)

    require 'coverart'
    api = CoverArt::Client.new
    api.get '/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd'


You can also use shortcuts :

    # Get the front image URL
    api.front '76df3287-6cda-33eb-8e9a-044b5e15ffdd'

    # Get the back image URL
    api.back '99b09d02-9cc9-3fed-8431-f162165a9371'

    # Get the front image URL for a release group
    api.group '76df3287-6cda-33eb-8e9a-044b5e15ffdd'


### Caching & middlewares

In order to perform caching, you can use [faraday_middleware](http://github.com/lostisland/faraday_middleware)
or your own middlewares:

    # Please note that faraday_middleware and active_support are not included as dependencies
    # you may install them

    require 'coverart'
    require 'faraday_middleware'
    require 'active_support'

    api = CoverArt::Client.new do |f|
      f.response :caching do
        ActiveSupport::Cache.lookup_store :file_store, './tmp/cache', namespace: 'covertart', expires_in: 3600
      end
    end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
