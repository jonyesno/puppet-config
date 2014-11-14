class nagios::client {
  include nagios::client::config
  include nagios::client::directories
  include nagios::client::packages
  include nagios::client::services
}
