class puppet::directories {
  file { [
    '/etc/facter',
    '/etc/facter/facts.d',
    ]:
    ensure => directory,
    owner  => 'root',
    group  => 'wheel',
    mode   => '0755',
  }
}
