# Sunstore

SunStore is a Simple UNscalable storage mechanism for saving very simple key value pairs like preferences, config parameters, etc.  It's really just a wrapper for JSON or YAML.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sunstore'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sunstore

## Usage

The simplest way is to say:

```ruby
Sustore.put("myKey",someSerializableObject)
```

and to later retrieve it as

```ruby
Sunstore.get("myKey")
```

## Configuration

There are a couple of configuration parameters invoked via the config message *prior* to using:

```ruby
Sunstore.config(params)
```

where the params can be:

    :format: :json or :yaml (default)
    :basename: the basename for the storage file (sunstore by default)
    :basedir: the default location to put the file (Rails/tmp if used in Rails context, else current working directory)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/etcetc/sunstore.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

