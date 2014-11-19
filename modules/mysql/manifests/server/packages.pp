class mysql::server::packages($percona = false) {
  package { [
    'Percona-Server-server-55',
    'percona-toolkit',
    ]: ensure => latest }
}
