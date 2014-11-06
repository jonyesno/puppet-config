class users::build {
  local-user { "build":
    user     => "build",
    comment  => "package builder",
    password => "XXX",
    uid      => 1000,
  }
}
