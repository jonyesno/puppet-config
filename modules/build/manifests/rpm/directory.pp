define build::rpm::directory() {
  file { "/home/build/rpmbuild/${name}":
    ensure  => directory,
    owner   => 'build',
    group   => 'build',
    require => File['/home/build/rpmbuild'],
  }
}
