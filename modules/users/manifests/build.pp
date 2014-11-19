class users::build {
  localuser { 'build':
    user     => 'build',
    comment  => 'package builder',
    uid      => 1000,
    groups   => 'build'
  }

  dotfile { [
    'build:gitconfig',
    'build:vimrc',
    ]: }
}
