class puppet::config {
  if (defined(Class['::puppetmaster'])) {
    $template = 'puppet/puppetmaster.conf.erb'
    $puppetmaster_report = hiera('puppetmaster_report', false)
  } else {
    $template = 'puppet/puppet.conf.erb'
  }

  file { '/etc/puppet/puppet.conf':
    owner   => root,
    group   => root,
    content => template($template),
    require => Class['puppet::packages'],
  }
}
