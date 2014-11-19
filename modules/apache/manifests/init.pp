# == Class: apache
#
# Installs, configures, runs Apache

class apache {
  include apache::auth
  include apache::config
  include apache::directories
  include apache::packages
  include apache::services
  include nagios::check::apache

  $certs = hiera_array('certificates', [])
  ssl::certificate { $certs: group => 'apache' }

  Class['apache::directories'] -> Class['apache::services']
}
