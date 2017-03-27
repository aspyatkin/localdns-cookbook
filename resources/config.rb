resource_name :localdns_config

property :name, String, name_property: true
property :forward_servers, Array
property :local_records, Hash

default_action :update

action :update do
  id = 'localdns'
  conf_file = ::File.join(node[id]['service']['conf_dir'], 'extra.conf')

  template conf_file do
    cookbook id
    source 'extra.conf.erb'
    variables(
      listen_address: '127.0.0.1',
      forward_servers: new_resource.forward_servers,
      local_records: new_resource.local_records
    )
    mode 0664
    notifies :restart, "service[#{node[id]['service']['name']}]", :delayed
    action :create
  end
end
