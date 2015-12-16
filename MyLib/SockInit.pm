#!/usr/bin/perl
#SockInit.pm

use strict;
use warnings;


sub get_port {
    print "Entry Port :";
    my $port = <STDIN>;
    return ($port);
}

sub get_ip {
    print "Entry IP :";
    my $ip = <STDIN>;
    return ($ip);
}

sub socket_server_init {
    my $sock = new(
	LocalHost = @_[0],
	LocalPort = @_[1],
	Proto = "TCP",
	Listen = 5,
	Reuse = 1,
	);
    return $sock OR die "Problem Init server socket";  
}

sub socket_client_init {
    my $sock = new (
	LocalHost = @_[0],
	LocalPort = @_[1],
	Proto = "TCP",
	);
    return $sock OR die "Problem init client socket";
}

sub Sock_read_server {

}

1;
