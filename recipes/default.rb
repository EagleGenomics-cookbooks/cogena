#
# Cookbook Name:: cogena
# Recipe:: default
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0.
##########################################################

include_recipe 'apt' if node['platform_family'] == 'debian'
include_recipe 'r'
include_recipe 'build-essential'

# install OS library dependencies for cogena
if node['platform_family'] == 'debian'
  package ['libcurl4-openssl-dev', 'libssl-dev'] do
    action :install
  end
elsif node['platform_family'] == 'rhel'
  package ['libcurl-devel', 'openssl-devel'] do
    action :install
  end
end

r_package 'optparse'

# install Bioconductor R packages
execute 'Rscript install biocLite' do
  command 'Rscript -e "source(\"https://bioconductor.org/biocLite.R\")" -e "biocLite()"'
  not_if { ::File.exist?('/usr/local/lib/R/site-library/BiocInstaller/DESCRIPTION') }
end

execute 'Rscript install cogena' do
  command 'Rscript -e "source(\"https://bioconductor.org/biocLite.R\")" -e "biocLite(\"cogena\")" -e "library(cogena)"'
  not_if { ::File.exist?('/usr/local/lib/R/site-library/cogena/DESCRIPTION') }
end

execute 'Rscript install STRINGdb' do
  command 'Rscript -e "source(\"https://bioconductor.org/biocLite.R\")" -e "biocLite(\"STRINGdb\")" -e "library(STRINGdb)"'
  not_if { ::File.exist?('/usr/local/lib/R/site-library/STRINGdb/DESCRIPTION') }
end

# hack to get the cogena version set as env variable
# execute a ruby block to update a node attribute
# which is later used to set the env variable
ruby_block 'cogena_version_specification' do
  block do
    # tricky way to load this Chef::Mixin::ShellOut utilities
    Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
    command_out = shell_out('Rscript -e \'packageVersion("cogena")\'')
    result = command_out.stdout.match(/.+(\d\.\d\.\d+).+/)
    version_number = result[1]
    # note: for info level logs, the kitchen default (warn) needs to be overwritten in the .kitchen.yml file
    Chef::Log.warn('Extracted cogena version number: ' + version_number)
    node.default['cogena']['version'] = version_number
  end
  action :run
end
magic_shell_environment 'COGENA_VERSION' do
  value lazy { node['cogena']['version'] }
end
