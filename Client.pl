#!/usr/bin/perl
#client.pl

use MyLib;

my $port = get_port();
my $ip = get_ip();
my $sock = socket_client_init($ip, $port);
