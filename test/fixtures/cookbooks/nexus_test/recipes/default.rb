#
# Cookbook Name:: nexus_test
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.set[:nexus][:cli][:ssl][:verify] = false
node.set[:nexus][:app_server_proxy][:use_self_signed] = true

include_recipe "tragus_nexus::cli"
include_recipe "tragus_nexus::app"

settings = {
    'foo' => 'bar'
}
# tragus_nexus_settings 'Configure Settings' do
#     path 'foo.bar.baz'
#     value settings
# end

ldap_conn_settings = {
    'foo' => 'bar'
}
ldap_user_group_settings = {
    'foo' => 'bar'
}
# nexus_oss_ldap 'Configure LDAP' do
#     action :get
#     conn_settings ldap_conn_settings
#     user_group_settings ldap_user_group_settings
# end
