# Tests to check if the infrastructure we expect is available

describe file('/usr/local/lib/R/site-library/BiocInstaller') do
  it { should be_directory }
end

describe file('/usr/local/lib/R/site-library/BiocInstaller/DESCRIPTION') do
  it { should be_file }
end

describe file('/usr/local/lib/R/site-library/cogena') do
  it { should be_directory }
end

describe file('/usr/local/lib/R/site-library/cogena/DESCRIPTION') do
  it { should be_file }
end

describe file('/usr/local/lib/R/site-library/STRINGdb') do
  it { should be_directory }
end

describe file('/usr/local/lib/R/site-library/STRINGdb/DESCRIPTION') do
  it { should be_file }
end

describe command('echo ${COGENA_VERSION:?missing}') do
  its('exit_status') { should eq 0 }
  its('stdout') { should_not match(/missing/) }
end

describe command('R --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/R version 3.4.3/) }
end

describe command('Rscript -e \'packageVersion("cogena")\'') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/1.12.0/) }
end

describe command('echo ${COGENA_VERSION}') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/1.12.0/) }
end
