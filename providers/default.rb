#
# Cookbook Name:: monit
# Provider:: default
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
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

require "chef/dsl/include_recipe"
include Chef::DSL::IncludeRecipe

action :create do
  include_recipe "monit"

  template config_file.to_s do
    source new_resource.source || "monit.conf.erb"
    cookbook new_resource.cookbook

    mode 0600
    owner "root"
    group "root"

    variables(
      new_resource.variables
    )

    action :create
    notifies :reload, "service[monit]"
  end

  new_resource.updated_by_last_action(true)
end

action :delete do
  include_recipe "monit"

  file config_file.to_s do
    action :delete
    notifies :reload, "service[monit]"
  end

  new_resource.updated_by_last_action(true)
end

def config_path
  @config_path ||= Pathname.new node["monit"]["config_dir"]
end

def config_file
  @config_file ||= config_path.join("#{new_resource.name}.conf")
end
