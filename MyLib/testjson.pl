#!/usr/bin/perl
#testjson.pl

use	strict;
use	warnings;
use	JSON;

my	%contact = (
    name=> "",
    email=> "",
    phone=> "",
);

sub	openjson {
    my	$file;
    if (! -e "test.txt")
    {
	my	$file;
	open($file, ">>", "test.txt") or die "cannot opened file";
	retrun $file;
    }
    open($file, '>>', "test.txt") or die "file couldn't be opened, error : $!";
    return $file;
}

sub	parsjson {
    
}


$contact{name;email;phone} .= 'monique','test',"toto';
print $contact{name};
