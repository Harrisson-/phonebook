#!/usr/bin/perl
#client.pl

use MyLib;

my $port = get_port();
my $ip = get_ip();
my $sock = socket_client_init($ip, $port);

my $mess = <STDIN>;
$sock->send($mess);
shutdown($sock, 1);
$sock->recv(my $rep, 1024);
print("$rep");
$sock->close();
