#
# Cookbook:: set_node_chef_env
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

node.chef_environment = case node['asi']['environment_type']
                            when 'dev'
                                'development'
                            when 'prd'
                                'production'
                            when 'oat'
                                'oat'
                            when 'uat'
                                'uat'
                            else
                                'unknown'
                            end
