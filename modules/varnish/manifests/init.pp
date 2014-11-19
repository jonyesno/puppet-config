# -- Class: varnish
class varnish {
  include varnish::config
  include varnish::packages
  include varnish::services
  include varnish::scripts
  include nagios::check::varnish

  Class['varnish::packages'] -> Class['varnish::config']
  Class['varnish::config']   ~> Class['varnish::services']
}
