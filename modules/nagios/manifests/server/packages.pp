class nagios::server::packages {
  package { [
    'nagios',
    'nagios-plugins-nrpe',
    ]:
    ensure => latest,
  }
}
