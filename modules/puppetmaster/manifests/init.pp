class puppetmaster {
  include puppetmaster::config
  include puppetmaster::cron
  include puppetmaster::packages
  include puppetmaster::services
}
