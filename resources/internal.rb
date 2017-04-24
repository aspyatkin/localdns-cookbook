resource_name :localdns_internal

property :name, String, name_property: true
property :records, Array

default_action :update

action :update do
  id = 'localdns'
  conf_file = ::File.join(node[id]['service']['conf_dir'], 'internal.conf')

  template conf_file do
    cookbook id
    source 'internal.conf.erb'
    variables(
      records: new_resource.records
    )
    mode 0664
    notifies :restart, "service[#{node[id]['service']['name']}]", :immediately
    action :create
  end
end
