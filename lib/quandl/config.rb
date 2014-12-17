require 'ostruct'
require 'yaml'

module Quandl
  class Config < ::OpenStruct
    VERSION = '0.0.2'

    def initialize(file_name)
      raw_config = File.read(::Rails.root.join('config', "#{file_name}.yml"))
      erb_config = ERB.new(raw_config).result
      config = YAML.load(erb_config)[Rails.env]

      super(config)
    end

    def configurable_attributes
      setters_and_getters = methods - self.class.instance_methods
      getters = setters_and_getters.reject { |method| method =~ /=$/ }
      getters
    end
  end
end

require 'quandl/configurable'
