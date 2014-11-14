class nagios::server {
  include nagios::server::config
  include nagios::server::checks
  include nagios::server::directories
  include nagios::server::packages
  include nagios::server::services
}
