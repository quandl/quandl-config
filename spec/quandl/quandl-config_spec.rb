require 'spec_helper'

describe Quandl::Config do
  subject(:configuration) { Quandl::Config.new('fake') }

  describe '.initialize' do
    it 'generates a Config class, evaluating ERB' do
      expect(configuration['notifiers']['ci']['channel']).to eq('#development')
    end
  end

  describe 'accessing values' do
    it 'can access values as methods' do
      expect(configuration['notifiers']['ci']['channel']).to eq('#development')
    end

    it 'can access values as hash table' do
      expect(configuration.notifiers['ci']['channel']).to eq('#development')
    end
  end

  describe '#configurable_attributes' do
    it 'provides a list of configurable attributes' do
      expect(configuration.configurable_attributes).to match_array([:webhook_url, :notifiers])
    end
  end
end
