class ntp::config {
  file { '/etc/sysconfig/ntpd':
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/ntp/sysconfig',
  }
}
