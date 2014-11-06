class firewall {
  # FIXME: need to define $apache, $mysql and $servers
  $manage = hiera('ipaddress_manage', '127.0.0.1')

  file { '/etc/sysconfig/iptables':
    owner   => root,
    group   => root,
    content => template('firewall/iptables.erb'),
    notify  => Service['iptables'],
  }

  service { 'iptables':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => false,
  }
}
