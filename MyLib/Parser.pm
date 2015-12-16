#!/usr/bin/perl
#Parser.pm

use strict;
use warnings;

use JSON;
use Switch;

# [elem]  : information
# /elem/  : separator
# |index| : index separator
# ACTION  : action
# index   : name OR email OR phone number

my	$contact = {
    'name'=> '',
    'email'=> '',
    'phone'=> '',
}


# Verify if the phonebook file exist
# Parameter : nothing
# Return : File handle
sub	verify_file{
    my	$file;
    my	$filename = "phonebook.data";
    if ( ! -e $filename)
    {
	open($file, '>>', $filename) or die "file couldn't be opened, error : $!";
	return $file;
    }
    open($file, '>>', $filename) or die "file couldn't be opened, error : $!";
    return $file;
}
  

# Send Client message to a good function
# Parameter : 1 String
# Return : 1 String
sub	pars_string{

    switch (@_[0]) {
	case (/\w+/ eq "INSERT") {return insert(@_[0])}
	case (/\w+/ eq "MODIFY") {return modify(@_[0])}
	case (/\w+/ eq "DELETE") {return delete(@_[0])}
	case (/\w+/ eq "SEARCH") {return search(@_[0])}
	case (/\w+/ eq "LIST") {return list()}
	else {return "UNKNOW ACTION"}
    }
}

# Parse Protocole to get contact's information
# Parameter : 1 String
# return : 3 different strings
sub	get_perso_info{
    my $name = @_[0] =~ \/{1}(\w+);
    my $email = @_[0] =~ \/{1}(\w+);
    my $phone = @_[0] =~ \/(\d+);
    return (\$name, \$email, \$phone);
}

# Get index for search element
# Parameter : 1 String
# return : 1 string
sub	get_index{
    return (my $index = @_[0] =~ \|(\w+)\|);
}

# INSERT[name/email/phonenumber]
# Insert new contact to phonebook
# Parameter : 1 String
# return : 1 string
sub	insert{
    my ($name, $email, $phone) = get_perso_info(@_[0]);
    
##insert elem
}

# MODIFY|index|[name/email/phonenumber]
# modify 1 contact to phonebook
# Parameter : 1 String
# return : 1 string  
sub	modify{
    my ($name, $email, $phone) = get_perso_info(@_[0]);
    my $index = get_index(@_[0]);
}

# DELETE|index|[name/email/phonenumber]
# delete 1 contact to phonebook
# Parameter : 1 String
# return : 1 string
sub	delete{
    my ($name, $email, $phone) = get_perso_info(@_[0]);
    my $index =get_index(@_[0]);
}

# SEARCH|index|
# search 1 contact in phonebook
# Parameter : 1 String
# return : 1 string  
sub	search{
    my $index =get_index(@_[0]);
    ##recup JSON txt
    if ()
    return $result;
}

# LIST
# list all contact in phonebook
# Parameter : 1 String
# return : 1 string  
sub	list{
    
}

1;
