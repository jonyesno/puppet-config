class base::services {
  service { 'network':
    hasrestart => true,
  }
  service { 'avahi-daemon':
    ensure => stopped,
    enable => false,
  }
  service { 'iscsid':
    ensure => stopped,
    enable => false,
  }
}
