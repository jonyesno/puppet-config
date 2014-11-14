class nagios::check::default(
  $service = $nagios::check::common::service,
  $target  = $nagios::check::common::target
) inherits nagios::check::common {

  @@nagios_host { $target:
    ensure         => present,
    use            => 'site-host',
    host_name      => $target,
    hostgroups     => [ $::environment ],
    address        => $::ipaddress,
    target         => "/etc/nagios/local/host-${target}.cfg",
  }
  @@nagios_service {"ping-${target}":
    ensure              => present,
    use                 => $service,
    host_name           => $target,
    check_command       => 'check_ping!100,20%!200,60%',
    service_description => 'ping',
    target              => "/etc/nagios/local/service-ping-${target}.cfg"
  }
  @@nagios_service {"load-${target}":
    ensure              => present,
    use                 => $service,
    host_name           => $target,
    check_command       => "check_nrpe!${check_load}",
    service_description => 'load',
    target              => "/etc/nagios/local/service-load-${target}.cfg"
  }
  @@nagios_service {"root-fs-${target}":
    ensure              => present,
    use                 => $service,
    host_name           => $target,
    check_command       => 'check_nrpe!check_root_disk',
    service_description => 'root filesystem usage',
    target              => "/etc/nagios/local/service-root-fs-${target}.cfg"
  }
  @@nagios_service {"raid-${target}":
    ensure              => present,
    use                 => $service,
    host_name           => $target,
    check_command       => 'check_nrpe!check_raid',
    service_description => 'RAID health',
    target              => "/etc/nagios/local/service-raid-${target}.cfg"
  }
  @@nagios_service {"crond-${target}":
    ensure              => present,
    use                 => $service,
    host_name           => $target,
    check_command       => 'check_nrpe!check_cron_daemon',
    service_description => 'cron service',
    target              => "/etc/nagios/local/service-crond-${target}.cfg"
  }
  @@nagios_service {"cronwrap-${target}":
    ensure              => present,
    use                 => $service,
    host_name           => $target,
    check_command       => 'check_nrpe!check_cronwrap',
    service_description => 'cron jobs',
    target              => "/etc/nagios/local/service-cronwrap-${target}.cfg"
  }
}
