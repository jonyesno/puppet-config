class repos {
  yumrepo { "local":
    baseurl  => "http://repo/local",
    enabled  => 0,
    priority => 10,
    gpgcheck => 0,
  }
}
