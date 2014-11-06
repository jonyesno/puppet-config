class net::packages {
  package { "telnet":
    ensure => present,
  }
}

class net::hosts {
  file { "/etc/hosts":
    owner  => root,
    group  => root,
    content => template("net/hosts.erb"),
  }
}

class net {
  include net::packages, net::hosts
}
