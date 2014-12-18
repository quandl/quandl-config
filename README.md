# Quandl::Config

This gem allows you to quickly convert YML files into a `Config` object where the attributes can be accessed using dot, hash symbol or hash string notation.

## Installation

Add this line to your application's Gemfile:

    gem 'quandl-config'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quandl-config

## Usage

1. Create a `yml` file with the same file name as your class. For example:
```
class: A::B::C
file name: config/a/b/c.yml
```

2. Extend the `Quandl::Configurable` class. This adds a configuration class method.
```ruby
class A::B::C
  extend Quandl::Configurable
end
```

```ruby
pry
pry> A::B::C.configuration
=> #<Quandl::Config language="spanish", hello="hola">
```

### What if my yml file name doesn't match the class name?

```ruby
class A::B::Special
  extend Quandl::Configurable
  def self.file_name
    'database_zip_uploader'
  end
end
```

### What if I want configuration to be an instance method?

```ruby
class A::B::C
  include Quandl::Configurable
end
```

### What if my project is not a Rails app?

That's ok. `Quandl::Config` will find your config file if it's in a `config` folder in the root of your app.

If you want to provide the environment, use `ENV['RAILS_ENV']` or `ENV['RAKE_ENV']`. If you don't, the `default` environment will be assumed.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/quandl-config/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
