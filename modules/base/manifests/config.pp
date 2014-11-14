class base::config {
  file { '/etc/sysctl.conf':
    owner   => root,
    group   => root,
    content => template('base/sysctl.conf.erb'),
    notify  => Exec['reload-sysctl.conf'],
  }

  exec { 'reload-sysctl.conf':
    command     => 'sysctl -e -p /etc/sysctl.conf',
    path        => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    subscribe   => File['/etc/sysctl.conf'],
    refreshonly => true,
  }
}
