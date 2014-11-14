class net::hosts {
  $puppetmaster_ip = hiera('ipaddress_manage')
  file { '/etc/hosts':
    owner   => root,
    group   => root,
    content => template('net/hosts.erb'),
  }
}
