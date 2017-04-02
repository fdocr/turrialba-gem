# Turrialba

This is a small gem that wraps the Turrialba server API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'turrialba'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install turrialba

## Usage

The api is available with the Client object:

```ruby
client = Turrialba::Client.new
user = client.user(360962402) # Fetches a user by uid
```

By default, the server authenticates requests using a `X-AUTH-TOKEN` header. Defaults are set for server url (`localhost:3000`) and auth token (`hashlol`). A custom server url will need to be set using `TURRIALBA_URL` ENV variable. You can initialize the Client with a custom auth token.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fdoxyz/turrialba-gem.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
