define puppet::externalfact {
  file { "/etc/facter/facts.d/${name}.txt":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    replace => false,
    require => Class['puppet::directories'],
  }
}
