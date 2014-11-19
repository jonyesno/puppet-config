class build::rpm {
  file { '/home/build/.rpmmacros':
    content => "%_topdir /home/build/rpmbuild\n%dist .local\n",
    owner   => 'build',
    group   => 'build'
  }

  file { '/home/build/rpmbuild':
    ensure => directory,
    owner  => 'build',
    group  => 'build',
  }

  build::rpm::directory { ['BUILD', 'RPMS', 'SOURCES', 'SPECS', 'SRPMS']: }
}
