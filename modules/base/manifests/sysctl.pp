class base::sysctl {
  exec { 'reload-sysctl.conf':
    command     => 'sysctl --system --quiet',
    path        => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    refreshonly => true,
  }
}
