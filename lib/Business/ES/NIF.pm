package Business::ES::NIF;

use 5.010001;
use strict;
use warnings;
use Carp qw(croak);

require Exporter;
use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Business::ES::NIF ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	code_nif valid_nif
);

our $VERSION = '0.01';

my %NIF = (
    0 => 'T', 1 => 'R', 2 => 'W', 3 => 'A', 4 => 'G', 5 => 'M',
    6 => 'Y', 7 => 'F', 8 => 'P', 9 => 'D', 10 => 'X', 11 => 'B',
    12 => 'N', 13 => 'J', 14 => 'Z', 15 => 'S', 16 => 'Q', 17 => 'V',
    18 => 'H', 19 => 'L', 20 => 'C', 21 => 'K', 22 => 'E',
);

my $DIVISOR = 23;


=head1 NAME

Business::ES::NIF - Validate Spanish NIF ( Número de Identificación Fiscal )

=begin readme

=head1 INSTALATION

INSTALLATION

To install this module type the following:

   perl Makefile.PL
   make
   make test
   make install

=head1 DEPENDENCIES


None

=end readme

=head1 SYNOPSIS


  use Business::ES::NIF;

  if (valid_nif($nif)) {
    ...
  }

  print code_nif($dni); # return code character from dni.
                        # Documento Nacional de Identidad

=head1 DESCRIPTION


Validates a nif or returns the character code from a dni.

=head1 FUNCTIONS


=head2 valid_nif

Validates Spanish NIFs.
Returns a true value if the validation succeeds, a false one otherwise.


  if (valid_nif($nif)) {
    ....
  }

=cut

sub valid_nif {
	my $nif = shift or croak "Missing nif\n";
	return undef unless $nif =~ /^(\d{8})(\w)$/;

	my ($dni,$code) = ($1,$2);

	return uc($code) eq uc(code_nif($dni));
}

=head2 code_nif

Returns NIF code from DNI number. ( Documento Nacional de Identidad ).

  my $code = code_nif($dni);

=cut

sub code_nif {
	my $dni = shift 				or croak "Missing dni\n";
	croak "Invalid DNI '$dni'"		unless $dni =~ /^\d{8}$/;

	my $code = $NIF{ $dni % $DIVISOR };

	croak "Unknown code for $dni"	unless $code;	# quite unlikely
	return $code;
}
=head1 SEE ALSO


=head1 AUTHOR

Francesc Guasch, E<lt>frankie@etsetb.upc.eduE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Francesc Guasch

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.


=cut

1;
__END__
