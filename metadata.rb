name 'localdns'
maintainer 'Alexander Pyatkin'
maintainer_email 'aspyatkin@gmail.com'
license 'MIT'
description 'Install and configure dnsmasq'
long_description ::IO.read(::File.join(::File.dirname(__FILE__), 'README.md'))
version '3.0.1'

scm_url = 'https://github.com/aspyatkin/localdns-cookbook'
source_url scm_url if respond_to?(:source_url)
issues_url "#{scm_url}/issues" if respond_to?(:issues_url)

depends 'line', '>= 2.3.0'

supports 'ubuntu'
