class puppetmaster {
  include puppetmaster::cron
  include puppetmaster::packages
  include puppetmaster::services
}
