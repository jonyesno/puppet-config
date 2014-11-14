class nagios::server::services {
  service { 'nagios':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
}
