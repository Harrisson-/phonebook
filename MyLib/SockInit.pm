#!/usr/bin/perl
#SockInit.pm

use strict;
use warnings;
use IO::Select;
use IO::Socket::INET;

=pod
 Get Port
 Parameter : 
 Return : string(Port)
=cut
sub get_port {
#    print "Entry Port :";
    my $port = "5000";
#    my $port = <STDIN>;
    return ($port);
}

=pod
 Get IP
 Parameter :
 Return : string(IP)
=cut
sub get_ip {
#    print "Entry IP :";
    my $ip = "127.0.0.1";
#    my $ip = <STDIN>;
    return ($ip);
}

=pod
 Initialize Client Socket
 Parameter : string(Port), string(IP)
 Return : Socket
=cut
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

=pod
 Initialize Server Socket
 Parameter : string(Port), string(IP)
 Return : Socket
=cut
sub socket_client_init {
    my ($ip, $port) = @_;
    my $sock = new IO::Socket::INET(
	PeerHost => $ip,
	PeerPort => $port,
	Proto => "TCP",
	);
    return ($sock or die "Problem init client socket $!");
}

1;
