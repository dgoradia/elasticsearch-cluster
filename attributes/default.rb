default['java']['jdk_version'] = '7'

default['elasticsearch']['version'] = '2.3.3'

default['nginx']['listen'] = 8080
default['nginx']['proxy_host'] = 'localhost' # Override with terraform output /etc/elb_dns_name
default['nginx']['proxy_port'] = 9200
default['nginx']['auth']['username'] = 'admin'
default['nginx']['auth']['password'] = 'f3nd3r'

default['plugin']['kopf']['es_root_path'] = '/es'
default['plugin']['kopf']['with_credentials'] = false
default['plugin']['kopf']['theme'] = 'dark'
default['plugin']['kopf']['refresh_rate'] = 5000
