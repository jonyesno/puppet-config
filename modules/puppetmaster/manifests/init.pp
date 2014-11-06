class puppetmaster::packages {
  package { "puppet-server":
    ensure => latest,
  }
  package { "createrepo":
    ensure => latest,
  }
}

class puppetmaster::config {
  file { "/etc/sysconfig/puppetmaster":
    owner  => root,
    group  => root,
    source => "puppet://puppet/puppetmaster/sysconfig",
  }
}

class puppetmaster::services {
  service { "puppetmaster":
    enable  => true,
    ensure  => running,
    require => Class["puppetmaster::packages", "puppetmaster::config"],
  }
}

class puppmetmaster::cron {
  cron { "clean-puppet-reports":
    command => "/usr/bin/find /var/lib/puppet/reports/ -mtime +7 -name '*.yaml' | /usr/bin/xargs /bin/rm",
    user    => puppet,
    hour    => 03,
    minute  => 00,
  }
}

class puppetmaster::repo {
  file { ["/var/www/repo", 
          "/var/www/repo/local", 
          "/var/www/repo/local/noarch"]:
    ensure  => directory,
    owner   => root,
    group   => root,
    require => Class["apache::packages"],
  }

  file { "/etc/httpd/conf.d/repo.conf":
    owner   => root,
    group   => root,
    content => template("puppetmaster/httpd.conf.erb"),
    require => Class["apache::packages"],
    notify  => Service["httpd"],
  }
}

class puppetmaster {
  include puppetmaster::packages, puppetmaster::config, puppetmaster::services, puppetmaster::repo
}
