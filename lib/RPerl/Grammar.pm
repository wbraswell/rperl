########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.182.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'lib/RPerl/Grammar.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package RPerl::Grammar;
use strict;

push @RPerl::Grammar::ISA, 'Parse::Eyapp::Driver';




BEGIN {
  # This strange way to load the modules is to guarantee compatibility when
  # using several standalone and non-standalone Eyapp parsers

  require Parse::Eyapp::Driver unless Parse::Eyapp::Driver->can('YYParse');
  require Parse::Eyapp::Node unless Parse::Eyapp::Node->can('hnew'); 
}
  

sub unexpendedInput { defined($_) ? substr($_, (defined(pos $_) ? pos $_ : 0)) : '' }

#line 1 "lib/RPerl/Grammar.eyp"

    use strict;
    use warnings;
    our $VERSION = 0.000_300;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G(\s*(?:#.*)?\s*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|for\ my\ integer|our\ \$VERSION\ \=|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|use\ Carp\;|\=\ sub\ \{|while\ \(|\)\ \=\ \@_\;|elsif\ \(|package|\(\ my|if\ \(|else|qw\(|use|our|\.\.|\:\:|\)\;|1\;|\@\{|\{\*|\}\;|\%\{|my|\]|\{|\;|\:|\[|\(|\/|\)|\})}gc and return ($1, $1);

      /\G(^(\#\!\/[\w\/]*\/perl)$)/gc and return ('SHEBANG', $1);
      /\G(\d+\.\d{3}\_\d{3})/gc and return ('VERSION_NUMBER', $1);
      /\G((-?\d+(\.\d+)?)|('[^']*')|("[^"]*"))/gc and return ('LITERAL', $1);
      /\G(\$[a-zA-Z][\w(::)]*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(keys|values)/gc and return ('KEYS_OR_VALUES', $1);
      /\G(string\s+\$class|object\s+\$self)/gc and return ('TYPE_CLASS_OR_SELF', $1);
      /\G(or|xor)/gc and return ('OP24_LOGICAL_OR_XOR', $1);
      /\G(and)/gc and return ('OP23_LOGICAL_AND', $1);
      /\G(not)/gc and return ('OP22_LOGICAL_NOT', $1);
      /\G(,)/gc and return ('OP21_LIST_COMMA', $1);
      /\G(=>)/gc and return ('OP20_HASH_FATARROW', $1);
      /\G(next|last)/gc and return ('OP19_LOOP_CONTROL', $1);
      /\G(\?)/gc and return ('OP18_TERNARY', $1);
      /\G(\.\.)/gc and return ('OP17_LIST_RANGE', $1);
      /\G(\|\|)/gc and return ('OP16_LOGICAL_OR', $1);
      /\G(&&)/gc and return ('OP15_LOGICAL_AND', $1);
      /\G(\||\^)/gc and return ('OP14_BITWISE_OR_XOR', $1);
      /\G(&)/gc and return ('OP13_BITWISE_AND', $1);
      /\G(==|!=|eq|ne)/gc and return ('OP12_COMPARE_EQ_NEQ', $1);
      /\G(<<|>>)/gc and return ('OP09_BITWISE_SHIFT', $1);
      /\G(^.)/gc and return ('OP10_NAMED_UNARY', $1);
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(\+|-)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\*|\/|\%)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(^.)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(=|\+=|-=|\*=|\/=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-)/gc and return ('OP05_MATH_NEG', $1);
      /\G(<|>|<=|>=|lt|gt|le|ge)/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G(print|croak|return|exit)/gc and return ('OP01_NAMED_VOID', $1);
      /\G(^.)/gc and return ('OP01_NAMED', $1);
      /\G([a-zA-Z]\w*)/gc and return ('WORD', $1);


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


#line 107 lib/RPerl/Grammar.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@RPerl::Grammar::ISA variable inside the header section of the eyapp program?
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
  [ 'Package_14' => 'Package', [ 'package', 'WordScoped', ';', 'Header', 'PLUS-4', '1;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [ 'STAR-5', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [ 'STAR-6', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [  ], 0 ],
  [ 'Header_19' => 'Header', [ 'use strict;', 'use warnings;', 'our $VERSION =', 'VERSION_NUMBER', ';', 'use Carp;', 'use RPerl;', 'STAR-5', 'STAR-6' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-7', [ 'PLUS-7', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-7', [ 'WORD' ], 0 ],
  [ 'Include_22' => 'Include', [ 'use', 'WordScoped', ';' ], 0 ],
  [ 'Include_23' => 'Include', [ 'use', 'WordScoped', 'qw(', 'PLUS-7', ');' ], 0 ],
  [ 'Constant_24' => 'Constant', [ 'use constant', 'WORD', 'OP20_HASH_FATARROW', 'Constant_Value', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-8', [ 'OP21_LIST_COMMA', 'LITERAL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-9', [ 'STAR-9', 'PAREN-8' ], 0 ],
  [ '_STAR_LIST' => 'STAR-9', [  ], 0 ],
  [ '_PAREN' => 'PAREN-10', [ 'OP21_LIST_COMMA', 'WORD', 'OP20_HASH_FATARROW', 'LITERAL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [ 'STAR-11', 'PAREN-10' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [  ], 0 ],
  [ 'Constant_Value_31' => 'Constant_Value', [ 'LITERAL' ], 0 ],
  [ 'Constant_Value_32' => 'Constant_Value', [ '[', 'LITERAL', 'STAR-9', ']' ], 0 ],
  [ 'Constant_Value_33' => 'Constant_Value', [ '{', 'WORD', 'OP20_HASH_FATARROW', 'LITERAL', 'STAR-11', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-12', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-12', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'PLUS-13', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'Operation' ], 0 ],
  [ 'Subroutine_38' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-12', 'PLUS-13', '};' ], 0 ],
  [ '_PAREN' => 'PAREN-14', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-15', [ 'STAR-15', 'PAREN-14' ], 0 ],
  [ '_STAR_LIST' => 'STAR-15', [  ], 0 ],
  [ 'SubroutineArguments_42' => 'SubroutineArguments', [ '( my', 'Type', 'VARIABLE_SYMBOL', 'STAR-15', ') = @_;' ], 0 ],
  [ 'Operation_43' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_44' => 'Operation', [ 'Statement' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [  ], 0 ],
  [ 'Operator_47' => 'Operator', [ 'OP01_NAMED', '(', 'OPTIONAL-16', ')' ], 0 ],
  [ 'Operator_48' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_49' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_50' => 'Operator', [ 'Expression', 'OP04_MATH_POW', 'Expression' ], 0 ],
  [ 'Operator_51' => 'Operator', [ 'OP05_LOGICAL_NEG', 'Expression' ], 0 ],
  [ 'Operator_52' => 'Operator', [ 'OP05_MATH_NEG', 'Expression' ], 0 ],
  [ 'Operator_53' => 'Operator', [ 'Expression', 'OP06_REGEX_MATCH', '/', 'OP06_REGEX_PATTERN', '/' ], 0 ],
  [ 'Operator_54' => 'Operator', [ 'Expression', 'OP07_MATH_MULT_DIV_MOD', 'Expression' ], 0 ],
  [ 'Operator_55' => 'Operator', [ 'Expression', 'OP08_MATH_ADD_SUB', 'Expression' ], 0 ],
  [ 'Operator_56' => 'Operator', [ 'Expression', 'OP08_STRING_CAT', 'Expression' ], 0 ],
  [ 'Operator_57' => 'Operator', [ 'Expression', 'OP09_BITWISE_SHIFT', 'Expression' ], 0 ],
  [ 'Operator_58' => 'Operator', [ 'OP10_NAMED_UNARY', 'Expression' ], 0 ],
  [ 'Operator_59' => 'Operator', [ 'Expression', 'OP11_COMPARE_LT_GT', 'Expression' ], 0 ],
  [ 'Operator_60' => 'Operator', [ 'Expression', 'OP12_COMPARE_EQ_NEQ', 'Expression' ], 0 ],
  [ 'Operator_61' => 'Operator', [ 'Expression', 'OP13_BITWISE_AND', 'Expression' ], 0 ],
  [ 'Operator_62' => 'Operator', [ 'Expression', 'OP14_BITWISE_OR_XOR', 'Expression' ], 0 ],
  [ 'Operator_63' => 'Operator', [ 'Expression', 'OP15_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_64' => 'Operator', [ 'Expression', 'OP16_LOGICAL_OR', 'Expression' ], 0 ],
  [ 'Operator_65' => 'Operator', [ 'Expression', 'OP17_LIST_RANGE', 'Expression' ], 0 ],
  [ 'Operator_66' => 'Operator', [ 'Expression', 'OP18_TERNARY', 'Variable', ':', 'Variable' ], 0 ],
  [ 'Operator_67' => 'Operator', [ 'OP22_LOGICAL_NOT', 'Expression' ], 0 ],
  [ 'Operator_68' => 'Operator', [ 'Expression', 'OP23_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_69' => 'Operator', [ 'Expression', 'OP24_LOGICAL_OR_XOR', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-19', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-19', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-20', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-20', [  ], 0 ],
  [ 'OperatorVoid_78' => 'OperatorVoid', [ 'OP01_NAMED_VOID', '(', 'OPTIONAL-17', ');' ], 0 ],
  [ 'OperatorVoid_79' => 'OperatorVoid', [ 'OP01_NAMED_VOID', '(', 'FileHandle', 'OPTIONAL-18', ');' ], 0 ],
  [ 'OperatorVoid_80' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-19', ';' ], 0 ],
  [ 'OperatorVoid_81' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'FileHandle', 'OPTIONAL-20', ';' ], 0 ],
  [ 'OperatorVoid_82' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-22', [ 'HashEntries' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-22', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [  ], 0 ],
  [ 'Expression_91' => 'Expression', [ 'LITERAL' ], 0 ],
  [ 'Expression_92' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_93' => 'Expression', [ '[', 'OPTIONAL-21', ']' ], 0 ],
  [ 'Expression_94' => 'Expression', [ '{', 'OPTIONAL-22', '}' ], 0 ],
  [ 'Expression_95' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_96' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-23', ')' ], 0 ],
  [ 'Expression_97' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-24', ')' ], 0 ],
  [ 'Expression_98' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-25', [ 'LoopLabel', ':' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-26', [ 'PAREN-25' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-26', [  ], 0 ],
  [ 'Statement_102' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_103' => 'Statement', [ 'OPTIONAL-26', 'Loop' ], 0 ],
  [ 'Statement_104' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_105' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_106' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-27', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'PAREN-27' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ '_PAREN' => 'PAREN-29', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-30', [ 'PAREN-29' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-30', [  ], 0 ],
  [ 'Conditional_113' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-28', 'OPTIONAL-30' ], 0 ],
  [ 'Loop_114' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_115' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_116' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_117' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_118' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_119' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-31', [ 'PLUS-31', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-31', [ 'Operation' ], 0 ],
  [ 'CodeBlock_122' => 'CodeBlock', [ '{', 'PLUS-31', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [ 'STAR-32', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [  ], 0 ],
  [ 'Variable_125' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-32' ], 0 ],
  [ 'VariableRetrieval_126' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_127' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableDeclaration_128' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_129' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_130' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-33', [ 'OP21_LIST_COMMA', 'ListElementValue' ], 0 ],
  [ '_STAR_LIST' => 'STAR-34', [ 'STAR-34', 'PAREN-33' ], 0 ],
  [ '_STAR_LIST' => 'STAR-34', [  ], 0 ],
  [ 'ListElements_134' => 'ListElements', [ 'ListElementValue', 'STAR-34' ], 0 ],
  [ 'ListElementValue_135' => 'ListElementValue', [ 'Expression' ], 0 ],
  [ 'ListElementValue_136' => 'ListElementValue', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ListElementValue_137' => 'ListElementValue', [ 'KEYS_OR_VALUES', '%{', 'Variable', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-35', [ 'OP21_LIST_COMMA', 'WORD', 'OP20_HASH_FATARROW', 'HashEntryValue' ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [ 'STAR-36', 'PAREN-35' ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [  ], 0 ],
  [ 'HashEntries_141' => 'HashEntries', [ 'WORD', 'OP20_HASH_FATARROW', 'HashEntryValue', 'STAR-36' ], 0 ],
  [ 'HashEntryValue_142' => 'HashEntryValue', [ 'Expression' ], 0 ],
  [ 'HashEntryValue_143' => 'HashEntryValue', [ '%{', 'Variable', '}' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-37', [ 'PLUS-37', 'WordScoped' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-37', [ 'WordScoped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [ 'STAR-38', 'Method' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-39', [ 'PLUS-39', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-39', [ 'Subroutine' ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'PLUS-39', '1;' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'PAREN-40' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'Class_153' => 'Class', [ 'package', 'WordScoped', ';', 'Header', 'use parent qw(', 'PLUS-37', ');', 'Properties', 'STAR-38', '1;', 'OPTIONAL-41' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'HashEntries' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ 'Properties_156' => 'Properties', [ 'our %properties = (', 'OPTIONAL-42', ');' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'Operation' ], 0 ],
  [ 'Method_161' => 'Method', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-43', 'PLUS-44', '};' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ 'MethodArguments_165' => 'MethodArguments', [ '( my', 'TYPE_CLASS_OR_SELF', 'STAR-46', ') = @_;' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ '::', 'WORD' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ 'WordScoped_169' => 'WordScoped', [ 'WORD', 'STAR-48' ], 0 ],
  [ 'FileHandle_170' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'Type_171' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_172' => 'LoopLabel', [ 'WORD' ], 0 ],
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
  'Operator_66' => 66,
  'Operator_67' => 67,
  'Operator_68' => 68,
  'Operator_69' => 69,
  '_OPTIONAL' => 70,
  '_OPTIONAL' => 71,
  '_OPTIONAL' => 72,
  '_OPTIONAL' => 73,
  '_OPTIONAL' => 74,
  '_OPTIONAL' => 75,
  '_OPTIONAL' => 76,
  '_OPTIONAL' => 77,
  'OperatorVoid_78' => 78,
  'OperatorVoid_79' => 79,
  'OperatorVoid_80' => 80,
  'OperatorVoid_81' => 81,
  'OperatorVoid_82' => 82,
  '_OPTIONAL' => 83,
  '_OPTIONAL' => 84,
  '_OPTIONAL' => 85,
  '_OPTIONAL' => 86,
  '_OPTIONAL' => 87,
  '_OPTIONAL' => 88,
  '_OPTIONAL' => 89,
  '_OPTIONAL' => 90,
  'Expression_91' => 91,
  'Expression_92' => 92,
  'Expression_93' => 93,
  'Expression_94' => 94,
  'Expression_95' => 95,
  'Expression_96' => 96,
  'Expression_97' => 97,
  'Expression_98' => 98,
  '_PAREN' => 99,
  '_OPTIONAL' => 100,
  '_OPTIONAL' => 101,
  'Statement_102' => 102,
  'Statement_103' => 103,
  'Statement_104' => 104,
  'Statement_105' => 105,
  'Statement_106' => 106,
  '_PAREN' => 107,
  '_STAR_LIST' => 108,
  '_STAR_LIST' => 109,
  '_PAREN' => 110,
  '_OPTIONAL' => 111,
  '_OPTIONAL' => 112,
  'Conditional_113' => 113,
  'Loop_114' => 114,
  'Loop_115' => 115,
  'Loop_116' => 116,
  'LoopFor_117' => 117,
  'LoopForEach_118' => 118,
  'LoopWhile_119' => 119,
  '_PLUS_LIST' => 120,
  '_PLUS_LIST' => 121,
  'CodeBlock_122' => 122,
  '_STAR_LIST' => 123,
  '_STAR_LIST' => 124,
  'Variable_125' => 125,
  'VariableRetrieval_126' => 126,
  'VariableRetrieval_127' => 127,
  'VariableDeclaration_128' => 128,
  'VariableDeclaration_129' => 129,
  'VariableModification_130' => 130,
  '_PAREN' => 131,
  '_STAR_LIST' => 132,
  '_STAR_LIST' => 133,
  'ListElements_134' => 134,
  'ListElementValue_135' => 135,
  'ListElementValue_136' => 136,
  'ListElementValue_137' => 137,
  '_PAREN' => 138,
  '_STAR_LIST' => 139,
  '_STAR_LIST' => 140,
  'HashEntries_141' => 141,
  'HashEntryValue_142' => 142,
  'HashEntryValue_143' => 143,
  '_PLUS_LIST' => 144,
  '_PLUS_LIST' => 145,
  '_STAR_LIST' => 146,
  '_STAR_LIST' => 147,
  '_PLUS_LIST' => 148,
  '_PLUS_LIST' => 149,
  '_PAREN' => 150,
  '_OPTIONAL' => 151,
  '_OPTIONAL' => 152,
  'Class_153' => 153,
  '_OPTIONAL' => 154,
  '_OPTIONAL' => 155,
  'Properties_156' => 156,
  '_OPTIONAL' => 157,
  '_OPTIONAL' => 158,
  '_PLUS_LIST' => 159,
  '_PLUS_LIST' => 160,
  'Method_161' => 161,
  '_PAREN' => 162,
  '_STAR_LIST' => 163,
  '_STAR_LIST' => 164,
  'MethodArguments_165' => 165,
  '_PAREN' => 166,
  '_STAR_LIST' => 167,
  '_STAR_LIST' => 168,
  'WordScoped_169' => 169,
  'FileHandle_170' => 170,
  'Type_171' => 171,
  'LoopLabel_172' => 172,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'( my' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	') = @_;' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	');' => { ISSEMANTIC => 0 },
	'..' => { ISSEMANTIC => 0 },
	'/' => { ISSEMANTIC => 0 },
	'1;' => { ISSEMANTIC => 0 },
	':' => { ISSEMANTIC => 0 },
	'::' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'= sub {' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	'[' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'else' => { ISSEMANTIC => 0 },
	'elsif (' => { ISSEMANTIC => 0 },
	'for my integer' => { ISSEMANTIC => 0 },
	'foreach my' => { ISSEMANTIC => 0 },
	'if (' => { ISSEMANTIC => 0 },
	'my' => { ISSEMANTIC => 0 },
	'our $VERSION =' => { ISSEMANTIC => 0 },
	'our %properties = (' => { ISSEMANTIC => 0 },
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
	'while (' => { ISSEMANTIC => 0 },
	'{' => { ISSEMANTIC => 0 },
	'{*' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	'};' => { ISSEMANTIC => 0 },
	KEYS_OR_VALUES => { ISSEMANTIC => 1 },
	LITERAL => { ISSEMANTIC => 1 },
	OP01_NAMED => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID => { ISSEMANTIC => 1 },
	OP02_ARRAY_THINARROW => { ISSEMANTIC => 1 },
	OP02_HASH_THINARROW => { ISSEMANTIC => 1 },
	OP02_METHOD_THINARROW => { ISSEMANTIC => 1 },
	OP03_MATH_INC_DEC => { ISSEMANTIC => 1 },
	OP04_MATH_POW => { ISSEMANTIC => 1 },
	OP05_LOGICAL_NEG => { ISSEMANTIC => 1 },
	OP05_MATH_NEG => { ISSEMANTIC => 1 },
	OP06_REGEX_MATCH => { ISSEMANTIC => 1 },
	OP06_REGEX_PATTERN => { ISSEMANTIC => 1 },
	OP07_MATH_MULT_DIV_MOD => { ISSEMANTIC => 1 },
	OP08_MATH_ADD_SUB => { ISSEMANTIC => 1 },
	OP08_STRING_CAT => { ISSEMANTIC => 1 },
	OP09_BITWISE_SHIFT => { ISSEMANTIC => 1 },
	OP10_NAMED_UNARY => { ISSEMANTIC => 1 },
	OP11_COMPARE_LT_GT => { ISSEMANTIC => 1 },
	OP12_COMPARE_EQ_NEQ => { ISSEMANTIC => 1 },
	OP13_BITWISE_AND => { ISSEMANTIC => 1 },
	OP14_BITWISE_OR_XOR => { ISSEMANTIC => 1 },
	OP15_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP16_LOGICAL_OR => { ISSEMANTIC => 1 },
	OP17_LIST_RANGE => { ISSEMANTIC => 1 },
	OP18_TERNARY => { ISSEMANTIC => 1 },
	OP19_LOOP_CONTROL => { ISSEMANTIC => 1 },
	OP19_VARIABLE_ASSIGN => { ISSEMANTIC => 1 },
	OP20_HASH_FATARROW => { ISSEMANTIC => 1 },
	OP21_LIST_COMMA => { ISSEMANTIC => 1 },
	OP22_LOGICAL_NOT => { ISSEMANTIC => 1 },
	OP23_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP24_LOGICAL_OR_XOR => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	TYPE_CLASS_OR_SELF => { ISSEMANTIC => 1 },
	VARIABLE_SYMBOL => { ISSEMANTIC => 1 },
	VERSION_NUMBER => { ISSEMANTIC => 1 },
	WORD => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'lib/RPerl/Grammar.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'SHEBANG' => 6,
			"package" => 2
		},
		GOTOS => {
			'Package' => 7,
			'CompileUnit' => 8,
			'Module' => 4,
			'Program' => 1,
			'Class' => 5,
			'PLUS-1' => 3
		}
	},
	{#State 1
		DEFAULT => -3
	},
	{#State 2
		ACTIONS => {
			'WORD' => 10
		},
		GOTOS => {
			'WordScoped' => 9
		}
	},
	{#State 3
		ACTIONS => {
			"package" => 2,
			'' => -4
		},
		GOTOS => {
			'Module' => 11,
			'Package' => 7,
			'Class' => 5
		}
	},
	{#State 4
		DEFAULT => -2
	},
	{#State 5
		DEFAULT => -11
	},
	{#State 6
		ACTIONS => {
			"use strict;" => 13
		},
		GOTOS => {
			'Header' => 12
		}
	},
	{#State 7
		DEFAULT => -10
	},
	{#State 8
		ACTIONS => {
			'' => 14
		}
	},
	{#State 9
		ACTIONS => {
			";" => 15
		}
	},
	{#State 10
		DEFAULT => -168,
		GOTOS => {
			'STAR-48' => 16
		}
	},
	{#State 11
		DEFAULT => -1
	},
	{#State 12
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 17
		}
	},
	{#State 13
		ACTIONS => {
			"use warnings;" => 18
		}
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		ACTIONS => {
			"use strict;" => 13
		},
		GOTOS => {
			'Header' => 19
		}
	},
	{#State 16
		ACTIONS => {
			"qw(" => -169,
			"::" => 20,
			'WORD' => -169,
			");" => -169,
			"(" => -169,
			";" => -169
		},
		GOTOS => {
			'PAREN-47' => 21
		}
	},
	{#State 17
		ACTIONS => {
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			"my" => 53,
			'OP19_LOOP_CONTROL' => 34,
			'OP01_NAMED_VOID' => 50,
			"for my integer" => -101,
			'OP10_NAMED_UNARY' => 35,
			'OP05_MATH_NEG' => 29,
			'WORD' => 45,
			"foreach my" => -101,
			'LITERAL' => 31,
			"(" => 32,
			"our" => 48,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_LOGICAL_NEG' => 30,
			"if (" => 46,
			"[" => 22,
			"while (" => -101,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43
		},
		GOTOS => {
			'Variable' => 41,
			'WordScoped' => 39,
			'Operation' => 40,
			'OPTIONAL-26' => 26,
			'VariableModification' => 51,
			'Statement' => 44,
			'Subroutine' => 23,
			'LoopLabel' => 25,
			'Conditional' => 24,
			'OperatorVoid' => 37,
			'Expression' => 27,
			'Operator' => 28,
			'VariableDeclaration' => 47,
			'PAREN-25' => 49,
			'PLUS-3' => 38
		}
	},
	{#State 18
		ACTIONS => {
			"our \$VERSION =" => 54
		}
	},
	{#State 19
		ACTIONS => {
			"our" => 48,
			"use parent qw(" => 55
		},
		GOTOS => {
			'PLUS-4' => 57,
			'Subroutine' => 56
		}
	},
	{#State 20
		ACTIONS => {
			'WORD' => 58
		}
	},
	{#State 21
		DEFAULT => -167
	},
	{#State 22
		ACTIONS => {
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP10_NAMED_UNARY' => 35,
			"]" => -84,
			'WORD' => 10,
			'OP05_MATH_NEG' => 29,
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			"(" => 32,
			'LITERAL' => 31,
			"[" => 22,
			'KEYS_OR_VALUES' => 60,
			"\@{" => 61,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42
		},
		GOTOS => {
			'ListElementValue' => 64,
			'OPTIONAL-21' => 65,
			'Variable' => 63,
			'ListElements' => 62,
			'Operator' => 28,
			'Expression' => 59,
			'WordScoped' => 39
		}
	},
	{#State 23
		DEFAULT => -5
	},
	{#State 24
		DEFAULT => -102
	},
	{#State 25
		ACTIONS => {
			":" => 66
		}
	},
	{#State 26
		ACTIONS => {
			"for my integer" => 67,
			"while (" => 70,
			"foreach my" => 72
		},
		GOTOS => {
			'LoopWhile' => 73,
			'Loop' => 69,
			'LoopForEach' => 68,
			'LoopFor' => 71
		}
	},
	{#State 27
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 74,
			";" => 75,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP17_LIST_RANGE' => 85,
			'OP16_LOGICAL_OR' => 77,
			'OP13_BITWISE_AND' => 76,
			'OP06_REGEX_MATCH' => 78,
			'OP18_TERNARY' => 87,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP11_COMPARE_LT_GT' => 79,
			'OP08_MATH_ADD_SUB' => 81,
			'OP15_LOGICAL_AND' => 80,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			'OP09_BITWISE_SHIFT' => 90,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP23_LOGICAL_AND' => 84
		}
	},
	{#State 28
		DEFAULT => -95
	},
	{#State 29
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 30,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_MATH_NEG' => 29,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'WORD' => 10,
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42,
			"[" => 22
		},
		GOTOS => {
			'Operator' => 28,
			'WordScoped' => 39,
			'Expression' => 91,
			'Variable' => 63
		}
	},
	{#State 30
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 43,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED' => 42,
			"[" => 22,
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"(" => 32,
			'OP05_LOGICAL_NEG' => 30,
			'WORD' => 10,
			'OP05_MATH_NEG' => 29,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36
		},
		GOTOS => {
			'Variable' => 63,
			'Operator' => 28,
			'WordScoped' => 39,
			'Expression' => 92
		}
	},
	{#State 31
		DEFAULT => -91
	},
	{#State 32
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			"(" => 32,
			'LITERAL' => 31,
			'WORD' => 10,
			'OP05_MATH_NEG' => 29,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			"[" => 22
		},
		GOTOS => {
			'Expression' => 93,
			'WordScoped' => 39,
			'Operator' => 28,
			'Variable' => 63
		}
	},
	{#State 33
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			"(" => 32,
			'LITERAL' => 31,
			'WORD' => 10,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			"{" => 36,
			'OP03_MATH_INC_DEC' => 43,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED' => 42,
			"[" => 22
		},
		GOTOS => {
			'Variable' => 63,
			'WordScoped' => 39,
			'Expression' => 94,
			'Operator' => 28
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => 95
		},
		GOTOS => {
			'LoopLabel' => 96
		}
	},
	{#State 35
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			"(" => 32,
			'LITERAL' => 31,
			'WORD' => 10,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP05_MATH_NEG' => 29,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42,
			'OP10_NAMED_UNARY' => 35,
			"[" => 22
		},
		GOTOS => {
			'Variable' => 63,
			'Operator' => 28,
			'Expression' => 97,
			'WordScoped' => 39
		}
	},
	{#State 36
		ACTIONS => {
			"}" => -86,
			'WORD' => 99
		},
		GOTOS => {
			'OPTIONAL-22' => 100,
			'HashEntries' => 98
		}
	},
	{#State 37
		DEFAULT => -104
	},
	{#State 38
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 34,
			'OP01_NAMED_VOID' => 50,
			"for my integer" => -101,
			'OP10_NAMED_UNARY' => 35,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			"my" => 53,
			"[" => 22,
			"while (" => -101,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			'OP05_MATH_NEG' => 29,
			'WORD' => 45,
			'LITERAL' => 31,
			"foreach my" => -101,
			"(" => 32,
			'OP22_LOGICAL_NOT' => 33,
			'' => -9,
			'OP05_LOGICAL_NEG' => 30,
			"if (" => 46
		},
		GOTOS => {
			'VariableDeclaration' => 47,
			'PAREN-25' => 49,
			'OperatorVoid' => 37,
			'Expression' => 27,
			'Operator' => 28,
			'VariableModification' => 51,
			'OPTIONAL-26' => 26,
			'Statement' => 44,
			'LoopLabel' => 25,
			'Conditional' => 24,
			'Variable' => 41,
			'WordScoped' => 39,
			'Operation' => 101
		}
	},
	{#State 39
		ACTIONS => {
			"(" => 102
		}
	},
	{#State 40
		DEFAULT => -8
	},
	{#State 41
		ACTIONS => {
			'OP16_LOGICAL_OR' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP19_VARIABLE_ASSIGN' => 103,
			'OP12_COMPARE_EQ_NEQ' => -92,
			";" => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP08_STRING_CAT' => -92,
			'OP04_MATH_POW' => -92,
			'OP02_METHOD_THINARROW' => 105,
			'OP23_LOGICAL_AND' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP18_TERNARY' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP03_MATH_INC_DEC' => 104
		}
	},
	{#State 42
		ACTIONS => {
			"(" => 106
		}
	},
	{#State 43
		ACTIONS => {
			'VARIABLE_SYMBOL' => 52
		},
		GOTOS => {
			'Variable' => 107
		}
	},
	{#State 44
		DEFAULT => -44
	},
	{#State 45
		ACTIONS => {
			"::" => -168,
			":" => -172,
			"(" => -168
		},
		GOTOS => {
			'STAR-48' => 16
		}
	},
	{#State 46
		ACTIONS => {
			'WORD' => 10,
			'OP05_MATH_NEG' => 29,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"(" => 32,
			'OP05_LOGICAL_NEG' => 30,
			"[" => 22,
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42
		},
		GOTOS => {
			'Expression' => 108,
			'WordScoped' => 39,
			'Operator' => 28,
			'Variable' => 63
		}
	},
	{#State 47
		DEFAULT => -105
	},
	{#State 48
		ACTIONS => {
			'WORD' => 109
		},
		GOTOS => {
			'Type' => 110
		}
	},
	{#State 49
		DEFAULT => -100
	},
	{#State 50
		ACTIONS => {
			'OP10_NAMED_UNARY' => 35,
			";" => -75,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			"[" => 22,
			"{*" => 113,
			'KEYS_OR_VALUES' => 60,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42,
			"\@{" => 61,
			'WORD' => 10,
			'OP05_MATH_NEG' => 29,
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"(" => 115,
			'OP05_LOGICAL_NEG' => 30
		},
		GOTOS => {
			'ListElementValue' => 64,
			'ListElements' => 112,
			'Variable' => 63,
			'WordScoped' => 39,
			'FileHandle' => 111,
			'OPTIONAL-19' => 114,
			'Expression' => 59,
			'Operator' => 28
		}
	},
	{#State 51
		DEFAULT => -106
	},
	{#State 52
		DEFAULT => -124,
		GOTOS => {
			'STAR-32' => 116
		}
	},
	{#State 53
		ACTIONS => {
			'WORD' => 109
		},
		GOTOS => {
			'Type' => 117
		}
	},
	{#State 54
		ACTIONS => {
			'VERSION_NUMBER' => 118
		}
	},
	{#State 55
		ACTIONS => {
			'WORD' => 10
		},
		GOTOS => {
			'PLUS-37' => 119,
			'WordScoped' => 120
		}
	},
	{#State 56
		DEFAULT => -13
	},
	{#State 57
		ACTIONS => {
			"1;" => 122,
			"our" => 48
		},
		GOTOS => {
			'Subroutine' => 121
		}
	},
	{#State 58
		DEFAULT => -166
	},
	{#State 59
		ACTIONS => {
			'OP23_LOGICAL_AND' => 84,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP09_BITWISE_SHIFT' => 90,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			");" => -135,
			'OP15_LOGICAL_AND' => 80,
			'OP08_MATH_ADD_SUB' => 81,
			'OP11_COMPARE_LT_GT' => 79,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP21_LIST_COMMA' => -135,
			'OP18_TERNARY' => 87,
			")" => -135,
			'OP06_REGEX_MATCH' => 78,
			'OP16_LOGICAL_OR' => 77,
			'OP13_BITWISE_AND' => 76,
			'OP17_LIST_RANGE' => 85,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			";" => -135,
			"]" => -135,
			'OP12_COMPARE_EQ_NEQ' => 74
		}
	},
	{#State 60
		ACTIONS => {
			"%{" => 123
		}
	},
	{#State 61
		ACTIONS => {
			'VARIABLE_SYMBOL' => 52
		},
		GOTOS => {
			'Variable' => 124
		}
	},
	{#State 62
		DEFAULT => -83
	},
	{#State 63
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -92,
			'OP04_MATH_POW' => -92,
			'OP08_STRING_CAT' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			");" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP02_METHOD_THINARROW' => 105,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP18_TERNARY' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP03_MATH_INC_DEC' => 104,
			".." => -92,
			"}" => -92,
			'OP17_LIST_RANGE' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP13_BITWISE_AND' => -92,
			")" => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP12_COMPARE_EQ_NEQ' => -92,
			"]" => -92,
			";" => -92
		}
	},
	{#State 64
		DEFAULT => -133,
		GOTOS => {
			'STAR-34' => 125
		}
	},
	{#State 65
		ACTIONS => {
			"]" => 126
		}
	},
	{#State 66
		DEFAULT => -99
	},
	{#State 67
		ACTIONS => {
			'VARIABLE_SYMBOL' => 127
		}
	},
	{#State 68
		DEFAULT => -115
	},
	{#State 69
		DEFAULT => -103
	},
	{#State 70
		ACTIONS => {
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_LOGICAL_NEG' => 30,
			"[" => 22,
			'OP03_MATH_INC_DEC' => 43,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED' => 42
		},
		GOTOS => {
			'Variable' => 63,
			'WordScoped' => 39,
			'Expression' => 128,
			'Operator' => 28
		}
	},
	{#State 71
		DEFAULT => -114
	},
	{#State 72
		ACTIONS => {
			'WORD' => 109
		},
		GOTOS => {
			'Type' => 129
		}
	},
	{#State 73
		DEFAULT => -116
	},
	{#State 74
		ACTIONS => {
			"[" => 22,
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42,
			'WORD' => 10,
			'OP05_MATH_NEG' => 29,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"(" => 32
		},
		GOTOS => {
			'Variable' => 63,
			'Operator' => 28,
			'Expression' => 130,
			'WordScoped' => 39
		}
	},
	{#State 75
		DEFAULT => -43
	},
	{#State 76
		ACTIONS => {
			'OP05_MATH_NEG' => 29,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 30,
			'LITERAL' => 31,
			"(" => 32,
			'OP22_LOGICAL_NOT' => 33,
			"[" => 22,
			'OP01_NAMED' => 42,
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43
		},
		GOTOS => {
			'Expression' => 131,
			'WordScoped' => 39,
			'Operator' => 28,
			'Variable' => 63
		}
	},
	{#State 77
		ACTIONS => {
			"[" => 22,
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 30,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33
		},
		GOTOS => {
			'Variable' => 63,
			'Operator' => 28,
			'Expression' => 132,
			'WordScoped' => 39
		}
	},
	{#State 78
		ACTIONS => {
			"/" => 133
		}
	},
	{#State 79
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42,
			'OP10_NAMED_UNARY' => 35,
			"[" => 22,
			'OP22_LOGICAL_NOT' => 33,
			"(" => 32,
			'LITERAL' => 31,
			'OP05_LOGICAL_NEG' => 30,
			'WORD' => 10,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			"{" => 36
		},
		GOTOS => {
			'Variable' => 63,
			'WordScoped' => 39,
			'Expression' => 134,
			'Operator' => 28
		}
	},
	{#State 80
		ACTIONS => {
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42,
			"[" => 22,
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"(" => 32,
			'OP05_LOGICAL_NEG' => 30,
			'WORD' => 10,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29
		},
		GOTOS => {
			'Variable' => 63,
			'Operator' => 28,
			'WordScoped' => 39,
			'Expression' => 135
		}
	},
	{#State 81
		ACTIONS => {
			"[" => 22,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 30,
			'LITERAL' => 31,
			"(" => 32,
			'OP22_LOGICAL_NOT' => 33
		},
		GOTOS => {
			'Operator' => 28,
			'WordScoped' => 39,
			'Expression' => 136,
			'Variable' => 63
		}
	},
	{#State 82
		ACTIONS => {
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42,
			"[" => 22,
			'OP05_LOGICAL_NEG' => 30,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10
		},
		GOTOS => {
			'Expression' => 137,
			'WordScoped' => 39,
			'Operator' => 28,
			'Variable' => 63
		}
	},
	{#State 83
		ACTIONS => {
			"[" => 22,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			'OP10_NAMED_UNARY' => 35,
			'OP05_MATH_NEG' => 29,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'WORD' => 10,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_LOGICAL_NEG' => 30
		},
		GOTOS => {
			'Operator' => 28,
			'Expression' => 138,
			'WordScoped' => 39,
			'Variable' => 63
		}
	},
	{#State 84
		ACTIONS => {
			"[" => 22,
			'OP01_NAMED' => 42,
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_LOGICAL_NEG' => 30
		},
		GOTOS => {
			'Variable' => 63,
			'Operator' => 28,
			'Expression' => 139,
			'WordScoped' => 39
		}
	},
	{#State 85
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 30,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10,
			'OP01_NAMED' => 42,
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			"[" => 22
		},
		GOTOS => {
			'Expression' => 140,
			'WordScoped' => 39,
			'Operator' => 28,
			'Variable' => 63
		}
	},
	{#State 86
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"(" => 32,
			'OP05_LOGICAL_NEG' => 30,
			'WORD' => 10,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'OP03_MATH_INC_DEC' => 43,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED' => 42,
			"[" => 22
		},
		GOTOS => {
			'Operator' => 28,
			'Expression' => 141,
			'WordScoped' => 39,
			'Variable' => 63
		}
	},
	{#State 87
		ACTIONS => {
			'VARIABLE_SYMBOL' => 52
		},
		GOTOS => {
			'Variable' => 142
		}
	},
	{#State 88
		ACTIONS => {
			'OP01_NAMED' => 42,
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			"[" => 22,
			'LITERAL' => 31,
			"(" => 32,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_LOGICAL_NEG' => 30,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10
		},
		GOTOS => {
			'WordScoped' => 39,
			'Expression' => 143,
			'Operator' => 28,
			'Variable' => 63
		}
	},
	{#State 89
		ACTIONS => {
			"[" => 22,
			'OP01_NAMED' => 42,
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			'WORD' => 10,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'OP22_LOGICAL_NOT' => 33,
			"(" => 32,
			'LITERAL' => 31,
			'OP05_LOGICAL_NEG' => 30
		},
		GOTOS => {
			'Variable' => 63,
			'WordScoped' => 39,
			'Expression' => 144,
			'Operator' => 28
		}
	},
	{#State 90
		ACTIONS => {
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			'OP10_NAMED_UNARY' => 35,
			"[" => 22,
			'OP05_LOGICAL_NEG' => 30,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10
		},
		GOTOS => {
			'Variable' => 63,
			'WordScoped' => 39,
			'Expression' => 145,
			'Operator' => 28
		}
	},
	{#State 91
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -52,
			'OP08_STRING_CAT' => -52,
			'OP04_MATH_POW' => 82,
			'OP08_MATH_ADD_SUB' => -52,
			");" => -52,
			'OP15_LOGICAL_AND' => -52,
			'OP23_LOGICAL_AND' => -52,
			'OP14_BITWISE_OR_XOR' => -52,
			'OP21_LIST_COMMA' => -52,
			'OP18_TERNARY' => -52,
			'OP11_COMPARE_LT_GT' => -52,
			'OP24_LOGICAL_OR_XOR' => -52,
			".." => -52,
			"}" => -52,
			'OP07_MATH_MULT_DIV_MOD' => -52,
			'OP13_BITWISE_AND' => -52,
			'OP16_LOGICAL_OR' => -52,
			'OP17_LIST_RANGE' => -52,
			")" => -52,
			'OP06_REGEX_MATCH' => -52,
			'OP12_COMPARE_EQ_NEQ' => -52,
			";" => -52,
			"]" => -52
		}
	},
	{#State 92
		ACTIONS => {
			'OP18_TERNARY' => -51,
			'OP21_LIST_COMMA' => -51,
			".." => -51,
			'OP24_LOGICAL_OR_XOR' => -51,
			'OP11_COMPARE_LT_GT' => -51,
			");" => -51,
			'OP15_LOGICAL_AND' => -51,
			'OP08_MATH_ADD_SUB' => -51,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => -51,
			'OP09_BITWISE_SHIFT' => -51,
			'OP14_BITWISE_OR_XOR' => -51,
			'OP23_LOGICAL_AND' => -51,
			'OP12_COMPARE_EQ_NEQ' => -51,
			"]" => -51,
			";" => -51,
			'OP13_BITWISE_AND' => -51,
			'OP07_MATH_MULT_DIV_MOD' => -51,
			'OP17_LIST_RANGE' => -51,
			'OP16_LOGICAL_OR' => -51,
			"}" => -51,
			'OP06_REGEX_MATCH' => -51,
			")" => -51
		}
	},
	{#State 93
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 90,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP15_LOGICAL_AND' => 80,
			'OP08_MATH_ADD_SUB' => 81,
			'OP23_LOGICAL_AND' => 84,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP18_TERNARY' => 87,
			'OP11_COMPARE_LT_GT' => 79,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP16_LOGICAL_OR' => 77,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP13_BITWISE_AND' => 76,
			'OP17_LIST_RANGE' => 85,
			")" => 146,
			'OP06_REGEX_MATCH' => 78,
			'OP12_COMPARE_EQ_NEQ' => 74
		}
	},
	{#State 94
		ACTIONS => {
			".." => -67,
			'OP24_LOGICAL_OR_XOR' => -67,
			'OP11_COMPARE_LT_GT' => 79,
			'OP18_TERNARY' => 87,
			'OP21_LIST_COMMA' => -67,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP23_LOGICAL_AND' => -67,
			'OP15_LOGICAL_AND' => 80,
			");" => -67,
			'OP08_MATH_ADD_SUB' => 81,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			'OP09_BITWISE_SHIFT' => 90,
			"]" => -67,
			";" => -67,
			'OP12_COMPARE_EQ_NEQ' => 74,
			'OP06_REGEX_MATCH' => 78,
			")" => -67,
			'OP17_LIST_RANGE' => 85,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP16_LOGICAL_OR' => 77,
			'OP13_BITWISE_AND' => 76,
			"}" => -67
		}
	},
	{#State 95
		DEFAULT => -172
	},
	{#State 96
		ACTIONS => {
			";" => 147
		}
	},
	{#State 97
		ACTIONS => {
			"}" => -58,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP17_LIST_RANGE' => -58,
			'OP16_LOGICAL_OR' => -58,
			'OP13_BITWISE_AND' => -58,
			'OP06_REGEX_MATCH' => 78,
			")" => -58,
			'OP12_COMPARE_EQ_NEQ' => -58,
			"]" => -58,
			";" => -58,
			'OP09_BITWISE_SHIFT' => 90,
			");" => -58,
			'OP15_LOGICAL_AND' => -58,
			'OP08_MATH_ADD_SUB' => 81,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			'OP23_LOGICAL_AND' => -58,
			'OP14_BITWISE_OR_XOR' => -58,
			'OP18_TERNARY' => -58,
			'OP21_LIST_COMMA' => -58,
			'OP24_LOGICAL_OR_XOR' => -58,
			'OP11_COMPARE_LT_GT' => -58,
			".." => -58
		}
	},
	{#State 98
		DEFAULT => -85
	},
	{#State 99
		ACTIONS => {
			'OP20_HASH_FATARROW' => 148
		}
	},
	{#State 100
		ACTIONS => {
			"}" => 149
		}
	},
	{#State 101
		DEFAULT => -7
	},
	{#State 102
		ACTIONS => {
			'OP05_MATH_NEG' => 29,
			'WORD' => 10,
			'LITERAL' => 31,
			"(" => 32,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_LOGICAL_NEG' => 30,
			"[" => 22,
			"\@{" => 61,
			'KEYS_OR_VALUES' => 60,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			")" => -88,
			'OP10_NAMED_UNARY' => 35
		},
		GOTOS => {
			'OPTIONAL-23' => 150,
			'ListElementValue' => 64,
			'WordScoped' => 39,
			'Expression' => 59,
			'Operator' => 28,
			'ListElements' => 151,
			'Variable' => 63
		}
	},
	{#State 103
		ACTIONS => {
			"[" => 22,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42,
			'OP10_NAMED_UNARY' => 35,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_LOGICAL_NEG' => 30
		},
		GOTOS => {
			'Variable' => 63,
			'Operator' => 28,
			'WordScoped' => 39,
			'Expression' => 152
		}
	},
	{#State 104
		DEFAULT => -49
	},
	{#State 105
		ACTIONS => {
			'WORD' => 153
		}
	},
	{#State 106
		ACTIONS => {
			'OP10_NAMED_UNARY' => 35,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			")" => -46,
			"[" => 22,
			"\@{" => 61,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			'KEYS_OR_VALUES' => 60,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 30,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33
		},
		GOTOS => {
			'ListElements' => 154,
			'OPTIONAL-16' => 155,
			'Variable' => 63,
			'Expression' => 59,
			'WordScoped' => 39,
			'Operator' => 28,
			'ListElementValue' => 64
		}
	},
	{#State 107
		DEFAULT => -48
	},
	{#State 108
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 74,
			'OP17_LIST_RANGE' => 85,
			'OP16_LOGICAL_OR' => 77,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP13_BITWISE_AND' => 76,
			'OP06_REGEX_MATCH' => 78,
			")" => 156,
			'OP18_TERNARY' => 87,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP11_COMPARE_LT_GT' => 79,
			'OP09_BITWISE_SHIFT' => 90,
			'OP15_LOGICAL_AND' => 80,
			'OP08_MATH_ADD_SUB' => 81,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			'OP23_LOGICAL_AND' => 84,
			'OP14_BITWISE_OR_XOR' => 83
		}
	},
	{#State 109
		DEFAULT => -171
	},
	{#State 110
		ACTIONS => {
			'VARIABLE_SYMBOL' => 157
		}
	},
	{#State 111
		ACTIONS => {
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP10_NAMED_UNARY' => 35,
			";" => -77,
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"(" => 32,
			'WORD' => 10,
			'OP05_MATH_NEG' => 29,
			'KEYS_OR_VALUES' => 60,
			"\@{" => 61,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			"[" => 22
		},
		GOTOS => {
			'ListElements' => 159,
			'Variable' => 63,
			'Expression' => 59,
			'WordScoped' => 39,
			'Operator' => 28,
			'ListElementValue' => 64,
			'OPTIONAL-20' => 158
		}
	},
	{#State 112
		DEFAULT => -74
	},
	{#State 113
		ACTIONS => {
			'WORD' => 160
		}
	},
	{#State 114
		ACTIONS => {
			";" => 161
		}
	},
	{#State 115
		ACTIONS => {
			'OP10_NAMED_UNARY' => 35,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			"[" => 22,
			'OP01_NAMED' => 42,
			"\@{" => 61,
			'KEYS_OR_VALUES' => 60,
			'OP03_MATH_INC_DEC' => 43,
			"{*" => 113,
			");" => -71,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 30,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33
		},
		GOTOS => {
			'ListElementValue' => 64,
			'ListElements' => 164,
			'Variable' => 63,
			'WordScoped' => 39,
			'FileHandle' => 165,
			'OPTIONAL-17' => 163,
			'Expression' => 162,
			'Operator' => 28
		}
	},
	{#State 116
		ACTIONS => {
			")" => -125,
			'OP06_REGEX_MATCH' => -125,
			'OP19_VARIABLE_ASSIGN' => -125,
			'OP02_ARRAY_THINARROW' => 168,
			"}" => -125,
			'OP07_MATH_MULT_DIV_MOD' => -125,
			'OP17_LIST_RANGE' => -125,
			'OP16_LOGICAL_OR' => -125,
			'OP13_BITWISE_AND' => -125,
			";" => -125,
			"]" => -125,
			'OP12_COMPARE_EQ_NEQ' => -125,
			'OP23_LOGICAL_AND' => -125,
			'OP02_METHOD_THINARROW' => -125,
			'OP14_BITWISE_OR_XOR' => -125,
			'OP09_BITWISE_SHIFT' => -125,
			'OP08_STRING_CAT' => -125,
			'OP04_MATH_POW' => -125,
			'OP08_MATH_ADD_SUB' => -125,
			");" => -125,
			'OP15_LOGICAL_AND' => -125,
			'OP11_COMPARE_LT_GT' => -125,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP03_MATH_INC_DEC' => -125,
			".." => -125,
			'OP21_LIST_COMMA' => -125,
			'OP18_TERNARY' => -125,
			":" => -125,
			'OP02_HASH_THINARROW' => 167
		},
		GOTOS => {
			'VariableRetrieval' => 166
		}
	},
	{#State 117
		ACTIONS => {
			'VARIABLE_SYMBOL' => 169
		}
	},
	{#State 118
		ACTIONS => {
			";" => 170
		}
	},
	{#State 119
		ACTIONS => {
			'WORD' => 10,
			");" => 171
		},
		GOTOS => {
			'WordScoped' => 172
		}
	},
	{#State 120
		DEFAULT => -145
	},
	{#State 121
		DEFAULT => -12
	},
	{#State 122
		DEFAULT => -14
	},
	{#State 123
		ACTIONS => {
			'VARIABLE_SYMBOL' => 52
		},
		GOTOS => {
			'Variable' => 173
		}
	},
	{#State 124
		ACTIONS => {
			"}" => 174
		}
	},
	{#State 125
		ACTIONS => {
			");" => -134,
			'OP21_LIST_COMMA' => 175,
			";" => -134,
			")" => -134,
			"]" => -134
		},
		GOTOS => {
			'PAREN-33' => 176
		}
	},
	{#State 126
		DEFAULT => -93
	},
	{#State 127
		ACTIONS => {
			"(" => 177
		}
	},
	{#State 128
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP11_COMPARE_LT_GT' => 79,
			'OP18_TERNARY' => 87,
			'OP23_LOGICAL_AND' => 84,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP09_BITWISE_SHIFT' => 90,
			'OP15_LOGICAL_AND' => 80,
			'OP08_MATH_ADD_SUB' => 81,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP12_COMPARE_EQ_NEQ' => 74,
			'OP06_REGEX_MATCH' => 78,
			")" => 178,
			'OP16_LOGICAL_OR' => 77,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP17_LIST_RANGE' => 85,
			'OP13_BITWISE_AND' => 76
		}
	},
	{#State 129
		ACTIONS => {
			'VARIABLE_SYMBOL' => 179
		}
	},
	{#State 130
		ACTIONS => {
			"}" => -60,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP16_LOGICAL_OR' => -60,
			'OP17_LIST_RANGE' => -60,
			'OP13_BITWISE_AND' => -60,
			")" => -60,
			'OP06_REGEX_MATCH' => 78,
			'OP12_COMPARE_EQ_NEQ' => undef,
			"]" => -60,
			";" => -60,
			'OP09_BITWISE_SHIFT' => 90,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			");" => -60,
			'OP08_MATH_ADD_SUB' => 81,
			'OP15_LOGICAL_AND' => -60,
			'OP23_LOGICAL_AND' => -60,
			'OP14_BITWISE_OR_XOR' => -60,
			'OP21_LIST_COMMA' => -60,
			'OP18_TERNARY' => -60,
			'OP11_COMPARE_LT_GT' => 79,
			'OP24_LOGICAL_OR_XOR' => -60,
			".." => -60
		}
	},
	{#State 131
		ACTIONS => {
			'OP06_REGEX_MATCH' => 78,
			")" => -61,
			"}" => -61,
			'OP17_LIST_RANGE' => -61,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP13_BITWISE_AND' => -61,
			'OP16_LOGICAL_OR' => -61,
			";" => -61,
			"]" => -61,
			'OP12_COMPARE_EQ_NEQ' => 74,
			'OP23_LOGICAL_AND' => -61,
			'OP14_BITWISE_OR_XOR' => -61,
			'OP09_BITWISE_SHIFT' => 90,
			");" => -61,
			'OP08_MATH_ADD_SUB' => 81,
			'OP15_LOGICAL_AND' => -61,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			'OP24_LOGICAL_OR_XOR' => -61,
			'OP11_COMPARE_LT_GT' => 79,
			".." => -61,
			'OP18_TERNARY' => -61,
			'OP21_LIST_COMMA' => -61
		}
	},
	{#State 132
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 90,
			");" => -64,
			'OP15_LOGICAL_AND' => 80,
			'OP08_MATH_ADD_SUB' => 81,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP23_LOGICAL_AND' => -64,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP18_TERNARY' => -64,
			'OP21_LIST_COMMA' => -64,
			'OP24_LOGICAL_OR_XOR' => -64,
			'OP11_COMPARE_LT_GT' => 79,
			".." => -64,
			"}" => -64,
			'OP17_LIST_RANGE' => -64,
			'OP16_LOGICAL_OR' => -64,
			'OP13_BITWISE_AND' => 76,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP06_REGEX_MATCH' => 78,
			")" => -64,
			'OP12_COMPARE_EQ_NEQ' => 74,
			";" => -64,
			"]" => -64
		}
	},
	{#State 133
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 180
		}
	},
	{#State 134
		ACTIONS => {
			'OP23_LOGICAL_AND' => -59,
			'OP14_BITWISE_OR_XOR' => -59,
			'OP09_BITWISE_SHIFT' => 90,
			'OP08_MATH_ADD_SUB' => 81,
			");" => -59,
			'OP15_LOGICAL_AND' => -59,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP24_LOGICAL_OR_XOR' => -59,
			'OP11_COMPARE_LT_GT' => undef,
			".." => -59,
			'OP18_TERNARY' => -59,
			'OP21_LIST_COMMA' => -59,
			'OP06_REGEX_MATCH' => 78,
			")" => -59,
			"}" => -59,
			'OP17_LIST_RANGE' => -59,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP13_BITWISE_AND' => -59,
			'OP16_LOGICAL_OR' => -59,
			";" => -59,
			"]" => -59,
			'OP12_COMPARE_EQ_NEQ' => -59
		}
	},
	{#State 135
		ACTIONS => {
			"]" => -63,
			";" => -63,
			'OP12_COMPARE_EQ_NEQ' => 74,
			")" => -63,
			'OP06_REGEX_MATCH' => 78,
			"}" => -63,
			'OP16_LOGICAL_OR' => -63,
			'OP13_BITWISE_AND' => 76,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP17_LIST_RANGE' => -63,
			'OP11_COMPARE_LT_GT' => 79,
			'OP24_LOGICAL_OR_XOR' => -63,
			".." => -63,
			'OP21_LIST_COMMA' => -63,
			'OP18_TERNARY' => -63,
			'OP23_LOGICAL_AND' => -63,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP09_BITWISE_SHIFT' => 90,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			");" => -63,
			'OP08_MATH_ADD_SUB' => 81,
			'OP15_LOGICAL_AND' => -63
		}
	},
	{#State 136
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -55,
			'OP24_LOGICAL_OR_XOR' => -55,
			".." => -55,
			'OP21_LIST_COMMA' => -55,
			'OP18_TERNARY' => -55,
			'OP23_LOGICAL_AND' => -55,
			'OP14_BITWISE_OR_XOR' => -55,
			'OP09_BITWISE_SHIFT' => -55,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => -55,
			'OP08_MATH_ADD_SUB' => -55,
			");" => -55,
			'OP15_LOGICAL_AND' => -55,
			";" => -55,
			"]" => -55,
			'OP12_COMPARE_EQ_NEQ' => -55,
			")" => -55,
			'OP06_REGEX_MATCH' => 78,
			"}" => -55,
			'OP13_BITWISE_AND' => -55,
			'OP16_LOGICAL_OR' => -55,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP17_LIST_RANGE' => -55
		}
	},
	{#State 137
		ACTIONS => {
			'OP23_LOGICAL_AND' => -50,
			'OP14_BITWISE_OR_XOR' => -50,
			'OP09_BITWISE_SHIFT' => -50,
			");" => -50,
			'OP08_MATH_ADD_SUB' => -50,
			'OP15_LOGICAL_AND' => -50,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => -50,
			'OP24_LOGICAL_OR_XOR' => -50,
			'OP11_COMPARE_LT_GT' => -50,
			".." => -50,
			'OP18_TERNARY' => -50,
			'OP21_LIST_COMMA' => -50,
			'OP06_REGEX_MATCH' => -50,
			")" => -50,
			"}" => -50,
			'OP07_MATH_MULT_DIV_MOD' => -50,
			'OP17_LIST_RANGE' => -50,
			'OP16_LOGICAL_OR' => -50,
			'OP13_BITWISE_AND' => -50,
			";" => -50,
			"]" => -50,
			'OP12_COMPARE_EQ_NEQ' => -50
		}
	},
	{#State 138
		ACTIONS => {
			";" => -62,
			"]" => -62,
			'OP12_COMPARE_EQ_NEQ' => 74,
			")" => -62,
			'OP06_REGEX_MATCH' => 78,
			'OP13_BITWISE_AND' => 76,
			'OP16_LOGICAL_OR' => -62,
			'OP17_LIST_RANGE' => -62,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			"}" => -62,
			".." => -62,
			'OP11_COMPARE_LT_GT' => 79,
			'OP24_LOGICAL_OR_XOR' => -62,
			'OP21_LIST_COMMA' => -62,
			'OP18_TERNARY' => -62,
			'OP14_BITWISE_OR_XOR' => -62,
			'OP23_LOGICAL_AND' => -62,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			'OP08_MATH_ADD_SUB' => 81,
			");" => -62,
			'OP15_LOGICAL_AND' => -62,
			'OP09_BITWISE_SHIFT' => 90
		}
	},
	{#State 139
		ACTIONS => {
			"]" => -68,
			";" => -68,
			'OP12_COMPARE_EQ_NEQ' => 74,
			")" => -68,
			'OP06_REGEX_MATCH' => 78,
			'OP16_LOGICAL_OR' => 77,
			'OP13_BITWISE_AND' => 76,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP17_LIST_RANGE' => 85,
			"}" => -68,
			".." => -68,
			'OP11_COMPARE_LT_GT' => 79,
			'OP24_LOGICAL_OR_XOR' => -68,
			'OP21_LIST_COMMA' => -68,
			'OP18_TERNARY' => 87,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP23_LOGICAL_AND' => -68,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			");" => -68,
			'OP08_MATH_ADD_SUB' => 81,
			'OP15_LOGICAL_AND' => 80,
			'OP09_BITWISE_SHIFT' => 90
		}
	},
	{#State 140
		ACTIONS => {
			'OP23_LOGICAL_AND' => -65,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP09_BITWISE_SHIFT' => 90,
			");" => -65,
			'OP08_MATH_ADD_SUB' => 81,
			'OP15_LOGICAL_AND' => 80,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP24_LOGICAL_OR_XOR' => -65,
			'OP11_COMPARE_LT_GT' => 79,
			".." => -65,
			'OP18_TERNARY' => -65,
			'OP21_LIST_COMMA' => -65,
			'OP06_REGEX_MATCH' => 78,
			")" => -65,
			"}" => -65,
			'OP13_BITWISE_AND' => 76,
			'OP17_LIST_RANGE' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP16_LOGICAL_OR' => 77,
			";" => -65,
			"]" => -65,
			'OP12_COMPARE_EQ_NEQ' => 74
		}
	},
	{#State 141
		ACTIONS => {
			"]" => -54,
			";" => -54,
			'OP12_COMPARE_EQ_NEQ' => -54,
			'OP06_REGEX_MATCH' => 78,
			")" => -54,
			'OP07_MATH_MULT_DIV_MOD' => -54,
			'OP17_LIST_RANGE' => -54,
			'OP16_LOGICAL_OR' => -54,
			'OP13_BITWISE_AND' => -54,
			"}" => -54,
			".." => -54,
			'OP24_LOGICAL_OR_XOR' => -54,
			'OP11_COMPARE_LT_GT' => -54,
			'OP18_TERNARY' => -54,
			'OP21_LIST_COMMA' => -54,
			'OP14_BITWISE_OR_XOR' => -54,
			'OP23_LOGICAL_AND' => -54,
			");" => -54,
			'OP08_MATH_ADD_SUB' => -54,
			'OP15_LOGICAL_AND' => -54,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => -54,
			'OP09_BITWISE_SHIFT' => -54
		}
	},
	{#State 142
		ACTIONS => {
			":" => 181
		}
	},
	{#State 143
		ACTIONS => {
			"}" => -69,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP16_LOGICAL_OR' => 77,
			'OP17_LIST_RANGE' => 85,
			'OP13_BITWISE_AND' => 76,
			")" => -69,
			'OP06_REGEX_MATCH' => 78,
			'OP12_COMPARE_EQ_NEQ' => 74,
			"]" => -69,
			";" => -69,
			'OP09_BITWISE_SHIFT' => 90,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP15_LOGICAL_AND' => 80,
			");" => -69,
			'OP08_MATH_ADD_SUB' => 81,
			'OP23_LOGICAL_AND' => 84,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP21_LIST_COMMA' => -69,
			'OP18_TERNARY' => 87,
			'OP11_COMPARE_LT_GT' => 79,
			'OP24_LOGICAL_OR_XOR' => -69,
			".." => -69
		}
	},
	{#State 144
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -56,
			"]" => -56,
			";" => -56,
			'OP16_LOGICAL_OR' => -56,
			'OP13_BITWISE_AND' => -56,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP17_LIST_RANGE' => -56,
			"}" => -56,
			")" => -56,
			'OP06_REGEX_MATCH' => 78,
			'OP21_LIST_COMMA' => -56,
			'OP18_TERNARY' => -56,
			".." => -56,
			'OP11_COMPARE_LT_GT' => -56,
			'OP24_LOGICAL_OR_XOR' => -56,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => -56,
			'OP08_MATH_ADD_SUB' => 81,
			");" => -56,
			'OP15_LOGICAL_AND' => -56,
			'OP09_BITWISE_SHIFT' => -56,
			'OP14_BITWISE_OR_XOR' => -56,
			'OP23_LOGICAL_AND' => -56
		}
	},
	{#State 145
		ACTIONS => {
			'OP23_LOGICAL_AND' => -57,
			'OP14_BITWISE_OR_XOR' => -57,
			'OP09_BITWISE_SHIFT' => -57,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			'OP08_MATH_ADD_SUB' => 81,
			");" => -57,
			'OP15_LOGICAL_AND' => -57,
			'OP11_COMPARE_LT_GT' => -57,
			'OP24_LOGICAL_OR_XOR' => -57,
			".." => -57,
			'OP21_LIST_COMMA' => -57,
			'OP18_TERNARY' => -57,
			")" => -57,
			'OP06_REGEX_MATCH' => 78,
			"}" => -57,
			'OP16_LOGICAL_OR' => -57,
			'OP13_BITWISE_AND' => -57,
			'OP17_LIST_RANGE' => -57,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			"]" => -57,
			";" => -57,
			'OP12_COMPARE_EQ_NEQ' => -57
		}
	},
	{#State 146
		DEFAULT => -98
	},
	{#State 147
		DEFAULT => -82
	},
	{#State 148
		ACTIONS => {
			"[" => 22,
			'OP03_MATH_INC_DEC' => 43,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED' => 42,
			"%{" => 182,
			'WORD' => 10,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP05_MATH_NEG' => 29,
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			"(" => 32,
			'LITERAL' => 31
		},
		GOTOS => {
			'Operator' => 28,
			'WordScoped' => 39,
			'Expression' => 184,
			'Variable' => 63,
			'HashEntryValue' => 183
		}
	},
	{#State 149
		DEFAULT => -94
	},
	{#State 150
		ACTIONS => {
			")" => 185
		}
	},
	{#State 151
		DEFAULT => -87
	},
	{#State 152
		ACTIONS => {
			'OP18_TERNARY' => 87,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP11_COMPARE_LT_GT' => 79,
			'OP09_BITWISE_SHIFT' => 90,
			'OP15_LOGICAL_AND' => 80,
			'OP08_MATH_ADD_SUB' => 81,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP23_LOGICAL_AND' => 84,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP12_COMPARE_EQ_NEQ' => 74,
			";" => 186,
			'OP17_LIST_RANGE' => 85,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP13_BITWISE_AND' => 76,
			'OP16_LOGICAL_OR' => 77,
			'OP06_REGEX_MATCH' => 78
		}
	},
	{#State 153
		ACTIONS => {
			"(" => 187
		}
	},
	{#State 154
		DEFAULT => -45
	},
	{#State 155
		ACTIONS => {
			")" => 188
		}
	},
	{#State 156
		ACTIONS => {
			"{" => 189
		},
		GOTOS => {
			'CodeBlock' => 190
		}
	},
	{#State 157
		ACTIONS => {
			"= sub {" => 191
		}
	},
	{#State 158
		ACTIONS => {
			";" => 192
		}
	},
	{#State 159
		DEFAULT => -76
	},
	{#State 160
		ACTIONS => {
			"}" => 193
		}
	},
	{#State 161
		DEFAULT => -80
	},
	{#State 162
		ACTIONS => {
			'OP18_TERNARY' => 87,
			'OP21_LIST_COMMA' => -135,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP11_COMPARE_LT_GT' => 79,
			'OP15_LOGICAL_AND' => 80,
			");" => -135,
			'OP08_MATH_ADD_SUB' => 81,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP09_BITWISE_SHIFT' => 90,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP23_LOGICAL_AND' => 84,
			'OP12_COMPARE_EQ_NEQ' => 74,
			'OP13_BITWISE_AND' => 76,
			'OP16_LOGICAL_OR' => 77,
			'OP17_LIST_RANGE' => 85,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP06_REGEX_MATCH' => 78,
			")" => 146
		}
	},
	{#State 163
		ACTIONS => {
			");" => 194
		}
	},
	{#State 164
		DEFAULT => -70
	},
	{#State 165
		ACTIONS => {
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP10_NAMED_UNARY' => 35,
			'OP05_LOGICAL_NEG' => 30,
			'LITERAL' => 31,
			"(" => 32,
			'OP22_LOGICAL_NOT' => 33,
			");" => -73,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10,
			'OP01_NAMED' => 42,
			'KEYS_OR_VALUES' => 60,
			'OP03_MATH_INC_DEC' => 43,
			"\@{" => 61,
			"[" => 22
		},
		GOTOS => {
			'ListElementValue' => 64,
			'OPTIONAL-18' => 196,
			'Variable' => 63,
			'ListElements' => 195,
			'Operator' => 28,
			'Expression' => 59,
			'WordScoped' => 39
		}
	},
	{#State 166
		DEFAULT => -123
	},
	{#State 167
		ACTIONS => {
			"[" => 22,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			"{" => 36,
			'WORD' => 10,
			'LITERAL' => 31,
			"(" => 32,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_LOGICAL_NEG' => 30
		},
		GOTOS => {
			'Variable' => 63,
			'WordScoped' => 39,
			'Expression' => 197,
			'Operator' => 28
		}
	},
	{#State 168
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 43,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED' => 42,
			"[" => 22,
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"(" => 32,
			'OP05_LOGICAL_NEG' => 30,
			'WORD' => 10,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP05_MATH_NEG' => 29
		},
		GOTOS => {
			'Variable' => 63,
			'Expression' => 198,
			'WordScoped' => 39,
			'Operator' => 28
		}
	},
	{#State 169
		ACTIONS => {
			";" => 199,
			'OP19_VARIABLE_ASSIGN' => 200
		}
	},
	{#State 170
		ACTIONS => {
			"use Carp;" => 201
		}
	},
	{#State 171
		ACTIONS => {
			"our %properties = (" => 202
		},
		GOTOS => {
			'Properties' => 203
		}
	},
	{#State 172
		DEFAULT => -144
	},
	{#State 173
		ACTIONS => {
			"}" => 204
		}
	},
	{#State 174
		DEFAULT => -136
	},
	{#State 175
		ACTIONS => {
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			'KEYS_OR_VALUES' => 60,
			"\@{" => 61,
			'OP01_NAMED' => 42,
			"[" => 22,
			'OP05_LOGICAL_NEG' => 30,
			'LITERAL' => 31,
			"(" => 32,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_MATH_NEG' => 29,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'WORD' => 10
		},
		GOTOS => {
			'ListElementValue' => 205,
			'WordScoped' => 39,
			'Expression' => 59,
			'Operator' => 28,
			'Variable' => 63
		}
	},
	{#State 176
		DEFAULT => -132
	},
	{#State 177
		ACTIONS => {
			'WORD' => 10,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"(" => 32,
			'OP05_LOGICAL_NEG' => 30,
			"[" => 22,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43
		},
		GOTOS => {
			'Expression' => 206,
			'WordScoped' => 39,
			'Operator' => 28,
			'Variable' => 63
		}
	},
	{#State 178
		ACTIONS => {
			"{" => 189
		},
		GOTOS => {
			'CodeBlock' => 207
		}
	},
	{#State 179
		ACTIONS => {
			"(" => 208
		}
	},
	{#State 180
		ACTIONS => {
			"/" => 209
		}
	},
	{#State 181
		ACTIONS => {
			'VARIABLE_SYMBOL' => 52
		},
		GOTOS => {
			'Variable' => 210
		}
	},
	{#State 182
		ACTIONS => {
			'VARIABLE_SYMBOL' => 52
		},
		GOTOS => {
			'Variable' => 211
		}
	},
	{#State 183
		DEFAULT => -140,
		GOTOS => {
			'STAR-36' => 212
		}
	},
	{#State 184
		ACTIONS => {
			"}" => -142,
			'OP17_LIST_RANGE' => 85,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP16_LOGICAL_OR' => 77,
			'OP13_BITWISE_AND' => 76,
			'OP06_REGEX_MATCH' => 78,
			'OP12_COMPARE_EQ_NEQ' => 74,
			'OP09_BITWISE_SHIFT' => 90,
			'OP15_LOGICAL_AND' => 80,
			");" => -142,
			'OP08_MATH_ADD_SUB' => 81,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			'OP23_LOGICAL_AND' => 84,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP18_TERNARY' => 87,
			'OP21_LIST_COMMA' => -142,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP11_COMPARE_LT_GT' => 79
		}
	},
	{#State 185
		DEFAULT => -96
	},
	{#State 186
		DEFAULT => -130
	},
	{#State 187
		ACTIONS => {
			'OP10_NAMED_UNARY' => 35,
			")" => -90,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			'KEYS_OR_VALUES' => 60,
			"\@{" => 61,
			"[" => 22,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_LOGICAL_NEG' => 30,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10
		},
		GOTOS => {
			'Operator' => 28,
			'Expression' => 59,
			'WordScoped' => 39,
			'Variable' => 63,
			'ListElements' => 213,
			'OPTIONAL-24' => 214,
			'ListElementValue' => 64
		}
	},
	{#State 188
		DEFAULT => -47
	},
	{#State 189
		ACTIONS => {
			"(" => 32,
			"foreach my" => -101,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_LOGICAL_NEG' => 30,
			"if (" => 46,
			'OP05_MATH_NEG' => 29,
			'WORD' => 45,
			"while (" => -101,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			"[" => 22,
			"my" => 53,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP10_NAMED_UNARY' => 35,
			"for my integer" => -101,
			'OP01_NAMED_VOID' => 50,
			'OP19_LOOP_CONTROL' => 34
		},
		GOTOS => {
			'VariableDeclaration' => 47,
			'PAREN-25' => 49,
			'OperatorVoid' => 37,
			'PLUS-31' => 215,
			'Expression' => 27,
			'Operator' => 28,
			'VariableModification' => 51,
			'Statement' => 44,
			'OPTIONAL-26' => 26,
			'Conditional' => 24,
			'LoopLabel' => 25,
			'Variable' => 41,
			'WordScoped' => 39,
			'Operation' => 216
		}
	},
	{#State 190
		DEFAULT => -109,
		GOTOS => {
			'STAR-28' => 217
		}
	},
	{#State 191
		ACTIONS => {
			'OP01_NAMED' => -35,
			'OP03_MATH_INC_DEC' => -35,
			"while (" => -35,
			"[" => -35,
			'OP05_LOGICAL_NEG' => -35,
			"if (" => -35,
			"(" => -35,
			"foreach my" => -35,
			'LITERAL' => -35,
			'OP22_LOGICAL_NOT' => -35,
			'OP05_MATH_NEG' => -35,
			'WORD' => -35,
			"( my" => 220,
			'OP10_NAMED_UNARY' => -35,
			"for my integer" => -35,
			'OP01_NAMED_VOID' => -35,
			'OP19_LOOP_CONTROL' => -35,
			"my" => -35,
			'VARIABLE_SYMBOL' => -35,
			"{" => -35
		},
		GOTOS => {
			'SubroutineArguments' => 219,
			'OPTIONAL-12' => 218
		}
	},
	{#State 192
		DEFAULT => -81
	},
	{#State 193
		DEFAULT => -170
	},
	{#State 194
		DEFAULT => -78
	},
	{#State 195
		DEFAULT => -72
	},
	{#State 196
		ACTIONS => {
			");" => 221
		}
	},
	{#State 197
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 74,
			'OP06_REGEX_MATCH' => 78,
			"}" => 222,
			'OP16_LOGICAL_OR' => 77,
			'OP17_LIST_RANGE' => 85,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP13_BITWISE_AND' => 76,
			'OP11_COMPARE_LT_GT' => 79,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP18_TERNARY' => 87,
			'OP23_LOGICAL_AND' => 84,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP09_BITWISE_SHIFT' => 90,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP15_LOGICAL_AND' => 80,
			'OP08_MATH_ADD_SUB' => 81
		}
	},
	{#State 198
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 74,
			"]" => 223,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP17_LIST_RANGE' => 85,
			'OP13_BITWISE_AND' => 76,
			'OP16_LOGICAL_OR' => 77,
			'OP06_REGEX_MATCH' => 78,
			'OP18_TERNARY' => 87,
			'OP11_COMPARE_LT_GT' => 79,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP09_BITWISE_SHIFT' => 90,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			'OP08_MATH_ADD_SUB' => 81,
			'OP15_LOGICAL_AND' => 80,
			'OP23_LOGICAL_AND' => 84,
			'OP14_BITWISE_OR_XOR' => 83
		}
	},
	{#State 199
		DEFAULT => -128
	},
	{#State 200
		ACTIONS => {
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_LOGICAL_NEG' => 30,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'WORD' => 10,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			'OP10_NAMED_UNARY' => 35,
			"[" => 22
		},
		GOTOS => {
			'Operator' => 28,
			'Expression' => 224,
			'WordScoped' => 39,
			'Variable' => 63
		}
	},
	{#State 201
		ACTIONS => {
			"use RPerl;" => 225
		}
	},
	{#State 202
		ACTIONS => {
			'WORD' => 99,
			");" => -155
		},
		GOTOS => {
			'HashEntries' => 227,
			'OPTIONAL-42' => 226
		}
	},
	{#State 203
		DEFAULT => -147,
		GOTOS => {
			'STAR-38' => 228
		}
	},
	{#State 204
		DEFAULT => -137
	},
	{#State 205
		DEFAULT => -131
	},
	{#State 206
		ACTIONS => {
			'OP17_LIST_RANGE' => 85,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP13_BITWISE_AND' => 76,
			'OP16_LOGICAL_OR' => 77,
			'OP06_REGEX_MATCH' => 78,
			'OP12_COMPARE_EQ_NEQ' => 74,
			'OP09_BITWISE_SHIFT' => 90,
			'OP15_LOGICAL_AND' => 80,
			'OP08_MATH_ADD_SUB' => 81,
			'OP08_STRING_CAT' => 89,
			'OP04_MATH_POW' => 82,
			'OP23_LOGICAL_AND' => 84,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP18_TERNARY' => 87,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP11_COMPARE_LT_GT' => 79,
			".." => 229
		}
	},
	{#State 207
		DEFAULT => -119
	},
	{#State 208
		ACTIONS => {
			"[" => 22,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			'KEYS_OR_VALUES' => 60,
			"\@{" => 61,
			'OP10_NAMED_UNARY' => 35,
			'WORD' => 10,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"(" => 32,
			'OP05_LOGICAL_NEG' => 30
		},
		GOTOS => {
			'ListElementValue' => 64,
			'Variable' => 63,
			'ListElements' => 230,
			'Operator' => 28,
			'Expression' => 59,
			'WordScoped' => 39
		}
	},
	{#State 209
		DEFAULT => -53
	},
	{#State 210
		DEFAULT => -66
	},
	{#State 211
		ACTIONS => {
			"}" => 231
		}
	},
	{#State 212
		ACTIONS => {
			"}" => -141,
			");" => -141,
			'OP21_LIST_COMMA' => 232
		},
		GOTOS => {
			'PAREN-35' => 233
		}
	},
	{#State 213
		DEFAULT => -89
	},
	{#State 214
		ACTIONS => {
			")" => 234
		}
	},
	{#State 215
		ACTIONS => {
			"my" => 53,
			'VARIABLE_SYMBOL' => 52,
			"}" => 235,
			"{" => 36,
			"for my integer" => -101,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED_VOID' => 50,
			'OP19_LOOP_CONTROL' => 34,
			"if (" => 46,
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			"foreach my" => -101,
			"(" => 32,
			'LITERAL' => 31,
			'WORD' => 45,
			'OP05_MATH_NEG' => 29,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			"while (" => -101,
			"[" => 22
		},
		GOTOS => {
			'LoopLabel' => 25,
			'Conditional' => 24,
			'OPTIONAL-26' => 26,
			'Statement' => 44,
			'VariableModification' => 51,
			'WordScoped' => 39,
			'Operation' => 236,
			'Variable' => 41,
			'VariableDeclaration' => 47,
			'PAREN-25' => 49,
			'Expression' => 27,
			'Operator' => 28,
			'OperatorVoid' => 37
		}
	},
	{#State 216
		DEFAULT => -121
	},
	{#State 217
		ACTIONS => {
			'OP01_NAMED_VOID' => -112,
			'OP19_LOOP_CONTROL' => -112,
			'OP10_NAMED_UNARY' => -112,
			"for my integer" => -112,
			"elsif (" => 241,
			"}" => -112,
			'VARIABLE_SYMBOL' => -112,
			"{" => -112,
			"my" => -112,
			"};" => -112,
			"[" => -112,
			"while (" => -112,
			'OP01_NAMED' => -112,
			'OP03_MATH_INC_DEC' => -112,
			'WORD' => -112,
			"else" => 240,
			'OP05_MATH_NEG' => -112,
			'' => -112,
			'OP22_LOGICAL_NOT' => -112,
			"(" => -112,
			'LITERAL' => -112,
			"foreach my" => -112,
			"if (" => -112,
			'OP05_LOGICAL_NEG' => -112
		},
		GOTOS => {
			'OPTIONAL-30' => 237,
			'PAREN-29' => 239,
			'PAREN-27' => 238
		}
	},
	{#State 218
		ACTIONS => {
			'OP10_NAMED_UNARY' => 35,
			"for my integer" => -101,
			'OP01_NAMED_VOID' => 50,
			'OP19_LOOP_CONTROL' => 34,
			"my" => 53,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			"while (" => -101,
			"[" => 22,
			"if (" => 46,
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			"foreach my" => -101,
			'LITERAL' => 31,
			"(" => 32,
			'WORD' => 45,
			'OP05_MATH_NEG' => 29
		},
		GOTOS => {
			'Operator' => 28,
			'Expression' => 27,
			'OperatorVoid' => 37,
			'PAREN-25' => 49,
			'VariableDeclaration' => 47,
			'Operation' => 242,
			'WordScoped' => 39,
			'PLUS-13' => 243,
			'Variable' => 41,
			'Conditional' => 24,
			'LoopLabel' => 25,
			'Statement' => 44,
			'OPTIONAL-26' => 26,
			'VariableModification' => 51
		}
	},
	{#State 219
		DEFAULT => -34
	},
	{#State 220
		ACTIONS => {
			'WORD' => 109
		},
		GOTOS => {
			'Type' => 244
		}
	},
	{#State 221
		DEFAULT => -79
	},
	{#State 222
		DEFAULT => -127
	},
	{#State 223
		DEFAULT => -126
	},
	{#State 224
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP11_COMPARE_LT_GT' => 79,
			'OP18_TERNARY' => 87,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP23_LOGICAL_AND' => 84,
			'OP08_MATH_ADD_SUB' => 81,
			'OP15_LOGICAL_AND' => 80,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP09_BITWISE_SHIFT' => 90,
			";" => 245,
			'OP12_COMPARE_EQ_NEQ' => 74,
			'OP06_REGEX_MATCH' => 78,
			'OP17_LIST_RANGE' => 85,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP16_LOGICAL_OR' => 77,
			'OP13_BITWISE_AND' => 76
		}
	},
	{#State 225
		DEFAULT => -16,
		GOTOS => {
			'STAR-5' => 246
		}
	},
	{#State 226
		ACTIONS => {
			");" => 247
		}
	},
	{#State 227
		DEFAULT => -154
	},
	{#State 228
		ACTIONS => {
			"our" => 248,
			"1;" => 249
		},
		GOTOS => {
			'Method' => 250
		}
	},
	{#State 229
		ACTIONS => {
			'OP01_NAMED' => 42,
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			"[" => 22,
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			"(" => 32,
			'LITERAL' => 31,
			'WORD' => 10,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			"{" => 36
		},
		GOTOS => {
			'Variable' => 63,
			'Expression' => 251,
			'WordScoped' => 39,
			'Operator' => 28
		}
	},
	{#State 230
		ACTIONS => {
			")" => 252
		}
	},
	{#State 231
		DEFAULT => -143
	},
	{#State 232
		ACTIONS => {
			'WORD' => 253
		}
	},
	{#State 233
		DEFAULT => -139
	},
	{#State 234
		DEFAULT => -97
	},
	{#State 235
		DEFAULT => -122
	},
	{#State 236
		DEFAULT => -120
	},
	{#State 237
		DEFAULT => -113
	},
	{#State 238
		DEFAULT => -108
	},
	{#State 239
		DEFAULT => -111
	},
	{#State 240
		ACTIONS => {
			"{" => 189
		},
		GOTOS => {
			'CodeBlock' => 254
		}
	},
	{#State 241
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"(" => 32,
			'WORD' => 10,
			"{" => 36,
			'OP05_MATH_NEG' => 29,
			'VARIABLE_SYMBOL' => 52,
			'OP01_NAMED' => 42,
			'OP10_NAMED_UNARY' => 35,
			'OP03_MATH_INC_DEC' => 43,
			"[" => 22
		},
		GOTOS => {
			'Variable' => 63,
			'WordScoped' => 39,
			'Expression' => 255,
			'Operator' => 28
		}
	},
	{#State 242
		DEFAULT => -37
	},
	{#State 243
		ACTIONS => {
			"if (" => 46,
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			"foreach my" => -101,
			"(" => 32,
			'LITERAL' => 31,
			'WORD' => 45,
			'OP05_MATH_NEG' => 29,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42,
			"while (" => -101,
			"[" => 22,
			"};" => 256,
			"my" => 53,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			'OP10_NAMED_UNARY' => 35,
			"for my integer" => -101,
			'OP19_LOOP_CONTROL' => 34,
			'OP01_NAMED_VOID' => 50
		},
		GOTOS => {
			'OperatorVoid' => 37,
			'Operator' => 28,
			'Expression' => 27,
			'PAREN-25' => 49,
			'VariableDeclaration' => 47,
			'Variable' => 41,
			'Operation' => 257,
			'WordScoped' => 39,
			'OPTIONAL-26' => 26,
			'VariableModification' => 51,
			'Statement' => 44,
			'Conditional' => 24,
			'LoopLabel' => 25
		}
	},
	{#State 244
		ACTIONS => {
			'VARIABLE_SYMBOL' => 258
		}
	},
	{#State 245
		DEFAULT => -129
	},
	{#State 246
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -18,
			'OP01_NAMED_VOID' => -18,
			'OP10_NAMED_UNARY' => -18,
			"for my integer" => -18,
			"use constant" => -18,
			'VARIABLE_SYMBOL' => -18,
			"{" => -18,
			"my" => -18,
			"[" => -18,
			"use" => 261,
			'OP03_MATH_INC_DEC' => -18,
			'OP01_NAMED' => -18,
			"while (" => -18,
			"use parent qw(" => -18,
			'WORD' => -18,
			'OP05_MATH_NEG' => -18,
			"if (" => -18,
			'OP05_LOGICAL_NEG' => -18,
			'OP22_LOGICAL_NOT' => -18,
			"(" => -18,
			'LITERAL' => -18,
			"foreach my" => -18,
			"our" => -18
		},
		GOTOS => {
			'Include' => 259,
			'STAR-6' => 260
		}
	},
	{#State 247
		DEFAULT => -156
	},
	{#State 248
		ACTIONS => {
			'WORD' => 109
		},
		GOTOS => {
			'Type' => 262
		}
	},
	{#State 249
		ACTIONS => {
			'' => -152,
			"our" => 48,
			"package" => -152
		},
		GOTOS => {
			'Subroutine' => 266,
			'PLUS-39' => 264,
			'PAREN-40' => 265,
			'OPTIONAL-41' => 263
		}
	},
	{#State 250
		DEFAULT => -146
	},
	{#State 251
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 83,
			'OP23_LOGICAL_AND' => 84,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP15_LOGICAL_AND' => 80,
			'OP08_MATH_ADD_SUB' => 81,
			'OP09_BITWISE_SHIFT' => 90,
			'OP11_COMPARE_LT_GT' => 79,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP18_TERNARY' => 87,
			")" => 267,
			'OP06_REGEX_MATCH' => 78,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP17_LIST_RANGE' => 85,
			'OP13_BITWISE_AND' => 76,
			'OP16_LOGICAL_OR' => 77,
			'OP12_COMPARE_EQ_NEQ' => 74
		}
	},
	{#State 252
		ACTIONS => {
			"{" => 189
		},
		GOTOS => {
			'CodeBlock' => 268
		}
	},
	{#State 253
		ACTIONS => {
			'OP20_HASH_FATARROW' => 269
		}
	},
	{#State 254
		DEFAULT => -110
	},
	{#State 255
		ACTIONS => {
			'OP06_REGEX_MATCH' => 78,
			")" => 270,
			'OP07_MATH_MULT_DIV_MOD' => 86,
			'OP17_LIST_RANGE' => 85,
			'OP16_LOGICAL_OR' => 77,
			'OP13_BITWISE_AND' => 76,
			'OP12_COMPARE_EQ_NEQ' => 74,
			'OP23_LOGICAL_AND' => 84,
			'OP14_BITWISE_OR_XOR' => 83,
			'OP09_BITWISE_SHIFT' => 90,
			'OP15_LOGICAL_AND' => 80,
			'OP08_MATH_ADD_SUB' => 81,
			'OP04_MATH_POW' => 82,
			'OP08_STRING_CAT' => 89,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP11_COMPARE_LT_GT' => 79,
			'OP18_TERNARY' => 87
		}
	},
	{#State 256
		DEFAULT => -38
	},
	{#State 257
		DEFAULT => -36
	},
	{#State 258
		DEFAULT => -41,
		GOTOS => {
			'STAR-15' => 271
		}
	},
	{#State 259
		DEFAULT => -15
	},
	{#State 260
		ACTIONS => {
			'VARIABLE_SYMBOL' => -19,
			"{" => -19,
			"my" => -19,
			'OP19_LOOP_CONTROL' => -19,
			'OP01_NAMED_VOID' => -19,
			'OP10_NAMED_UNARY' => -19,
			"for my integer" => -19,
			"use constant" => 273,
			"use parent qw(" => -19,
			'OP05_MATH_NEG' => -19,
			'WORD' => -19,
			'OP05_LOGICAL_NEG' => -19,
			"if (" => -19,
			"foreach my" => -19,
			"(" => -19,
			"our" => -19,
			'LITERAL' => -19,
			'OP22_LOGICAL_NOT' => -19,
			"[" => -19,
			'OP01_NAMED' => -19,
			'OP03_MATH_INC_DEC' => -19,
			"while (" => -19
		},
		GOTOS => {
			'Constant' => 272
		}
	},
	{#State 261
		ACTIONS => {
			'WORD' => 10
		},
		GOTOS => {
			'WordScoped' => 274
		}
	},
	{#State 262
		ACTIONS => {
			'VARIABLE_SYMBOL' => 275
		}
	},
	{#State 263
		DEFAULT => -153
	},
	{#State 264
		ACTIONS => {
			"our" => 48,
			"1;" => 277
		},
		GOTOS => {
			'Subroutine' => 276
		}
	},
	{#State 265
		DEFAULT => -151
	},
	{#State 266
		DEFAULT => -149
	},
	{#State 267
		ACTIONS => {
			"{" => 189
		},
		GOTOS => {
			'CodeBlock' => 278
		}
	},
	{#State 268
		DEFAULT => -118
	},
	{#State 269
		ACTIONS => {
			"%{" => 182,
			'VARIABLE_SYMBOL' => 52,
			'OP05_MATH_NEG' => 29,
			"{" => 36,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 30,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			"[" => 22,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			'OP10_NAMED_UNARY' => 35
		},
		GOTOS => {
			'WordScoped' => 39,
			'Expression' => 184,
			'Operator' => 28,
			'HashEntryValue' => 279,
			'Variable' => 63
		}
	},
	{#State 270
		ACTIONS => {
			"{" => 189
		},
		GOTOS => {
			'CodeBlock' => 280
		}
	},
	{#State 271
		ACTIONS => {
			'OP21_LIST_COMMA' => 283,
			") = \@_;" => 282
		},
		GOTOS => {
			'PAREN-14' => 281
		}
	},
	{#State 272
		DEFAULT => -17
	},
	{#State 273
		ACTIONS => {
			'WORD' => 284
		}
	},
	{#State 274
		ACTIONS => {
			";" => 286,
			"qw(" => 285
		}
	},
	{#State 275
		ACTIONS => {
			"= sub {" => 287
		}
	},
	{#State 276
		DEFAULT => -148
	},
	{#State 277
		DEFAULT => -150
	},
	{#State 278
		DEFAULT => -117
	},
	{#State 279
		DEFAULT => -138
	},
	{#State 280
		DEFAULT => -107
	},
	{#State 281
		DEFAULT => -40
	},
	{#State 282
		DEFAULT => -42
	},
	{#State 283
		ACTIONS => {
			"my" => 288
		}
	},
	{#State 284
		ACTIONS => {
			'OP20_HASH_FATARROW' => 289
		}
	},
	{#State 285
		ACTIONS => {
			'WORD' => 290
		},
		GOTOS => {
			'PLUS-7' => 291
		}
	},
	{#State 286
		DEFAULT => -22
	},
	{#State 287
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -158,
			'OP01_NAMED_VOID' => -158,
			'OP10_NAMED_UNARY' => -158,
			"for my integer" => -158,
			"( my" => 293,
			'VARIABLE_SYMBOL' => -158,
			"{" => -158,
			"my" => -158,
			"[" => -158,
			"while (" => -158,
			'OP01_NAMED' => -158,
			'OP03_MATH_INC_DEC' => -158,
			'WORD' => -158,
			'OP05_MATH_NEG' => -158,
			'OP22_LOGICAL_NOT' => -158,
			"foreach my" => -158,
			"(" => -158,
			'LITERAL' => -158,
			"if (" => -158,
			'OP05_LOGICAL_NEG' => -158
		},
		GOTOS => {
			'MethodArguments' => 294,
			'OPTIONAL-43' => 292
		}
	},
	{#State 288
		ACTIONS => {
			'WORD' => 109
		},
		GOTOS => {
			'Type' => 295
		}
	},
	{#State 289
		ACTIONS => {
			'LITERAL' => 298,
			"{" => 296,
			"[" => 297
		},
		GOTOS => {
			'Constant_Value' => 299
		}
	},
	{#State 290
		DEFAULT => -21
	},
	{#State 291
		ACTIONS => {
			'WORD' => 301,
			");" => 300
		}
	},
	{#State 292
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 30,
			"if (" => 46,
			"foreach my" => -101,
			"(" => 32,
			'LITERAL' => 31,
			'OP22_LOGICAL_NOT' => 33,
			'OP05_MATH_NEG' => 29,
			'WORD' => 45,
			'OP03_MATH_INC_DEC' => 43,
			'OP01_NAMED' => 42,
			"while (" => -101,
			"[" => 22,
			"my" => 53,
			'VARIABLE_SYMBOL' => 52,
			"{" => 36,
			"for my integer" => -101,
			'OP10_NAMED_UNARY' => 35,
			'OP01_NAMED_VOID' => 50,
			'OP19_LOOP_CONTROL' => 34
		},
		GOTOS => {
			'VariableDeclaration' => 47,
			'PAREN-25' => 49,
			'OperatorVoid' => 37,
			'Expression' => 27,
			'PLUS-44' => 302,
			'Operator' => 28,
			'OPTIONAL-26' => 26,
			'VariableModification' => 51,
			'Statement' => 44,
			'Conditional' => 24,
			'LoopLabel' => 25,
			'Variable' => 41,
			'WordScoped' => 39,
			'Operation' => 303
		}
	},
	{#State 293
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 304
		}
	},
	{#State 294
		DEFAULT => -157
	},
	{#State 295
		ACTIONS => {
			'VARIABLE_SYMBOL' => 305
		}
	},
	{#State 296
		ACTIONS => {
			'WORD' => 306
		}
	},
	{#State 297
		ACTIONS => {
			'LITERAL' => 307
		}
	},
	{#State 298
		DEFAULT => -31
	},
	{#State 299
		ACTIONS => {
			";" => 308
		}
	},
	{#State 300
		DEFAULT => -23
	},
	{#State 301
		DEFAULT => -20
	},
	{#State 302
		ACTIONS => {
			'WORD' => 45,
			'OP05_MATH_NEG' => 29,
			"if (" => 46,
			'OP05_LOGICAL_NEG' => 30,
			'OP22_LOGICAL_NOT' => 33,
			'LITERAL' => 31,
			"foreach my" => -101,
			"(" => 32,
			"[" => 22,
			"};" => 310,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 43,
			"while (" => -101,
			"{" => 36,
			'VARIABLE_SYMBOL' => 52,
			"my" => 53,
			'OP19_LOOP_CONTROL' => 34,
			'OP01_NAMED_VOID' => 50,
			"for my integer" => -101,
			'OP10_NAMED_UNARY' => 35
		},
		GOTOS => {
			'VariableDeclaration' => 47,
			'PAREN-25' => 49,
			'Expression' => 27,
			'Operator' => 28,
			'OperatorVoid' => 37,
			'LoopLabel' => 25,
			'Conditional' => 24,
			'VariableModification' => 51,
			'OPTIONAL-26' => 26,
			'Statement' => 44,
			'WordScoped' => 39,
			'Operation' => 309,
			'Variable' => 41
		}
	},
	{#State 303
		DEFAULT => -160
	},
	{#State 304
		DEFAULT => -164,
		GOTOS => {
			'STAR-46' => 311
		}
	},
	{#State 305
		DEFAULT => -39
	},
	{#State 306
		ACTIONS => {
			'OP20_HASH_FATARROW' => 312
		}
	},
	{#State 307
		DEFAULT => -27,
		GOTOS => {
			'STAR-9' => 313
		}
	},
	{#State 308
		DEFAULT => -24
	},
	{#State 309
		DEFAULT => -159
	},
	{#State 310
		DEFAULT => -161
	},
	{#State 311
		ACTIONS => {
			'OP21_LIST_COMMA' => 315,
			") = \@_;" => 314
		},
		GOTOS => {
			'PAREN-45' => 316
		}
	},
	{#State 312
		ACTIONS => {
			'LITERAL' => 317
		}
	},
	{#State 313
		ACTIONS => {
			"]" => 320,
			'OP21_LIST_COMMA' => 319
		},
		GOTOS => {
			'PAREN-8' => 318
		}
	},
	{#State 314
		DEFAULT => -165
	},
	{#State 315
		ACTIONS => {
			"my" => 321
		}
	},
	{#State 316
		DEFAULT => -163
	},
	{#State 317
		DEFAULT => -30,
		GOTOS => {
			'STAR-11' => 322
		}
	},
	{#State 318
		DEFAULT => -26
	},
	{#State 319
		ACTIONS => {
			'LITERAL' => 323
		}
	},
	{#State 320
		DEFAULT => -32
	},
	{#State 321
		ACTIONS => {
			'WORD' => 109
		},
		GOTOS => {
			'Type' => 324
		}
	},
	{#State 322
		ACTIONS => {
			"}" => 325,
			'OP21_LIST_COMMA' => 326
		},
		GOTOS => {
			'PAREN-10' => 327
		}
	},
	{#State 323
		DEFAULT => -25
	},
	{#State 324
		ACTIONS => {
			'VARIABLE_SYMBOL' => 328
		}
	},
	{#State 325
		DEFAULT => -33
	},
	{#State 326
		ACTIONS => {
			'WORD' => 329
		}
	},
	{#State 327
		DEFAULT => -29
	},
	{#State 328
		DEFAULT => -162
	},
	{#State 329
		ACTIONS => {
			'OP20_HASH_FATARROW' => 330
		}
	},
	{#State 330
		ACTIONS => {
			'LITERAL' => 331
		}
	},
	{#State 331
		DEFAULT => -28
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 4035 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 99 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4042 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 99 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4049 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4060 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 100 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4078 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 100 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4085 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-3', 2,
sub {
#line 100 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4092 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-3', 1,
sub {
#line 100 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4099 lib/RPerl/Grammar.pm
	],
	[#Rule Program_9
		 'Program', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4110 lib/RPerl/Grammar.pm
	],
	[#Rule Module_10
		 'Module', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4121 lib/RPerl/Grammar.pm
	],
	[#Rule Module_11
		 'Module', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4132 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-4', 2,
sub {
#line 102 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4139 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-4', 1,
sub {
#line 102 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4146 lib/RPerl/Grammar.pm
	],
	[#Rule Package_14
		 'Package', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4157 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4164 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4171 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4178 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4185 lib/RPerl/Grammar.pm
	],
	[#Rule Header_19
		 'Header', 9,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4196 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-7', 2,
sub {
#line 104 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4203 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-7', 1,
sub {
#line 104 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4210 lib/RPerl/Grammar.pm
	],
	[#Rule Include_22
		 'Include', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4221 lib/RPerl/Grammar.pm
	],
	[#Rule Include_23
		 'Include', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4232 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_24
		 'Constant', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4243 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-8', 2,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4250 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4257 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4264 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-10', 4,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4271 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4278 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4285 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_Value_31
		 'Constant_Value', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4296 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_Value_32
		 'Constant_Value', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4307 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_Value_33
		 'Constant_Value', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4318 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 107 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4325 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 107 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4332 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 107 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4339 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 107 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4346 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_38
		 'Subroutine', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4357 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-14', 4,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4364 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-15', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4371 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-15', 0,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4378 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_42
		 'SubroutineArguments', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4389 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_43
		 'Operation', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4400 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_44
		 'Operation', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4411 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4418 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4425 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_47
		 'Operator', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4436 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_48
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4447 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_49
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4458 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_50
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4469 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_51
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4480 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_52
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4491 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_53
		 'Operator', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4502 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_54
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4513 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_55
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4524 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_56
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4535 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_57
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4546 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_58
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4557 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_59
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4568 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_60
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4579 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_61
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4590 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_62
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4601 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_63
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4612 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_64
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4623 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_65
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4634 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_66
		 'Operator', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4645 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_67
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4656 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_68
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4667 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_69
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4678 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4685 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4692 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4699 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4706 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4713 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4720 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-20', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4727 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-20', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4734 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_78
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4745 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_79
		 'OperatorVoid', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4756 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_80
		 'OperatorVoid', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4767 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_81
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4778 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_82
		 'OperatorVoid', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4789 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4796 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4803 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4810 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4817 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4824 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4831 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4838 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4845 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_91
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4856 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_92
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4867 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_93
		 'Expression', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4878 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_94
		 'Expression', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4889 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_95
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4900 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_96
		 'Expression', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4911 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_97
		 'Expression', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4922 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_98
		 'Expression', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4933 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4940 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4947 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4954 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_102
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4965 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_103
		 'Statement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4976 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_104
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4987 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_105
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4998 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_106
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5009 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 4,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5016 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5023 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5030 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5037 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-30', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5044 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-30', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5051 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_113
		 'Conditional', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5062 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_114
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5073 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_115
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5084 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_116
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5095 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_117
		 'LoopFor', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5106 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_118
		 'LoopForEach', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5117 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_119
		 'LoopWhile', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5128 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-31', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5135 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-31', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5142 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_122
		 'CodeBlock', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5153 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5160 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5167 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_125
		 'Variable', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5178 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_126
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5189 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_127
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5200 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_128
		 'VariableDeclaration', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5211 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_129
		 'VariableDeclaration', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5222 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_130
		 'VariableModification', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5233 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5240 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5247 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5254 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_134
		 'ListElements', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5265 lib/RPerl/Grammar.pm
	],
	[#Rule ListElementValue_135
		 'ListElementValue', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5276 lib/RPerl/Grammar.pm
	],
	[#Rule ListElementValue_136
		 'ListElementValue', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5287 lib/RPerl/Grammar.pm
	],
	[#Rule ListElementValue_137
		 'ListElementValue', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5298 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 4,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5305 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5312 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5319 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntries_141
		 'HashEntries', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5330 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryValue_142
		 'HashEntryValue', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5341 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryValue_143
		 'HashEntryValue', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5352 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-37', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5359 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-37', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5366 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5373 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5380 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-39', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5387 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-39', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5394 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5401 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5408 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5415 lib/RPerl/Grammar.pm
	],
	[#Rule Class_153
		 'Class', 11,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5426 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5433 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5440 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_156
		 'Properties', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5451 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5458 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5465 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5472 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5479 lib/RPerl/Grammar.pm
	],
	[#Rule Method_161
		 'Method', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5490 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 4,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5497 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5504 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5511 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_165
		 'MethodArguments', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5522 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5529 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5536 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5543 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_169
		 'WordScoped', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5554 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_170
		 'FileHandle', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5565 lib/RPerl/Grammar.pm
	],
	[#Rule Type_171
		 'Type', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5576 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_172
		 'LoopLabel', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5587 lib/RPerl/Grammar.pm
	]
],
#line 5590 lib/RPerl/Grammar.pm
    yybypass       => 0,
    yybuildingtree => 1,
    yyprefix       => '',
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
         'Operator_66', 
         'Operator_67', 
         'Operator_68', 
         'Operator_69', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_78', 
         'OperatorVoid_79', 
         'OperatorVoid_80', 
         'OperatorVoid_81', 
         'OperatorVoid_82', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_91', 
         'Expression_92', 
         'Expression_93', 
         'Expression_94', 
         'Expression_95', 
         'Expression_96', 
         'Expression_97', 
         'Expression_98', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_102', 
         'Statement_103', 
         'Statement_104', 
         'Statement_105', 
         'Statement_106', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_113', 
         'Loop_114', 
         'Loop_115', 
         'Loop_116', 
         'LoopFor_117', 
         'LoopForEach_118', 
         'LoopWhile_119', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_122', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_125', 
         'VariableRetrieval_126', 
         'VariableRetrieval_127', 
         'VariableDeclaration_128', 
         'VariableDeclaration_129', 
         'VariableModification_130', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_134', 
         'ListElementValue_135', 
         'ListElementValue_136', 
         'ListElementValue_137', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashEntries_141', 
         'HashEntryValue_142', 
         'HashEntryValue_143', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Class_153', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Properties_156', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Method_161', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_165', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'WordScoped_169', 
         'FileHandle_170', 
         'Type_171', 
         'LoopLabel_172', );
  $self;
}

#line 150 "lib/RPerl/Grammar.eyp"


{
    1;
}

=for None

=cut


#line 5792 lib/RPerl/Grammar.pm



1;
