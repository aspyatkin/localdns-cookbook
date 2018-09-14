id = 'localdns'

default[id]['package'] = 'dnsmasq'
default[id]['service']['name'] = 'dnsmasq'
default[id]['service']['conf_file'] = '/etc/dnsmasq.conf'
default[id]['service']['conf_dir'] = '/etc/dnsmasq.d'

default[id]['listen_address'] = '127.0.0.1'
default[id]['forward_servers'] = %w(
  1.1.1.1
  1.0.0.1
)

default[id]['records'] = []
