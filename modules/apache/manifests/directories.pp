class apache::directories {
  file { [ '/etc/httpd/auth', '/etc/httpd/ssl']:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Class['apache::packages'],
  }

  file { '/var/core/httpd':
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0755',
    require => Class['base::directories'],
  }
}
