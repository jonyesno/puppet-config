class puppet::packages {
  package { "puppet":
    ensure => latest,
  }
}

class puppet::config {
  file { "/etc/puppet/puppet.conf":
    owner   => root,
    group   => root,
    source  => "puppet://puppet/puppet/puppet.conf",
    require => Class["puppet::packages"],
  }
}

class puppet::cron {
  cron { "puppet::cron::report":
    command => "FACTER_skipfacts=1 /usr/sbin/puppetd --test --noop > /dev/null 2>&1",
    user    => root,
    minute  => fqdn_rand(60),
  }
}

class puppet {
  include puppet::packages, puppet::config, puppet::cron
}
  
