class mysql::server::fixup {
  file { '/root/bin/fixup-mysql-install.sh':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/mysql/fixup-mysql-install.sh',
  }

  exec { 'fixup-mysql':
    unless  => 'test -f /root/.my.cnf',
    path    => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    command => '/root/bin/fixup-mysql-install.sh',
    user    => 'root',
    require => [ Class['mysql::server::services'], File['/root/bin/fixup-mysql-install.sh'] ],
  }
}
