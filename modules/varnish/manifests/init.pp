class varnish::packages {
  package { "varnish":
    ensure => latest,
    notify => Service["varnish"],
  }
}

class varnish::config {
  file { "/etc/varnish/local.vcl":
    owner   => root,
    group   => root,
    content => template("varnish/local.vcl.erb"),
    require => Class["varnish::packages"],
    notify  => Exec["reload-varnish"],
  }
  file { "/etc/varnish/secret":
    owner   => root,
    group   => root,
    mode    => 0440,
    source  => "puppet://puppet/varnish/secret",
    require => Class["varnish::packages"],
    notify  => Service["varnish"],
  }

  file { "/etc/logrotate.d/varnish":
    owner   => root,
    group   => root,
    source  => "puppet://puppet/varnish/logrotate",
  }
}

class varnish::runit {
  file { [
    "/usr/local/var/service/varnish",
    "/usr/local/var/service/varnish/log",
    "/usr/local/var/service/varnish/log/main",
    ]:
    ensure => directory,
    owner  => root,
    group  => root,
  }
  file { "/usr/local/var/service/varnish/run":
    owner   => root,
    group   => root,
    mode    => 755,
    require => File["/usr/local/var/service/varnish"],
    content => template("varnish/varnish-run.erb"),
  }
  file { "/usr/local/var/service/varnish/log/run":
    owner   => root,
    group   => root,
    mode    => 755,
    require => File["/usr/local/var/service/varnish/log"],
    source  => "puppet://puppet/varnish/log-run",
  }
  file { [
    "/usr/local/var/service/varnishncsa",
    "/usr/local/var/service/varnishncsa/log",
    "/usr/local/var/service/varnishncsa/log/main",
    ]:
    ensure => directory,
    owner  => root,
    group  => root,
  }
  file { "/usr/local/var/service/varnishncsa/run":
    owner   => root,
    group   => root,
    mode    => 755,
    require => File["/usr/local/var/service/varnish"],
    source  => "puppet://puppet/varnish/varnishncsa-run",
  }
  file { "/usr/local/var/service/varnishncsa/log/run":
    owner   => root,
    group   => root,
    mode    => 755,
    require => File["/usr/local/var/service/varnishncsa/log"],
    source  => "puppet://puppet/varnish/log-run",
  }
}
 
class varnish::services {
  service { "varnish":
    enable   => true,
    ensure   => running,
    provider => runit,
    path     => "/usr/local/var/service",
    require  => Class["varnish::packages", "varnish::runit"],
    notify   => Service["varnishncsa"],
  }
  service { "varnishncsa":
    enable   => true,
    ensure   => running,
    provider => runit,
    path     => "/usr/local/var/service",
    require  => Class["varnish::packages", "varnish::runit"],
  }
  exec { "reload-varnish":
    command     => "/root/bin/reload-varnish.sh > /var/log/reload-varnish.log 2>&1",
    user        => root,
    group       => root,
    path        => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"],
    refreshonly => true,
  }

}

class varnish::munin {
  munin-plugin-plug { [
    "varnish_backend_traffic",
    "varnish_expunge",
    "varnish_hit_rate",
    "varnish_memory_usage",
    "varnish_objects",
    "varnish_request_rate",
    "varnish_threads",
    "varnish_transfer_rates",
    "varnish_uptime",
    ]:
    target => "varnish_",
  }
}

class varnish {
  include varnish::packages, varnish::config, varnish::services, varnish::runit, varnish::munin
}

