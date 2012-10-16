#!/bin/ksh

#=============================================================================
#
# samba.sh
# --------
#
# Simple method to start Samba's smbd and nmbd daemons. The stopping is done
# through the SMF :kill method.
#
#=============================================================================

PATH=/usr/bin

BINDIR="/usr/local/samba/sbin"

. /lib/svc/share/smf_include.sh

ret=$SMF_EXIT_OK

# Start smbd, if that works, start nmbd

if [[ $1 == "start" ]]
then
    print -n "starting smbd: "

    if ${BINDIR}/smbd -D
    then
        print -n "ok\nstarting nmbd: "

        if ${BINDIR}/nmbd -D
        then
            print "ok"
        else
            print "failed"
            ret=1
        fi

    else
        print "failed. Not starting nmbd"
        ret=1
    fi

else
    print "usage: ${0##*/} start"
fi

exit $ret
