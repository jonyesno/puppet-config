define runit::runner (
  $runscript    = $name,
  $service_name = $name,
  $vars         = {}
  ) {
  file { [
    "/usr/local/var/service/${service_name}",
    "/usr/local/var/service/${service_name}/log",
    "/usr/local/var/service/${service_name}/log/main",
    ]:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { "/usr/local/var/service/${service_name}/run":
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File["/usr/local/var/service/${service_name}"],
    content => template("runit/${runscript}-run.erb"),
  }
  file { "/usr/local/var/service/${service_name}/log/run":
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File["/usr/local/var/service/${service_name}/log"],
    source  => 'puppet:///modules/runit/log-run'
  }
}
