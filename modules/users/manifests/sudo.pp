class users::sudo {
  file { '/etc/sudoers':
    ensure  => present,
    mode    => '0440',
    owner   => root,
    group   => root,
    content => template('users/sudoers.erb'),
  }
}
