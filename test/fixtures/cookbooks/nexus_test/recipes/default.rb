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

include_recipe "nexus::cli"
include_recipe "nexus::app"

securityRealms = [
      "XmlAuthenticatingRealm",
      "XmlAuthorizingRealm",
      "LdapAuthenticatingRealm"
    ]

nexus_settings 'Enable OSS LDAP' do
    path 'data.securityRealms'
    value securityRealms
    action :update
end

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

package 'createrepo'

yum_properties = {
    "maxNumberParallelThreads" => 12,
    "createrepoPath" => "/usr/bin/createrepo",
    "mergerepoPath" => "/usr/bin/mergerepo"
}
nexus_capability "yum capability" do
    type 'yum'
    enabled true
    properties yum_properties
end

thirdparty_yum = {
     "repository" => "releases",
     "deleteProcessing" => true,
     "deleteProcessingDelay" => 10
}
nexus_capability "thirdparty yum" do
    type 'yum.generate'
    enabled true
    properties thirdparty_yum
end
