class mysql::server::directories {
  file { '/var/lib/backup/mysql':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    require => Class['base::directories'],
  }
}
