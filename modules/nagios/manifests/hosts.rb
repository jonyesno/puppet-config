hostclass :"nagios::hosts" do
  hosts = scope.lookupvar("servers")
  hosts.each do |host|
    scope.unsetvar("host")
    scope.setvar("host", host)

    # FIXME: calling the ENC directly is an icky fudge
    #        also, errors are hard to track down
    host_classes = YAML::load( %x[ /etc/puppet/libexec/puppet-node.rb #{host['name']} ] )['classes']
    scope.unsetvar("host_classes")
    scope.setvar("host_classes", host_classes)

    file "/etc/nagios/local/#{host['name']}.cfg",
      :owner   => "root",
      :group   => "root",
      :content => call_function("template", ["nagios/host.cfg.erb"]),
      :require => "Class[nagios::server::directories]",
      :notify  => "Service[nagios]"
  end
  
  scope.setvar("hosts", hosts)
  file "/etc/nagios/local/hostgroup.cfg",
    :owner   => "root",
    :group   => "root",
    :content => call_function("template", ["nagios/hostgroup.cfg.erb"]),
    :require => "Class[nagios::server::directories]",
    :notify  => "Service[nagios]"

end

