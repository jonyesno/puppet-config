class timezone::utc {
  exec { 'set-timezone-to-utc':
    unless  => 'diff -q /etc/localtime /usr/share/zoneinfo/UTC',
    path    => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    command => 'cp /usr/share/zoneinfo/UTC /etc/localtime',
  }
}
