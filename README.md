# Coverart

A tiny client for the [Cover Art Archive](http://coverartarchive.org) web service.

It works great with the [Musicbrainz client](http://github.com/inkstak/musicbrainz).

[![Gem Version](https://badge.fury.io/rb/coverart.svg)](https://rubygems.org/gems/coverart)
[![CI Status](https://github.com/inkstak/coverart/actions/workflows/ci.yml/badge.svg)](https://github.com/inkstak/coverart/actions/workflows/ci.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/9bb8b75ea8c66b1a9c94/maintainability)](https://codeclimate.com/github/inkstak/coverart/maintainability)


### Installation

```bash
bundle add coverart
```

### Usage

You should first read the [JSON API manual](http://wiki.musicbrainz.org/Cover_Art_Archive/API) by Musicbrainz.

```ruby
require "coverart"

client = Coverart::Client.new
client.get("/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd")
```

You can also use shortcuts :

```ruby
# Get the front image URL
client.front("76df3287-6cda-33eb-8e9a-044b5e15ffdd")

# Get the back image URL
client.back("99b09d02-9cc9-3fed-8431-f162165a9371")

# Get the front image URL for a release group
client.group("76df3287-6cda-33eb-8e9a-044b5e15ffdd")
```

### Caching & middlewares

In order to perform caching, you can use [faraday_middleware](http://github.com/lostisland/faraday_middleware)
or your own middlewares:

```ruby
# FYI: faraday_middleware and active_support are not present in dependencies.
# Add them to your bundle.

require "coverart"
require "faraday_middleware"
require "active_support"

client = Coverart::Client.new do |connection|
  connection.response :caching do
    ActiveSupport::Cache.lookup_store(:file_store, "./tmp/cache", namespace: "covertart", expires_in: 3600)
  end
end
```

## Contributing

1. Don't hesitate to submit your feature/idea/fix in [issues](https://github.com/inkstak/coverart)
2. Fork the [repository](https://github.com/inkstak/coverart)
3. Create your feature branch
4. Ensure RSpec & Rubocop are passing
4. Create a pull request

### Tests & lint

```bash
bundle exec rspec
bundle exec rubocop
```

Both can be run with:

```bash
bundle exec rake
```

Rubocop uses [Standard](https://github.com/testdouble/standard) cops

## License & credits

Please see [LICENSE](https://github.com/inkstak/coverart/blob/main/LICENSE) for further details.

Contributors: [./graphs/contributors](https://github.com/inkstak/coverart/graphs/contributors)
