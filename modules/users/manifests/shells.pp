class users::shells {
# package { 'zsh':
#   ensure => latest,
# }
  file { '/bin/rbash':
    ensure => symlink,
    target => '/bin/bash',
  }
}
