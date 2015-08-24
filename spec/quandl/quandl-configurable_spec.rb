require 'spec_helper'

module ConfigurationOverride
  def configuration_options
    {
      root_path: Pathname.new(Dir.tmpdir),
      environment: 'this_is_a_test'
    }
  end
end

describe Quandl::Configurable do
  before(:each) do
    Quandl::Config.clear_internal_cache
  end

  shared_examples 'override configuration' do
    it 'should use the overwritten values' do
      expect(File).to receive(:read).with(Pathname.new(Dir.tmpdir).join('config', 'fake.yml')).and_return('---\n:a: :b\n')
      expect(subject.send(:project_environment)).to eq('this_is_a_test')
      expect(subject.send(:project_root)).to eq(Pathname.new(Dir.tmpdir))
    end
  end

  context 'when extending' do
    subject { Fake.configuration }

    before(:each) do
      Fake.extend(Quandl::Configurable)
      Fake.instance_variable_set(:@configuration, nil)
    end

    it 'adds a configuration class method' do
      expect(subject).to be_kind_of(Quandl::Config)
    end

    context 'when overriding configuration options' do
      before(:each) do
        Fake.extend(ConfigurationOverride)
      end

      include_examples 'override configuration'
    end
  end

  context 'when including' do
    subject { Fake.new.configuration }

    before(:each) do
      Fake.include(Quandl::Configurable)
    end

    it 'adds a configuration instance method' do
      expect(subject).to be_kind_of(Quandl::Config)
    end

    context 'when overriding configuration options' do
      before(:each) do
        Fake.include(ConfigurationOverride)
      end

      include_examples 'override configuration'
    end
  end
end
