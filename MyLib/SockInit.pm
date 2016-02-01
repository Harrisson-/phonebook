#!/usr/bin/perl
#SockInit.pm

use strict;
use warnings;
use IO::Select;
use IO::Socket;


# Get Port
# Parameter : 
# Return : string(Port)
sub get_port {
    print "Entry Port :";
    my $port = <STDIN>;
    return ($port);
}

# Get IP
# Parameter :
# Return : string(IP)
sub get_ip {
    print "Entry IP :";
    my $ip = <STDIN>;
    return ($ip);
}

# Initialize Client Socket
# Parameter : string(Port), string(IP)
# Return : Socket
sub socket_server_init {
    my ($ip, $port) = @_;
    my $sock = new IO::Socket::INET(
	LocalHost => $ip,
	LocalPort => $port,
	Proto => "TCP",
	Listen => 5,
	Reuse => 1,
	);
    return ($sock or die "Problem Init server socket $!");  
}

# Initialize Server Socket
# Parameter : string(Port), string(IP)
# Return : Socket
sub socket_client_init {
    my ($ip, $port) = @_;
    print($ip);
    print($port);
    my $sock = new IO::Socket::INET(
	PeerHost => $ip,
	PeerPort => $port,
	Proto => "TCP",
	);
    return ($sock or die "Problem init client socket $!");
}

1;
