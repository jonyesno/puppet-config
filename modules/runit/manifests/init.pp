class runit::packages {
  package { "runit":
    ensure  => latest,
#   require => Yumrepo["runit"],
  }
}

class runit::directories {
  file { [
    "/usr/local/var",
    "/usr/local/var/service",
    ]:
    ensure => directory,
    owner  => root,
    group  => root,
  }
}

class runit::services {
  service { "runsvdir":
    ensure  => running,
    enable  => true,
    require => Class["runit::packages"],
  }
}

class runit::fixups {
  # runit provider looks for /usr/bin/sv
  file { "/usr/bin/sv":
    ensure => symlink,
    target => "/sbin/sv",
  }
}

class runit {
  include runit::packages, runit::services, runit::fixups, runit::directories
}
