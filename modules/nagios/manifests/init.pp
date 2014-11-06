class nagios::server::packages {
  package { [
    "nagios",
    ]:
    ensure => latest,
  }
}

class nagios::server::services {
  service { "nagios":
    enable     => true,
    ensure     => running,
    hasrestart => true,
  }
}

class nagios::server::directories {
  file { "/etc/nagios/local":
    ensure => directory,
    owner  => root,
    group  => root,
  }
}

class nagios::server::user {
  exec { "add-apache-to-nagios-group":
    unless  => "id apache | grep -q nagios",
    command => "usermod -a -G nagios apache",
    path    => "/sbin/:/usr/sbin/:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:",
    user    => "root",
  }
}

class nagios::server::config {
  file { "/etc/httpd/conf.d/nagios.conf":
    owner   => root,
    group   => root,
    content => template("nagios/httpd.conf.erb"),
    require => Class["apache::packages"],
    notify  => Service["httpd"],
  }
  file { "/etc/httpd/auth/nagios":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet://puppet/nagios/auth",
    require => Class["apache::packages"],
  }
  file { "/etc/nagios/nagios.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet://puppet/nagios/nagios.cfg",
    require => Class["nagios::server::packages"],
    notify  => Service["nagios"],
  }
  file { "/etc/nagios/cgi.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet://puppet/nagios/cgi.cfg",
    require => Class["nagios::server::packages"],
  }
  file { "/usr/share/nagios/html/config.inc.php":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet://puppet/nagios/config.inc.php",
    require => Class["nagios::server::packages"],
  }

  define nagios-local-config() {
    file {"/etc/nagios/local/${name}.cfg":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "puppet://puppet/nagios/${name}.cfg",
      require => Class["nagios::server::packages"],
      notify  => Service["nagios"],
    }
  }

  nagios-local-config { [
    "commands",
    "templates",
    ]:
  }

  file { "/etc/nagios/local/contacts.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("nagios/contacts.cfg.erb"),
    require => Class["nagios::server::packages"],
    notify  => Service["nagios"],
  }
    
}


class nagios::server {
  include nagios::hosts 
  include nagios::server::config
  include nagios::server::directories
  include nagios::server::packages
  include nagios::server::services
  include nagios::server::user
}

class nagios::client::packages {
  package { [
    "nagios-plugins-disk",
    "nagios-plugins-http",
    "nagios-plugins-load",
    "nagios-plugins-nrpe",
    "nagios-plugins-ping",
    "nagios-plugins-procs",
    "nagios-plugins-ssh",
    "nagios-plugins-swap",
    "nagios-nrpe",
    ]:
    ensure => latest,
  }
}

class nagios::client::mysql {
  package { "nagios-plugins-mysql":
    ensure => latest,
  }
}

class nagios::client::config {
  file { "/etc/nagios/nrpe.cfg":
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("nagios/nrpe.cfg.erb"),
    require => Class["nagios::client::packages"],
    notify  => Service["nrpe"],
  }
}

class nagios::client::services {
  service { "nrpe":
    ensure => running,
    enable => true,
  }
}
  
class nagios::client {
  include nagios::client::config
  include nagios::client::packages
  include nagios::client::services
}
