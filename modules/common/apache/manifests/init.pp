class apache::packages {
  package { ["httpd", "mod_ssl" ]:
    ensure => latest,
  }
}

class apache::auth {
  file { "/etc/httpd/auth/local":
    owner   => root,
    group   => root,
    source  => "puppet://puppet/apache/auth",
    require => Class["apache::directories"],
  }
}

class apache::config {
  file { "/etc/httpd/conf/httpd.conf":
    owner   => root,
    group   => root,
    content => template("apache/httpd.conf.erb"),
    require => Class["apache::packages"],
    notify  => Service["httpd"],
  }
  file { "/etc/httpd/conf.d/nvh.conf":
    owner   => root,
    group   => root,
    content => template("apache/nvh.conf.erb"),
    require => Class["apache::packages"],
    notify  => Service["httpd"],
  }
  file { "/etc/httpd/conf.d/ssl.conf":
    owner   => root,
    group   => root,
    source  => "puppet://puppet/apache/ssl.conf",
    require => Class["apache::packages"],
    notify  => Service["httpd"],
  }
  file { "/etc/httpd/conf.d/status.conf":
    owner   => root,
    group   => root,
    content => template("apache/status.conf.erb"),
    require => Class["apache::packages"],
    notify  => Service["httpd"],
  }
  file { "/etc/httpd/ssl/ca.pem":
    owner   => root,
    group   => root,
    source  => "puppet://puppet/apache/ca.pem",
    require => Class["apache::directories"],
    notify  => Service["httpd"],
  }

  file { "/etc/logrotate.d/httpd":
    owner   => root,
    group   => root,
    source  => "puppet://puppet/apache/logrotate",
  }
}

class apache::directories {
  file { "/etc/httpd/auth":
    ensure  => directory,
    owner   => root,
    group   => root,
    require => Class["apache::packages"],
  }

  file { "/etc/httpd/ssl":
    ensure => directory,
    owner   => root,
    group   => root,
    require => Class["apache::packages"],
  }

  file { "/var/log/httpd":
    mode => 0755,
  }
}

class apache::munin {
  munin-plugin-plug { [
    "apache_accesses",
    "apache_processes",
    "apache_volume",
    ]:
  }
}

class apache::services {
  service { "httpd":
    ensure  => running,
    enable  => true,
    require => Class["apache::config"],
  }
}

class apache {
  include apache::packages, apache::auth, apache::config, apache::services, apache::certs, apache::directories, apache::munin
}
