class ssh::config {
  file { "/etc/ssh/sshd_config":
    owner   => root,
    group   => root,
    source  => "puppet://puppet/ssh/sshd_config",
  }

  exec { "reload-sshd":
    user        => root,
    command     => "service sshd reload",
    path        => "/sbin/:/usr/sbin/:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:",
    subscribe   => File["/etc/ssh/sshd_config"],
    refreshonly => true,
  }
}

class ssh {
  include ssh::config
}
