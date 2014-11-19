class apache::config($port80 = true, $children = 8) {
  if (defined(Class['::varnish'])) {
    $varnish = true
  }

  file { '/etc/httpd/conf/httpd.conf':
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('apache/httpd.conf.erb'),
    require => Class['apache::packages'],
    notify  => Service['httpd'],
  }
  file { '/etc/httpd/conf.d/ssl.conf':
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/apache/ssl.conf',
    require => Class['apache::packages'],
    notify  => Service['httpd'],
  }
  file { '/etc/httpd/conf.d/status.conf':
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('apache/status.conf.erb'),
    require => Class['apache::packages'],
    notify  => Service['httpd'],
  }
  file { '/etc/logrotate.d/httpd':
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/apache/logrotate',
  }
}
