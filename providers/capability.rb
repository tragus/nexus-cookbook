#
# Cookbook Name:: nexus
# Provider:: capabilities
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

def load_current_resource
  @current_resource = Chef::Resource::TragusNexusCapability.new(new_resource.path)
  @current_resource.value new_resource.value

  run_context.include_recipe "tragus_nexus::cli"
  Chef::Nexus.ensure_nexus_available(node)

  @current_resource
end

action :create do
  Chef::Nexus::nexus(node).create_capability(new_resource.id, new_resource.enabled, new_resource.properties)
  new_resource.updated_by_last_action(true)
end

action :delete do
  puts "I can't do that yet"
end
