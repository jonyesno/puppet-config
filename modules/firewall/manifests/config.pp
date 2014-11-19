class firewall::config {
  $manage  = hiera('managehost', '127.0.0.1')
  $servers = hiera('servers', [])

  if (defined(Class['::apache'])) {
    $apache = true
  }
  if (defined(Class['::mysql::server'])) {
    $mysql = true
  }
  if (defined(Class['::puppetmaster'])) {
    $puppetmaster = true
  }

  file { '/etc/sysconfig/iptables':
    owner   => root,
    group   => root,
    content => template('firewall/iptables.erb'),
    notify  => Service['iptables'],
  }
}
