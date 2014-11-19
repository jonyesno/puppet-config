define apache::certs {
  $certs = hiera('x509certificates', {})
  if (has_key($certs, $name)) {
    $cert  = $certs[$name]

    file { "/etc/httpd/ssl/${name}.pem":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => $cert,
      require => Class['apache::directories'],
    }
  }
}
