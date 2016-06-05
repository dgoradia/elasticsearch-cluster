#
# Cookbook Name:: fender-elasticsearch
# Recipe:: default
#
# Copyright (c) 2016 Dru Goradia, All Rights Reserved.

include_recipe 'java'
include_recipe 'elasticsearch'

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch'

elasticsearch_configure 'elasticsearch' do
    configuration ({
      'cluster.name' => 'fd-escluster',
      'node.name' => node['ec2']['instance_id'],
      'network.host' => '["_eth0_", "_local_"]',
      'discovery.zen.ping.multicast.enabled' => false,
      'discovery.zen.minimum_master_nodes' => 2,
      'discovery.zen.ping.unicast.hosts' => '["10.68.1.4", "10.68.1.5", "10.68.1.6"]'
    })
end

elasticsearch_plugin 'kopf' do
  url 'lmenezes/elasticsearch-kopf/2.0'
  action :install
end

template '/usr/share/elasticsearch/plugins/kopf/kopf_external_settings.json' do
  source 'kopf_external_settings.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    es_root_path: node['plugin']['kopf']['es_root_path'],
    with_credentials: node['plugin']['kopf']['with_credentials'],
    theme: node['plugin']['kopf']['theme'],
    refresh_rate: node['plugin']['kopf']['refresh_rate']
  )
end

elasticsearch_service 'elasticsearch' do
  service_actions [:enable, :start]
end
