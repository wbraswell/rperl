#!/usr/bin/perl
use strict;  use warnings;

# TODO: add support for Test::Exception
use Test::More tests => 12;

BEGIN { diag("\n[[[ Beginning Dependency Tests ]]]\n ");	}
BEGIN { use_ok('Data::Dumper'); }
require_ok('Data::Dumper');

# DEPENDENCIES LIKELY FULFILLED BY SYSTEM-WIDE MODULES ABOVE THIS LINE
# DEPENDENCIES POSSIBLY FULFILLED BY USER-SPECIFIC MODULES BELOW THIS LINE

BEGIN { use lib '/tmp/RPerl-latest/lib/CPAN/';  use_ok('MyConfig'); }
require_ok('MyConfig');

BEGIN { use_ok('Parse::RecDescent'); }
require_ok('Parse::RecDescent');

BEGIN { use_ok('Inline'); }
require_ok('Inline');

#BEGIN { use_ok('Inline::C'); }  # It is invalid to use 'Inline::C' directly. Please consult the Inline documentation for more information. 
require_ok('Inline::C');

#BEGIN { use_ok('Inline::CPP'); }  # It is invalid to use 'Inline::CPP' directly. Please consult the Inline documentation for more information. 
require_ok('Inline::CPP');

BEGIN { use_ok('Inline::Filters'); }
require_ok('Inline::Filters');

=SNIP it is annoying to see the long failure message(s), even though we know it is inside a TODO block
TODO: 
{
	local $TODO = "RPerl pegex parser not yet implemented";	
#	BEGIN { use_ok('Pegex'); }  # NEED FIX: BEGIN block inside TODO block registers as real failure instead of TODO pseudo-failure
	require_ok('Pegex');
}
=cut