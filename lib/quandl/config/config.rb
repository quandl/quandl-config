require 'ostruct'
require 'yaml'
require 'pathname'

module Quandl
  class Config < ::OpenStruct
    # Optimize loading of configs multiple times by keeping a hash of already loaded configs.
    def self.new(filename, options = {})
      @_registered_configs ||= {}
      return @_registered_configs[filename] if @_registered_configs.key?(filename)
      @_registered_configs[filename] = super
    end

    def self.clear_internal_cache
      @_registered_configs = {}
    end

    def initialize(file_name, options = {})
      @_root = options.delete(:root_path)
      @_environment = options.delete(:environment)

      super(read_config(file_name))
    end

    def configurable_attributes
      setters_and_getters = methods - self.class.instance_methods
      setters_and_getters += self.table.keys
      getters = setters_and_getters.reject { |method| method =~ /=$/ }
      getters.uniq
    end

    private

    def read_config(file_name)
      raw_config = File.read(Pathname.new(project_root).join('config', "#{file_name}.yml"))
      erb_config = ERB.new(raw_config).result
      YAML.load(erb_config)[project_environment]
    end

    def project_root
      @_root ||= defined?(Rails) ? ::Rails.root : ProjectRoot.root
    end

    def project_environment
      @_environment ||= defined?(Rails) ? ::Rails.env : (ENV['RAILS_ENV'] || ENV['RAKE_ENV'] || ENV['QUANDL_ENV'] || 'default')
    end
  end
end
