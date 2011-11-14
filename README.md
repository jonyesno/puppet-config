## Overview

This is a skeleton set of [Puppet](http://puppetlabs.com/) manifests for
bootstrapping a set of machines to do web-shaped things. It reflects my
personal preferences for system layout and operation. It may not suit yours.

## Manifest layout

The manifests are generally written along the lines of @ripienaar's [Simple
Puppet Module
Structure](http://www.devco.net/archives/2009/09/28/simple_puppet_module_structure.php).

## External Node Classifier

The script at <code>libexec/puppet-node.rb</code> is what Puppet calls an External Node
Classifier. Puppet invokes this script with the target machine's hostname and
receives a YAML response detailing the classes that should be applied to that
host along with parameters used in the manifests and templates.

Here, puppet-node.rb consults two YAML files:

 *  <code>/etc/puppet/systems.yml</code>
 *  <code>/etc/puppet/profiles.yml</code>

A server's entry in the systems file indicates its profile and provides the
host's parameters. The server's profile is the list of Puppet classes that is
uses. Both support a 'default' entry. For systems, the defaults are relative to
the server's environment (eg: 'production'). Profile defaults apply to all
systems.

See [External Nodes](http://docs.puppetlabs.com/guides/external_nodes.html) for
more details.

## Explicit process management

I tend to run services under explicit process management. These manifests run
daemons such as varnishd and varnishncsa under
[runit](http://smarden.org/runit/). Some daemons, such as Apache, aren't run
under runit. This is admittedly inconsistent, but Apache has never got me out
of the bed in the small hours for wholesale bombing out.

## Passwords and other sensitive data

Some simple passwords are present (eg: <code>nagios/files/passwd</code> for
Nagios CGI).  Consider changing these.  Some related placeholders are just
dummy files (eg: <code>apache/files/ca.pem</code> for <code>mod_ssl</code>).
These need real data in them for services to run.

## Thanks

I am grateful for the permission to share this work by several companies that I
have done systems configuration consultancy for, in particular [Portal47
Ltd](http://www.portal47.com/). All mistakes, ugly hacks and brokenness are
mine, of course. Mostly I'm sharing it so I don't have to keep rewriting it!

## License

Released under [ASL](http://www.opensource.org/licenses/Apache-2.0). See
LICENSE for details.

## Author

Jon Stuart, jon@zomo.co.uk, [Zomo Technology Ltd](http://www.zomo.co.uk), 2011.
