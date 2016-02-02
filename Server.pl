#!/usr/bin/perl
#server.pl

use MyLib::SockInit;
use MyLib::Parser;
use IO::Socket;

my $port = get_port();
my $ip = get_ip();
my $sock = socket_server_init($ip, $port);
Sock_read_server($sock);

# wait and Read Socket (server side)
# Parameter : Socket
# Return :
sub Sock_read_server {
    my $ns;
    my ($sock) = @_;
    my $read_set = new IO::Select() or die "new IO::Select $!\n";
    $read_set->add($sock);
    while(1)
    {
	my ($rh_set) = IO::Select->select($read_set, undef, undef, 5);
	print "sock : $sock\n";
	foreach $rh (@$rh_set) {
	    print "in foreach\n";
	    if ($rh == $sock)
	    {
		print "$rh\n";
		my $ns = $rh->accept() or die "accept | $!\n";
		print"after accept\n";
		$read_set->add($ns);
	    }
	    else
	    {
		print "else\n";
		my $buf = <$rh>;
		if ($buf)
		{
		    #		    my $txt = pars_string($buf);
		    print($buff);
		}
		else
		{
		    $read_set->remove($rh);
		    close($rh);
		}
	    }
	}
    }
}
