class mail::packages {
  package { 'postfix':  ensure => absent }
  package { 'sendmail': ensure => absent }
  package { 'exim':     ensure => latest }
}
