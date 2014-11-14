  define nagios::server::configfile() {
    file { "/etc/nagios/site/${name}.cfg":
      owner   => root,
      group   => root,
      mode    => '0644',
      source  => "puppet:///modules/nagios/${name}.cfg",
      require => Class['nagios::server::directories'],
      notify  => Service['nagios'],
    }
  }

