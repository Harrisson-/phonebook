#!/usr/bin/perl
#Parser.pm

use strict;
use warnings;

use Data::Dumper;
use Cpanel::JSON::XS;
use Switch;

=pod
 [elem]  : information
 /.../  : separator
 |index| : index separator
 ACTION  : action
 index   : name OR email OR phone number
=cut

my	%contact = (
    name=> '',
    email=> '',
    phone=> '',
);


#OK
=pod
 Add information to hash
 Parameter : string(name), string(email), string(phone)
=cut
sub	complete_hash{
    $contact{name} = $_[0];
    $contact{email} = $_[1];
    $contact{phone} = $_[2];
}

#OK
=pod
 Verify if the phonebook file exist
 Parameter : 
 Return : Array(Phonebook Content)
=cut

sub	verify_file{
    my	$fh;
    my	$filename = "phonebook.json";
=pod
    if ( ! -e $filename)
    {
	print "-e filename";
	open($fh, '>>', $filename) or die "file couldn't be opened, error : $!";
	my @txt = <$fh>;
	close $fh;
	#   open($file, '<', $filename) or die "file couldn't be opened, error : $!";
	return(@txt, $filename);
    }
=cut
#    open($file, '>>', $filename) or die "file couldn't be opened, error : $!";
    open($fh, '<', $filename) or die "file couldn't be opened, error : $!";
    my @txt = <$fh>;
    close $fh;
    return ($filename, @txt);
}
  

#OK
=pod
 Send Client message to a good function
 Parameter : string(client message)
 Return : string
=cut
sub	pars_string{
    my ($cmd) = $_[0] =~ /(\w+)/i;
    switch ($cmd) {
	case ("INSERT") {return insert_contact(@_);}
	case ("MODIFY") {return modify_contact(@_);}
	case ("DELETE") {return delete_contact(@_);}
	case ("SEARCH") {return search_contact(@_);}
	case ("LIST") {return list_contact();}
	else {return "UNKNOW ACTION";}
    }
}

#OK
=pod
 Parse Protocole to get contact's information
 Parameter : string(client message)
 return : string(name), string(email), string(phone)
=cut
sub	get_perso_info{
    my ($name) = $_[0] =~ m/\[(\w+)/;
    my ($email) = $_[0] =~ /(?:\/(.*)\/)/;
    my ($phone) = $_[0] =~ /\/(\d+)\]/;
    return ($name, $email, $phone);
}

#OK
=pod
 Get index for search element
 Parameter : string
 return : string(index)
=cut
sub	get_index{
    return (my ($index) = $_[0] =~ /\|(\w+)\|/);
}

#OK
=pod
 Return json text from new hash contact
 Parameter : 
 Return : string(contact JSON)
=cut
sub	create_json_elem {
    return (encode_json(\%contact));
}

=pod
 Add
=cut
sub	append_in_json_file {
    my ($filename, $json, @txt) = @_;
    push @txt, $json;
    open(my $fh, '>', $filename) or die "error during appending json in file : $!";
    print $fh @txt;
    close $fh;
}
    
=pod
 INSERT[name/email/phonenumber]
 Insert new contact to phonebook
 Parameter : string
 return : string("OK" or "ERROR")
=cut
sub	insert_contact{
    my ($name, $email, $phone) = get_perso_info(@_);
    my ($filename, @txt) = verify_file();
    print "@txt";
    print "\n";
    complete_hash($name, $email, $phone);
    my ($json) = create_json_elem();
    append_in_json_file($filename, $json, @txt);
##insert elem
}

=pod
 Find Array with pattern match
 Parameter : string(JSON), string(index)
 return : integer(position in Array)
=cut
sub find_array {
    my (@txt, $index) = @_;
    my $size = @txt;
    for (my $i = 0; $i != $size; $i++)#index(@txt[i], $index) == -1) 
    {
        if (index(@txt[$i], $index) != -1) {
            return(@txt[$i]);
	}
    }
    return;
}

=pod
 MODIFY|index|[name/email/phonenumber]
 modify 1 contact to phonebook
 Parameter : string
 return : string("OK" or "ERROR")
=cut
sub	modify_contact{
    my ($name, $email, $phone) = get_perso_info(@_);
    my ($index) = get_index(@_);
    my @txt = verify_file();
#    complete_hash($name, $email, $phone);
    my ($find_result) = find_array(@txt, $index);
    print "$find_result\n";
#    splice(@txt, $find_result,1);
    
}

=pod
 DELETE|index|[name/email/phonenumber]
 delete 1 contact to phonebook
 Parameter : string
 return : string("OK" or "ERROR")
=cut
sub	delete_contact{
    my ($name, $email, $phone) = get_perso_info(@_);
    my $index = get_index(@_);
    my @txt = verify_file();
    my ($find_result) = find_array(@txt, $index);
    splice(@txt, $find_result,1);
}

=pod
 SEARCH|index|
 search 1 contact in phonebook
 Parameter : string
 return : string(contact information)
=cut
sub	search_contact{
    my $index =get_index(@_);
    my @txt = verify_file();
    my ($find_result) = find_array(@txt, $index);

    return $find_result;
}

=pod
 LIST
 list all contact in phonebook
 Parameter : string
 return : Array(all contact information)  
=cut
sub	list_contact{
    return(my @txt = verify_file());
}

1;
