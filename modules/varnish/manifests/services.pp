class varnish::services {

  $varnish = hiera('varnish')
  runit::runner { 'varnish': vars => $varnish }
  runit::runner { 'varnishncsa': }
  runit::runner { 'varnishlog': }

  puppet::externalfact { 'varnish': }

  service { 'varnish':
    ensure => serviceswitch('varnish-run', 'ensure'),
    enable => serviceswitch('varnish-run', 'enable'),
#   notify => Exec['reload-varnish'],
  }
  service { 'varnishncsa':
    ensure  => serviceswitch('varnish-run', 'ensure'),
    enable  => serviceswitch('varnish-run', 'enable'),
  }

  service { 'varnishlog':
    ensure  => serviceswitch('varnish-log', 'ensure'),
    enable  => serviceswitch('varnish-log', 'enable'),
  }

  # TODO this will fire even if varnish isn't enabled by the serviceswitch
  #      the resulting reload fails in this case
  # FIXME likely not needed anymore
  exec { 'reload-varnish':
    command     => '/root/bin/reload-varnish.sh > /root/log/reload-varnish.log 2>&1',
    user        => 'root',
    group       => 'root',
    path        => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    refreshonly => true,
  }

}
