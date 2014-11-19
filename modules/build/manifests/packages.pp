class build::packages {
  package { [
    'rpm-build',
    ]: ensure => latest }
}
