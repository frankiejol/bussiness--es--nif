# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Business-ES-NIF.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 162;
use warnings;
use strict;
BEGIN { use_ok('Business::ES::NIF') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

# two real random NIFs from BOE 2005 belong to real people but are public

for my $nif(qw(75761039M 31228142F 26449509S)) {

	my ($dni,$lletra) = $nif =~ /^(\d{8})(\w)$/;
	
	ok(uc(code_nif($dni)) eq uc($lletra));
	ok(valid_nif("$dni$lletra"));
	
	ok(valid_nif(uc("$dni$lletra")));
	
	for ( 'a'..'z' ) {
		next if lc($_) eq lc($lletra);
		ok( !valid_nif($dni."$_"));
		ok( !valid_nif($dni.uc($_)));
	}
}

eval {
	code_nif();
};
ok($@ =~ /Missing dni/);

eval {
	code_nif('a');
};
ok($@ =~ /Invalid DNI 'a'/);
