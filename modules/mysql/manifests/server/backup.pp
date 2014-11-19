class mysql::server::backup {
  file { '/root/bin/backup-mysql.sh':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/mysql/backup-mysql.sh',
  }

  # FIXME - cronwrap this
  cron { 'mysql-backup':
    command => '/root/bin/backup-mysql.sh > /root/log/backup-mysql.sh 2>&1',
    user    => root,
    hour    => 01,
    minute  => 00,
  }
}
