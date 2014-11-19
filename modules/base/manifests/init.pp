# == Class: base
#
# A collection of settings, packages, files and directories we want everywhere

class base {
  include base::cabundle
  include base::directories
  include base::packages
  include base::services
  include base::sysctl
}
