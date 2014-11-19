class ssh::config {
  file { '/etc/ssh/sshd_config':
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/ssh/sshd_config',
  }

  exec { 'reload-sshd':
    user        => root,
    command     => 'service sshd reload',
    path        => '/sbin/:/usr/sbin/:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:',
    subscribe   => File['/etc/ssh/sshd_config'],
    refreshonly => true,
  }
}
