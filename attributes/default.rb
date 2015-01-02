#
# Cookbook Name:: git
# Attributes:: default
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

default["monit"]["packages"] = %w(
  monit
)

default["monit"]["service_name"] = value_for_platform_family(
  "debian" => "monit",
  "ubuntu" => "monit",
  "suse" => "monit"
)

default["monit"]["sysconfig_file"] = value_for_platform_family(
  "debian" => "/etc/default/monit",
  "ubuntu" => "/etc/default/monit",
  "suse" => "/etc/sysconfig/monit"
)

default["monit"]["config_file"] = value_for_platform_family(
  "debian" => "/etc/monitrc",
  "ubuntu" => "/etc/monitrc",
  "suse" => "/etc/monitrc"
)

default["monit"]["via_inittab"] = "no"
default["monit"]["inittab_base"] = "mi:2345:respawn:/usr/bin/monit"
default["monit"]["inittab_comment"] = "System monitoring with monit"
default["monit"]["args"] = "-p /run/monit/monit.pid -s /run/monit/monit.state"
default["monit"]["interval"] = 60
default["monit"]["delay"] = 30
default["monit"]["slots"] = 100
default["monit"]["log_file"] = "syslog facility log_daemon"
default["monit"]["id_file"] = "/run/monit/id"
default["monit"]["state_file"] = "/run/monit/state"
default["monit"]["pid_file"] = "/var/run/monit.pid"
default["monit"]["config_dir"] = "/etc/monit.d"
default["monit"]["events_dir"] = "/run/monit/events"
default["monit"]["mailservers"] = ["localhost port 25"]
default["monit"]["alerts"] = ["hostmaster@webhippie.de"]
default["monit"]["reply"] = "support@webhippie.de"
default["monit"]["subject"] = "Monit: $EVENT $SERVICE at $DATE"
default["monit"]["message"] = "$EVENT $SERVICE $ACTION at $DATE on $HOST:\\n$DESCRIPTION"

default["monit"]["webinterface"]["enabled"] = true
default["monit"]["webinterface"]["port"] = 2812
default["monit"]["webinterface"]["listen"] = "127.0.0.1"
default["monit"]["webinterface"]["allows"] = ["localhost"]

default["monit"]["mmonit"]["enabled"] = false
default["monit"]["mmonit"]["without_creds"] = false
default["monit"]["mmonit"]["host"] = "http://monit:monit@monit.webhippie.de:8080/collector"

default["monit"]["load"]["enabled"] = true
default["monit"]["load"]["cycles"] = 5
default["monit"]["load"]["value"] = 5

default["monit"]["cpu"]["enabled"] = true
default["monit"]["cpu"]["cycles"] = 5
default["monit"]["cpu"]["value"] = 70

default["monit"]["memory"]["enabled"] = true
default["monit"]["memory"]["cycles"] = 5
default["monit"]["memory"]["value"] = 70

default["monit"]["swap"]["enabled"] = true
default["monit"]["swap"]["cycles"] = 5
default["monit"]["swap"]["value"] = 50
