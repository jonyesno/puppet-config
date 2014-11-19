class mysql::server {
  include mysql::server::backup
  include mysql::server::config
  include mysql::server::packages
  include mysql::server::directories
  include mysql::server::services
  include mysql::server::fixup
  include nagios::check::mysql

  Class['mysql::server::packages'] ~> Class['mysql::server::config']
  Class['mysql::server::config']   ~> Class['mysql::server::services']
# Class['mysql::server::services'] -> Class['mysql::server::fixup']
}
