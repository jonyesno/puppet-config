class net::hosts {
  $puppetmaster_ip = hiera('managehost')
  file { '/etc/hosts':
    owner   => root,
    group   => root,
    content => template('net/hosts.erb'),
  }
}
