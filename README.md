# phonebook
Simple TCP/IP client/server in Perl for a "phonebook"


Execute

Launch Client.pl to execute the client.
Launch Server.pl to execute the server.

Add port and IP to client and server to connect each of them.

Protocol client message :
INSERT[name/email/phonenumber]
MODIFY|index|[name/email/phonenumber]
DELETE|index|[name/email/phonenumber]
SEARCH|index|
LIST


Protocol information :
[elem]  : information
/.../  : separator
|index| : index separator
ACTION  : action
index   : name OR email OR phone number 