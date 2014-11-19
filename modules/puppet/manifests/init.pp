class puppet {
  include puppet::config
  include puppet::directories
  include puppet::packages

  Class['puppet::packages'] ~> Class['puppet::config']
}
