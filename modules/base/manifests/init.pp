# == Class: base
#
# A collection of settings, packages, files and directories we want everywhere

class base {
  include base::cabundle
  include base::config
  include base::directories
  include base::ipmi
  include base::packages
  include base::services
}
