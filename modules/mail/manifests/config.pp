class mail::config {
  file { '/etc/exim/exim.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/mail/exim.conf',
  }
  file { '/etc/aliases':
    source => 'puppet:///modules/mail/aliases',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  file { '/etc/logrotate.d/exim':
    source => 'puppet:///modules/mail/logrotate',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}
