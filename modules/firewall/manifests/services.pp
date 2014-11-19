class firewall::services {
  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }

  service { 'iptables':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => false,
  }
}
