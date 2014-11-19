define varnish::config::file() {
  file { "/etc/varnish/${name}.vcl":
    owner   => 'root',
    group   => 'root',
    source  => [
      "puppet:///modules/varnish/${name}.vcl.${environment}",
      "puppet:///modules/varnish/${name}.vcl",
    ],
    mode    => '0644',
    require => Class['varnish::packages'],
    notify  => Exec['reload-varnish'],
  }
}
