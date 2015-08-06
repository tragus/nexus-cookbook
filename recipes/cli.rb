#
# Cookbook Name:: nexus
# Recipes:: cli
#
# Author:: Jesse Howarth (<him@jessehowarth.com>)
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

git "#{Chef::Config[:file_cache_path]}/nexus_cli" do
    repository 'https://github.com/tragus/nexus_cli.git'
    revision 'j4.3.0'
end

execute 'Build nexus_cli gem' do
    command '/opt/chef/embedded/bin/gem build tragus_nexus_cli.gemspec'
    cwd "#{Chef::Config[:file_cache_path]}/nexus_cli"
end

chef_gem "tragus_nexus_cli" do
  version "4.3.0"
  source "#{Chef::Config[:file_cache_path]}/nexus_cli/tragus_nexus_cli-4.3.0.gem"
  compile_time false if respond_to?(:compile_time)
end
