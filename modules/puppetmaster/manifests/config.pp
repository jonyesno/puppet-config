class puppetmaster::config {
  file { '/etc/sysconfig/puppetmaster':
    owner  => root,
    group  => root,
    source => 'puppet:///modules/puppetmaster/sysconfig',
  }
}
