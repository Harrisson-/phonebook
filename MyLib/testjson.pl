#!/usr/bin/perl
#testjson.pl

use	strict;
use	warnings;
use	JSON;
use	Data::Dumper;

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


$contact{name} .= 'monique';
$contact{email} .= 'iekioek@kerij';
$contact{phone} .= '056156';
#my $json = encode_json \%contact;
#open my $test, ">>", "json.data";
#print $test $json;
#print $contact{name};
open my $test, "<", "json.data"; 
#my @contact = decode_json($test);
my @toto = <$test>;
print Dumper(@contact);
#my $txt = decode_json($test);
#print Dumper($txt);

#%contact .= (name => 'monique', -email => 'test', -phone => 'toto');
#print %contact;
#my @test = keys %contact;
#print $test[2];
