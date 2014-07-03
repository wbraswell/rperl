########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.182.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'Grammar.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package Grammar;
use strict;

push @Grammar::ISA, 'Parse::Eyapp::Driver';




BEGIN {
  # This strange way to load the modules is to guarantee compatibility when
  # using several standalone and non-standalone Eyapp parsers

  require Parse::Eyapp::Driver unless Parse::Eyapp::Driver->can('YYParse');
  require Parse::Eyapp::Node unless Parse::Eyapp::Node->can('hnew'); 
}
  

sub unexpendedInput { defined($_) ? substr($_, (defined(pos $_) ? pos $_ : 0)) : '' }

#line 1 "Grammar.eyp"

#    package RPerl::Grammar; NEED FIX: what package name?
    use strict;
    use warnings;
    our $VERSION = 0.000_100;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      m{\G(\s+)}gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties|our\ \$VERSION\ \=|for\ my\ integer|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|use\ Carp\;|\=\ sub\ \{|package|while|elsif|else|\-\>\[|qw\(|\-\>\{|use|our|my|\)\;|\}\;|if|\@\{|\.\.|\=\>|\-\>|\%\{|1\;|\,|\)|\}|\(|\;|\]|\{|\=|\[|\:)}gc and return ($1, $1);

      /\G^(\#\!\/[\w\/]*\/perl)$/gc and return ('SHEBANG', $1);
      /\G[a-zA-Z]\w*/gc and return ('WORD', $1);
      /\G[a-zA-Z][\w(::)]*/gc and return ('WORD_SCOPED', $1);
      /\G\d+\.\d{3}\_\d{3}/gc and return ('VERSION_NUMBER', $1);
      /\G(-?\d+(\.\d+)?)|('[^']*')/gc and return ('LITERAL', $1);
      /\G\$[a-zA-Z]\w*/gc and return ('VARIABLE_SYMBOL', $1);
      /\G[a-z][a-z_]*[a-z]/gc and return ('TYPE', $1);
      /\Gor|xor/gc and return ('OPERATOR_SYMBOL_24', $1);
      /\Gand/gc and return ('OPERATOR_SYMBOL_23', $1);
      /\Gnot/gc and return ('OPERATOR_SYMBOL_22', $1);
      /\Gnext|last/gc and return ('OPERATOR_SYMBOL_19a', $1);
      /\G=|\+=|-=|\*=|\/=/gc and return ('OPERATOR_SYMBOL_19', $1);
      /\G\.\./gc and return ('OPERATOR_SYMBOL_17', $1);
      /\G\|\|/gc and return ('OPERATOR_SYMBOL_16', $1);
      /\G&&/gc and return ('OPERATOR_SYMBOL_15', $1);
      /\G\||\^/gc and return ('OPERATOR_SYMBOL_14', $1);
      /\G&/gc and return ('OPERATOR_SYMBOL_13', $1);
      /\G==|!=|eq|ne/gc and return ('OPERATOR_SYMBOL_12', $1);
      /\G<|>|<=|>=|lt|gt|le|ge/gc and return ('OPERATOR_SYMBOL_11', $1);
      /\G[a-z]+/gc and return ('OPERATOR_SYMBOL_10', $1);
      /\G<<|>>/gc and return ('OPERATOR_SYMBOL_09', $1);
      /\G\+|-|\./gc and return ('OPERATOR_SYMBOL_08', $1);
      /\G\*|\/|\%/gc and return ('OPERATOR_SYMBOL_07', $1);
      /\G!|-/gc and return ('OPERATOR_SYMBOL_05', $1);
      /\G\*\*/gc and return ('OPERATOR_SYMBOL_04', $1);
      /\G\+\+|--/gc and return ('OPERATOR_SYMBOL_03', $1);
      /\G[a-zA-Z]\w*/gc and return ('OPERATOR_SYMBOL_01', $1);
      /\Gcroak|print|return|exit/gc and return ('OPERATOR_VOID', $1);
      /\G[A-Z][A-Z0-9_]*/gc and return ('LOOP_LABEL', $1);
      /\Gkeys|values/gc and return ('KEYS_OR_VALUES', $1);
      /\Gclass|self/gc and return ('CLASS_OR_SELF', $1);
      /\G\(\s*my/gc and return ('ARGUMENTS_BEGIN', $1);
      /\G\)\s*=\s*\@_\s*;/gc and return ('ARGUMENTS_END', $1);


      return ('', undef) if ($_ eq '') || (defined(pos($_)) && (pos($_) >= length($_)));
      /\G\s*(\S+)/;
      my $near = substr($1,0,10); 

      return($near, $near);

     # die( "Error inside the lexical analyzer near '". $near
     #     ."'. Line: ".$self->line()
     #     .". File: '".$self->YYFilename()."'. No match found.\n");
    }
  }
;


#line 103 ./Grammar.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@Grammar::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.182',
    yyGRAMMAR  =>
[#[productionNameAndLabel => lhs, [ rhs], bypass]]
  [ '_SUPERSTART' => '$start', [ 'CompileUnit', '$end' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-1', [ 'PLUS-1', 'Module' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-1', [ 'Module' ], 0 ],
  [ 'CompileUnit_3' => 'CompileUnit', [ 'Program' ], 0 ],
  [ 'CompileUnit_4' => 'CompileUnit', [ 'PLUS-1' ], 0 ],
  [ '_STAR_LIST' => 'STAR-2', [ 'STAR-2', 'Subroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-2', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-3', [ 'PLUS-3', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-3', [ 'Operation' ], 0 ],
  [ 'Program_9' => 'Program', [ 'SHEBANG', 'Header', 'STAR-2', 'PLUS-3' ], 0 ],
  [ 'Module_10' => 'Module', [ 'Package' ], 0 ],
  [ 'Module_11' => 'Module', [ 'Class' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-4', [ 'PLUS-4', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-4', [ 'Subroutine' ], 0 ],
  [ 'Package_14' => 'Package', [ 'package', 'WORD_SCOPED', ';', 'Header', 'PLUS-4', '1;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [ 'STAR-5', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [ 'STAR-6', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [  ], 0 ],
  [ 'Header_19' => 'Header', [ 'use strict;', 'use warnings;', 'our $VERSION =', 'VERSION_NUMBER', ';', 'use Carp;', 'use RPerl;', 'STAR-5', 'STAR-6' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-7', [ 'PLUS-7', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-7', [ 'WORD' ], 0 ],
  [ 'Include_22' => 'Include', [ 'use', 'WORD_SCOPED', ';' ], 0 ],
  [ 'Include_23' => 'Include', [ 'use', 'WORD_SCOPED', 'qw(', 'PLUS-7', ');' ], 0 ],
  [ 'Constant_24' => 'Constant', [ 'use constant', 'WORD', '=>', 'Constant_Value', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-8', [ ',', 'LITERAL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-9', [ 'STAR-9', 'PAREN-8' ], 0 ],
  [ '_STAR_LIST' => 'STAR-9', [  ], 0 ],
  [ '_PAREN' => 'PAREN-10', [ ',', 'WORD', '=>', 'LITERAL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [ 'STAR-11', 'PAREN-10' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [  ], 0 ],
  [ 'Constant_Value_31' => 'Constant_Value', [ 'LITERAL' ], 0 ],
  [ 'Constant_Value_32' => 'Constant_Value', [ '[', 'LITERAL', 'STAR-9', ']' ], 0 ],
  [ 'Constant_Value_33' => 'Constant_Value', [ '{', 'WORD', '=>', 'LITERAL', 'STAR-11', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-12', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-12', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'PLUS-13', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'Operation' ], 0 ],
  [ 'Subroutine_38' => 'Subroutine', [ 'our', 'TYPE', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-12', 'PLUS-13', '};' ], 0 ],
  [ '_PAREN' => 'PAREN-14', [ ',', 'my', 'TYPE', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-15', [ 'STAR-15', 'PAREN-14' ], 0 ],
  [ '_STAR_LIST' => 'STAR-15', [  ], 0 ],
  [ 'SubroutineArguments_42' => 'SubroutineArguments', [ 'ARGUMENTS_BEGIN', 'TYPE', 'VARIABLE_SYMBOL', 'STAR-15', 'ARGUMENTS_END' ], 0 ],
  [ 'Operation_43' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_44' => 'Operation', [ 'Statement' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [  ], 0 ],
  [ 'Operator_47' => 'Operator', [ 'OPERATOR_SYMBOL_01', '(', 'OPTIONAL-16', ')' ], 0 ],
  [ 'Operator_48' => 'Operator', [ 'OPERATOR_SYMBOL_03', 'Variable' ], 0 ],
  [ 'Operator_49' => 'Operator', [ 'Variable', 'OPERATOR_SYMBOL_03' ], 0 ],
  [ 'Operator_50' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_04', 'Expression' ], 0 ],
  [ 'Operator_51' => 'Operator', [ 'OPERATOR_SYMBOL_05', 'Expression' ], 0 ],
  [ 'Operator_52' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_07', 'Expression' ], 0 ],
  [ 'Operator_53' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_08', 'Expression' ], 0 ],
  [ 'Operator_54' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_09', 'Expression' ], 0 ],
  [ 'Operator_55' => 'Operator', [ 'OPERATOR_SYMBOL_10', 'Expression' ], 0 ],
  [ 'Operator_56' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_11', 'Expression' ], 0 ],
  [ 'Operator_57' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_12', 'Expression' ], 0 ],
  [ 'Operator_58' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_13', 'Expression' ], 0 ],
  [ 'Operator_59' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_14', 'Expression' ], 0 ],
  [ 'Operator_60' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_15', 'Expression' ], 0 ],
  [ 'Operator_61' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_16', 'Expression' ], 0 ],
  [ 'Operator_62' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_17', 'Expression' ], 0 ],
  [ 'Operator_63' => 'Operator', [ 'OPERATOR_SYMBOL_22', 'Expression' ], 0 ],
  [ 'Operator_64' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_23', 'Expression' ], 0 ],
  [ 'Operator_65' => 'Operator', [ 'Expression', 'OPERATOR_SYMBOL_24', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [  ], 0 ],
  [ 'OperatorVoid_68' => 'OperatorVoid', [ 'OPERATOR_SYMBOL_19a', 'LOOP_LABEL', ';' ], 0 ],
  [ 'OperatorVoid_69' => 'OperatorVoid', [ 'OPERATOR_VOID', '(', 'OPTIONAL-17', ')', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-19', [ 'HashEntries' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-19', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-20', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-20', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [  ], 0 ],
  [ 'Expression_78' => 'Expression', [ 'LITERAL' ], 0 ],
  [ 'Expression_79' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_80' => 'Expression', [ '[', 'OPTIONAL-18', ']' ], 0 ],
  [ 'Expression_81' => 'Expression', [ '{', 'OPTIONAL-19', '}' ], 0 ],
  [ 'Expression_82' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_83' => 'Expression', [ 'WORD_SCOPED', '(', 'OPTIONAL-20', ')' ], 0 ],
  [ 'Expression_84' => 'Expression', [ 'Variable', '->', 'WORD', '(', 'OPTIONAL-21', ')' ], 0 ],
  [ 'Expression_85' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-22', [ 'LOOP_LABEL', ':' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [ 'PAREN-22' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [  ], 0 ],
  [ 'Statement_89' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_90' => 'Statement', [ 'OPTIONAL-23', 'Loop' ], 0 ],
  [ 'Statement_91' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_92' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_93' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-24', [ 'elsif', '(', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'PAREN-24' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ '_PAREN' => 'PAREN-26', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [ 'PAREN-26' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [  ], 0 ],
  [ 'Conditional_100' => 'Conditional', [ 'if', '(', 'Expression', ')', 'CodeBlock', 'STAR-25', 'OPTIONAL-27' ], 0 ],
  [ 'Loop_101' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_102' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_103' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_104' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_105' => 'LoopForEach', [ 'foreach my', 'TYPE', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_106' => 'LoopWhile', [ 'while', '(', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-28', [ 'PLUS-28', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-28', [ 'Operation' ], 0 ],
  [ 'CodeBlock_109' => 'CodeBlock', [ '{', 'PLUS-28', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [ 'STAR-29', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [  ], 0 ],
  [ 'Variable_112' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-29' ], 0 ],
  [ 'VariableRetrieval_113' => 'VariableRetrieval', [ '->[', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_114' => 'VariableRetrieval', [ '->{', 'Expression', '}' ], 0 ],
  [ 'VariableDeclaration_115' => 'VariableDeclaration', [ 'my', 'TYPE', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_116' => 'VariableDeclaration', [ 'my', 'TYPE', 'VARIABLE_SYMBOL', 'OPERATOR_SYMBOL_19', 'Expression', ';' ], 0 ],
  [ 'VariableModification_117' => 'VariableModification', [ 'Variable', 'OPERATOR_SYMBOL_19', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-30', [ ',', 'ListElementValue' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [ 'STAR-31', 'PAREN-30' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [  ], 0 ],
  [ 'ListElements_121' => 'ListElements', [ 'ListElementValue', 'STAR-31' ], 0 ],
  [ 'ListElementValue_122' => 'ListElementValue', [ 'Expression' ], 0 ],
  [ 'ListElementValue_123' => 'ListElementValue', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ListElementValue_124' => 'ListElementValue', [ 'KEYS_OR_VALUES', '%{', 'Variable', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-32', [ ',', 'WORD', '=>', 'HashEntryValue' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [ 'STAR-33', 'PAREN-32' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [  ], 0 ],
  [ 'HashEntries_128' => 'HashEntries', [ 'WORD', '=>', 'HashEntryValue', 'STAR-33' ], 0 ],
  [ 'HashEntryValue_129' => 'HashEntryValue', [ 'Expression' ], 0 ],
  [ 'HashEntryValue_130' => 'HashEntryValue', [ '%{', 'Variable', '}' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-34', [ 'PLUS-34', 'WORD_SCOPED' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-34', [ 'WORD_SCOPED' ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [ 'STAR-35', 'Method' ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [  ], 0 ],
  [ 'Class_135' => 'Class', [ 'package', 'WORD_SCOPED', ';', 'Header', 'use parent qw(', 'PLUS-34', ');', 'Properties', 'STAR-35', '1;' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'HashEntries' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ 'Properties_138' => 'Properties', [ 'our %properties', '=', '(', 'OPTIONAL-36', ');' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-38', [ 'PLUS-38', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-38', [ 'Operation' ], 0 ],
  [ 'Method_143' => 'Method', [ 'our', 'TYPE', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-37', 'PLUS-38', '};' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ ',', 'my', 'TYPE', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [ 'STAR-40', 'PAREN-39' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [  ], 0 ],
  [ 'MethodArguments_147' => 'MethodArguments', [ 'ARGUMENTS_BEGIN', 'TYPE', 'CLASS_OR_SELF', 'STAR-40', 'ARGUMENTS_END' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  '_PLUS_LIST' => 1,
  '_PLUS_LIST' => 2,
  'CompileUnit_3' => 3,
  'CompileUnit_4' => 4,
  '_STAR_LIST' => 5,
  '_STAR_LIST' => 6,
  '_PLUS_LIST' => 7,
  '_PLUS_LIST' => 8,
  'Program_9' => 9,
  'Module_10' => 10,
  'Module_11' => 11,
  '_PLUS_LIST' => 12,
  '_PLUS_LIST' => 13,
  'Package_14' => 14,
  '_STAR_LIST' => 15,
  '_STAR_LIST' => 16,
  '_STAR_LIST' => 17,
  '_STAR_LIST' => 18,
  'Header_19' => 19,
  '_PLUS_LIST' => 20,
  '_PLUS_LIST' => 21,
  'Include_22' => 22,
  'Include_23' => 23,
  'Constant_24' => 24,
  '_PAREN' => 25,
  '_STAR_LIST' => 26,
  '_STAR_LIST' => 27,
  '_PAREN' => 28,
  '_STAR_LIST' => 29,
  '_STAR_LIST' => 30,
  'Constant_Value_31' => 31,
  'Constant_Value_32' => 32,
  'Constant_Value_33' => 33,
  '_OPTIONAL' => 34,
  '_OPTIONAL' => 35,
  '_PLUS_LIST' => 36,
  '_PLUS_LIST' => 37,
  'Subroutine_38' => 38,
  '_PAREN' => 39,
  '_STAR_LIST' => 40,
  '_STAR_LIST' => 41,
  'SubroutineArguments_42' => 42,
  'Operation_43' => 43,
  'Operation_44' => 44,
  '_OPTIONAL' => 45,
  '_OPTIONAL' => 46,
  'Operator_47' => 47,
  'Operator_48' => 48,
  'Operator_49' => 49,
  'Operator_50' => 50,
  'Operator_51' => 51,
  'Operator_52' => 52,
  'Operator_53' => 53,
  'Operator_54' => 54,
  'Operator_55' => 55,
  'Operator_56' => 56,
  'Operator_57' => 57,
  'Operator_58' => 58,
  'Operator_59' => 59,
  'Operator_60' => 60,
  'Operator_61' => 61,
  'Operator_62' => 62,
  'Operator_63' => 63,
  'Operator_64' => 64,
  'Operator_65' => 65,
  '_OPTIONAL' => 66,
  '_OPTIONAL' => 67,
  'OperatorVoid_68' => 68,
  'OperatorVoid_69' => 69,
  '_OPTIONAL' => 70,
  '_OPTIONAL' => 71,
  '_OPTIONAL' => 72,
  '_OPTIONAL' => 73,
  '_OPTIONAL' => 74,
  '_OPTIONAL' => 75,
  '_OPTIONAL' => 76,
  '_OPTIONAL' => 77,
  'Expression_78' => 78,
  'Expression_79' => 79,
  'Expression_80' => 80,
  'Expression_81' => 81,
  'Expression_82' => 82,
  'Expression_83' => 83,
  'Expression_84' => 84,
  'Expression_85' => 85,
  '_PAREN' => 86,
  '_OPTIONAL' => 87,
  '_OPTIONAL' => 88,
  'Statement_89' => 89,
  'Statement_90' => 90,
  'Statement_91' => 91,
  'Statement_92' => 92,
  'Statement_93' => 93,
  '_PAREN' => 94,
  '_STAR_LIST' => 95,
  '_STAR_LIST' => 96,
  '_PAREN' => 97,
  '_OPTIONAL' => 98,
  '_OPTIONAL' => 99,
  'Conditional_100' => 100,
  'Loop_101' => 101,
  'Loop_102' => 102,
  'Loop_103' => 103,
  'LoopFor_104' => 104,
  'LoopForEach_105' => 105,
  'LoopWhile_106' => 106,
  '_PLUS_LIST' => 107,
  '_PLUS_LIST' => 108,
  'CodeBlock_109' => 109,
  '_STAR_LIST' => 110,
  '_STAR_LIST' => 111,
  'Variable_112' => 112,
  'VariableRetrieval_113' => 113,
  'VariableRetrieval_114' => 114,
  'VariableDeclaration_115' => 115,
  'VariableDeclaration_116' => 116,
  'VariableModification_117' => 117,
  '_PAREN' => 118,
  '_STAR_LIST' => 119,
  '_STAR_LIST' => 120,
  'ListElements_121' => 121,
  'ListElementValue_122' => 122,
  'ListElementValue_123' => 123,
  'ListElementValue_124' => 124,
  '_PAREN' => 125,
  '_STAR_LIST' => 126,
  '_STAR_LIST' => 127,
  'HashEntries_128' => 128,
  'HashEntryValue_129' => 129,
  'HashEntryValue_130' => 130,
  '_PLUS_LIST' => 131,
  '_PLUS_LIST' => 132,
  '_STAR_LIST' => 133,
  '_STAR_LIST' => 134,
  'Class_135' => 135,
  '_OPTIONAL' => 136,
  '_OPTIONAL' => 137,
  'Properties_138' => 138,
  '_OPTIONAL' => 139,
  '_OPTIONAL' => 140,
  '_PLUS_LIST' => 141,
  '_PLUS_LIST' => 142,
  'Method_143' => 143,
  '_PAREN' => 144,
  '_STAR_LIST' => 145,
  '_STAR_LIST' => 146,
  'MethodArguments_147' => 147,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	');' => { ISSEMANTIC => 0 },
	',' => { ISSEMANTIC => 0 },
	'->' => { ISSEMANTIC => 0 },
	'->[' => { ISSEMANTIC => 0 },
	'->{' => { ISSEMANTIC => 0 },
	'..' => { ISSEMANTIC => 0 },
	'1;' => { ISSEMANTIC => 0 },
	':' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'= sub {' => { ISSEMANTIC => 0 },
	'=' => { ISSEMANTIC => 0 },
	'=>' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	'[' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'else' => { ISSEMANTIC => 0 },
	'elsif' => { ISSEMANTIC => 0 },
	'for my integer' => { ISSEMANTIC => 0 },
	'foreach my' => { ISSEMANTIC => 0 },
	'if' => { ISSEMANTIC => 0 },
	'my' => { ISSEMANTIC => 0 },
	'our $VERSION =' => { ISSEMANTIC => 0 },
	'our %properties' => { ISSEMANTIC => 0 },
	'our' => { ISSEMANTIC => 0 },
	'package' => { ISSEMANTIC => 0 },
	'qw(' => { ISSEMANTIC => 0 },
	'use Carp;' => { ISSEMANTIC => 0 },
	'use RPerl;' => { ISSEMANTIC => 0 },
	'use constant' => { ISSEMANTIC => 0 },
	'use parent qw(' => { ISSEMANTIC => 0 },
	'use strict;' => { ISSEMANTIC => 0 },
	'use warnings;' => { ISSEMANTIC => 0 },
	'use' => { ISSEMANTIC => 0 },
	'while' => { ISSEMANTIC => 0 },
	'{' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	'};' => { ISSEMANTIC => 0 },
	ARGUMENTS_BEGIN => { ISSEMANTIC => 1 },
	ARGUMENTS_END => { ISSEMANTIC => 1 },
	CLASS_OR_SELF => { ISSEMANTIC => 1 },
	KEYS_OR_VALUES => { ISSEMANTIC => 1 },
	LITERAL => { ISSEMANTIC => 1 },
	LOOP_LABEL => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_01 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_03 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_04 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_05 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_07 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_08 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_09 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_10 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_11 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_12 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_13 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_14 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_15 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_16 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_17 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_19 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_19a => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_22 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_23 => { ISSEMANTIC => 1 },
	OPERATOR_SYMBOL_24 => { ISSEMANTIC => 1 },
	OPERATOR_VOID => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	TYPE => { ISSEMANTIC => 1 },
	VARIABLE_SYMBOL => { ISSEMANTIC => 1 },
	VERSION_NUMBER => { ISSEMANTIC => 1 },
	WORD => { ISSEMANTIC => 1 },
	WORD_SCOPED => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'Grammar.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'SHEBANG' => 4,
			"package" => 8
		},
		GOTOS => {
			'Program' => 2,
			'Module' => 1,
			'CompileUnit' => 6,
			'Class' => 5,
			'PLUS-1' => 3,
			'Package' => 7
		}
	},
	{#State 1
		DEFAULT => -2
	},
	{#State 2
		DEFAULT => -3
	},
	{#State 3
		ACTIONS => {
			'' => -4,
			"package" => 8
		},
		GOTOS => {
			'Class' => 5,
			'Package' => 7,
			'Module' => 9
		}
	},
	{#State 4
		ACTIONS => {
			"use strict;" => 10
		},
		GOTOS => {
			'Header' => 11
		}
	},
	{#State 5
		DEFAULT => -11
	},
	{#State 6
		ACTIONS => {
			'' => 12
		}
	},
	{#State 7
		DEFAULT => -10
	},
	{#State 8
		ACTIONS => {
			'WORD_SCOPED' => 13
		}
	},
	{#State 9
		DEFAULT => -1
	},
	{#State 10
		ACTIONS => {
			"use warnings;" => 14
		}
	},
	{#State 11
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 15
		}
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		ACTIONS => {
			";" => 16
		}
	},
	{#State 14
		ACTIONS => {
			"our \$VERSION =" => 17
		}
	},
	{#State 15
		ACTIONS => {
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_22' => 25,
			"for my integer" => -88,
			"our" => 24,
			'OPERATOR_VOID' => 21,
			'LITERAL' => 20,
			"foreach my" => -88,
			'LOOP_LABEL' => 45,
			'OPERATOR_SYMBOL_05' => 46,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_19a' => 37,
			"if" => 40,
			"my" => 38,
			"{" => 36,
			"[" => 34,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			"while" => -88
		},
		GOTOS => {
			'PAREN-22' => 44,
			'VariableDeclaration' => 47,
			'PLUS-3' => 28,
			'Operator' => 39,
			'Statement' => 43,
			'VariableModification' => 42,
			'Expression' => 22,
			'Conditional' => 35,
			'Operation' => 23,
			'Variable' => 29,
			'OperatorVoid' => 18,
			'OPTIONAL-23' => 33,
			'Subroutine' => 19
		}
	},
	{#State 16
		ACTIONS => {
			"use strict;" => 10
		},
		GOTOS => {
			'Header' => 48
		}
	},
	{#State 17
		ACTIONS => {
			'VERSION_NUMBER' => 49
		}
	},
	{#State 18
		DEFAULT => -91
	},
	{#State 19
		DEFAULT => -5
	},
	{#State 20
		DEFAULT => -78
	},
	{#State 21
		ACTIONS => {
			"(" => 50
		}
	},
	{#State 22
		ACTIONS => {
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_17' => 53,
			";" => 63,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_23' => 64,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_24' => 58
		}
	},
	{#State 23
		DEFAULT => -8
	},
	{#State 24
		ACTIONS => {
			'TYPE' => 65
		}
	},
	{#State 25
		ACTIONS => {
			'LITERAL' => 20,
			"[" => 34,
			"{" => 36,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41
		},
		GOTOS => {
			'Operator' => 39,
			'Variable' => 67,
			'Expression' => 66
		}
	},
	{#State 26
		ACTIONS => {
			'VARIABLE_SYMBOL' => 32
		},
		GOTOS => {
			'Variable' => 68
		}
	},
	{#State 27
		ACTIONS => {
			'LITERAL' => 20,
			"[" => 34,
			"{" => 36,
			'OPERATOR_SYMBOL_10' => 30,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_03' => 26,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41
		},
		GOTOS => {
			'Expression' => 69,
			'Variable' => 67,
			'Operator' => 39
		}
	},
	{#State 28
		ACTIONS => {
			'WORD_SCOPED' => 41,
			"my" => 38,
			"if" => 40,
			'OPERATOR_SYMBOL_19a' => 37,
			'OPERATOR_SYMBOL_05' => 46,
			'LOOP_LABEL' => 45,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_10' => 30,
			"while" => -88,
			'' => -9,
			"{" => 36,
			"[" => 34,
			'OPERATOR_SYMBOL_22' => 25,
			"for my integer" => -88,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			"foreach my" => -88,
			'OPERATOR_VOID' => 21,
			'LITERAL' => 20
		},
		GOTOS => {
			'Expression' => 22,
			'Conditional' => 35,
			'Operation' => 70,
			'Variable' => 29,
			'OperatorVoid' => 18,
			'OPTIONAL-23' => 33,
			'PAREN-22' => 44,
			'VariableDeclaration' => 47,
			'Operator' => 39,
			'Statement' => 43,
			'VariableModification' => 42
		}
	},
	{#State 29
		ACTIONS => {
			'OPERATOR_SYMBOL_17' => -79,
			'OPERATOR_SYMBOL_13' => -79,
			'OPERATOR_SYMBOL_07' => -79,
			"->" => 71,
			'OPERATOR_SYMBOL_03' => 72,
			'OPERATOR_SYMBOL_14' => -79,
			'OPERATOR_SYMBOL_08' => -79,
			'OPERATOR_SYMBOL_09' => -79,
			'OPERATOR_SYMBOL_16' => -79,
			";" => -79,
			'OPERATOR_SYMBOL_19' => 73,
			'OPERATOR_SYMBOL_23' => -79,
			'OPERATOR_SYMBOL_15' => -79,
			'OPERATOR_SYMBOL_24' => -79,
			'OPERATOR_SYMBOL_11' => -79,
			'OPERATOR_SYMBOL_04' => -79,
			'OPERATOR_SYMBOL_12' => -79
		}
	},
	{#State 30
		ACTIONS => {
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41
		},
		GOTOS => {
			'Expression' => 74,
			'Variable' => 67,
			'Operator' => 39
		}
	},
	{#State 31
		ACTIONS => {
			"(" => 75
		}
	},
	{#State 32
		DEFAULT => -111,
		GOTOS => {
			'STAR-29' => 76
		}
	},
	{#State 33
		ACTIONS => {
			"for my integer" => 77,
			"foreach my" => 81,
			"while" => 83
		},
		GOTOS => {
			'LoopFor' => 82,
			'LoopForEach' => 79,
			'LoopWhile' => 78,
			'Loop' => 80
		}
	},
	{#State 34
		ACTIONS => {
			"]" => -71,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_03' => 26,
			"(" => 27,
			'KEYS_OR_VALUES' => 87,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'LITERAL' => 20,
			"[" => 34,
			"\@{" => 88,
			"{" => 36
		},
		GOTOS => {
			'Variable' => 67,
			'Operator' => 39,
			'Expression' => 84,
			'ListElements' => 85,
			'ListElementValue' => 86,
			'OPTIONAL-18' => 89
		}
	},
	{#State 35
		DEFAULT => -89
	},
	{#State 36
		ACTIONS => {
			'WORD' => 90,
			"}" => -73
		},
		GOTOS => {
			'HashEntries' => 92,
			'OPTIONAL-19' => 91
		}
	},
	{#State 37
		ACTIONS => {
			'LOOP_LABEL' => 93
		}
	},
	{#State 38
		ACTIONS => {
			'TYPE' => 94
		}
	},
	{#State 39
		DEFAULT => -82
	},
	{#State 40
		ACTIONS => {
			"(" => 95
		}
	},
	{#State 41
		ACTIONS => {
			"(" => 96
		}
	},
	{#State 42
		DEFAULT => -93
	},
	{#State 43
		DEFAULT => -44
	},
	{#State 44
		DEFAULT => -87
	},
	{#State 45
		ACTIONS => {
			":" => 97
		}
	},
	{#State 46
		ACTIONS => {
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			'OPERATOR_SYMBOL_03' => 26,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			"[" => 34,
			'LITERAL' => 20,
			"{" => 36
		},
		GOTOS => {
			'Operator' => 39,
			'Variable' => 67,
			'Expression' => 98
		}
	},
	{#State 47
		DEFAULT => -92
	},
	{#State 48
		ACTIONS => {
			"our" => 24,
			"use parent qw(" => 99
		},
		GOTOS => {
			'PLUS-4' => 101,
			'Subroutine' => 100
		}
	},
	{#State 49
		ACTIONS => {
			";" => 102
		}
	},
	{#State 50
		ACTIONS => {
			'OPERATOR_SYMBOL_10' => 30,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			"\@{" => 88,
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			")" => -67,
			"(" => 27,
			'KEYS_OR_VALUES' => 87,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_03' => 26
		},
		GOTOS => {
			'Operator' => 39,
			'Variable' => 67,
			'Expression' => 84,
			'ListElements' => 104,
			'ListElementValue' => 86,
			'OPTIONAL-17' => 103
		}
	},
	{#State 51
		ACTIONS => {
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			"{" => 36,
			"[" => 34,
			'LITERAL' => 20,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_03' => 26
		},
		GOTOS => {
			'Expression' => 105,
			'Variable' => 67,
			'Operator' => 39
		}
	},
	{#State 52
		ACTIONS => {
			'OPERATOR_SYMBOL_10' => 30,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'LITERAL' => 20,
			"[" => 34,
			"{" => 36,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_03' => 26,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46
		},
		GOTOS => {
			'Expression' => 106,
			'Operator' => 39,
			'Variable' => 67
		}
	},
	{#State 53
		ACTIONS => {
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34,
			'OPERATOR_SYMBOL_10' => 30,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31
		},
		GOTOS => {
			'Variable' => 67,
			'Operator' => 39,
			'Expression' => 107
		}
	},
	{#State 54
		ACTIONS => {
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			"{" => 36,
			"[" => 34,
			'LITERAL' => 20,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_03' => 26
		},
		GOTOS => {
			'Expression' => 108,
			'Variable' => 67,
			'Operator' => 39
		}
	},
	{#State 55
		ACTIONS => {
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_10' => 30,
			'LITERAL' => 20,
			"[" => 34,
			"{" => 36
		},
		GOTOS => {
			'Expression' => 109,
			'Operator' => 39,
			'Variable' => 67
		}
	},
	{#State 56
		ACTIONS => {
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_10' => 30,
			"[" => 34,
			'LITERAL' => 20,
			"{" => 36,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27
		},
		GOTOS => {
			'Variable' => 67,
			'Operator' => 39,
			'Expression' => 110
		}
	},
	{#State 57
		ACTIONS => {
			'OPERATOR_SYMBOL_03' => 26,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			"[" => 34,
			'LITERAL' => 20,
			"{" => 36,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32
		},
		GOTOS => {
			'Operator' => 39,
			'Variable' => 67,
			'Expression' => 111
		}
	},
	{#State 58
		ACTIONS => {
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			'OPERATOR_SYMBOL_03' => 26,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			"[" => 34,
			'LITERAL' => 20,
			"{" => 36
		},
		GOTOS => {
			'Expression' => 112,
			'Variable' => 67,
			'Operator' => 39
		}
	},
	{#State 59
		ACTIONS => {
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_10' => 30,
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34
		},
		GOTOS => {
			'Expression' => 113,
			'Operator' => 39,
			'Variable' => 67
		}
	},
	{#State 60
		ACTIONS => {
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			"{" => 36,
			"[" => 34,
			'LITERAL' => 20,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32
		},
		GOTOS => {
			'Expression' => 114,
			'Variable' => 67,
			'Operator' => 39
		}
	},
	{#State 61
		ACTIONS => {
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			"{" => 36,
			"[" => 34,
			'LITERAL' => 20
		},
		GOTOS => {
			'Expression' => 115,
			'Variable' => 67,
			'Operator' => 39
		}
	},
	{#State 62
		ACTIONS => {
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_10' => 30,
			"{" => 36,
			"[" => 34,
			'LITERAL' => 20,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26
		},
		GOTOS => {
			'Expression' => 116,
			'Operator' => 39,
			'Variable' => 67
		}
	},
	{#State 63
		DEFAULT => -43
	},
	{#State 64
		ACTIONS => {
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34,
			'OPERATOR_SYMBOL_10' => 30,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41
		},
		GOTOS => {
			'Expression' => 117,
			'Variable' => 67,
			'Operator' => 39
		}
	},
	{#State 65
		ACTIONS => {
			'VARIABLE_SYMBOL' => 118
		}
	},
	{#State 66
		ACTIONS => {
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => 55,
			"}" => -63,
			"," => -63,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_24' => -63,
			");" => -63,
			"]" => -63,
			")" => -63,
			'OPERATOR_SYMBOL_23' => -63,
			".." => -63,
			";" => -63,
			'OPERATOR_SYMBOL_16' => 62
		}
	},
	{#State 67
		ACTIONS => {
			'OPERATOR_SYMBOL_24' => -79,
			'OPERATOR_SYMBOL_15' => -79,
			");" => -79,
			'OPERATOR_SYMBOL_11' => -79,
			'OPERATOR_SYMBOL_04' => -79,
			'OPERATOR_SYMBOL_12' => -79,
			".." => -79,
			'OPERATOR_SYMBOL_23' => -79,
			'OPERATOR_SYMBOL_16' => -79,
			";" => -79,
			")" => -79,
			"]" => -79,
			'OPERATOR_SYMBOL_09' => -79,
			"," => -79,
			'OPERATOR_SYMBOL_03' => 72,
			"}" => -79,
			"->" => 71,
			'OPERATOR_SYMBOL_13' => -79,
			'OPERATOR_SYMBOL_17' => -79,
			'OPERATOR_SYMBOL_07' => -79,
			'OPERATOR_SYMBOL_08' => -79,
			'OPERATOR_SYMBOL_14' => -79
		}
	},
	{#State 68
		DEFAULT => -48
	},
	{#State 69
		ACTIONS => {
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_24' => 58,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_08' => 56,
			")" => 119,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_23' => 64,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_07' => 52
		}
	},
	{#State 70
		DEFAULT => -7
	},
	{#State 71
		ACTIONS => {
			'WORD' => 120
		}
	},
	{#State 72
		DEFAULT => -49
	},
	{#State 73
		ACTIONS => {
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			'LITERAL' => 20,
			"[" => 34,
			"{" => 36,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_10' => 30
		},
		GOTOS => {
			'Variable' => 67,
			'Operator' => 39,
			'Expression' => 121
		}
	},
	{#State 74
		ACTIONS => {
			");" => -55,
			'OPERATOR_SYMBOL_24' => -55,
			'OPERATOR_SYMBOL_15' => -55,
			'OPERATOR_SYMBOL_11' => -55,
			'OPERATOR_SYMBOL_12' => -55,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_16' => -55,
			";" => -55,
			".." => -55,
			'OPERATOR_SYMBOL_23' => -55,
			"]" => -55,
			")" => -55,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_17' => -55,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_13' => -55,
			"}" => -55,
			"," => -55,
			'OPERATOR_SYMBOL_14' => -55,
			'OPERATOR_SYMBOL_08' => 56
		}
	},
	{#State 75
		ACTIONS => {
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'KEYS_OR_VALUES' => 87,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			")" => -46,
			"{" => 36,
			"\@{" => 88,
			'LITERAL' => 20,
			"[" => 34,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_10' => 30
		},
		GOTOS => {
			'ListElementValue' => 86,
			'Expression' => 84,
			'ListElements' => 123,
			'Variable' => 67,
			'Operator' => 39,
			'OPTIONAL-16' => 122
		}
	},
	{#State 76
		ACTIONS => {
			'OPERATOR_SYMBOL_09' => -112,
			'OPERATOR_SYMBOL_07' => -112,
			'OPERATOR_SYMBOL_13' => -112,
			'OPERATOR_SYMBOL_17' => -112,
			"->[" => 126,
			"->" => -112,
			"}" => -112,
			'OPERATOR_SYMBOL_03' => -112,
			"," => -112,
			'OPERATOR_SYMBOL_14' => -112,
			'OPERATOR_SYMBOL_08' => -112,
			");" => -112,
			"->{" => 125,
			'OPERATOR_SYMBOL_15' => -112,
			'OPERATOR_SYMBOL_24' => -112,
			'OPERATOR_SYMBOL_04' => -112,
			'OPERATOR_SYMBOL_11' => -112,
			'OPERATOR_SYMBOL_12' => -112,
			";" => -112,
			'OPERATOR_SYMBOL_16' => -112,
			'OPERATOR_SYMBOL_19' => -112,
			'OPERATOR_SYMBOL_23' => -112,
			".." => -112,
			")" => -112,
			"]" => -112
		},
		GOTOS => {
			'VariableRetrieval' => 124
		}
	},
	{#State 77
		ACTIONS => {
			'VARIABLE_SYMBOL' => 127
		}
	},
	{#State 78
		DEFAULT => -103
	},
	{#State 79
		DEFAULT => -102
	},
	{#State 80
		DEFAULT => -90
	},
	{#State 81
		ACTIONS => {
			'TYPE' => 128
		}
	},
	{#State 82
		DEFAULT => -101
	},
	{#State 83
		ACTIONS => {
			"(" => 129
		}
	},
	{#State 84
		ACTIONS => {
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_07' => 52,
			"," => -122,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_24' => 58,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_23' => 64,
			")" => -122,
			"]" => -122
		}
	},
	{#State 85
		DEFAULT => -70
	},
	{#State 86
		DEFAULT => -120,
		GOTOS => {
			'STAR-31' => 130
		}
	},
	{#State 87
		ACTIONS => {
			"%{" => 131
		}
	},
	{#State 88
		ACTIONS => {
			'VARIABLE_SYMBOL' => 32
		},
		GOTOS => {
			'Variable' => 132
		}
	},
	{#State 89
		ACTIONS => {
			"]" => 133
		}
	},
	{#State 90
		ACTIONS => {
			"=>" => 134
		}
	},
	{#State 91
		ACTIONS => {
			"}" => 135
		}
	},
	{#State 92
		DEFAULT => -72
	},
	{#State 93
		ACTIONS => {
			";" => 136
		}
	},
	{#State 94
		ACTIONS => {
			'VARIABLE_SYMBOL' => 137
		}
	},
	{#State 95
		ACTIONS => {
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			"{" => 36,
			"[" => 34,
			'LITERAL' => 20
		},
		GOTOS => {
			'Operator' => 39,
			'Variable' => 67,
			'Expression' => 138
		}
	},
	{#State 96
		ACTIONS => {
			"\@{" => 88,
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34,
			'OPERATOR_SYMBOL_10' => 30,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			"(" => 27,
			'KEYS_OR_VALUES' => 87,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			")" => -75
		},
		GOTOS => {
			'ListElements' => 140,
			'Expression' => 84,
			'ListElementValue' => 86,
			'OPTIONAL-20' => 139,
			'Variable' => 67,
			'Operator' => 39
		}
	},
	{#State 97
		DEFAULT => -86
	},
	{#State 98
		ACTIONS => {
			'OPERATOR_SYMBOL_14' => -51,
			'OPERATOR_SYMBOL_08' => -51,
			'OPERATOR_SYMBOL_17' => -51,
			'OPERATOR_SYMBOL_07' => -51,
			'OPERATOR_SYMBOL_13' => -51,
			"," => -51,
			"}" => -51,
			'OPERATOR_SYMBOL_09' => -51,
			")" => -51,
			"]" => -51,
			'OPERATOR_SYMBOL_16' => -51,
			";" => -51,
			'OPERATOR_SYMBOL_23' => -51,
			".." => -51,
			'OPERATOR_SYMBOL_12' => -51,
			'OPERATOR_SYMBOL_11' => -51,
			'OPERATOR_SYMBOL_04' => 61,
			");" => -51,
			'OPERATOR_SYMBOL_15' => -51,
			'OPERATOR_SYMBOL_24' => -51
		}
	},
	{#State 99
		ACTIONS => {
			'WORD_SCOPED' => 141
		},
		GOTOS => {
			'PLUS-34' => 142
		}
	},
	{#State 100
		DEFAULT => -13
	},
	{#State 101
		ACTIONS => {
			"our" => 24,
			"1;" => 143
		},
		GOTOS => {
			'Subroutine' => 144
		}
	},
	{#State 102
		ACTIONS => {
			"use Carp;" => 145
		}
	},
	{#State 103
		ACTIONS => {
			")" => 146
		}
	},
	{#State 104
		DEFAULT => -66
	},
	{#State 105
		ACTIONS => {
			'OPERATOR_SYMBOL_14' => -54,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_17' => -54,
			'OPERATOR_SYMBOL_13' => -54,
			'OPERATOR_SYMBOL_07' => 52,
			"}" => -54,
			"," => -54,
			'OPERATOR_SYMBOL_09' => -54,
			")" => -54,
			"]" => -54,
			";" => -54,
			'OPERATOR_SYMBOL_16' => -54,
			'OPERATOR_SYMBOL_23' => -54,
			".." => -54,
			'OPERATOR_SYMBOL_12' => -54,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_11' => -54,
			");" => -54,
			'OPERATOR_SYMBOL_24' => -54,
			'OPERATOR_SYMBOL_15' => -54
		}
	},
	{#State 106
		ACTIONS => {
			'OPERATOR_SYMBOL_09' => -52,
			'OPERATOR_SYMBOL_14' => -52,
			'OPERATOR_SYMBOL_08' => -52,
			'OPERATOR_SYMBOL_07' => -52,
			'OPERATOR_SYMBOL_17' => -52,
			'OPERATOR_SYMBOL_13' => -52,
			"," => -52,
			"}" => -52,
			'OPERATOR_SYMBOL_11' => -52,
			'OPERATOR_SYMBOL_12' => -52,
			'OPERATOR_SYMBOL_04' => 61,
			");" => -52,
			'OPERATOR_SYMBOL_24' => -52,
			'OPERATOR_SYMBOL_15' => -52,
			"]" => -52,
			")" => -52,
			";" => -52,
			'OPERATOR_SYMBOL_16' => -52,
			".." => -52,
			'OPERATOR_SYMBOL_23' => -52
		}
	},
	{#State 107
		ACTIONS => {
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_17' => undef,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_13' => 54,
			"}" => -62,
			"," => -62,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_08' => 56,
			");" => -62,
			'OPERATOR_SYMBOL_24' => -62,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			";" => -62,
			'OPERATOR_SYMBOL_16' => 62,
			".." => -62,
			'OPERATOR_SYMBOL_23' => -62,
			"]" => -62,
			")" => -62
		}
	},
	{#State 108
		ACTIONS => {
			'OPERATOR_SYMBOL_15' => -58,
			'OPERATOR_SYMBOL_24' => -58,
			");" => -58,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_11' => 59,
			".." => -58,
			'OPERATOR_SYMBOL_23' => -58,
			";" => -58,
			'OPERATOR_SYMBOL_16' => -58,
			")" => -58,
			"]" => -58,
			'OPERATOR_SYMBOL_09' => 51,
			"}" => -58,
			"," => -58,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_17' => -58,
			'OPERATOR_SYMBOL_13' => -58,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => -58
		}
	},
	{#State 109
		ACTIONS => {
			'OPERATOR_SYMBOL_23' => -59,
			".." => -59,
			";" => -59,
			'OPERATOR_SYMBOL_16' => -59,
			"]" => -59,
			")" => -59,
			'OPERATOR_SYMBOL_15' => -59,
			'OPERATOR_SYMBOL_24' => -59,
			");" => -59,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_04' => 61,
			"}" => -59,
			"," => -59,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_17' => -59,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => -59,
			'OPERATOR_SYMBOL_09' => 51
		}
	},
	{#State 110
		ACTIONS => {
			'OPERATOR_SYMBOL_14' => -53,
			'OPERATOR_SYMBOL_08' => -53,
			'OPERATOR_SYMBOL_13' => -53,
			'OPERATOR_SYMBOL_17' => -53,
			'OPERATOR_SYMBOL_07' => 52,
			"," => -53,
			"}" => -53,
			'OPERATOR_SYMBOL_09' => -53,
			")" => -53,
			"]" => -53,
			";" => -53,
			'OPERATOR_SYMBOL_16' => -53,
			".." => -53,
			'OPERATOR_SYMBOL_23' => -53,
			'OPERATOR_SYMBOL_11' => -53,
			'OPERATOR_SYMBOL_12' => -53,
			'OPERATOR_SYMBOL_04' => 61,
			");" => -53,
			'OPERATOR_SYMBOL_24' => -53,
			'OPERATOR_SYMBOL_15' => -53
		}
	},
	{#State 111
		ACTIONS => {
			'OPERATOR_SYMBOL_15' => -60,
			'OPERATOR_SYMBOL_24' => -60,
			");" => -60,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_23' => -60,
			".." => -60,
			";" => -60,
			'OPERATOR_SYMBOL_16' => -60,
			")" => -60,
			"]" => -60,
			'OPERATOR_SYMBOL_09' => 51,
			"," => -60,
			"}" => -60,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_17' => -60,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => 55
		}
	},
	{#State 112
		ACTIONS => {
			");" => -65,
			'OPERATOR_SYMBOL_24' => -65,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_11' => 59,
			";" => -65,
			'OPERATOR_SYMBOL_16' => 62,
			".." => -65,
			'OPERATOR_SYMBOL_23' => 64,
			"]" => -65,
			")" => -65,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_07' => 52,
			"," => -65,
			"}" => -65,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_08' => 56
		}
	},
	{#State 113
		ACTIONS => {
			'OPERATOR_SYMBOL_09' => 51,
			"," => -56,
			"}" => -56,
			'OPERATOR_SYMBOL_13' => -56,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_17' => -56,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => -56,
			'OPERATOR_SYMBOL_24' => -56,
			'OPERATOR_SYMBOL_15' => -56,
			");" => -56,
			'OPERATOR_SYMBOL_12' => -56,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_11' => undef,
			'OPERATOR_SYMBOL_23' => -56,
			".." => -56,
			";" => -56,
			'OPERATOR_SYMBOL_16' => -56,
			")" => -56,
			"]" => -56
		}
	},
	{#State 114
		ACTIONS => {
			'OPERATOR_SYMBOL_12' => undef,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_15' => -57,
			'OPERATOR_SYMBOL_24' => -57,
			");" => -57,
			"]" => -57,
			")" => -57,
			".." => -57,
			'OPERATOR_SYMBOL_23' => -57,
			";" => -57,
			'OPERATOR_SYMBOL_16' => -57,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => -57,
			"}" => -57,
			"," => -57,
			'OPERATOR_SYMBOL_13' => -57,
			'OPERATOR_SYMBOL_17' => -57,
			'OPERATOR_SYMBOL_07' => 52
		}
	},
	{#State 115
		ACTIONS => {
			".." => -50,
			'OPERATOR_SYMBOL_23' => -50,
			";" => -50,
			'OPERATOR_SYMBOL_16' => -50,
			"]" => -50,
			")" => -50,
			'OPERATOR_SYMBOL_15' => -50,
			'OPERATOR_SYMBOL_24' => -50,
			");" => -50,
			'OPERATOR_SYMBOL_11' => -50,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => -50,
			"," => -50,
			"}" => -50,
			'OPERATOR_SYMBOL_17' => -50,
			'OPERATOR_SYMBOL_07' => -50,
			'OPERATOR_SYMBOL_13' => -50,
			'OPERATOR_SYMBOL_08' => -50,
			'OPERATOR_SYMBOL_14' => -50,
			'OPERATOR_SYMBOL_09' => -50
		}
	},
	{#State 116
		ACTIONS => {
			");" => -61,
			'OPERATOR_SYMBOL_24' => -61,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			";" => -61,
			'OPERATOR_SYMBOL_16' => -61,
			'OPERATOR_SYMBOL_23' => -61,
			".." => -61,
			"]" => -61,
			")" => -61,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_17' => -61,
			"}" => -61,
			"," => -61,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_08' => 56
		}
	},
	{#State 117
		ACTIONS => {
			".." => -64,
			'OPERATOR_SYMBOL_23' => -64,
			";" => -64,
			'OPERATOR_SYMBOL_16' => 62,
			"]" => -64,
			")" => -64,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_24' => -64,
			");" => -64,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_04' => 61,
			"," => -64,
			"}" => -64,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_09' => 51
		}
	},
	{#State 118
		ACTIONS => {
			"= sub {" => 147
		}
	},
	{#State 119
		DEFAULT => -85
	},
	{#State 120
		ACTIONS => {
			"(" => 148
		}
	},
	{#State 121
		ACTIONS => {
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_16' => 62,
			";" => 149,
			'OPERATOR_SYMBOL_23' => 64,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_24' => 58
		}
	},
	{#State 122
		ACTIONS => {
			")" => 150
		}
	},
	{#State 123
		DEFAULT => -45
	},
	{#State 124
		DEFAULT => -110
	},
	{#State 125
		ACTIONS => {
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			"[" => 34,
			'LITERAL' => 20,
			"{" => 36,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_10' => 30
		},
		GOTOS => {
			'Expression' => 151,
			'Operator' => 39,
			'Variable' => 67
		}
	},
	{#State 126
		ACTIONS => {
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_03' => 26,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34,
			'OPERATOR_SYMBOL_10' => 30,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31
		},
		GOTOS => {
			'Expression' => 152,
			'Operator' => 39,
			'Variable' => 67
		}
	},
	{#State 127
		ACTIONS => {
			"(" => 153
		}
	},
	{#State 128
		ACTIONS => {
			'VARIABLE_SYMBOL' => 154
		}
	},
	{#State 129
		ACTIONS => {
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34,
			'OPERATOR_SYMBOL_10' => 30,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_03' => 26,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25
		},
		GOTOS => {
			'Operator' => 39,
			'Variable' => 67,
			'Expression' => 155
		}
	},
	{#State 130
		ACTIONS => {
			"]" => -121,
			")" => -121,
			"," => 156
		},
		GOTOS => {
			'PAREN-30' => 157
		}
	},
	{#State 131
		ACTIONS => {
			'VARIABLE_SYMBOL' => 32
		},
		GOTOS => {
			'Variable' => 158
		}
	},
	{#State 132
		ACTIONS => {
			"}" => 159
		}
	},
	{#State 133
		DEFAULT => -80
	},
	{#State 134
		ACTIONS => {
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_10' => 30,
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34,
			'OPERATOR_SYMBOL_22' => 25,
			"%{" => 162,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26
		},
		GOTOS => {
			'Variable' => 67,
			'Operator' => 39,
			'Expression' => 161,
			'HashEntryValue' => 160
		}
	},
	{#State 135
		DEFAULT => -81
	},
	{#State 136
		DEFAULT => -68
	},
	{#State 137
		ACTIONS => {
			'OPERATOR_SYMBOL_19' => 164,
			";" => 163
		}
	},
	{#State 138
		ACTIONS => {
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_24' => 58,
			")" => 165,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_23' => 64,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_13' => 54
		}
	},
	{#State 139
		ACTIONS => {
			")" => 166
		}
	},
	{#State 140
		DEFAULT => -74
	},
	{#State 141
		DEFAULT => -132
	},
	{#State 142
		ACTIONS => {
			'WORD_SCOPED' => 167,
			");" => 168
		}
	},
	{#State 143
		DEFAULT => -14
	},
	{#State 144
		DEFAULT => -12
	},
	{#State 145
		ACTIONS => {
			"use RPerl;" => 169
		}
	},
	{#State 146
		ACTIONS => {
			";" => 170
		}
	},
	{#State 147
		ACTIONS => {
			"(" => -35,
			'OPERATOR_SYMBOL_03' => -35,
			"for my integer" => -35,
			'OPERATOR_SYMBOL_22' => -35,
			'OPERATOR_VOID' => -35,
			'LITERAL' => -35,
			"foreach my" => -35,
			'ARGUMENTS_BEGIN' => 173,
			'LOOP_LABEL' => -35,
			'OPERATOR_SYMBOL_05' => -35,
			'WORD_SCOPED' => -35,
			'OPERATOR_SYMBOL_19a' => -35,
			"if" => -35,
			"my" => -35,
			"{" => -35,
			"[" => -35,
			'OPERATOR_SYMBOL_10' => -35,
			'OPERATOR_SYMBOL_01' => -35,
			'VARIABLE_SYMBOL' => -35,
			"while" => -35
		},
		GOTOS => {
			'OPTIONAL-12' => 171,
			'SubroutineArguments' => 172
		}
	},
	{#State 148
		ACTIONS => {
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'KEYS_OR_VALUES' => 87,
			")" => -77,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			"[" => 34,
			'LITERAL' => 20,
			"{" => 36,
			"\@{" => 88,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_10' => 30
		},
		GOTOS => {
			'ListElementValue' => 86,
			'Expression' => 84,
			'ListElements' => 175,
			'Operator' => 39,
			'Variable' => 67,
			'OPTIONAL-21' => 174
		}
	},
	{#State 149
		DEFAULT => -117
	},
	{#State 150
		DEFAULT => -47
	},
	{#State 151
		ACTIONS => {
			'OPERATOR_SYMBOL_23' => 64,
			"}" => 176,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_24' => 58,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_09' => 51
		}
	},
	{#State 152
		ACTIONS => {
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_24' => 58,
			"]" => 177,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_23' => 64,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_17' => 53
		}
	},
	{#State 153
		ACTIONS => {
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			'OPERATOR_SYMBOL_03' => 26,
			"(" => 27,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_10' => 30,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'LITERAL' => 20,
			"[" => 34,
			"{" => 36
		},
		GOTOS => {
			'Variable' => 67,
			'Operator' => 39,
			'Expression' => 178
		}
	},
	{#State 154
		ACTIONS => {
			"(" => 179
		}
	},
	{#State 155
		ACTIONS => {
			'OPERATOR_SYMBOL_24' => 58,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_23' => 64,
			'OPERATOR_SYMBOL_14' => 55,
			")" => 180,
			'OPERATOR_SYMBOL_08' => 56
		}
	},
	{#State 156
		ACTIONS => {
			"{" => 36,
			"\@{" => 88,
			"[" => 34,
			'LITERAL' => 20,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_05' => 46,
			'KEYS_OR_VALUES' => 87,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41
		},
		GOTOS => {
			'Variable' => 67,
			'Operator' => 39,
			'Expression' => 84,
			'ListElementValue' => 181
		}
	},
	{#State 157
		DEFAULT => -119
	},
	{#State 158
		ACTIONS => {
			"}" => 182
		}
	},
	{#State 159
		DEFAULT => -123
	},
	{#State 160
		DEFAULT => -127,
		GOTOS => {
			'STAR-33' => 183
		}
	},
	{#State 161
		ACTIONS => {
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => 55,
			"," => -129,
			"}" => -129,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_23' => 64,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_24' => 58,
			'OPERATOR_SYMBOL_15' => 57,
			");" => -129
		}
	},
	{#State 162
		ACTIONS => {
			'VARIABLE_SYMBOL' => 32
		},
		GOTOS => {
			'Variable' => 184
		}
	},
	{#State 163
		DEFAULT => -115
	},
	{#State 164
		ACTIONS => {
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_10' => 30
		},
		GOTOS => {
			'Expression' => 185,
			'Variable' => 67,
			'Operator' => 39
		}
	},
	{#State 165
		ACTIONS => {
			"{" => 186
		},
		GOTOS => {
			'CodeBlock' => 187
		}
	},
	{#State 166
		DEFAULT => -83
	},
	{#State 167
		DEFAULT => -131
	},
	{#State 168
		ACTIONS => {
			"our %properties" => 188
		},
		GOTOS => {
			'Properties' => 189
		}
	},
	{#State 169
		DEFAULT => -16,
		GOTOS => {
			'STAR-5' => 190
		}
	},
	{#State 170
		DEFAULT => -69
	},
	{#State 171
		ACTIONS => {
			'OPERATOR_SYMBOL_05' => 46,
			'LOOP_LABEL' => 45,
			'WORD_SCOPED' => 41,
			"if" => 40,
			"my" => 38,
			'OPERATOR_SYMBOL_19a' => 37,
			"{" => 36,
			"[" => 34,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_10' => 30,
			"while" => -88,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_22' => 25,
			"for my integer" => -88,
			'OPERATOR_VOID' => 21,
			'LITERAL' => 20,
			"foreach my" => -88
		},
		GOTOS => {
			'VariableDeclaration' => 47,
			'PAREN-22' => 44,
			'VariableModification' => 42,
			'Statement' => 43,
			'Operator' => 39,
			'Operation' => 191,
			'Expression' => 22,
			'Conditional' => 35,
			'OPTIONAL-23' => 33,
			'OperatorVoid' => 18,
			'Variable' => 29,
			'PLUS-13' => 192
		}
	},
	{#State 172
		DEFAULT => -34
	},
	{#State 173
		ACTIONS => {
			'TYPE' => 193
		}
	},
	{#State 174
		ACTIONS => {
			")" => 194
		}
	},
	{#State 175
		DEFAULT => -76
	},
	{#State 176
		DEFAULT => -114
	},
	{#State 177
		DEFAULT => -113
	},
	{#State 178
		ACTIONS => {
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_24' => 58,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_23' => 64,
			".." => 195,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_14' => 55
		}
	},
	{#State 179
		ACTIONS => {
			'OPERATOR_SYMBOL_05' => 46,
			'KEYS_OR_VALUES' => 87,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_22' => 25,
			"{" => 36,
			"\@{" => 88,
			'LITERAL' => 20,
			"[" => 34,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_10' => 30
		},
		GOTOS => {
			'ListElementValue' => 86,
			'ListElements' => 196,
			'Expression' => 84,
			'Operator' => 39,
			'Variable' => 67
		}
	},
	{#State 180
		ACTIONS => {
			"{" => 186
		},
		GOTOS => {
			'CodeBlock' => 197
		}
	},
	{#State 181
		DEFAULT => -118
	},
	{#State 182
		DEFAULT => -124
	},
	{#State 183
		ACTIONS => {
			");" => -128,
			"}" => -128,
			"," => 199
		},
		GOTOS => {
			'PAREN-32' => 198
		}
	},
	{#State 184
		ACTIONS => {
			"}" => 200
		}
	},
	{#State 185
		ACTIONS => {
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_13' => 54,
			";" => 201,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_23' => 64,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_08' => 56,
			'OPERATOR_SYMBOL_24' => 58,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_11' => 59
		}
	},
	{#State 186
		ACTIONS => {
			'OPERATOR_SYMBOL_03' => 26,
			"(" => 27,
			"for my integer" => -88,
			'OPERATOR_SYMBOL_22' => 25,
			'LITERAL' => 20,
			'OPERATOR_VOID' => 21,
			"foreach my" => -88,
			'OPERATOR_SYMBOL_05' => 46,
			'LOOP_LABEL' => 45,
			"my" => 38,
			"if" => 40,
			'OPERATOR_SYMBOL_19a' => 37,
			'WORD_SCOPED' => 41,
			"[" => 34,
			"{" => 36,
			"while" => -88,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_10' => 30
		},
		GOTOS => {
			'Operator' => 39,
			'Statement' => 43,
			'VariableModification' => 42,
			'PAREN-22' => 44,
			'VariableDeclaration' => 47,
			'PLUS-28' => 202,
			'Variable' => 29,
			'OperatorVoid' => 18,
			'OPTIONAL-23' => 33,
			'Conditional' => 35,
			'Expression' => 22,
			'Operation' => 203
		}
	},
	{#State 187
		DEFAULT => -96,
		GOTOS => {
			'STAR-25' => 204
		}
	},
	{#State 188
		ACTIONS => {
			"=" => 205
		}
	},
	{#State 189
		DEFAULT => -134,
		GOTOS => {
			'STAR-35' => 206
		}
	},
	{#State 190
		ACTIONS => {
			"if" => -18,
			"my" => -18,
			'OPERATOR_SYMBOL_19a' => -18,
			'WORD_SCOPED' => -18,
			'OPERATOR_SYMBOL_05' => -18,
			'LOOP_LABEL' => -18,
			"while" => -18,
			'VARIABLE_SYMBOL' => -18,
			'OPERATOR_SYMBOL_01' => -18,
			'OPERATOR_SYMBOL_10' => -18,
			"[" => -18,
			"{" => -18,
			"use constant" => -18,
			"our" => -18,
			"for my integer" => -18,
			"use" => 207,
			'OPERATOR_SYMBOL_22' => -18,
			'OPERATOR_SYMBOL_03' => -18,
			"(" => -18,
			"foreach my" => -18,
			"use parent qw(" => -18,
			'LITERAL' => -18,
			'OPERATOR_VOID' => -18
		},
		GOTOS => {
			'STAR-6' => 209,
			'Include' => 208
		}
	},
	{#State 191
		DEFAULT => -37
	},
	{#State 192
		ACTIONS => {
			'OPERATOR_SYMBOL_19a' => 37,
			"my" => 38,
			"if" => 40,
			'WORD_SCOPED' => 41,
			'LOOP_LABEL' => 45,
			'OPERATOR_SYMBOL_05' => 46,
			"while" => -88,
			'OPERATOR_SYMBOL_10' => 30,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			"[" => 34,
			"{" => 36,
			"};" => 211,
			"for my integer" => -88,
			'OPERATOR_SYMBOL_22' => 25,
			'OPERATOR_SYMBOL_03' => 26,
			"(" => 27,
			"foreach my" => -88,
			'LITERAL' => 20,
			'OPERATOR_VOID' => 21
		},
		GOTOS => {
			'Operation' => 210,
			'Expression' => 22,
			'Conditional' => 35,
			'OPTIONAL-23' => 33,
			'OperatorVoid' => 18,
			'Variable' => 29,
			'VariableDeclaration' => 47,
			'PAREN-22' => 44,
			'VariableModification' => 42,
			'Statement' => 43,
			'Operator' => 39
		}
	},
	{#State 193
		ACTIONS => {
			'VARIABLE_SYMBOL' => 212
		}
	},
	{#State 194
		DEFAULT => -84
	},
	{#State 195
		ACTIONS => {
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_10' => 30,
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34
		},
		GOTOS => {
			'Expression' => 213,
			'Variable' => 67,
			'Operator' => 39
		}
	},
	{#State 196
		ACTIONS => {
			")" => 214
		}
	},
	{#State 197
		DEFAULT => -106
	},
	{#State 198
		DEFAULT => -126
	},
	{#State 199
		ACTIONS => {
			'WORD' => 215
		}
	},
	{#State 200
		DEFAULT => -130
	},
	{#State 201
		DEFAULT => -116
	},
	{#State 202
		ACTIONS => {
			'WORD_SCOPED' => 41,
			'OPERATOR_SYMBOL_19a' => 37,
			"my" => 38,
			"if" => 40,
			'LOOP_LABEL' => 45,
			'OPERATOR_SYMBOL_05' => 46,
			'OPERATOR_SYMBOL_10' => 30,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			"while" => -88,
			"{" => 36,
			"[" => 34,
			'OPERATOR_SYMBOL_22' => 25,
			"for my integer" => -88,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			"}" => 216,
			"foreach my" => -88,
			'OPERATOR_VOID' => 21,
			'LITERAL' => 20
		},
		GOTOS => {
			'Conditional' => 35,
			'Expression' => 22,
			'Operation' => 217,
			'Variable' => 29,
			'OperatorVoid' => 18,
			'OPTIONAL-23' => 33,
			'PAREN-22' => 44,
			'VariableDeclaration' => 47,
			'Operator' => 39,
			'Statement' => 43,
			'VariableModification' => 42
		}
	},
	{#State 203
		DEFAULT => -108
	},
	{#State 204
		ACTIONS => {
			"{" => -99,
			"[" => -99,
			'VARIABLE_SYMBOL' => -99,
			'OPERATOR_SYMBOL_01' => -99,
			'OPERATOR_SYMBOL_10' => -99,
			"while" => -99,
			'' => -99,
			'OPERATOR_SYMBOL_05' => -99,
			'LOOP_LABEL' => -99,
			"else" => 221,
			'WORD_SCOPED' => -99,
			"if" => -99,
			"my" => -99,
			'OPERATOR_SYMBOL_19a' => -99,
			'OPERATOR_VOID' => -99,
			'LITERAL' => -99,
			"foreach my" => -99,
			"(" => -99,
			'OPERATOR_SYMBOL_03' => -99,
			"}" => -99,
			'OPERATOR_SYMBOL_22' => -99,
			"for my integer" => -99,
			"elsif" => 218,
			"};" => -99
		},
		GOTOS => {
			'OPTIONAL-27' => 222,
			'PAREN-24' => 219,
			'PAREN-26' => 220
		}
	},
	{#State 205
		ACTIONS => {
			"(" => 223
		}
	},
	{#State 206
		ACTIONS => {
			"our" => 226,
			"1;" => 224
		},
		GOTOS => {
			'Method' => 225
		}
	},
	{#State 207
		ACTIONS => {
			'WORD_SCOPED' => 227
		}
	},
	{#State 208
		DEFAULT => -15
	},
	{#State 209
		ACTIONS => {
			"{" => -19,
			"use constant" => 229,
			"[" => -19,
			'OPERATOR_SYMBOL_01' => -19,
			'VARIABLE_SYMBOL' => -19,
			'OPERATOR_SYMBOL_10' => -19,
			"while" => -19,
			'OPERATOR_SYMBOL_05' => -19,
			'LOOP_LABEL' => -19,
			'WORD_SCOPED' => -19,
			"if" => -19,
			"my" => -19,
			'OPERATOR_SYMBOL_19a' => -19,
			'OPERATOR_VOID' => -19,
			"use parent qw(" => -19,
			'LITERAL' => -19,
			"foreach my" => -19,
			"(" => -19,
			'OPERATOR_SYMBOL_03' => -19,
			'OPERATOR_SYMBOL_22' => -19,
			"for my integer" => -19,
			"our" => -19
		},
		GOTOS => {
			'Constant' => 228
		}
	},
	{#State 210
		DEFAULT => -36
	},
	{#State 211
		DEFAULT => -38
	},
	{#State 212
		DEFAULT => -41,
		GOTOS => {
			'STAR-15' => 230
		}
	},
	{#State 213
		ACTIONS => {
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_24' => 58,
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_23' => 64,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_08' => 56,
			")" => 231
		}
	},
	{#State 214
		ACTIONS => {
			"{" => 186
		},
		GOTOS => {
			'CodeBlock' => 232
		}
	},
	{#State 215
		ACTIONS => {
			"=>" => 233
		}
	},
	{#State 216
		DEFAULT => -109
	},
	{#State 217
		DEFAULT => -107
	},
	{#State 218
		ACTIONS => {
			"(" => 234
		}
	},
	{#State 219
		DEFAULT => -95
	},
	{#State 220
		DEFAULT => -98
	},
	{#State 221
		ACTIONS => {
			"{" => 186
		},
		GOTOS => {
			'CodeBlock' => 235
		}
	},
	{#State 222
		DEFAULT => -100
	},
	{#State 223
		ACTIONS => {
			'WORD' => 90,
			");" => -137
		},
		GOTOS => {
			'OPTIONAL-36' => 236,
			'HashEntries' => 237
		}
	},
	{#State 224
		DEFAULT => -135
	},
	{#State 225
		DEFAULT => -133
	},
	{#State 226
		ACTIONS => {
			'TYPE' => 238
		}
	},
	{#State 227
		ACTIONS => {
			"qw(" => 240,
			";" => 239
		}
	},
	{#State 228
		DEFAULT => -17
	},
	{#State 229
		ACTIONS => {
			'WORD' => 241
		}
	},
	{#State 230
		ACTIONS => {
			'ARGUMENTS_END' => 243,
			"," => 244
		},
		GOTOS => {
			'PAREN-14' => 242
		}
	},
	{#State 231
		ACTIONS => {
			"{" => 186
		},
		GOTOS => {
			'CodeBlock' => 245
		}
	},
	{#State 232
		DEFAULT => -105
	},
	{#State 233
		ACTIONS => {
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			'WORD_SCOPED' => 41,
			"%{" => 162,
			'OPERATOR_SYMBOL_22' => 25,
			"{" => 36,
			'LITERAL' => 20,
			"[" => 34,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_10' => 30
		},
		GOTOS => {
			'HashEntryValue' => 246,
			'Expression' => 161,
			'Operator' => 39,
			'Variable' => 67
		}
	},
	{#State 234
		ACTIONS => {
			"{" => 36,
			"[" => 34,
			'LITERAL' => 20,
			'OPERATOR_SYMBOL_01' => 31,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_05' => 46,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26,
			'OPERATOR_SYMBOL_22' => 25,
			'WORD_SCOPED' => 41
		},
		GOTOS => {
			'Variable' => 67,
			'Operator' => 39,
			'Expression' => 247
		}
	},
	{#State 235
		DEFAULT => -97
	},
	{#State 236
		ACTIONS => {
			");" => 248
		}
	},
	{#State 237
		DEFAULT => -136
	},
	{#State 238
		ACTIONS => {
			'VARIABLE_SYMBOL' => 249
		}
	},
	{#State 239
		DEFAULT => -22
	},
	{#State 240
		ACTIONS => {
			'WORD' => 251
		},
		GOTOS => {
			'PLUS-7' => 250
		}
	},
	{#State 241
		ACTIONS => {
			"=>" => 252
		}
	},
	{#State 242
		DEFAULT => -40
	},
	{#State 243
		DEFAULT => -42
	},
	{#State 244
		ACTIONS => {
			"my" => 253
		}
	},
	{#State 245
		DEFAULT => -104
	},
	{#State 246
		DEFAULT => -125
	},
	{#State 247
		ACTIONS => {
			'OPERATOR_SYMBOL_09' => 51,
			'OPERATOR_SYMBOL_11' => 59,
			'OPERATOR_SYMBOL_12' => 60,
			'OPERATOR_SYMBOL_04' => 61,
			'OPERATOR_SYMBOL_24' => 58,
			'OPERATOR_SYMBOL_15' => 57,
			'OPERATOR_SYMBOL_14' => 55,
			'OPERATOR_SYMBOL_08' => 56,
			")" => 254,
			'OPERATOR_SYMBOL_16' => 62,
			'OPERATOR_SYMBOL_17' => 53,
			'OPERATOR_SYMBOL_13' => 54,
			'OPERATOR_SYMBOL_07' => 52,
			'OPERATOR_SYMBOL_23' => 64
		}
	},
	{#State 248
		DEFAULT => -138
	},
	{#State 249
		ACTIONS => {
			"= sub {" => 255
		}
	},
	{#State 250
		ACTIONS => {
			'WORD' => 256,
			");" => 257
		}
	},
	{#State 251
		DEFAULT => -21
	},
	{#State 252
		ACTIONS => {
			'LITERAL' => 258,
			"[" => 259,
			"{" => 260
		},
		GOTOS => {
			'Constant_Value' => 261
		}
	},
	{#State 253
		ACTIONS => {
			'TYPE' => 262
		}
	},
	{#State 254
		ACTIONS => {
			"{" => 186
		},
		GOTOS => {
			'CodeBlock' => 263
		}
	},
	{#State 255
		ACTIONS => {
			'LITERAL' => -140,
			'OPERATOR_VOID' => -140,
			'ARGUMENTS_BEGIN' => 265,
			"foreach my" => -140,
			'OPERATOR_SYMBOL_03' => -140,
			"(" => -140,
			'OPERATOR_SYMBOL_22' => -140,
			"for my integer" => -140,
			"[" => -140,
			"{" => -140,
			"while" => -140,
			'OPERATOR_SYMBOL_10' => -140,
			'OPERATOR_SYMBOL_01' => -140,
			'VARIABLE_SYMBOL' => -140,
			'LOOP_LABEL' => -140,
			'OPERATOR_SYMBOL_05' => -140,
			'OPERATOR_SYMBOL_19a' => -140,
			"my" => -140,
			"if" => -140,
			'WORD_SCOPED' => -140
		},
		GOTOS => {
			'MethodArguments' => 266,
			'OPTIONAL-37' => 264
		}
	},
	{#State 256
		DEFAULT => -20
	},
	{#State 257
		DEFAULT => -23
	},
	{#State 258
		DEFAULT => -31
	},
	{#State 259
		ACTIONS => {
			'LITERAL' => 267
		}
	},
	{#State 260
		ACTIONS => {
			'WORD' => 268
		}
	},
	{#State 261
		ACTIONS => {
			";" => 269
		}
	},
	{#State 262
		ACTIONS => {
			'VARIABLE_SYMBOL' => 270
		}
	},
	{#State 263
		DEFAULT => -94
	},
	{#State 264
		ACTIONS => {
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_10' => 30,
			"while" => -88,
			"{" => 36,
			"[" => 34,
			'WORD_SCOPED' => 41,
			"my" => 38,
			"if" => 40,
			'OPERATOR_SYMBOL_19a' => 37,
			'OPERATOR_SYMBOL_05' => 46,
			'LOOP_LABEL' => 45,
			"foreach my" => -88,
			'OPERATOR_VOID' => 21,
			'LITERAL' => 20,
			'OPERATOR_SYMBOL_22' => 25,
			"for my integer" => -88,
			"(" => 27,
			'OPERATOR_SYMBOL_03' => 26
		},
		GOTOS => {
			'Variable' => 29,
			'OperatorVoid' => 18,
			'OPTIONAL-23' => 33,
			'PLUS-38' => 272,
			'Conditional' => 35,
			'Operation' => 271,
			'Expression' => 22,
			'Operator' => 39,
			'Statement' => 43,
			'VariableModification' => 42,
			'PAREN-22' => 44,
			'VariableDeclaration' => 47
		}
	},
	{#State 265
		ACTIONS => {
			'TYPE' => 273
		}
	},
	{#State 266
		DEFAULT => -139
	},
	{#State 267
		DEFAULT => -27,
		GOTOS => {
			'STAR-9' => 274
		}
	},
	{#State 268
		ACTIONS => {
			"=>" => 275
		}
	},
	{#State 269
		DEFAULT => -24
	},
	{#State 270
		DEFAULT => -39
	},
	{#State 271
		DEFAULT => -142
	},
	{#State 272
		ACTIONS => {
			'OPERATOR_SYMBOL_05' => 46,
			'LOOP_LABEL' => 45,
			"if" => 40,
			"my" => 38,
			'OPERATOR_SYMBOL_19a' => 37,
			'WORD_SCOPED' => 41,
			"[" => 34,
			"{" => 36,
			"while" => -88,
			'VARIABLE_SYMBOL' => 32,
			'OPERATOR_SYMBOL_01' => 31,
			'OPERATOR_SYMBOL_10' => 30,
			'OPERATOR_SYMBOL_03' => 26,
			"(" => 27,
			"};" => 277,
			"for my integer" => -88,
			'OPERATOR_SYMBOL_22' => 25,
			'LITERAL' => 20,
			'OPERATOR_VOID' => 21,
			"foreach my" => -88
		},
		GOTOS => {
			'OPTIONAL-23' => 33,
			'OperatorVoid' => 18,
			'Variable' => 29,
			'Conditional' => 35,
			'Expression' => 22,
			'Operation' => 276,
			'VariableModification' => 42,
			'Statement' => 43,
			'Operator' => 39,
			'VariableDeclaration' => 47,
			'PAREN-22' => 44
		}
	},
	{#State 273
		ACTIONS => {
			'CLASS_OR_SELF' => 278
		}
	},
	{#State 274
		ACTIONS => {
			"]" => 279,
			"," => 281
		},
		GOTOS => {
			'PAREN-8' => 280
		}
	},
	{#State 275
		ACTIONS => {
			'LITERAL' => 282
		}
	},
	{#State 276
		DEFAULT => -141
	},
	{#State 277
		DEFAULT => -143
	},
	{#State 278
		DEFAULT => -146,
		GOTOS => {
			'STAR-40' => 283
		}
	},
	{#State 279
		DEFAULT => -32
	},
	{#State 280
		DEFAULT => -26
	},
	{#State 281
		ACTIONS => {
			'LITERAL' => 284
		}
	},
	{#State 282
		DEFAULT => -30,
		GOTOS => {
			'STAR-11' => 285
		}
	},
	{#State 283
		ACTIONS => {
			"," => 288,
			'ARGUMENTS_END' => 287
		},
		GOTOS => {
			'PAREN-39' => 286
		}
	},
	{#State 284
		DEFAULT => -25
	},
	{#State 285
		ACTIONS => {
			"," => 290,
			"}" => 289
		},
		GOTOS => {
			'PAREN-10' => 291
		}
	},
	{#State 286
		DEFAULT => -145
	},
	{#State 287
		DEFAULT => -147
	},
	{#State 288
		ACTIONS => {
			"my" => 292
		}
	},
	{#State 289
		DEFAULT => -33
	},
	{#State 290
		ACTIONS => {
			'WORD' => 293
		}
	},
	{#State 291
		DEFAULT => -29
	},
	{#State 292
		ACTIONS => {
			'TYPE' => 294
		}
	},
	{#State 293
		ACTIONS => {
			"=>" => 295
		}
	},
	{#State 294
		ACTIONS => {
			'VARIABLE_SYMBOL' => 296
		}
	},
	{#State 295
		ACTIONS => {
			'LITERAL' => 297
		}
	},
	{#State 296
		DEFAULT => -144
	},
	{#State 297
		DEFAULT => -28
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 3419 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 87 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3426 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 87 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3433 ./Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3440 ./Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3447 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 88 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3454 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 88 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3461 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-3', 2,
sub {
#line 88 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3468 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-3', 1,
sub {
#line 88 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3475 ./Grammar.pm
	],
	[#Rule Program_9
		 'Program', 4,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3482 ./Grammar.pm
	],
	[#Rule Module_10
		 'Module', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3489 ./Grammar.pm
	],
	[#Rule Module_11
		 'Module', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3496 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-4', 2,
sub {
#line 90 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3503 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-4', 1,
sub {
#line 90 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3510 ./Grammar.pm
	],
	[#Rule Package_14
		 'Package', 6,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3517 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 91 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3524 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 91 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3531 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 91 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3538 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 91 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3545 ./Grammar.pm
	],
	[#Rule Header_19
		 'Header', 9,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3552 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-7', 2,
sub {
#line 92 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3559 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-7', 1,
sub {
#line 92 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3566 ./Grammar.pm
	],
	[#Rule Include_22
		 'Include', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3573 ./Grammar.pm
	],
	[#Rule Include_23
		 'Include', 5,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3580 ./Grammar.pm
	],
	[#Rule Constant_24
		 'Constant', 5,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3587 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-8', 2,
sub {
#line 94 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 3594 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 94 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3601 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 94 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3608 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-10', 4,
sub {
#line 94 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 3615 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 94 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3622 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 94 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3629 ./Grammar.pm
	],
	[#Rule Constant_Value_31
		 'Constant_Value', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3636 ./Grammar.pm
	],
	[#Rule Constant_Value_32
		 'Constant_Value', 4,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3643 ./Grammar.pm
	],
	[#Rule Constant_Value_33
		 'Constant_Value', 6,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3650 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 95 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3657 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 95 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3664 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 95 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3671 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 95 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3678 ./Grammar.pm
	],
	[#Rule Subroutine_38
		 'Subroutine', 7,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3685 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-14', 4,
sub {
#line 96 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 3692 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-15', 2,
sub {
#line 96 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3699 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-15', 0,
sub {
#line 96 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3706 ./Grammar.pm
	],
	[#Rule SubroutineArguments_42
		 'SubroutineArguments', 5,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3713 ./Grammar.pm
	],
	[#Rule Operation_43
		 'Operation', 2,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3720 ./Grammar.pm
	],
	[#Rule Operation_44
		 'Operation', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3727 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 99 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3734 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 99 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3741 ./Grammar.pm
	],
	[#Rule Operator_47
		 'Operator', 4,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3748 ./Grammar.pm
	],
	[#Rule Operator_48
		 'Operator', 2,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3755 ./Grammar.pm
	],
	[#Rule Operator_49
		 'Operator', 2,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3762 ./Grammar.pm
	],
	[#Rule Operator_50
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3769 ./Grammar.pm
	],
	[#Rule Operator_51
		 'Operator', 2,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3776 ./Grammar.pm
	],
	[#Rule Operator_52
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3783 ./Grammar.pm
	],
	[#Rule Operator_53
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3790 ./Grammar.pm
	],
	[#Rule Operator_54
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3797 ./Grammar.pm
	],
	[#Rule Operator_55
		 'Operator', 2,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3804 ./Grammar.pm
	],
	[#Rule Operator_56
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3811 ./Grammar.pm
	],
	[#Rule Operator_57
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3818 ./Grammar.pm
	],
	[#Rule Operator_58
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3825 ./Grammar.pm
	],
	[#Rule Operator_59
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3832 ./Grammar.pm
	],
	[#Rule Operator_60
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3839 ./Grammar.pm
	],
	[#Rule Operator_61
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3846 ./Grammar.pm
	],
	[#Rule Operator_62
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3853 ./Grammar.pm
	],
	[#Rule Operator_63
		 'Operator', 2,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3860 ./Grammar.pm
	],
	[#Rule Operator_64
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3867 ./Grammar.pm
	],
	[#Rule Operator_65
		 'Operator', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3874 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 106 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3881 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 106 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3888 ./Grammar.pm
	],
	[#Rule OperatorVoid_68
		 'OperatorVoid', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3895 ./Grammar.pm
	],
	[#Rule OperatorVoid_69
		 'OperatorVoid', 5,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3902 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 107 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3909 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 107 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3916 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 107 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3923 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 107 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3930 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-20', 1,
sub {
#line 108 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3937 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-20', 0,
sub {
#line 108 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3944 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 108 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3951 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 108 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3958 ./Grammar.pm
	],
	[#Rule Expression_78
		 'Expression', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3965 ./Grammar.pm
	],
	[#Rule Expression_79
		 'Expression', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3972 ./Grammar.pm
	],
	[#Rule Expression_80
		 'Expression', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3979 ./Grammar.pm
	],
	[#Rule Expression_81
		 'Expression', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3986 ./Grammar.pm
	],
	[#Rule Expression_82
		 'Expression', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3993 ./Grammar.pm
	],
	[#Rule Expression_83
		 'Expression', 4,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4000 ./Grammar.pm
	],
	[#Rule Expression_84
		 'Expression', 6,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4007 ./Grammar.pm
	],
	[#Rule Expression_85
		 'Expression', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4014 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-22', 2,
sub {
#line 109 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4021 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 109 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4028 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 109 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4035 ./Grammar.pm
	],
	[#Rule Statement_89
		 'Statement', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4042 ./Grammar.pm
	],
	[#Rule Statement_90
		 'Statement', 2,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4049 ./Grammar.pm
	],
	[#Rule Statement_91
		 'Statement', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4056 ./Grammar.pm
	],
	[#Rule Statement_92
		 'Statement', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4063 ./Grammar.pm
	],
	[#Rule Statement_93
		 'Statement', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4070 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 5,
sub {
#line 110 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4077 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 110 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4084 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 110 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4091 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 2,
sub {
#line 110 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4098 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 110 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4105 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 110 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4112 ./Grammar.pm
	],
	[#Rule Conditional_100
		 'Conditional', 7,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4119 ./Grammar.pm
	],
	[#Rule Loop_101
		 'Loop', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4126 ./Grammar.pm
	],
	[#Rule Loop_102
		 'Loop', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4133 ./Grammar.pm
	],
	[#Rule Loop_103
		 'Loop', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4140 ./Grammar.pm
	],
	[#Rule LoopFor_104
		 'LoopFor', 8,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4147 ./Grammar.pm
	],
	[#Rule LoopForEach_105
		 'LoopForEach', 7,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4154 ./Grammar.pm
	],
	[#Rule LoopWhile_106
		 'LoopWhile', 5,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4161 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-28', 2,
sub {
#line 115 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4168 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-28', 1,
sub {
#line 115 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4175 ./Grammar.pm
	],
	[#Rule CodeBlock_109
		 'CodeBlock', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4182 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 117 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4189 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 117 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4196 ./Grammar.pm
	],
	[#Rule Variable_112
		 'Variable', 2,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4203 ./Grammar.pm
	],
	[#Rule VariableRetrieval_113
		 'VariableRetrieval', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4210 ./Grammar.pm
	],
	[#Rule VariableRetrieval_114
		 'VariableRetrieval', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4217 ./Grammar.pm
	],
	[#Rule VariableDeclaration_115
		 'VariableDeclaration', 4,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4224 ./Grammar.pm
	],
	[#Rule VariableDeclaration_116
		 'VariableDeclaration', 6,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4231 ./Grammar.pm
	],
	[#Rule VariableModification_117
		 'VariableModification', 4,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4238 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 2,
sub {
#line 121 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4245 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 121 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4252 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 121 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4259 ./Grammar.pm
	],
	[#Rule ListElements_121
		 'ListElements', 2,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4266 ./Grammar.pm
	],
	[#Rule ListElementValue_122
		 'ListElementValue', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4273 ./Grammar.pm
	],
	[#Rule ListElementValue_123
		 'ListElementValue', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4280 ./Grammar.pm
	],
	[#Rule ListElementValue_124
		 'ListElementValue', 4,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4287 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 4,
sub {
#line 123 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4294 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 2,
sub {
#line 123 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4301 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 0,
sub {
#line 123 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4308 ./Grammar.pm
	],
	[#Rule HashEntries_128
		 'HashEntries', 4,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4315 ./Grammar.pm
	],
	[#Rule HashEntryValue_129
		 'HashEntryValue', 1,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4322 ./Grammar.pm
	],
	[#Rule HashEntryValue_130
		 'HashEntryValue', 3,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4329 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-34', 2,
sub {
#line 127 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4336 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-34', 1,
sub {
#line 127 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4343 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 2,
sub {
#line 127 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4350 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 0,
sub {
#line 127 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4357 ./Grammar.pm
	],
	[#Rule Class_135
		 'Class', 10,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4364 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 128 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4371 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 128 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4378 ./Grammar.pm
	],
	[#Rule Properties_138
		 'Properties', 5,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4385 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 129 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4392 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 129 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4399 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 129 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4406 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 129 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4413 ./Grammar.pm
	],
	[#Rule Method_143
		 'Method', 7,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4420 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 130 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4427 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 130 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4434 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 130 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4441 ./Grammar.pm
	],
	[#Rule MethodArguments_147
		 'MethodArguments', 5,
sub {
#line 82 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4448 ./Grammar.pm
	]
],
#line 4451 ./Grammar.pm
    yybypass       => 0,
    yybuildingtree => 1,
    yyprefix       => 'RPerl::',
    yyaccessors    => {
   },
    yyconflicthandlers => {}
,
    yystateconflict => {  },
    @_,
  );
  bless($self,$class);

  $self->make_node_classes('TERMINAL', '_OPTIONAL', '_STAR_LIST', '_PLUS_LIST', 
         '_SUPERSTART', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CompileUnit_3', 
         'CompileUnit_4', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Program_9', 
         'Module_10', 
         'Module_11', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Package_14', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Header_19', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Include_22', 
         'Include_23', 
         'Constant_24', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Constant_Value_31', 
         'Constant_Value_32', 
         'Constant_Value_33', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Subroutine_38', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_42', 
         'Operation_43', 
         'Operation_44', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Operator_47', 
         'Operator_48', 
         'Operator_49', 
         'Operator_50', 
         'Operator_51', 
         'Operator_52', 
         'Operator_53', 
         'Operator_54', 
         'Operator_55', 
         'Operator_56', 
         'Operator_57', 
         'Operator_58', 
         'Operator_59', 
         'Operator_60', 
         'Operator_61', 
         'Operator_62', 
         'Operator_63', 
         'Operator_64', 
         'Operator_65', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_68', 
         'OperatorVoid_69', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_78', 
         'Expression_79', 
         'Expression_80', 
         'Expression_81', 
         'Expression_82', 
         'Expression_83', 
         'Expression_84', 
         'Expression_85', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_89', 
         'Statement_90', 
         'Statement_91', 
         'Statement_92', 
         'Statement_93', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_100', 
         'Loop_101', 
         'Loop_102', 
         'Loop_103', 
         'LoopFor_104', 
         'LoopForEach_105', 
         'LoopWhile_106', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_109', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_112', 
         'VariableRetrieval_113', 
         'VariableRetrieval_114', 
         'VariableDeclaration_115', 
         'VariableDeclaration_116', 
         'VariableModification_117', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_121', 
         'ListElementValue_122', 
         'ListElementValue_123', 
         'ListElementValue_124', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashEntries_128', 
         'HashEntryValue_129', 
         'HashEntryValue_130', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Class_135', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Properties_138', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Method_143', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_147', );
  $self;
}

#line 132 "Grammar.eyp"


{
    1;
}

=for None

=cut


#line 4628 ./Grammar.pm



1;
