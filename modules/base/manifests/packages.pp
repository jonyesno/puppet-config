class base::packages {
  package { [
    'bzip2',
    'git',
    'iotop',
    'ipmitool',
    'lockrun',
    'mailx',
    'man',
    'multitail',
    'pv',
    'screen',
    'smartmontools',
    'tar',
    'tcpdump',
    'telnet',
    'vim-enhanced',
    'yum-utils',
    ]:
    ensure  => latest,
  }

  package { 'logwatch':
    ensure => absent,
  }
}
