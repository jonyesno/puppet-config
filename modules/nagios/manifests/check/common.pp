class nagios::check::common {
  $service = 'site-service'
  $target = $::fqdn
}
