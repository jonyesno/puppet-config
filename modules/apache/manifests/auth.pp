class apache::auth {
  file { '/etc/httpd/auth/local':
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/apache/local.auth',
    require => Class['apache::directories'],
  }
}
