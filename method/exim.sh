#!/bin/ksh

#=============================================================================
#
# exim.sh
# -------
#
# Very rough and ready SMF method for exim. Doesn't do any PID file
# checking.
#
# R Fisher 2007
#
#=============================================================================

PATH=/usr/bin

EXIM_DIR="/usr/local/exim"
EXIM_CONF="$EXIM_DIR/etc/configure"
EXIM_PID="/var/spool/exim/exim-daemon.pid"

case "$1" in

	'start')
        ${EXIM_DIR}/bin/exim -bd -q10m
        ;;

	'stop')
		[[ -f $EXIM_PID ]] && kill $(head -1 $EXIM_PID)
        ;;

	'refresh')
        [[ -f $EXIM_PID ]] && kill -HUP $(head -1 $EXIM_PID)
        ;;


	*)	print "Usage: $0 start|stop|refresh"
        exit 1
        ;;

esac

