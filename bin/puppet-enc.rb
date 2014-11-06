#!/usr/bin/env ruby

require 'yaml'

systems_yml = File.dirname(__FILE__) + '/../systems.yaml'
raise RuntimeError, "can not find systems config at #{systems_yml}" unless File.exists?(systems_yml)

system = ARGV.shift
raise RuntimeError, "usage: puppet-enc.rb servername" if system.nil?
system("logger -t puppet-enc called for #{system}")

systems = YAML::load_file(systems_yml)
unless systems.has_key?(system)
  system("logger -t puppet-enc does not know about #{system}")
  exit 1
end

output = { 'parameters' => systems[system] }
puts YAML::dump(output)
