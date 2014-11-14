class nagios::client::config {
  $monitor_ip = hiera('managehost')
  file { '/etc/nagios/nrpe.cfg':
    content => template('nagios/nrpe.cfg.erb'),
    owner   => root,
    group   => root,
    require => Class['nagios::client::packages'],
    notify  => Service['nrpe'],
  }
}
