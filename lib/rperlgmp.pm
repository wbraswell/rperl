# [[[ HEADER ]]]
package  # hide from PAUSE indexing
    rperlgmp; ## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ INCLUDES ]]]
#use rperltypes;
use RPerl::DataType::GMPInteger;
use RPerl::Operation::Expression::Operator::GMPFunctions;

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT = qw(
    gmp_integer_CHECK gmp_integer_CHECKTRACE
    gmp_integer_to_boolean gmp_integer_to_unsigned_integer gmp_integer_to_integer gmp_integer_to_number gmp_integer_to_character gmp_integer_to_string
    boolean_to_gmp_integer integer_to_gmp_integer unsigned_integer_to_gmp_integer number_to_gmp_integer character_to_gmp_integer string_to_gmp_integer
    gmp_init gmp_init_set_unsigned_integer gmp_init_set_signed_integer
    gmp_set gmp_set_unsigned_integer gmp_set_signed_integer gmp_set_number gmp_set_string
    gmp_get_unsigned_integer gmp_get_signed_integer gmp_get_number gmp_get_string
    gmp_add gmp_sub gmp_mul gmp_mul_unsigned_integer gmp_mul_signed_integer gmp_sub_mul_unsigned_integer gmp_add_mul_unsigned_integer gmp_neg
    gmp_div_truncate_quotient
    gmp_cmp
);



# START HERE: figure out how to get gmp_integer_CHECK*() enabled as rperltypes::gmp_integer_CHECK*() for automatic use by subroutine type-check code in Class.pm
# START HERE: figure out how to get gmp_integer_CHECK*() enabled as rperltypes::gmp_integer_CHECK*() for automatic use by subroutine type-check code in Class.pm
# START HERE: figure out how to get gmp_integer_CHECK*() enabled as rperltypes::gmp_integer_CHECK*() for automatic use by subroutine type-check code in Class.pm


=DISABLED_NEED_FIGURE_OUT
package
    rperltypes;

#require rperltypes;
use rperlgmp;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = ( 
#@rperltypes::EXPORT = (
    @rperltypes::EXPORT,
    @rperlgmp::EXPORT,
);
our @EXPORT_OK = ( 
#@rperltypes::EXPORT_OK = (
    @rperltypes::EXPORT_OK,
    @rperlgmp::EXPORT_OK,
);

#use Data::Dumper;
#print 'in rperltypes, have @rperltypes::EXPORT = ', Dumper(\@rperltypes::EXPORT), "\n";
#die 'TMP DEBUG';

=cut

1;  # end of package
