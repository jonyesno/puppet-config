class base::directories {
  file { [
    '/root',
    '/root/bin',
    ]:
    ensure => directory,
    mode   => '0755', # world readable
  }

  file { '/var/core':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }
}
