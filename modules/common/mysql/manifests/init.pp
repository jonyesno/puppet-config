class mysql::server::packages {
  package { [
    "git",
    "perl-DBD-MySQL",
    "mysql-server",
    "mytop",
    ]:
    ensure => present,
  }
}

class mysql::client::packages {
  package { "mysql-libs":
    ensure => latest,
  }
}

class mysql::server::config {
  file { "/etc/my.cnf":
    owner   => root,
    group   => root,
    content => template("mysql/my.cnf.erb"),
    require => Class["mysql::server::packages"], 
  }
}
  
class mysql::server::directories {
  file { [
    "/var/lib/mysql-backup",
    "/var/lib/mysql-log",
    "/var/lib/mysql-log/master",
    "/var/lib/mysql-log/relay",
    ]:
    ensure  => directory,
    owner   => mysql,
    group   => mysql,
    require => Class["mysql::server::packages"], 
  }
}

class mysql::server::setup {
  exec { "setup-mysql":
    unless  => "test -f /var/lib/mysql/mysql/db.MYD",
    path    => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"],
    command => "mysql_install_db && chown -R mysql:mysql /var/lib/mysql",
    user    => root,
    require => Class["mysql::server::packages", "mysql::server::config"], 
  }
}

class mysql::server::services {
  service { "mysql":
    ensure  => running,
    enable  => true,
    require => Class["mysql::server::setup"],
  }
}

class mysql::server::munin {
  munin-plugin-plug { [
    "mysql_bin_relay_log",
    "mysql_commands",
    "mysql_connections",
    "mysql_files_tables",
    "mysql_innodb_bpool",
    "mysql_innodb_bpool_act",
    "mysql_innodb_insert_buf",
    "mysql_innodb_io",
    "mysql_innodb_io_pend",
    "mysql_innodb_log",
    "mysql_innodb_rows",
    "mysql_innodb_semaphores",
    "mysql_innodb_tnx",
    "mysql_myisam_indexes",
    "mysql_network_traffic",
    "mysql_qcache",
    "mysql_qcache_mem",
    "mysql_replication",
    "mysql_select_types",
    "mysql_slow",
    "mysql_sorts",
    "mysql_table_locks",
    "mysql_tmp_tables",
    ]:
    target => "mysql_",
  }
}

class mysql::server::scripts {
  file { "/root/bin/backup-mysql.sh":
    owner   => root,
    group   => root,
    mode    => 0755,
    content => template("mysql/backup-mysql.sh.erb"),
  }
}

class mysql::server::cron {
  cron { "backup-mysql":
    command => "/root/bin/backup-mysql.sh > /var/log/backup-mysql.log 2>&1",
    user    => root,
    hour    => 01,
    minute  => 00,
  }
}

class mysql::server {
  include mysql::client::packages
  include mysql::server::config
  include mysql::server::cron
  include mysql::server::directories
  include mysql::server::packages
  include mysql::server::scripts
  include mysql::server::setup
  include mysql::server::services
  include mysql::server::munin
}

class mysql::client {
  include mysql::client::packages
}
