define nagios::server::template() {
  $nagios = hiera('nagios')
  file { "/etc/nagios/site/${name}.cfg":
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("nagios/${name}.cfg.erb"),
    require => Class['nagios::server::directories'],
    notify  => Service['nagios'],
  }
}
