class varnish::config {
  $varnish = hiera('varnish')
  file { '/etc/varnish/varnish.params':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('varnish/varnish.params.erb'),
  }

  varnish::config::file { 'local': }
}
