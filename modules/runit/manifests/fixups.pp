class runit::fixups {
  # runit provider looks for /usr/bin/sv
  file { '/usr/bin/sv':
    ensure => symlink,
    target => '/sbin/sv',
  }
  file { '/service':
    ensure => symlink,
    target => '/var/service',
  }
}
