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
#BEGIN { use lib '../lib/CPAN/';  use_ok('MyConfig'); }  # BULK88: NEED REMOVE hard-coded directory 
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
