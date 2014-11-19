#!/usr/bin/env bash
set -e

fail() {
  echo "[backup-mysql] error: $* ($?)"
  exit 1
}
trap fail ERR
trace() {
  echo "[backup-mysql] $*" >&2
}

STAMP=$( date '+%Y%m%d-%H%M%S' )
TOP=/var/lib/backup/mysql
ROOT="${TOP}/${STAMP}"
mkdir -p ${ROOT} || fail "couldn't create ${ROOT}"

cd ${ROOT}

DBS=$( mysql --batch --skip-column-names --execute 'show databases' | grep -v '_schema$' )

trace "starting at $( date )"
for DB in ${DBS} ; do
  OUT="${ROOT}/${DB}.sql.gz"
  trace "dumping ${DB} to ${OUT} at $( date )"
  mysqldump --quick --skip-lock-tables ${DB} | gzip -c > ${OUT}
  [[ ${PIPESTATUS[0]} -eq 0 ]] || fail "mysqldump failed for ${DB}"
done

trace "removing older backups"
find ${TOP}/ -type d -mtime +3 | xargs rm -Rfv 2> /dev/null || true

trace "ending at $( date )"

