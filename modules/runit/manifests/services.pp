class runit::services {
  service { 'runsvdir':
    ensure    => running,
    enable    => true,
    require   => Class['runit::packages'],
    hasstatus => false,
  }
}
