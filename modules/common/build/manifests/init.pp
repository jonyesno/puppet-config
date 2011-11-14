class build::packages {
  package { [
    "gcc",
    "gcc-c++",
    "make",
    "php",
    "rpm-build",
    ]:
    ensure => latest,
  }
}

class build::config {
  file { "/home/build/.rpmmacros":
    owner   => build,
    group   => build,
    content => "%_topdir /home/build/rpmbuild\n%dist .local\n",
  }

  file { "/etc/httpd/conf.d/build.conf":
    owner   => root,
    group   => root,
    content => template("build/httpd.conf.erb"),
    require => Class["apache::packages"],
    notify  => Service["httpd"],
  }

}

class build {
  include build::packages, build::config
}
