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


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
