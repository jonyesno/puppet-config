define users::localuser($user,
  $comment,
  $uid,
  $password  = 'x',
  $groups    = [],
  $ensure    = 'present',
  $shell     = '/bin/sh',
  $managekey = true) {
  group { $user:
    ensure => present,
    gid    => $uid,
  }
  user { $user:
    ensure     => $ensure,
    uid        => $uid,
    gid        => $user,
    comment    => $comment,
    password   => $password,
    groups     => $groups,
    require    => [ Class['base::directories'], Group[$user] ],
    shell      => $shell,
    managehome => true,
  }
  file { "/home/${user}/tmp":
    ensure  => directory,
    mode    => '0755',
    owner   => $user,
    group   => $user,
  }

  users::sshkey { $user:
    managekey => $managekey,
  }

  dotfile { [
    "${user}:bashrc",
    ]: }

}
