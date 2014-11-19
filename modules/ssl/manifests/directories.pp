class ssl::directories {
  file { '/etc/ssl/local':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0775',
  }
}
