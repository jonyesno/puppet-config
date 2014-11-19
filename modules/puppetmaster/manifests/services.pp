class puppetmaster::services {
  service { 'puppetmaster':
    ensure  => running,
    enable  => true,
    require => Class['puppetmaster::packages', 'puppetmaster::config'],
  }
}
