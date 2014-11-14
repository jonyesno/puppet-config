class nagios::server::checks($environments = [ ]) {
  Nagios_host    <<||>> ~> Exec['fixup-nagios-config']
  Nagios_service <<||>> ~> Exec['fixup-nagios-config']

  nagios_hostgroup { $environments:
    ensure => present,
    target => '/etc/nagios/local/hostgroups.cfg',
    notify => Exec['fixup-nagios-config'],
  }

  exec { 'fixup-nagios-config':
    command     => 'chmod -R ugo+r /etc/nagios/local',
    user        => 'root',
    refreshonly => true,
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    notify      => Class['nagios::server::services'],
  }
}
