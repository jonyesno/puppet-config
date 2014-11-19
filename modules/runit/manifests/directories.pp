class runit::directories {
  file { '/usr/local/var/service':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
  }
}
