class nagios::check::mysql(
  $service = $nagios::check::common::service,
  $target  = $nagios::check::common::target
) inherits nagios::check::common {

  $replication = hiera('replication', false)
  $check_mysql = $replication ? {
    true  => 'check_mysql_with_slave',
    false => 'check_mysql',
  }

  @@nagios_service {"mysql-${target}":
    ensure              => present,
    use                 => $service,
    host_name           => $target,
    check_command       => "check_nrpe!${check_mysql}",
    service_description => 'mysql',
    target              => "/etc/nagios/local/service-mysql-${target}.cfg"
  }
}

