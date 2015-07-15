Rails = Class.new do
  require_relative 'fake'

  def self.root
    Pathname.new(File.dirname(__FILE__))
  end

  def self.env
    'development'
  end
end
