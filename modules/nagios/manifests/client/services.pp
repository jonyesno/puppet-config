class nagios::client::services {
  service { 'nrpe':
    ensure  => running,
    enable  => true,
    require => Class['nagios::client::packages'],
  }
}
