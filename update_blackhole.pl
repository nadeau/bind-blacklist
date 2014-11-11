#!/usr/bin/perl -w

use LWP::Simple;

our @URLs = ( 'http://adaway.sufficientlysecure.org/hosts.txt',
	      'http://winhelp2002.mvps.org/hosts.txt',
	      'http://hosts-file.net/ad_servers.asp',
	      'http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext',
	      'http://www.malwaredomainlist.com/hostslist/hosts.txt',
	      'http://adblock.gjtech.net/?format=unix-hosts' );

our %done;
our %domains;

foreach my $url ( @URLs )
{
    warn "Fetching $url\n";

    my $content = get $url
	or die "Can't fetch $url";

    foreach my $line ( split /^/, $content )
    {
	$domains{ lc $1 }++ if $line =~ /127.0.0.1\s+(\S+)/;
	print STDERR '.';
    }

    print STDERR "\n";
}

delete $domains{localhost};

foreach my $domain ( sort keys %domains )
{
    print 'zone "',$domain,'" { type master; notify no; file "/etc/bind/db.blackhole"; };' . "\n";
}
