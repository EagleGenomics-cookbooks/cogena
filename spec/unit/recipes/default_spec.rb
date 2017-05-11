#
# Cookbook Name:: cogena
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'cogena::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'includes the `r` recipe' do
    expect(chef_run).to include_recipe('r')
  end

  it 'includes the `build-essential` recipe' do
    expect(chef_run).to include_recipe('build-essential')
  end

  it 'executes the biocLite install' do
    expect(chef_run).to run_execute('Rscript install biocLite')
  end

  it 'executes the cogena install' do
    expect(chef_run).to run_execute('Rscript install cogena')
  end

  it 'executes the STRINGdb install' do
    expect(chef_run).to run_execute('Rscript install STRINGdb')
  end

  it 'sets COGENA_VERSION variable' do
    expect(chef_run).to add_magic_shell_environment('COGENA_VERSION')
  end
end
