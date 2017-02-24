require 'spec_helper'

describe 'metricbeat', :type => :class do
  let(:facts) { {
      :osfamily  => 'Windows'
  } }
  let(:params) {{
      :ensure       => 'present',
      :example_path	=> 'c:\Temp'
  }}

  it { should contain_class('metricbeat::install').that_comes_before('Class[metricbeat::config]') }

  context 'should compile with default values' do
    it {
      is_expected.to compile.with_all_deps
      should contain_class('template')
    }
  end

  context 'when trying to install on a non Windows server' do
    let(:facts) { {:osfamily => 'Ubuntu'} }

    it { should compile.and_raise_error(/ERROR:: This module will only work on Windows./) }
  end

  context 'when not passing correct values to ensure should fail' do
    let(:params) {{
        :ensure => 'nope',
    }}

    it { should compile.and_raise_error(/ERROR:: You must specify present or absent/) }
  end

  context 'when not passing example_path should fail' do
    let(:params) {{
        :ensure       => 'present',
        :example_path	=> ''
    }}

    it { should compile.and_raise_error(/ERROR:: You must specify a correct path/) }
  end

end