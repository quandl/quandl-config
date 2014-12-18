Rails = Class.new do
  require "#{File.dirname(__FILE__)}/dummy_app/fake"

  def self.root
    Pathname.new(File.dirname(__FILE__))
  end

  def self.env
    'development'
  end
end
