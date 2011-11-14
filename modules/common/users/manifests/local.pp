class users::local {
  local-user { "build":
    user     => "build",
    comment  => "build",
    password => 'XXX',
    uid      => 1000,
    groups   => "wheel",
  }
}
