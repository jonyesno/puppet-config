class apache::packages {
  package { ['httpd', 'mod_ssl' ]:
    ensure => latest,
    notify => Class['apache::config'],
  }
}
