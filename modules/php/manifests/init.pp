class php::packages {
  package { [
    "php",
    "php-gd",
    "php-mbstring",
    "php-mcrypt",
    "php-mysql",
    "php-xml",
    "php-xmlrpc",
    ]:
    ensure => latest,
  }
}

class php::config {
  file { "/etc/php.ini":
    owner  => root,
    group  => root,
    source => "puppet://puppet/php/php.ini",
  }
}

class php {
  include php::packages, php::config
}
