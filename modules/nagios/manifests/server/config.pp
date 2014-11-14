class nagios::server::config {
  $nagios = hiera('nagios')
  file { '/etc/httpd/conf.d/nagios.conf':
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('nagios/httpd.conf.erb'),
    require => Class['apache::packages'],
    notify  => Service['httpd'],
  }
  file { '/etc/nagios/passwd':
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/nagios/passwd',
    require => Class['apache::packages'],
  }
  file { '/etc/nagios/nagios.cfg':
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/nagios/nagios.cfg',
    require => Class['nagios::server::packages'],
    notify  => Service['nagios'],
  }
  file { '/etc/nagios/cgi.cfg':
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/nagios/cgi.cfg',
    require => Class['nagios::server::packages'],
  }
  file { '/usr/share/nagios/html/config.inc.php':
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/nagios/config.inc.php',
    require => Class['nagios::server::packages'],
  }

  nagios::server::template { [
    'contacts',
    ]:
  }

  nagios::server::configfile { [
    'commands',
    'templates',
    ]:
  }
}
