class base::directories {
  file { [
    '/root',
    '/root/bin',
    '/root/log',
    ]:
    ensure => directory,
    mode   => '0755', # world readable
  }

  file { [
    '/var/core',
    '/var/lib/backup',
    ]:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }
}
