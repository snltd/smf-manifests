#!/bin/ksh

#=============================================================================
#
# static_routes.sh
# ----------------
#
# Examine a file for a routing table, and add or delete the routes therein.
#
# There is a problem in that currently the zones service exits before zones
# are fully up. That is, before their interfaces are UP. Even though the
# SMF service that runs this script is dependent on zones, this means this
# method may be run before the network is visible, so it will fail. For that
# reason, there's a horrible hack coming...
#
#
# R Fisher 03/07
#
#=============================================================================

ROUTEFILE="/etc/static_routes"

PATH=/usr/bin:/usr/sbin

# smf_is_globalzone is only in Solaris 11

.  /lib/svc/share/smf_include.sh

#smf_is_globalzone || print "zone is not global" | smf_console

case $1 in

	"start")
		grep ^[0-9d] $ROUTEFILE | while read dest gate
		do
			try=1

			while [[ $try -lt 3 ]]
			do

				if ifconfig -a | egrep -s ${gate%.*}
				then
					route add $dest $gate
					break
				else
					print "waiting for interface for $gate"
					sleep 20
					try=$((try + 1))
				fi

			done

		done
		;;

	"stop")
		grep ^[0-9d] $ROUTEFILE | while read dest gate
		do
			route delete $dest $gate
		done
		;;

	*)	print "usage: ${0##*/} start|stop"
		;;

esac

