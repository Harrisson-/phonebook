#!/usr/bin/perl
#server.pl

use MyLib;

my $port = get_port();
my $ip = get_ip();
my $sock = socket_server_init($ip, $port);
sock_read_server($sock);

# wait and Read Socket (server side)
# Parameter : Socket
# Return :
sub Sock_read_server {
    my $sock = @_[0];
    my $read_set = new->IO::Select();

    $read_set = add($sock);
    while(1)
    {
	my $rh_set = IO::Select->select($read_set, undef, undef, 0);
	foreach $rh (@$rh_set) {
	    if ($rh == $sock)
	    {
		my $ns = $rh->accept();
		$read_set->add($ns);
	    }
	    else
	    {
		my $buf = <$rh>;
		if ($buf)
		{
		    my $txt = pars_string($buf);
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
