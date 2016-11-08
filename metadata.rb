name             'cogena'
maintainer       'Eagle Genomics Ltd'
maintainer_email 'chef@eaglegenomics.com'
license          'All rights reserved'
description      'Installs/Configures cogena'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

source_url 'https://github.com/EagleGenomics-cookbooks/cogena'
issues_url 'https://github.com/EagleGenomics-cookbooks/cogena/issues'

depends 'apt'
depends 'build-essential'
depends 'magic_shell', '= 1.0.1'
depends 'r'
