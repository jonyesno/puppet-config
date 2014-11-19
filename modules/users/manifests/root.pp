class users::root {
  file { '/root/.bashrc':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0444',
    source => 'puppet:///modules/users/bashrc.root',
  }
}
