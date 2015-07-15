require 'ostruct'
require 'yaml'
require 'quandl/project_root'

module Quandl
  class Config < ::OpenStruct
    VERSION = '0.0.4'

    def initialize(file_name, options = {})
      raw_config = File.read(project_root.join('config', "#{file_name}.yml"))
      erb_config = ERB.new(raw_config).result
      config = YAML.load(erb_config)[project_environment]

      @_root = options.delete(:root_path)
      @_environment = options.delete(:environment)

      super(config)
    end

    def configurable_attributes
      setters_and_getters = methods - self.class.instance_methods
      getters = setters_and_getters.reject { |method| method =~ /=$/ }
      getters
    end

    private

    def project_root
      @_root ||= defined?(Rails) ? ::Rails.root : Pathname.new(ProjectRoot.root)
    end

    def project_environment
      @_environment ||= defined?(Rails) ? ::Rails.env : (ENV['RAILS_ENV'] || ENV['RAKE_ENV'] || ENV['QUANDL_ENV'] || 'default')
    end
  end
end

require 'quandl/configurable'
