#!/bin/ksh

#=============================================================================
#
# webx.sh
# -------
#
# Start, stop, and run the monitor for WebX.
#
# R Fisher 03/2007
#
#=============================================================================

WEBX_DIR=/webx
PATH=/usr/bin

case $1 in

	"start")
		print "Starting webx"
		cd $WEBX_DIR
		/bin/sh ./make-run
		;;

	"stop")
		echo "Stopping webx"
		cd $WEBX_DIR
		/bin/sh ./make-quit 
		;;

	"monitor")

		if print GET /\n| telnet localhost 80 
		then
			exit 110
		else
			exit 100
		fi
		;;

	*)	print "Usage: $0 start|stop|monitor"
		exit 1
		;;

esac

