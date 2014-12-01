require 'spec_helper'

describe 'gems' do
  it 'has docs install disabled' do
    configuration_file = file '/root/.gemrc'
    expect(configuration_file).to contain 'gem: --no-document'
  end

  it 'has bundler installed' do
    expect(command('which bundle').exit_status).to eq 0
  end

  describe 'dependencies:' do
    it 'nokogiri dependencies are installed' do
      expect(package 'libxml2').to be_installed
      expect(package 'libxml2-devel').to be_installed
      expect(package 'libxslt').to be_installed
      expect(package 'libxslt-devel').to be_installed
    end
  end
end

describe 'readline' do
  it 'is installed' do
    expect(package 'readline').to be_installed
  end
end

describe 'ruby' do
  let(:executable) { file('/usr/local/bin/ruby') }

  it 'is installed' do
    expect(executable).to be_file
  end

  it 'is executable by root' do
    expect(executable).to be_executable.by_user('root')
  end

  describe 'dependencies:' do
    it 'gcc is installed' do
      expect(package 'gcc').to be_installed
    end

    it 'gcc-c++ is installed' do
      expect(package 'gcc-c++').to be_installed
    end

    it 'make is installed' do
      expect(package 'make').to be_installed
    end

    it 'openssl-devel is installed' do
      expect(package 'openssl-devel').to be_installed
    end
  end
end

describe 'postgres' do
  it 'is installed' do
    expect(package 'postgresql93-devel').to be_installed
  end

  it 'is on PATH' do
    expect(command('which psql').exit_status).to eq 0
  end
end

