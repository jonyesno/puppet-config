#!/bin/sh

BASE=$( dirname $0 )
LOCAL_MODULES="${BASE}/../modules"
SITE="${BASE}/../manifests/site.pp"

ENC="--external_nodes=/root/puppet/bin/puppet-enc.rb --node_terminus=exec"
HIERA="--hiera_config=/root/puppet/hiera.yaml"
MODULES="--modulepath=${LOCAL_MODULES}:/root/puppet/library"

if [ "$1" = 'local' ] ; then
  shift
  echo puppet apply ${ENC} ${HIERA} ${MODULES} --show_diff ${SITE} $*
  # https://tickets.puppetlabs.com/browse/PUP-3258
  puppet apply ${ENC} ${HIERA} ${MODULES} --show_diff < ${SITE} $*
else
  puppet agent --test $*
fi
