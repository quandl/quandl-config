require 'spec_helper'

describe Quandl::Configurable do
  context 'when extending' do
    it 'adds a configuration method to the class' do
      Fake.extend(Quandl::Configurable)
      expect(Fake.configuration).to be_kind_of(Quandl::Config)
    end
  end
end
