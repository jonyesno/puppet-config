#!/usr/bin/env ruby

require 'yaml'

node_yml = ENV['SERVER_CONFIG']
node_yml ||= '/etc/puppet/systems.yml'

profile_yml = ENV['PROFILE_CONFIG']
profile_yml ||= '/etc/puppet/profiles.yml'


fqhn = ARGV.shift
node = fqhn # .split(/\./).first
raise RuntimeError, "usage: puppet-node.rb servername" if node.nil?
system("logger -t puppet-node #{node} #{fqhn} start")

nodes = YAML::load_file(node_yml)
unless nodes.has_key?(node)
  exit 1
end

system   = nodes[node]
profile  = system['profile']
defaults = nodes['default'][system['environment']]
system   = defaults.merge(system) unless defaults.nil? # system overrides defaults

profiles = YAML::load_file(profile_yml)
raise RuntimeError, "#{node} has no profile" unless system.has_key?('profile')
raise RuntimeError, "#{profile} not found in #{profile_yml}" unless profiles.has_key?(profile)

classes  = profiles[profile] || []
defaults = profiles['default']
classes += defaults
if system.has_key?('classes')
  classes += system['classes']
  system.delete('classes')
end

puppet = {
  'classes'     => classes,
  'parameters'  => system,
}

puts YAML::dump(puppet)
system("logger -t puppet-node #{node} #{fqhn} end")
