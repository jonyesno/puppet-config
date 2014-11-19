class varnish::scripts {
  file { '/root/bin/reload-varnish.sh':
    ensure => present,
    owner  => 'root',
    group  => 'wheel',
    mode   => '0755',
    source => 'puppet:///modules/varnish/reload-varnish.sh',
  }
}
