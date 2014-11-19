class mysql::server::services {
  service { 'mysql':
    ensure  => running,
    enable  => true,
    require => Class[
#     'mysql::server::setup',
     'mysql::server::packages'],
  }
}
