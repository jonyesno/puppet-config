class ntp {
  include ntp::config
  include ntp::packages
  include ntp::services

  Class['ntp::packages'] ~> Class['ntp::config']
  Class['ntp::config']   ~> Class['ntp::services']
}
