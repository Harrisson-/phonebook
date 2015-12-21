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
# Parameter : Array(name), Array(email), Array(phone)
# Return : Hash(contact)
sub	complete_hash{
    $contact{name} .= $_[0];
    $contact{email} .= $_[1];
    $contact{phone} .= $_[2];
    return %contact;
}

# Verify if the phonebook file exist
# Parameter : nothing
# Return : File handle
sub	verify_file{
    my	$file;
    my	$filename = "phonebook.data";
    if ( ! -e $filename)
    {
	#	open($file, '>>', $filename) or die "file couldn't be opened, error : $!";
	   open($file, '<', $filename) or die "file couldn't be opened, error : $!";
	   return(my @txt = <$file>);
    }
#    open($file, '>>', $filename) or die "file couldn't be opened, error : $!";
    open($file, '<', $filename) or die "file couldn't be opened, error : $!";
    return(my @txt = <$file>);
}
  

# Send Client message to a good function
# Parameter : 1 String
# Return : 1 String
sub	pars_string{

    switch (@_[0]) {
	case (/\w+/ eq "INSERT") {return insert_contact(@_[0]);}
	case (/\w+/ eq "MODIFY") {return modify_contact(@_[0]);}
	case (/\w+/ eq "DELETE") {return delete_contact(@_[0]);}
	case (/\w+/ eq "SEARCH") {return search_contact(@_[0]);}
	case (/\w+/ eq "LIST") {return list_contact()}
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
sub	insert_contact{
    my ($name, $email, $phone) = get_perso_info(@_[0]);
    my @txt = verify_file();
    complete_hash($name, $email, $phone);
##insert elem
}

# Find Array with pattern match
# Parameter : Array(JSON), Array(index)
# return : index(position in Array)
sub find_array {
   for ( my $i = 0; i != @_[0]; i++)#index(@txt[i], $index) == -1) 
    {
        if (index(@_[0][i], @_[1]) != -1)
            return(i);
    }
    return;
}

# MODIFY|index|[name/email/phonenumber]
# modify 1 contact to phonebook
# Parameter : 1 String
# return : 1 string  
sub	modify_contact{
    my ($name, $email, $phone) = get_perso_info(@_[0]);
    my $index = get_index(@_[0]);
    my @txt = verify_file();
    complete_hash($name, $email, $phone);
    my $find_result = find_array(@txt, $index);
    splice(@txt, $find_result,1);
    
}

# DELETE|index|[name/email/phonenumber]
# delete 1 contact to phonebook
# Parameter : 1 String
# return : 1 string
sub	delete_contact{
    my ($name, $email, $phone) = get_perso_info(@_[0]);
    my $index = get_index(@_[0]);
    my @txt = verify_file();
    my $find_result = find_array(@txt, $index);
    splice(@txt, $find_result,1);
}

# SEARCH|index|
# search 1 contact in phonebook
# Parameter : 1 String
# return : 1 string  
sub	search_contact{
    my $index =get_index(@_[0]);
    my @txt = verify_file();
    my $find_result = find_array(@txt, $index);

    return $result;
}

# LIST
# list all contact in phonebook
# Parameter : 1 String
# return : 1 string  
sub	list_contact{
    return(my @txt = verify_file());
}

1;
