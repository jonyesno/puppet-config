class firewall {
  include firewall::packages
  include firewall::config
  include firewall::services

  Class['firewall::packages'] -> Class['firewall::config']
  Class['firewall::config']   ~> Class['firewall::services']
}
