#
# Cookbook Name:: monit
# Recipe:: default
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

node["monit"]["packages"].each do |name|
  package name do
    action :install
  end
end

template node["monit"]["sysconfig_file"] do
  source "sysconfig.conf.erb"
  owner "root"
  group "root"
  mode 0644

  variables(
    node["monit"]
  )

  notifies :restart, "service[monit]"

  not_if do
    node["monit"]["sysconfig_file"].empty?
  end
end

template node["monit"]["config_file"] do
  source "monitrc.conf.erb"
  owner "root"
  group "root"
  mode 0700

  variables(
    node["monit"]
  )

  notifies :restart, "service[monit]"

  not_if do
    node["monit"]["config_file"].empty?
  end
end

service "monit" do
  service_name node["monit"]["service_name"]
  action [:enable, :start]
end
