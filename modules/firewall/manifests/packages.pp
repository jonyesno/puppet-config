class firewall::packages {
  package { 'iptables-services': ensure => latest }
}
