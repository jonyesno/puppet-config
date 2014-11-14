class nagios::check::apache(
  $service = $nagios::check::common::service,
  $target  = $nagios::check::common::target
) inherits nagios::check::common {

  @@nagios_service {"apache-${target}":
    ensure              => present,
    use                 => $service,
    host_name           => $target,
    check_command       => 'check_nrpe!check_apache',
    service_description => 'apache',
    target              => "/etc/nagios/local/service-apache-${target}.cfg",
  }
}
