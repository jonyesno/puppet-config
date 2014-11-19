class php::php54::config {
  file { '/etc/php.ini':
    owner   => root,
    group   => root,
    source  => 'puppet:///modules/php/php54.ini',
    require => Class['php::php54::packages'],
  }
}
