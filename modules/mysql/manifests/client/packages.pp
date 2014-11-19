class mysql::client::packages {
  package { [
      'Percona-Server-client-55',
      'Percona-Server-shared-55',
    ]: ensure => latest }
}
