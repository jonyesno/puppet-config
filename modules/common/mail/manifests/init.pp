class mail::packages {
  package { "postfix":
    ensure => absent,
    require => Package["exim"],
  }
  package { "exim":
    ensure  => present,
  }
}
  
class mail {
  include mail::packages
}
