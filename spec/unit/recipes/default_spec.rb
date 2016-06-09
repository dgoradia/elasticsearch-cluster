#
# Cookbook Name:: elasticsearch-cluster
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require_relative '../../spec_helper'

describe 'elasticsearch-cluster::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node, server|
        node.automatic_attrs['ec2']['instance_id'] = 'f1e2d3c'
      end.converge(described_recipe)
    end

    it 'should converge' do
      expect(chef_run).to include_recipe(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes java recipe' do
      expect(chef_run).to include_recipe('java')
    end

    it 'includes elasticsearch recipe' do
      expect(chef_run).to include_recipe('elasticsearch')
    end

    it 'should create elasticsearch user' do
      expect(chef_run).to create_elasticsearch_user('elasticsearch')
    end

    it 'should install elasticsearch' do
      expect(chef_run).to install_elasticsearch('elasticsearch')
    end

    it 'should manage elasticsearch' do
      expect(chef_run).to manage_elasticsearch_configure('cluster.name').with('fd-escluster')
    end

  end
end
