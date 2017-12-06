resource_name :localdns_config

property :name, String, name_property: true
property :listen_address, String, required: true
property :bind_interfaces, [TrueClass, FalseClass], default: false
property :forward_servers, Array

default_action :update

action :update do
  id = 'localdns'
  conf_file = ::File.join(node[id]['service']['conf_dir'], 'extra.conf')

  template conf_file do
    cookbook id
    source 'extra.conf.erb'
    variables(
      listen_address: new_resource.listen_address,
      bind_interfaces: new_resource.bind_interfaces,
      forward_servers: new_resource.forward_servers
    )
    mode 0664
    notifies :restart, "service[#{node[id]['service']['name']}]", :immediately
    action :create
  end
end
