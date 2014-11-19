# == Class: apache
#
# Installs, configures, runs Apache

class apache($http = true) {
  include apache::auth
  class { 'apache::config': http => $http }
  include apache::directories
  include apache::packages
  include apache::services
  include nagios::check::apache

  $certs = hiera_array('certs', [])
  apache::certs { $certs: }

  Class['apache::directories'] -> Class['apache::services']
}
