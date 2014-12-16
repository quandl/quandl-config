require 'spec_helper'

describe Quandl::Configurable do
  context 'when extending' do
    it 'adds a configuration class method' do
      Fake.extend(Quandl::Configurable)
      expect(Fake.configuration).to be_kind_of(Quandl::Config)
    end
  end

  context 'when including' do
    it 'adds a configuration instance method' do
      Fake.include(Quandl::Configurable)
      expect(Fake.new.configuration).to be_kind_of(Quandl::Config)
    end
  end
end
