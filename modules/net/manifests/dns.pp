class net::dns($local = false) {
  if ($local == true) {
    package { [
      'bind-utils',
      'ndjbdns',
      ]:
      ensure => latest
    }
    ->
    service { 'dnscache':
      ensure => running,
      enable => true,
    }
    ->
    file { '/etc/resolv.conf':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "nameserver 127.0.0.1\n",
    }
  } else {
    $nameservers = hiera('nameservers', [ '8.8.8.8', '8.8.4.4' ] )
    file { '/etc/resolv.conf':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('net/resolv.conf.erb'),
    }
  }
}
