resource_name :localdns_install

property :packages, Array, default: %w[dnsmasq]
property :service_name, String, default: 'dnsmasq'
property :service_conf_file, String, default: '/etc/dnsmasq.conf'
property :service_conf_dir, String, default: '/etc/dnsmasq.d'

property :listen_address, String, required: true
property :bind_interfaces, [TrueClass, FalseClass], default: false
property :forward_servers, Array, default: %w[8.8.8.8 1.1.1.1 8.8.4.4 1.0.0.1]
property :records, Array, default: %w[]

default_action :run

action :run do
  new_resource.packages.each do |pkg_name|
    package pkg_name do
      action :install
    end
  end

  service new_resource.service_name do
    action 'nothing'
  end

  replace_or_add 'update resolver config' do
    path new_resource.service_conf_file
    pattern "#conf-dir=#{new_resource.service_conf_dir}/,*.conf"
    line "conf-dir=#{new_resource.service_conf_dir}/,*.conf"
    replace_only true
    action :edit
    notifies :restart, "service[#{new_resource.service_name}]", :delayed
  end

  template ::File.join(new_resource.service_conf_dir, 'default.conf') do
    cookbook 'localdns'
    source 'default.conf.erb'
    variables(
      listen_address: new_resource.listen_address,
      bind_interfaces: new_resource.bind_interfaces,
      forward_servers: new_resource.forward_servers
    )
    mode 0o664
    action :create
    notifies :restart, "service[#{new_resource.service_name}]", :delayed
  end

  template ::File.join(new_resource.service_conf_dir, 'records.conf') do
    cookbook 'localdns'
    source 'records.conf.erb'
    variables(
      records: new_resource.records
    )
    mode 0o664
    action :create
    notifies :restart, "service[#{new_resource.service_name}]", :delayed
  end

  service new_resource.service_name do
    action %i[enable start]
  end
end
