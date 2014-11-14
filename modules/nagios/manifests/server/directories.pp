class nagios::server::directories {
  file { [
    '/etc/nagios/site',  # for 'static' config: contacts, templates, ...
    '/etc/nagios/local', # for files created by exported resources
    ]:
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Class['nagios::server::packages'],
  }
  file { '/var/log/nagios':
    mode => '0775',
  }
}
