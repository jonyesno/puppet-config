class puppetmaster::cron {
  cron { 'clean-puppet-reports':
    command => '/usr/bin/find /var/lib/puppet/reports/ -mtime +7 -name "*.yaml" | /usr/bin/xargs /bin/rm > /dev/null 2>&1',
    user    => puppet,
    hour    => 03,
    minute  => 00,
  }
}
