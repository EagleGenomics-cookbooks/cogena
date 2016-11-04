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
