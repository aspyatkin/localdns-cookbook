id = 'localdns'

package node[id]['package'] do
  action :install
end

service node[id]['service']['name'] do
  action [:enable, :start]
end

replace_line node[id]['service']['conf_file'] do
  replace "#conf-dir=#{node[id]['service']['conf_dir']}/,*.conf"
  with "conf-dir=#{node[id]['service']['conf_dir']}/,*.conf"
  notifies :restart, "service[#{node[id]['service']['name']}]", :delayed
end
