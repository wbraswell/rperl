package types;
use strict;
use warnings;

# [[[ NON-RPERL MODULES ]]]
use File::Copy qw(move);

# all following type lists lowest-to-highest level

# [[[ CODE ]]]
use RPerl::Code::Subroutine;

# [[[ OBJECT-ORIENTED ]]]
use RPerl::Class;
use RPerl::Object;
use RPerl::DataStructure::Property;
use RPerl::Code::Subroutine::Method;  # Data Types & Structures Are Implemented As Classes With Methods, etc.

# [[[ DATA TYPES ]]]
use RPerl::DataType::Void;
use RPerl::DataType::Integer;
use RPerl::DataType::Float;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;
use RPerl::DataType::Scalar;
use RPerl::DataType::Unknown;

# [[[ DATA STRUCTURES ]]]
use RPerl::DataStructure::Array;
use RPerl::DataStructure::Hash;
#use RPerl::DataStructure::LinkedList;
#use RPerl::DataStructure::LinkedList::Node;
#use RPerl::DataStructure::Graph;
#use RPerl::DataStructure::Graph::Tree;
#use RPerl::DataStructure::Graph::Tree::Binary;
#use RPerl::DataStructure::Graph::Tree::Binary::Node;

# [[[ C++ TYPE CONTROL ]]]
package RPerl;  if (not(defined($RPerl::INCLUDE_PATH))) { our $INCLUDE_PATH = '/FAILURE/BECAUSE/RPERL/INCLUDE/PATH/NOT/YET/SET'; }  1;  # suppress warnings about typo in types_enable() below
package types;
#our void $types_input_enable = sub { (my $types_input) = @_;  # NEED FIX: RPerl typed functions not working in types.pm, must call as normal Perl function
sub types_enable { (my $types_input) = @_;
;
	print "in types::types_enable(), received \$types_input = '$types_input'\n";
	
	my string $types_h_filename = $RPerl::INCLUDE_PATH . '/types_mode.h';
#	my bool $types_h_modified = 0;
	my integer $types_h_modified = 0;
	
	print "in types::types_enable(), have \$types_h_filename = '$types_h_filename'\n";
	
	open(my $TYPES_H_FILEHANDLE_IN,'<', $types_h_filename) or die("Can't read types_mode.h input file: $!, dying");
	open(my $TYPES_H_FILEHANDLE_OUT,'>', ($types_h_filename . '.swap')) or die("Can't write types_mode.h.swap output file: $!, dying");

	while(defined(my $line_current = <$TYPES_H_FILEHANDLE_IN>))
	{
		my string $types_current;
	
		print "in types::types_enable(), have \$line_current =\n$line_current";
		if ($line_current =~ /\#\s*define\s+\_\_(\w+)\_\_TYPES/)
		{
			$types_current = $1;
			print "in types::types_enable(), FOUND $types_current TYPES DEFINITION\n";
			
			if ($line_current =~ /^\s*\/\//)
			{
				print "in types::types_enable(), FOUND $types_current TYPES DISABLED\n";
				if ($types_current eq $types_input)
				{
					print "in types::types_enable(), ENABLE $types_current TYPES\n";
					$line_current =~ s/\/\///;  # remove first occurence of // comment
					$types_h_modified = 1;
				}
			}
			elsif ($line_current =~ /^\s*\#\s*define/)
			{
				print "in types::types_enable(), FOUND $types_current TYPES ENABLED\n";
				if ($types_current ne $types_input)
				{
					print "in types::types_enable(), DISABLE $types_current TYPES\n";
					$line_current = '//' . $line_current;
					$types_h_modified = 1;
				}
			}
			else
			{
				close($TYPES_H_FILEHANDLE_OUT);
				die('Found invalid __$types_current__TYPES definition in types_mode.h, neither properly disabled nor enabled, dying');
			}
		}
		print $TYPES_H_FILEHANDLE_OUT $line_current;
	}

	close($TYPES_H_FILEHANDLE_OUT);
	
	if ($types_h_modified)
	{
		move($types_h_filename, ($types_h_filename . '.orig')) or die("Can't move types_mode.h input file to types_mode.h.orig: $!, dying");
		move(($types_h_filename . '.swap'), $types_h_filename) or die("Can't move types_mode.h.swap output file to types_mode.h: $!, dying");
	}
	
	return();
#};
}


1;
