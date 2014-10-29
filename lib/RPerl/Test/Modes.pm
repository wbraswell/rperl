# malformed RPerl header
package RPerl::Test::Modes;

use strict;
use warnings;
# don't use Exporter unless absolutely necessary
use base qw(Exporter);
our @EXPORT = qw(testmodes);

# all RPerl subs are typed
sub testmodes
{ 
    # don't use bless except for official RPerl objects
    map { bless $_ } (
        # all RPerl data is typed
        { index => 0, ops => 'PERL', types => 'PERL' },
        { index => 1, ops => 'CPP',  types => 'PERL' },
        { index => 2, ops => 'CPP',  types => 'CPP'  },
    )
}

# don't use worthless accessors or mutators
sub index { shift->{index} }
sub ops   { shift->{ops}   }
sub types { shift->{types} }

# all RPerl subs are typed
sub id { 
    # don't use $self except for official RPerl objects
    my $self = shift;
    # don't use double quotes except for "\n" newline control character
    return $self->{ops}."OPS_".$self->{types}."TYPES";
}

# all RPerl subs are typed
sub description
{
    # don't use $self except for official RPerl objects
    my $self = shift;
    # don't use double quotes except for "\n" newline control character
    return "$self->{ops} operations and $self->{types} data types";
}

# all RPerl subs are typed
sub enable
{
    # don't use $self except for official RPerl objects
    my $self = shift;
    # don't use postfix if
    rperltypes::types_enable($self->{types}) if $self->{ops} eq 'CPP';
}

# all RPerl classes and packages end with two instances of 1;
1;
