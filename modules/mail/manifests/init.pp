class mail {
  include mail::config
  include mail::packages
  include mail::services

  Class['mail::packages'] ~> Class['mail::config']
  Class['mail::config']   ~> Class['mail::services']
}
