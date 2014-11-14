module Puppet::Parser::Functions
  newfunction(:serviceswitch, :type => :rvalue) do |args|
    raise Puppet::ParseError, "serviceswitch takes externalfact as first argument" unless !args[0].nil?
    externalfact = lookupvar(args[0]) || false

    raise Puppet::ParseError, "serviceswitch takes 'enable' or 'ensure' as second argument" unless !args[1].nil?

    case args[1]
    when 'enable'
      externalfact == 'true' ? true : false
    when 'ensure'
      externalfact == 'true' ? 'running' : 'stopped'
    when 'present'
      externalfact == 'true' ? 'present' : 'absent'
    else
      raise Puppet::ParseError, "serviceswitch takes 'enable' or 'ensure' as second argument"
    end
  end
end
