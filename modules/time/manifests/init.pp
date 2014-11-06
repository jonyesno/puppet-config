class time::packages {
  package { [
    "ntp",
    "ntpdate",
    ]:
    ensure => latest,
  }
}

class time::services {
  service { "ntpdate":
    enable  => true,
    require => Class["time::packages"],
  }
  service { "ntpd":
    enable  => true,
    require => Class["time::packages"],
  }
}

class time::zone {
  exec { "set-timezone":
    unless  => "diff -q /etc/localtime /usr/share/zoneinfo/GMT",
    command => "cp /usr/share/zoneinfo/GMT /etc/localtime",
    path    => "/sbin/:/usr/sbin/:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:",
    user    => "root",
  }
}

class time::config {
  file { "/etc/sysconfig/clock":
    owner   => "root",
    group   => "root",
    content => "ZONE=GMT\n",
  }
  file { "/etc/sysconfig/ntpd":
    owner   => "root",
    group   => "root",
    content => "OPTIONS=\"-u ntp:ntp -p /var/run/ntpd.pid -g -x\"\n",
    notify  => Service["ntpd"],
  }
}


class time {
  include time::packages, time::services, time::zone, time::config
}
