#
# Cookbook Name:: fender-elasticsearch
# Recipe:: kopf
#
# Copyright (c) 2016 Dru Goradia, All Rights Reserved.

include_recipe 'apt'
package 'nginx'

service 'nginx' do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

ruby_block 'elb_dns_name' do
  block do
    Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
    cmd = "cat /etc/elb_dns_name"
    output = shell_out(cmd)
    node.set['nginx']['proxy_host'] = output.stdout.chomp
  end
  action :nothing
end.run_action(:create)

file '/etc/nginx/sites-enabled/default' do
  action :delete
end

execute 'htpasswd' do
  command "echo \"#{node['nginx']['auth']['username']}:$(openssl passwd -crypt #{node['nginx']['auth']['password']})\n\" > /etc/nginx/passwd"
  sensitive true
  action :run
end

template '/etc/nginx/sites-available/kopf-proxy' do
  source 'kopf.nginx.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    listen: node['nginx']['listen'],
    proxy_host: node['nginx']['proxy_host'],
    proxy_port: node['nginx']['proxy_port'],
    es_root_path: node['plugin']['kopf']['es_root_path']
  )

  notifies :restart, 'service[nginx]'
end

link 'enable nginx proxy' do
  link_type :symbolic
  target_file '/etc/nginx/sites-enabled/kopf-proxy'
  to '/etc/nginx/sites-available/kopf-proxy'
  action :create

  notifies :restart, 'service[nginx]'
end
