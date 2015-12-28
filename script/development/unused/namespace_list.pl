#!/usr/bin/perl
use strict;
use warnings;
use rperlnames;

use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

#package qui;
$qui::bat = 23;
$qui::bat += 42;

package pon;
my $baton = "hangy";

#use RPerl;

package main;
#print Dumper( rperlnames::namespaces_array() );
#print Dumper( rperlnames::namespaces_hash() );
#print Dumper( rperlnames::namespaces_hash_noncore() );
print Dumper( rperlnames::namespaces_hash_noncore_nonrperl() );
