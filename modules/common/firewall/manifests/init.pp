class firewall {
  file { "/etc/sysconfig/iptables":
    owner   => root,
    group   => root,
    content => template("firewall/iptables.erb"),
    notify  => Service["iptables"],
  }

  service { "iptables":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => false,
  }
}
