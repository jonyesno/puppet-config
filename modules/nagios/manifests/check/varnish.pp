class nagios::check::varnish(
  $service = $nagios::check::common::service,
  $target  = $nagios::check::common::target
) inherits nagios::check::common {

  @@nagios_service {"varnish-${target}":
    ensure              => serviceswitch('varnish-run', 'present'),
    use                 => $service,
    host_name           => $target,
    check_command       => 'check_nrpe!check_varnish',
    service_description => 'varnish',
    target              => "/etc/nagios/local/service-varnish-${target}.cfg",
  }

  @@nagios_service {"varnishncsa-${target}":
    ensure              => serviceswitch('varnish-run', 'present'),
    use                 => $service,
    host_name           => $target,
    check_command       => 'check_nrpe!check_varnishncsa',
    service_description => 'varnish logger',
    target              => "/etc/nagios/local/service-varnishncsa-${target}.cfg",
  }
}
