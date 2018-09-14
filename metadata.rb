name 'localdns'
maintainer 'Alexander Pyatkin'
maintainer_email 'aspyatkin@gmail.com'
license 'MIT'
description ''
long_description ::IO.read(::File.join(::File.dirname(__FILE__), 'README.md'))
version '1.3.1'

scm_url = 'https://github.com/aspyatkin/localdns-cookbook'
source_url scm_url if respond_to?(:source_url)
issues_url "#{scm_url}/issues" if respond_to?(:issues_url)

depends 'patch', '~> 2.2.1'

supports 'ubuntu'
