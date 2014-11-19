define ssl::certificate(
  $owner = 'root',
  $group = 'root',
  $mode  = '0440') {
  $certs = hiera('x509certificates', {})
  if (has_key($certs, $name)) {
    $cert  = $certs[$name]

    file { "/etc/ssl/local/${name}.pem":
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => $cert,
      require => Class['ssl::directories'],
    }
  }
}
