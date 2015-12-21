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
    my $sock = new IO::Socket::INET(
	LocalHost = @_[0],
	LocalPort = @_[1],
	Proto = "TCP",
	Listen = 5,
	Reuse = 1,
	);
    return $sock OR die "Problem Init server socket";  
}

# Initialize Server Socket
# Parameter : string(Port), string(IP)
# Return : Socket
sub socket_client_init {
    my $sock = new IO::Socket::INET(
	LocalHost = @_[0],
	LocalPort = @_[1],
	Proto = "TCP",
	);
    return $sock OR die "Problem init client socket";
}

1;
