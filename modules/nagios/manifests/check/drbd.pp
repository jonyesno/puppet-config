class nagios::check::drbd(
  $service = $nagios::check::common::service,
  $target  = $nagios::check::common::target
) inherits nagios::check::common {

  $cluster = hiera('cluster', {})
  if $cluster['disposition'] == 'active' {
    @@nagios_service {"drbd-primary-${target}":
      ensure              => present,
      use                 => $service,
      host_name           => $target,
      check_command       => 'check_nrpe!check_drbd_primary',
      service_description => 'DRBD primary',
      target              => "/etc/nagios/local/service-drbd-primary-${target}.cfg",
    }
  } else {
    @@nagios_service {"drbd-secondary-${target}":
      ensure              => present,
      use                 => $service,
      host_name           => $target,
      check_command       => 'check_nrpe!check_drbd_secondary',
      service_description => 'DRBD secondary',
      target              => "/etc/nagios/local/service-drbd-secondary-${target}.cfg",
    }
  }
}
