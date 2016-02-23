#!/usr/bin/perl
#Parser.pm

use strict;
use warnings;

use JSON;
use Switch;

# [elem]  : information
# /.../  : separator
# |index| : index separator
# ACTION  : action
# index   : name OR email OR phone number

my	%contact = (
    name=> '',
    email=> '',
    phone=> '',
);


# Add information to hash
# Parameter : string(name), string(email), string(phone)
# Return : Hash(contact)
sub	complete_hash{
    $contact{name} = $_[0];
    $contact{email} = $_[1];
    $contact{phone} = $_[2];
    return %contact;
}

# Verify if the phonebook file exist
# Parameter : 
# Return : Array(Phonebook Content)
sub	verify_file{
    my	$file;
    my	$filename = "phonebook.json";
    if ( ! -e $filename)
    {
		open($file, '>>', $filename) or die "file couldn't be opened, error : $!";
	#   open($file, '<', $filename) or die "file couldn't be opened, error : $!";
	   return(my @txt = <$file>);
    }
#    open($file, '>>', $filename) or die "file couldn't be opened, error : $!";
    open($file, '<', $filename) or die "file couldn't be opened, error : $!";
    return(my @txt = <$file>);
}
  

# Send Client message to a good function
# Parameter : string(client message)
# Return : string
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

# Parse Protocole to get contact's information
# Parameter : string(client message)
# return : string(name), string(email), string(phone)
sub	get_perso_info{
    my ($name) = $_[0] =~ m/\[(\w+)/;
    my ($email) = $_[0] =~ /(?:\/(.*)\/)/;
    my ($phone) = $_[0] =~ /\/(\d+)\]/;
    return ($name, $email, $phone);
}

# Get index for search element
# Parameter : string
# return : string(index)
sub	get_index{
    return (my ($index) = $_[0] =~ /\|(\w+)\|/);
}

# INSERT[name/email/phonenumber]
# Insert new contact to phonebook
# Parameter : string
# return : string("OK" or "ERROR")
sub	insert_contact{
    my ($name, $email, $phone) = get_perso_info(@_);
    my @txt = verify_file();
    complete_hash($name, $email, $phone);
##insert elem
}

# Find Array with pattern match
# Parameter : string(JSON), string(index)
# return : integer(position in Array)
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

# MODIFY|index|[name/email/phonenumber]
# modify 1 contact to phonebook
# Parameter : string
# return : string("OK" or "ERROR")  
sub	modify_contact{
    my ($name, $email, $phone) = get_perso_info(@_);
    my $index = get_index(@_);
    my @txt = verify_file();
    complete_hash($name, $email, $phone);
    my ($find_result) = find_array(@txt, $index);
    splice(@txt, $find_result,1);
    
}

# DELETE|index|[name/email/phonenumber]
# delete 1 contact to phonebook
# Parameter : string
# return : string("OK" or "ERROR")
sub	delete_contact{
    my ($name, $email, $phone) = get_perso_info(@_);
    my $index = get_index(@_);
    my @txt = verify_file();
    my ($find_result) = find_array(@txt, $index);
    splice(@txt, $find_result,1);
}

# SEARCH|index|
# search 1 contact in phonebook
# Parameter : string
# return : string(contact information)
sub	search_contact{
    my $index =get_index(@_);
    my @txt = verify_file();
    my ($find_result) = find_array(@txt, $index);

    return $find_result;
}

# LIST
# list all contact in phonebook
# Parameter : string
# return : Array(all contact information)  
sub	list_contact{
    return(my @txt = verify_file());
}

1;
