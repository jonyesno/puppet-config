# -- Class: runit
class runit {
  include runit::directories
  include runit::fixups
  include runit::packages
  include runit::services
}
