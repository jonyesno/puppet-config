class ntp::services {
  service { 'ntpd':
    ensure  => running,
    enable  => true,
  }
}
