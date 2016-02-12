#!/usr/bin/perl
#server.pl

use MyLib::SockInit;
use MyLib::Parser;

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
       	foreach $rh (@$rh_set) {
	    if ($rh == $sock)
	    {
		my $ns = $rh->accept() or die "accept | $!\n";
		$read_set->add($ns);
	    }
	    else
	    {
		my $buf = <$rh>;
		if ($buf)
		{
		    my $txt = pars_string($buf);
		    print "$txt\n";
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
