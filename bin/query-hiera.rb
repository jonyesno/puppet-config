#!/usr/bin/env ruby

require 'yaml'
require 'pp'

base = File.dirname(__FILE__) + '/..'
systems_yml = "#{base}/systems.yaml"
hiera_yml   = "#{base}/hiera.yaml"
raise RuntimeError, "can not find systems config at #{systems_yml}" unless File.exists?(systems_yml)

system = ARGV.shift
key    = ARGV.shift
raise RuntimeError, "usage: query-hiera.rb servername key" if system.nil? || key.nil?

systems = YAML::load_file(systems_yml)
unless systems.has_key?(system)
  raise RuntimeError, "can't find #{system} in #{systems_yml}"
  exit 1
end

args = [ "::fqdn=#{system}" ]
systems[system].each { |k,v| args << "::#{k}=#{v}" }
system("hiera -d -c #{hiera_yml} #{key} #{args.join(' ')}")
