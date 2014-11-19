class mysql::server::config {
  file { '/etc/my.cnf':
    owner   => root,
    group   => root,
    content => template('mysql/my.cnf.erb'),
  }
}
