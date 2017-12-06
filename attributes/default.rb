id = 'localdns'

default[id]['package'] = 'dnsmasq'
default[id]['service']['name'] = 'dnsmasq'
default[id]['service']['conf_file'] = '/etc/dnsmasq.conf'
default[id]['service']['conf_dir'] = '/etc/dnsmasq.d'

default[id]['forward_servers'] = %w(
  8.8.8.8
  8.8.4.4
  208.67.222.222
  208.67.220.220
)
