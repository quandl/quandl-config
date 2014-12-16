require 'spec_helper'

describe Quandl::Config do
  describe '.initialize' do
    it 'generates a Config class, evaluating ERB' do
      configuration = Quandl::Config.new('fake')

      expect(configuration['notifiers']['ci']['channel']).to eq('#development')
    end
  end

  describe '#configurable_attributes' do
    it 'provides a list of configurable attributes' do
      configuration = Quandl::Config.new('fake')

      expect(configuration.configurable_attributes).to eq([:webhook_url, :notifiers])
    end
  end
end
