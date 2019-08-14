#!/bin/sh

# override default configuration
[ -n "$Log" ] && sed -i "s/^Log.*/Log $Log stdout/" /etc/tor/torrc
[ -n "$SocksPort" ] && sed -i "s/^SocksPort.*/SocksPort $SocksPort/" /etc/tor/torrc
[ -n "$NumEntryGuards" ] && sed -i "s/^NumEntryGuards.*/NumEntryGuards $NumEntryGuards/" /etc/tor/torrc

# apply additional configuration
[ -n "$CircuitBuildTimeout" ] && echo "CircuitBuildTimeout $CircuitBuildTimeout" >> /etc/tor/torrc
[ -n "$ControlPort" ] && echo "ControlPort $ControlPort" >> /etc/tor/torrc
[ -n "$HashedControlPassword" ] && echo "HashedControlPassword $HashedControlPassword" >> /etc/tor/torrc
[ -n "$CookieAuthentication" ] && echo "CookieAuthentication $CookieAuthentication" >> /etc/tor/torrc
[ -n "$NewCircuitPeriod" ] && echo "NewCircuitPeriod $NewCircuitPeriod" >> /etc/tor/torrc
[ -n "$CircuitBuildTimeout" ] && echo "CircuitBuildTimeout $CircuitBuildTimeout" >> /etc/tor/torrc
[ -n "$KeepalivePeriod" ] && echo "KeepalivePeriod $KeepalivePeriod" >> /etc/tor/torrc
[ -n "$ExcludeNodes" ] && echo "ExcludeNodes $ExcludeNodes" >> /etc/tor/torrc
[ -n "$ExcludeExitNodes" ] && echo "ExcludeExitNodes $ExcludeExitNodes" >> /etc/tor/torrc
[ -n "$ExitNodes" ] && echo "ExitNodes $ExitNodes" >> /etc/tor/torrc
[ -n "$StrictNodes" ] && echo "StrictNodes $StrictNodes" >> /etc/tor/torrc
#[ -n "$" ] && echo " $" >> /etc/tor/torrc


# start tor
su - tor -s /bin/sh -c "/usr/bin/tor -f /etc/tor/torrc"

