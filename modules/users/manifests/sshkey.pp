define users::sshkey($home = "/home/${name}", $group = $name, $managekey = true) {
  file { "${home}/.ssh":
    ensure  => directory,
    mode    => '0700',
    owner   => $name,
    group   => $group,
  }
  file { "${home}/.ssh/authorized_keys":
    ensure  => present,
    mode    => '0600',
    owner   => $name,
    group   => $group,
    require => File["${home}/.ssh"],
    replace => $managekey,
    source  => [ "puppet:///modules/users/keys/${name}.key.${hostname}",
                 "puppet:///modules/users/keys/${name}.key.${environment}",
                 "puppet:///modules/users/keys/${name}.key.${profile}",
                 "puppet:///modules/users/keys/${name}.key" ],
  }
}
