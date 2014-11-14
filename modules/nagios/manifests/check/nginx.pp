class nagios::check::nginx(
  $service = $nagios::check::common::service,
  $target  = $nagios::check::common::target
) inherits nagios::check::common {

  @@nagios_service {"nginx-${target}":
    ensure              => present,
    use                 => $service,
    host_name           => $target,
    check_command       => 'check_nrpe!check_nginx',
    service_description => 'nginx',
    target              => "/etc/nagios/local/service-nginx-${target}.cfg"
  }
}
