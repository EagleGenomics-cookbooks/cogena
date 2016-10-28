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
