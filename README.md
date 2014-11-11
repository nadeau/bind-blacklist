bind-blacklist
==============

Use Internet sources to blackhole Ads and malware providers
-----------------------------------------------------------

Inspiration and URL sources:

    https://github.com/dschuermann/ad-away/wiki/HostsSources (AdAway's sources)


Update and copy db.blackhole to your bind directory

    vi db.blackhole; cp db.blackhole /etc/bind/

Run the update script to create blackhole.conf

    update_blackhole.pl > blackhole.conf

Update named.conf to include db.blackhole

    include "/etc/bind/blackhole.conf";

Restart bind
