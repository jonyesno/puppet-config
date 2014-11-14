class base::cabundle {
  file { '/etc/pki/tls/certs/ca-bundle.crt':
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/base/ca-bundle.crt',
  }
}
