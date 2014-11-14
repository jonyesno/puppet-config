class nagios::client::directories {
  file { '/var/run/nagios':
    ensure => directory,
    owner  => 'nagios',
    group  => 'nagios',
    mode   => '0775',
  }
}
