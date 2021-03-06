#
# Cookbook Name:: nexus
# Recipe:: load_balancer
#
# Author:: Kyle Allan (<kallan@riotgames.com>)
# Copyright 2013, Riot Games
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "tragus::app_server_proxy"

template ::File.join(node[:nginx][:dir], "conf.d", "upstream.conf") do
  source "upstream.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :upstream_name => node[:nexus][:load_balancer][:upstream_name],
    :servers => node[:nexus][:load_balancer][:upstream_servers]
  )
end
