require 'active_support/inflector'

module Quandl
  module Configurable
    def configuration
      @configuration ||= Config.new(file_name)
    end

    private

    def file_name
      name.underscore
    end
  end
end
