## Overview

This is a skeleton set of [Puppet](http://puppetlabs.com/) manifests for
bootstrapping a set of machines to do web-shaped things. It reflects my
personal preferences for system layout and operation. It may not suit yours.

This tree was overhauled in November 2014 to align with CentOS 7 systems and
the considerable change in Puppet practise and style since 2011. There's likely
still plenty of delinting to do.

## Manifest layout

The manifests are generally written along the lines of @ripienaar's [Simple
Puppet Module
Structure](http://www.devco.net/archives/2009/09/28/simple_puppet_module_structure.php).

## External Node Classifier and Hiera

The script at <code>bin/puppet-enc.rb</code> is what Puppet calls an External
Node Classifier. Puppet invokes this script with the target machine's hostname,
looks that up in <code>systems.yaml</code> and feeds that to Hiera to obtain
class lists and system parameters for use in the manifests and templates.

A utility script <code>bin/query-hiera.rb</code> can be used to check Hiera
lookups.

See [External Nodes](http://docs.puppetlabs.com/guides/external_nodes.html) and
[Hiera](https://docs.puppetlabs.com/hiera/1/index.html) for more details.

Hiera is configured with the [<code>hiera-eyaml</code>
backend](https://github.com/TomPoulton/hiera-eyaml) so that confidential
information (eg: X509 keys) can be stored in the repository.

## Thanks

I am grateful for the permission to share this work by several companies that I
have done systems configuration consultancy for, in particular [Portal47
Ltd](http://www.portal47.com/). All mistakes, ugly hacks and brokenness are
mine, of course. Mostly I'm sharing it so I don't have to keep rewriting it!

## License

Released under [ASL](http://www.opensource.org/licenses/Apache-2.0). See
LICENSE for details.

## Author

Jon Stuart, jon@zomo.co.uk, [Zomo Technology Ltd](http://www.zomo.co.uk), 2014.
