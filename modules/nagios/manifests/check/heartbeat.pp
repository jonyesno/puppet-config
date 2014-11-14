class nagios::check::heartbeat(
  $service = $nagios::check::common::service,
  $target  = $nagios::check::common::target
) inherits nagios::check::common {
  @@nagios_service {"heartbeat-${target}":
    ensure              => present,
    use                 => $service,
    host_name           => $target,
    check_command       => 'check_nrpe!check_heartbeat',
    service_description => 'Heartbeat process',
    target              => "/etc/nagios/local/service-heartbeat-${target}.cfg"
  }
}
