class users {
  define local-user($user, $comment, $uid, $password = "x", $groups = "", $ensure = "present") {
      group { "${user}":
        ensure => present,
        gid    => $uid,
      }
      user { "${user}":
        ensure     => $ensure,
        uid        => $uid,
        gid        => $user,
        comment    => $comment,
        password   => $password,
        groups     => $groups,
        require    => Group[$user],
        managehome => true,
      }
      # http://projects.puppetlabs.com/issues/1099 - managehome is wonky
      file { "/home/${user}":
        ensure  => directory,
        mode    => 0755,
        owner   => $user,
        group   => $user,
        require => User[$user],
      }
      file { "/home/${user}/tmp":
        ensure  => directory,
        mode    => 0755,
        owner   => $user,
        group   => $user,
        require => File["/home/${user}"],
      }
      file { "/home/${user}/.ssh":
        ensure  => directory,
        mode    => 0700,
        owner   => $user,
        group   => $user,
        require => File["/home/${user}"],
      }
      file { "/home/${user}/.ssh/authorized_keys":
        ensure  => present,
        mode    => 0600,
        owner   => $user,
        group   => $user,
        require => File["/home/${user}/.ssh"],
        source  => ["puppet://puppet/modules/users/${user}.key.${hostname}",
                    "puppet://puppet/modules/users/${user}.key.${environment}",
                    "puppet://puppet/modules/users/${user}.key"]
      }

      dotfile { [
        "${user}:gitconfig",
        "${user}:vimrc",
        ]:
      }

    }

  define dotfile() {
    $split = split($name, ":")
    $user  = $split[0]
    $file  = $split[1]
    file { "/home/${user}/.${file}":
      require => [File["/home/${user}"]],
      owner   => $user,
      group   => $user,
      source  => "puppet://puppet/users/${file}",
    }
  }

  include users::sudo, users::path, users::shells
}

class users::shells {
  file { "/bin/rbash":
    ensure => symlink,
    target => "/bin/bash",
  }
}

class users::sudo {
  file { "/etc/sudoers":
    ensure => present,
    mode   => 0440,
    owner  => root,
    group  => root,
    source => "puppet://puppet/modules/users/sudoers",
  }
}

class users::path {
  file { "/etc/profile.d/path.sh":
    source => "puppet://puppet/modules/users/path.sh",
    owner  => root,
    group  => root,
  }
}
