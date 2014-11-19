define users::dotfile() {
  $split = split($name, ':')
  $user  = $split[0]
  $file  = $split[1]

  $home = $user ? {
    root    => '/root',
    default => "/home/${user}",
  }

  file { "${home}/.${file}":
    owner   => $user,
    group   => $user,
    mode    => '0644',
    source  => [ "puppet:///modules/users/dotfiles/${file}.${user}",
                 "puppet:///modules/users/dotfiles/${file}.default" ],
  }
}
