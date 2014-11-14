class nagios::client::packages {
  package {[
    'nagios-nrpe',
    'nagios-plugins-disk',
    'nagios-plugins-http',
    'nagios-plugins-load',
    'nagios-plugins-log',
    'nagios-plugins-ping',
    'nagios-plugins-procs',
    'nagios-plugins-smtp',
    'nagios-plugins-swap',
    ]:
    ensure  => latest,
  }
}
