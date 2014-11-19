class ntp::packages {
  package { 'ntp': ensure => latest }
}
