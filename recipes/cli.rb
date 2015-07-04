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

# chef_gem "tragus_nexus_cli" do
#   version "4.2.0"
# end

# This is a hack until the gem is finalized

package 'git' do
    action :install
end

git "/tmp/tragus_nexus_cli" do
    repository 'https://github.com/tragus/nexus_cli.git'
    reference 'master'
    action :sync
end

script 'compile tragus_nexus_cli gem' do
    interpreter '/bin/bash'
    cwd '/tmp/tragus_nexus_cli'
    code <<-EOH
        /opt/chef/embedded/bin/gem build *.gemspec
    EOH
end

chef_gem 'tragus_nexus_cli' do
    clear_sources true
    compile_time false
    source '/tmp/tragus_nexus_cli/tragus_nexus_cli-4.2.0.gem'
    version '4.2.0'
end
