#!/bin/ksh

. /lib/svc/share/smf_include.sh

BINDIR=/opt/graphite/bin

case $1 in
	'start')
        ${BINDIR}/carbon-cache.py start
        ;;

    'stop')
        ${BINDIR}/carbon-cache.py stop
        ;;

    *)
        print -u2 "Usage: ${0##*/} <start|stop>"
        exit $SMF_EXIT_ERR_FATAL
        ;;

esac

exit $SMF_EXIT_OK
