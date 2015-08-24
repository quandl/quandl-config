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

That's ok. `Quandl::Config` will find your config file if it's in a `config` folder in the root of your app. See also the [How do I override default values?](#how-do-i-override-default-values) for more information.

### How do I override default values?

You can override default values by adding a `configuration_options` method to your class/instance. The options available to be overwritten are:

* `root_path` - Override this when you want to change the default path to your configuration files root folder. (default: your project path)
* `environment` - Override this when you are not using a rails project and don't set the environment via `ENV['RAILS_ENV']`

```ruby
class A::B::Special
  extend Quandl::Configurable
  
  def self.configuration_options
    {
        root_path: Pathname.new('~/configs/my_project'),
        environment: ENV['MY_PROJECT']
    }
  end
end
```

## FAQ

### My config file won't reload in development mode (Rails)

quandl-config utilizes an internal caching schema to save previously loaded configurations so that they don't load twice. You may need to restart your server in certain cases depending on how quandl-config was used in your project.

Additionally if you have `included` via `include Quandl::Configurable` you can use the following method to reset the internal config. This however will not work when `extending` the module.

```ruby
Quandl::Config.clear_internal_cache
``` 

## Contributing

1. Fork it ( https://github.com/[my-github-username]/quandl-config/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
