class mail::services {
  service { 'exim':
    ensure  => running,
    enable  => true,
  }
  service { 'sendmail':
    ensure => stopped,
    enable => false,
  }
  service { 'postfix':
    ensure => stopped,
    enable => false,
  }
}
