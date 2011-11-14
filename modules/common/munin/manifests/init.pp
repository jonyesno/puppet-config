class munin::node::packages {
  package { [
    "perl-Cache-Cache",
    "perl-Net-SSLeay",
    "munin-common",
    "munin-node",
    ]:
    ensure => latest,
  }
}

class munin::node::config {
  file { "/etc/munin/munin-node.conf":
    content => template("munin/munin-node.conf.erb"),
    owner   => root,
    group   => root,
    notify  => Service["munin-node"],
    require => Class["munin::node::packages"],
  }
}

class munin::node::services {
  service { "munin-node":
    ensure  => running,
    enable  => true,
    require => Class["munin::node::config"],
  }
}

define munin-plugin-unplug() {
  file { "/etc/munin/plugins/${name}":
    ensure => absent,
    notify => Service["munin-node"],
  }
}

define munin-plugin-plug($target = $name) {
  file { "/etc/munin/plugins/${name}":
    ensure => symlink,
    target => "/usr/share/munin/plugins/${target}",
    notify => Service["munin-node"],
  }
}

class munin::node::plugins::standard {
  munin-plugin-unplug { [
    "nfs_client",
    "nfs4_client",
    "nfsd",
    "nfsd4",
    ]:
  }
}

class munin::node {
  include munin::node::packages, munin::node::config, munin::node::services, munin::node::plugins::standard
}

class munin::server::packages {
  package { "munin":
    ensure => present,
  }
}

class munin::server::config {
  file { "/etc/munin/munin.conf":
    content => template("munin/munin.conf.erb"),
    owner   => root,
    group   => root,
    require => Class["munin::server::packages"],
  }

  file { "/etc/httpd/conf.d/munin.conf":
    owner   => root,
    group   => root,
    content => template("munin/httpd.conf.erb"),
    require => Class["apache::packages"],
    notify  => Service["httpd"],
  }
}

class munin::server {
  include munin::server::packages, munin::server::config
}
