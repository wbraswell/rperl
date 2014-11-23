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
    our $VERSION = 0.000_735;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

       /\G(\s*(?:#[^#\!].*)?\s*)/gc and print (q{WHITESPACE = '} . $1 . q{'} . "\n") ;

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|\#\!\/usr\/bin\/perl|filehandle_ref|for\ my\ integer|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|\<STDIN\>|while\ \(|\$TYPED_|\=\ sub\ \{|package|elsif\ \(|undef|else|if\ \(|\(\ my|our|use|qw\(|\@_\;|1\;|\{\*|\@\{|my|\.\.|\%\{|\}|\(|\)|\;|\{|\[|\]|\/)}gc and return ($1, $1);

      /\G\$VERSION\ \=\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$[a-zA-Z]\w*(::)*\w*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(keys|values)/gc and return ('KEYS_OR_VALUES', $1);
      /\G(string\s+\$class|object\s+\$self)/gc and return ('TYPE_CLASS_OR_SELF', $1);
      /\G(::[a-zA-Z]\w*__CHECK(TRACE)?)/gc and return ('CHECK_OR_CHECKTRACE', $1);
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
      /\G(scalar)/gc and return ('OP10_NAMED_UNARY', $1);
      /\G(::[a-zA-Z]\w*__stringify)/gc and return ('OP10_NAMED_UNARY_STRINGIFY', $1);
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\*|\/|\%)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(HOWDYHOWDYHOWDY)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(\+=|-=|\*=|\/=)/gc and return ('OP19_VARIABLE_ASSIGN_BY', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG', $1);
      /\G(\+|-)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(<|>|<=|>=|lt|gt|le|ge)/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G((print|croak|return|exit)\s*\()/gc and return ('OP01_NAMED_VOID_PAREN', $1);
      /\G(print|croak|return|exit)/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw)/gc and return ('OP01_NAMED_QW', $1);
      /\G(sin|cos|tan)/gc and return ('OP01_NAMED', $1);
      /\G(([a-zA-Z]\w*(::[a-zA-Z]\w*)+)|(::[a-zA-Z]\w*(::[a-zA-Z]\w*)*))/gc and return ('WORD_SCOPED', $1);
      /\G([a-zA-Z]\w*)/gc and return ('WORD', $1);
      /\G:/gc and return ('COLON', $1);


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


#line 114 lib/RPerl/Grammar.pm

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
  [ '_STAR_LIST' => 'STAR-2', [ 'STAR-2', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-2', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-3', [ 'STAR-3', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-3', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [ 'STAR-4', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [ 'STAR-5', 'Subroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-6', [ 'PLUS-6', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-6', [ 'Operation' ], 0 ],
  [ 'Program_15' => 'Program', [ '#!/usr/bin/perl', 'Header', 'STAR-2', 'STAR-3', 'STAR-4', 'STAR-5', 'PLUS-6' ], 0 ],
  [ 'Module_16' => 'Module', [ 'Package' ], 0 ],
  [ 'Module_17' => 'Module', [ 'Class' ], 0 ],
  [ '_STAR_LIST' => 'STAR-7', [ 'STAR-7', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-7', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-8', [ 'STAR-8', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-8', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-9', [ 'STAR-9', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-9', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-10', [ 'PLUS-10', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-10', [ 'Subroutine' ], 0 ],
  [ 'Package_26' => 'Package', [ 'package', 'WordScoped', ';', 'Header', 'STAR-7', 'STAR-8', 'STAR-9', 'PLUS-10', '1;', '1;' ], 0 ],
  [ 'Header_27' => 'Header', [ 'use strict;', 'use warnings;', 'use RPerl;', 'our', 'VERSION_NUMBER_ASSIGN' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-11', [ 'PLUS-11', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-11', [ 'WORD' ], 0 ],
  [ 'Critic_30' => 'Critic', [ '## no critic qw(', 'PLUS-11', ')' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-12', [ 'PLUS-12', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-12', [ 'WORD' ], 0 ],
  [ 'Include_33' => 'Include', [ 'use', 'WordScoped', ';' ], 0 ],
  [ 'Include_34' => 'Include', [ 'use', 'WordScoped', 'qw(', 'PLUS-12', ')', ';' ], 0 ],
  [ 'Constant_35' => 'Constant', [ 'use constant', 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'ConstantValue', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-13', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-13', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-14', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-14', [  ], 0 ],
  [ '_PAREN' => 'PAREN-15', [ 'OP21_LIST_COMMA', 'OPTIONAL-14', 'Literal' ], 0 ],
  [ '_STAR_LIST' => 'STAR-16', [ 'STAR-16', 'PAREN-15' ], 0 ],
  [ '_STAR_LIST' => 'STAR-16', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [  ], 0 ],
  [ '_PAREN' => 'PAREN-19', [ 'OP21_LIST_COMMA', 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-18', 'Literal' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [ 'STAR-20', 'PAREN-19' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [  ], 0 ],
  [ 'ConstantValue_50' => 'ConstantValue', [ 'Literal' ], 0 ],
  [ 'ConstantValue_51' => 'ConstantValue', [ '[', 'OPTIONAL-13', 'Literal', 'STAR-16', ']' ], 0 ],
  [ 'ConstantValue_52' => 'ConstantValue', [ '{', 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-17', 'Literal', 'STAR-20', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-22', [ 'PLUS-22', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-22', [ 'Operation' ], 0 ],
  [ 'Subroutine_57' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-21', 'PLUS-22', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-23', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [ 'STAR-24', 'PAREN-23' ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ 'SubroutineArguments_63' => 'SubroutineArguments', [ '( my', 'Type', 'VARIABLE_SYMBOL', 'STAR-24', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-25' ], 0 ],
  [ '_PAREN' => 'PAREN-26', [ 'OP21_LIST_COMMA', 'Expression', 'OP21_LIST_COMMA', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [ 'PAREN-26' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [  ], 0 ],
  [ 'ArgumentCheck_67' => 'ArgumentCheck', [ 'CHECK_OR_CHECKTRACE', '(', 'Expression', 'OPTIONAL-27', ')', ';' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [ 'STAR-29', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [ 'STAR-30', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [ 'STAR-31', 'Method' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-32', [ 'PLUS-32', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-32', [ 'Subroutine' ], 0 ],
  [ '_PAREN' => 'PAREN-33', [ 'PLUS-32', '1;', '1;' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'PAREN-33' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ 'Class_81' => 'Class', [ 'package', 'WordScoped', ';', 'Header', 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-28', 'STAR-29', 'STAR-30', 'Properties', 'STAR-31', '1;', '1;', 'OPTIONAL-34' ], 0 ],
  [ '_PAREN' => 'PAREN-35', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [ 'STAR-36', 'PAREN-35' ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [  ], 0 ],
  [ 'Properties_85' => 'Properties', [ 'our %properties = (', 'HashEntryTyped', 'STAR-36', ')', ';' ], 0 ],
  [ 'Properties_86' => 'Properties', [ 'our %properties = (', ')', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-38', [ 'PLUS-38', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-38', [ 'Operation' ], 0 ],
  [ 'Method_91' => 'Method', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-37', 'PLUS-38', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [ 'STAR-40', 'PAREN-39' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [ 'STAR-41', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [  ], 0 ],
  [ 'MethodArguments_97' => 'MethodArguments', [ '( my', 'TYPE_CLASS_OR_SELF', 'STAR-40', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-41' ], 0 ],
  [ 'Operation_98' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_99' => 'Operation', [ 'Statement' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'OP01_NAMED', '(', 'OPTIONAL-42', ')' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'Expression', 'OP04_MATH_POW', 'Expression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'OP05_LOGICAL_NEG', 'Expression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'OP05_MATH_NEG', 'Expression', ')' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'Expression', 'OP06_REGEX_MATCH', '/', 'OP06_REGEX_PATTERN', '/' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'Expression', 'OP07_MATH_MULT_DIV_MOD', 'Expression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'Expression', 'OP08_MATH_ADD_SUB', 'Expression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'Expression', 'OP08_STRING_CAT', 'Expression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'Expression', 'OP09_BITWISE_SHIFT', 'Expression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'OP10_NAMED_UNARY', 'Expression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'OP10_NAMED_UNARY_STRINGIFY', 'Expression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'Expression', 'OP11_COMPARE_LT_GT', 'Expression' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'Expression', 'OP12_COMPARE_EQ_NEQ', 'Expression' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'Expression', 'OP13_BITWISE_AND', 'Expression' ], 0 ],
  [ 'Operator_118' => 'Operator', [ 'Expression', 'OP14_BITWISE_OR_XOR', 'Expression' ], 0 ],
  [ 'Operator_119' => 'Operator', [ 'Expression', 'OP15_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_120' => 'Operator', [ 'Expression', 'OP16_LOGICAL_OR', 'Expression' ], 0 ],
  [ 'Operator_121' => 'Operator', [ 'Expression', 'OP17_LIST_RANGE', 'Expression' ], 0 ],
  [ 'Operator_122' => 'Operator', [ 'Expression', 'OP18_TERNARY', 'Variable', 'COLON', 'Variable' ], 0 ],
  [ 'Operator_123' => 'Operator', [ 'OP22_LOGICAL_NOT', 'Expression' ], 0 ],
  [ 'Operator_124' => 'Operator', [ 'Expression', 'OP23_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_125' => 'Operator', [ 'Expression', 'OP24_LOGICAL_OR_XOR', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'OperatorVoid_134' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'OPTIONAL-43', ')', ';' ], 0 ],
  [ 'OperatorVoid_135' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'FileHandle', 'OPTIONAL-44', ')', ';' ], 0 ],
  [ 'OperatorVoid_136' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-45', ';' ], 0 ],
  [ 'OperatorVoid_137' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'FileHandle', 'OPTIONAL-46', ';' ], 0 ],
  [ 'OperatorVoid_138' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'Expression_143' => 'Expression', [ 'undef' ], 0 ],
  [ 'Expression_144' => 'Expression', [ 'Literal' ], 0 ],
  [ 'Expression_145' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_146' => 'Expression', [ 'ArrayReference' ], 0 ],
  [ 'Expression_147' => 'Expression', [ 'ArrayDereferenced' ], 0 ],
  [ 'Expression_148' => 'Expression', [ 'HashReference' ], 0 ],
  [ 'Expression_149' => 'Expression', [ 'HashDereferenced' ], 0 ],
  [ 'Expression_150' => 'Expression', [ '{', '}' ], 0 ],
  [ 'Expression_151' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_152' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-47', ')' ], 0 ],
  [ 'Expression_153' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-48', ')' ], 0 ],
  [ 'Expression_154' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ 'ExpressionOrStdin_155' => 'ExpressionOrStdin', [ 'Expression' ], 0 ],
  [ 'ExpressionOrStdin_156' => 'ExpressionOrStdin', [ '<STDIN>' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'PAREN-49' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'Statement_160' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_161' => 'Statement', [ 'OPTIONAL-50', 'Loop' ], 0 ],
  [ 'Statement_162' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_163' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_164' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ '_PAREN' => 'PAREN-53', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [ 'PAREN-53' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [  ], 0 ],
  [ 'Conditional_171' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-52', 'OPTIONAL-54' ], 0 ],
  [ 'Loop_172' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_173' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_174' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_175' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_176' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_177' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-55', [ 'PLUS-55', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-55', [ 'Operation' ], 0 ],
  [ 'CodeBlock_180' => 'CodeBlock', [ '{', 'PLUS-55', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [ 'STAR-56', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [  ], 0 ],
  [ 'Variable_183' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-56' ], 0 ],
  [ 'VariableRetrieval_184' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_185' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_186' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_187' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_188' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_189' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_190' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-57', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [ 'STAR-58', 'PAREN-57' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-59', [ 'PLUS-59', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-59', [ 'WORD' ], 0 ],
  [ 'ListElements_196' => 'ListElements', [ 'ListElement', 'STAR-58' ], 0 ],
  [ 'ListElements_197' => 'ListElements', [ 'OP01_NAMED_QW', '(', 'PLUS-59', ')' ], 0 ],
  [ 'ListElement_198' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_199' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_200' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [  ], 0 ],
  [ 'ArrayReference_203' => 'ArrayReference', [ '[', 'OPTIONAL-60', ']' ], 0 ],
  [ 'ArrayDereferenced_204' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_205' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-61', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-61', [  ], 0 ],
  [ 'HashEntry_208' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-61', 'Expression' ], 0 ],
  [ 'HashEntry_209' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_210' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_211' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-62', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-63', [ 'STAR-63', 'PAREN-62' ], 0 ],
  [ '_STAR_LIST' => 'STAR-63', [  ], 0 ],
  [ 'HashReference_215' => 'HashReference', [ '{', 'HashEntry', 'STAR-63', '}' ], 0 ],
  [ 'HashDereferenced_216' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_217' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_218' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_219' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'FileHandle_220' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'FileHandle_221' => 'FileHandle', [ 'my', 'filehandle_ref', 'VARIABLE_SYMBOL' ], 0 ],
  [ 'TypeInner_222' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Type_223' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_224' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Literal_225' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_226' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_STAR_LIST' => 7,
  '_STAR_LIST' => 8,
  '_STAR_LIST' => 9,
  '_STAR_LIST' => 10,
  '_STAR_LIST' => 11,
  '_STAR_LIST' => 12,
  '_PLUS_LIST' => 13,
  '_PLUS_LIST' => 14,
  'Program_15' => 15,
  'Module_16' => 16,
  'Module_17' => 17,
  '_STAR_LIST' => 18,
  '_STAR_LIST' => 19,
  '_STAR_LIST' => 20,
  '_STAR_LIST' => 21,
  '_STAR_LIST' => 22,
  '_STAR_LIST' => 23,
  '_PLUS_LIST' => 24,
  '_PLUS_LIST' => 25,
  'Package_26' => 26,
  'Header_27' => 27,
  '_PLUS_LIST' => 28,
  '_PLUS_LIST' => 29,
  'Critic_30' => 30,
  '_PLUS_LIST' => 31,
  '_PLUS_LIST' => 32,
  'Include_33' => 33,
  'Include_34' => 34,
  'Constant_35' => 35,
  '_OPTIONAL' => 36,
  '_OPTIONAL' => 37,
  '_OPTIONAL' => 38,
  '_OPTIONAL' => 39,
  '_PAREN' => 40,
  '_STAR_LIST' => 41,
  '_STAR_LIST' => 42,
  '_OPTIONAL' => 43,
  '_OPTIONAL' => 44,
  '_OPTIONAL' => 45,
  '_OPTIONAL' => 46,
  '_PAREN' => 47,
  '_STAR_LIST' => 48,
  '_STAR_LIST' => 49,
  'ConstantValue_50' => 50,
  'ConstantValue_51' => 51,
  'ConstantValue_52' => 52,
  '_OPTIONAL' => 53,
  '_OPTIONAL' => 54,
  '_PLUS_LIST' => 55,
  '_PLUS_LIST' => 56,
  'Subroutine_57' => 57,
  '_PAREN' => 58,
  '_STAR_LIST' => 59,
  '_STAR_LIST' => 60,
  '_STAR_LIST' => 61,
  '_STAR_LIST' => 62,
  'SubroutineArguments_63' => 63,
  '_PAREN' => 64,
  '_OPTIONAL' => 65,
  '_OPTIONAL' => 66,
  'ArgumentCheck_67' => 67,
  '_STAR_LIST' => 68,
  '_STAR_LIST' => 69,
  '_STAR_LIST' => 70,
  '_STAR_LIST' => 71,
  '_STAR_LIST' => 72,
  '_STAR_LIST' => 73,
  '_STAR_LIST' => 74,
  '_STAR_LIST' => 75,
  '_PLUS_LIST' => 76,
  '_PLUS_LIST' => 77,
  '_PAREN' => 78,
  '_OPTIONAL' => 79,
  '_OPTIONAL' => 80,
  'Class_81' => 81,
  '_PAREN' => 82,
  '_STAR_LIST' => 83,
  '_STAR_LIST' => 84,
  'Properties_85' => 85,
  'Properties_86' => 86,
  '_OPTIONAL' => 87,
  '_OPTIONAL' => 88,
  '_PLUS_LIST' => 89,
  '_PLUS_LIST' => 90,
  'Method_91' => 91,
  '_PAREN' => 92,
  '_STAR_LIST' => 93,
  '_STAR_LIST' => 94,
  '_STAR_LIST' => 95,
  '_STAR_LIST' => 96,
  'MethodArguments_97' => 97,
  'Operation_98' => 98,
  'Operation_99' => 99,
  '_OPTIONAL' => 100,
  '_OPTIONAL' => 101,
  'Operator_102' => 102,
  'Operator_103' => 103,
  'Operator_104' => 104,
  'Operator_105' => 105,
  'Operator_106' => 106,
  'Operator_107' => 107,
  'Operator_108' => 108,
  'Operator_109' => 109,
  'Operator_110' => 110,
  'Operator_111' => 111,
  'Operator_112' => 112,
  'Operator_113' => 113,
  'Operator_114' => 114,
  'Operator_115' => 115,
  'Operator_116' => 116,
  'Operator_117' => 117,
  'Operator_118' => 118,
  'Operator_119' => 119,
  'Operator_120' => 120,
  'Operator_121' => 121,
  'Operator_122' => 122,
  'Operator_123' => 123,
  'Operator_124' => 124,
  'Operator_125' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  '_OPTIONAL' => 128,
  '_OPTIONAL' => 129,
  '_OPTIONAL' => 130,
  '_OPTIONAL' => 131,
  '_OPTIONAL' => 132,
  '_OPTIONAL' => 133,
  'OperatorVoid_134' => 134,
  'OperatorVoid_135' => 135,
  'OperatorVoid_136' => 136,
  'OperatorVoid_137' => 137,
  'OperatorVoid_138' => 138,
  '_OPTIONAL' => 139,
  '_OPTIONAL' => 140,
  '_OPTIONAL' => 141,
  '_OPTIONAL' => 142,
  'Expression_143' => 143,
  'Expression_144' => 144,
  'Expression_145' => 145,
  'Expression_146' => 146,
  'Expression_147' => 147,
  'Expression_148' => 148,
  'Expression_149' => 149,
  'Expression_150' => 150,
  'Expression_151' => 151,
  'Expression_152' => 152,
  'Expression_153' => 153,
  'Expression_154' => 154,
  'ExpressionOrStdin_155' => 155,
  'ExpressionOrStdin_156' => 156,
  '_PAREN' => 157,
  '_OPTIONAL' => 158,
  '_OPTIONAL' => 159,
  'Statement_160' => 160,
  'Statement_161' => 161,
  'Statement_162' => 162,
  'Statement_163' => 163,
  'Statement_164' => 164,
  '_PAREN' => 165,
  '_STAR_LIST' => 166,
  '_STAR_LIST' => 167,
  '_PAREN' => 168,
  '_OPTIONAL' => 169,
  '_OPTIONAL' => 170,
  'Conditional_171' => 171,
  'Loop_172' => 172,
  'Loop_173' => 173,
  'Loop_174' => 174,
  'LoopFor_175' => 175,
  'LoopForEach_176' => 176,
  'LoopWhile_177' => 177,
  '_PLUS_LIST' => 178,
  '_PLUS_LIST' => 179,
  'CodeBlock_180' => 180,
  '_STAR_LIST' => 181,
  '_STAR_LIST' => 182,
  'Variable_183' => 183,
  'VariableRetrieval_184' => 184,
  'VariableRetrieval_185' => 185,
  'VariableRetrieval_186' => 186,
  'VariableDeclaration_187' => 187,
  'VariableDeclaration_188' => 188,
  'VariableModification_189' => 189,
  'VariableModification_190' => 190,
  '_PAREN' => 191,
  '_STAR_LIST' => 192,
  '_STAR_LIST' => 193,
  '_PLUS_LIST' => 194,
  '_PLUS_LIST' => 195,
  'ListElements_196' => 196,
  'ListElements_197' => 197,
  'ListElement_198' => 198,
  'ListElement_199' => 199,
  'ListElement_200' => 200,
  '_OPTIONAL' => 201,
  '_OPTIONAL' => 202,
  'ArrayReference_203' => 203,
  'ArrayDereferenced_204' => 204,
  'ArrayDereferenced_205' => 205,
  '_OPTIONAL' => 206,
  '_OPTIONAL' => 207,
  'HashEntry_208' => 208,
  'HashEntry_209' => 209,
  'HashEntryTyped_210' => 210,
  'HashEntryTyped_211' => 211,
  '_PAREN' => 212,
  '_STAR_LIST' => 213,
  '_STAR_LIST' => 214,
  'HashReference_215' => 215,
  'HashDereferenced_216' => 216,
  'HashDereferenced_217' => 217,
  'WordScoped_218' => 218,
  'WordScoped_219' => 219,
  'FileHandle_220' => 220,
  'FileHandle_221' => 221,
  'TypeInner_222' => 222,
  'Type_223' => 223,
  'LoopLabel_224' => 224,
  'Literal_225' => 225,
  'Literal_226' => 226,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'#!/usr/bin/perl' => { ISSEMANTIC => 0 },
	'## no critic qw(' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'( my' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	'..' => { ISSEMANTIC => 0 },
	'/' => { ISSEMANTIC => 0 },
	'1;' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'<STDIN>' => { ISSEMANTIC => 0 },
	'= sub {' => { ISSEMANTIC => 0 },
	'@_;' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	'[' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'else' => { ISSEMANTIC => 0 },
	'elsif (' => { ISSEMANTIC => 0 },
	'filehandle_ref' => { ISSEMANTIC => 0 },
	'for my integer' => { ISSEMANTIC => 0 },
	'foreach my' => { ISSEMANTIC => 0 },
	'if (' => { ISSEMANTIC => 0 },
	'my' => { ISSEMANTIC => 0 },
	'our %properties = (' => { ISSEMANTIC => 0 },
	'our' => { ISSEMANTIC => 0 },
	'package' => { ISSEMANTIC => 0 },
	'qw(' => { ISSEMANTIC => 0 },
	'undef' => { ISSEMANTIC => 0 },
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
	CHECK_OR_CHECKTRACE => { ISSEMANTIC => 1 },
	COLON => { ISSEMANTIC => 1 },
	KEYS_OR_VALUES => { ISSEMANTIC => 1 },
	LITERAL_NUMBER => { ISSEMANTIC => 1 },
	LITERAL_STRING => { ISSEMANTIC => 1 },
	OP01_NAMED => { ISSEMANTIC => 1 },
	OP01_NAMED_QW => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID_PAREN => { ISSEMANTIC => 1 },
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
	OP10_NAMED_UNARY_STRINGIFY => { ISSEMANTIC => 1 },
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
	OP19_VARIABLE_ASSIGN_BY => { ISSEMANTIC => 1 },
	OP20_HASH_FATARROW => { ISSEMANTIC => 1 },
	OP21_LIST_COMMA => { ISSEMANTIC => 1 },
	OP22_LOGICAL_NOT => { ISSEMANTIC => 1 },
	OP23_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP24_LOGICAL_OR_XOR => { ISSEMANTIC => 1 },
	TYPE_CLASS_OR_SELF => { ISSEMANTIC => 1 },
	VARIABLE_SYMBOL => { ISSEMANTIC => 1 },
	VERSION_NUMBER_ASSIGN => { ISSEMANTIC => 1 },
	WORD => { ISSEMANTIC => 1 },
	WORD_SCOPED => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'lib/RPerl/Grammar.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			"#!/usr/bin/perl" => 5,
			"package" => 3
		},
		GOTOS => {
			'Class' => 8,
			'CompileUnit' => 4,
			'Package' => 7,
			'PLUS-1' => 1,
			'Program' => 6,
			'Module' => 2
		}
	},
	{#State 1
		ACTIONS => {
			'' => -4,
			"package" => 3
		},
		GOTOS => {
			'Class' => 8,
			'Package' => 7,
			'Module' => 9
		}
	},
	{#State 2
		DEFAULT => -2
	},
	{#State 3
		ACTIONS => {
			'WORD_SCOPED' => 11,
			'WORD' => 10
		},
		GOTOS => {
			'WordScoped' => 12
		}
	},
	{#State 4
		ACTIONS => {
			'' => 13
		}
	},
	{#State 5
		ACTIONS => {
			"use strict;" => 14
		},
		GOTOS => {
			'Header' => 15
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		DEFAULT => -16
	},
	{#State 8
		DEFAULT => -17
	},
	{#State 9
		DEFAULT => -1
	},
	{#State 10
		DEFAULT => -218
	},
	{#State 11
		DEFAULT => -219
	},
	{#State 12
		ACTIONS => {
			";" => 16
		}
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		ACTIONS => {
			"use warnings;" => 17
		}
	},
	{#State 15
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 18
		}
	},
	{#State 16
		ACTIONS => {
			"use strict;" => 14
		},
		GOTOS => {
			'Header' => 19
		}
	},
	{#State 17
		ACTIONS => {
			"use RPerl;" => 20
		}
	},
	{#State 18
		ACTIONS => {
			"\@{" => -8,
			"%{" => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			"my" => -8,
			"if (" => -8,
			"[" => -8,
			"use constant" => -8,
			'WORD_SCOPED' => -8,
			'OP22_LOGICAL_NOT' => -8,
			'OP01_NAMED_VOID' => -8,
			'OP01_NAMED' => -8,
			"for my integer" => -8,
			'LITERAL_STRING' => -8,
			'OP03_MATH_INC_DEC' => -8,
			"(" => -8,
			"use" => -8,
			'VARIABLE_SYMBOL' => -8,
			"{" => -8,
			'OP19_LOOP_CONTROL' => -8,
			'LITERAL_NUMBER' => -8,
			'OP05_LOGICAL_NEG' => -8,
			"undef" => -8,
			"our" => -8,
			'WORD' => -8,
			"## no critic qw(" => 23,
			'OP05_MATH_NEG' => -8,
			"while (" => -8,
			"foreach my" => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			'OP10_NAMED_UNARY' => -8
		},
		GOTOS => {
			'STAR-3' => 21,
			'Critic' => 22
		}
	},
	{#State 19
		ACTIONS => {
			"use constant" => -19,
			"our" => -19,
			"## no critic qw(" => -19,
			"use" => -19,
			"use parent qw(" => 24
		},
		GOTOS => {
			'STAR-7' => 25
		}
	},
	{#State 20
		ACTIONS => {
			"our" => 26
		}
	},
	{#State 21
		ACTIONS => {
			'OP10_NAMED_UNARY' => -10,
			'OP05_MATH_NEG' => -10,
			"while (" => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"foreach my" => -10,
			'LITERAL_NUMBER' => -10,
			'OP05_LOGICAL_NEG' => -10,
			"undef" => -10,
			'WORD' => -10,
			"our" => -10,
			'VARIABLE_SYMBOL' => -10,
			"{" => -10,
			'OP19_LOOP_CONTROL' => -10,
			"(" => -10,
			'OP03_MATH_INC_DEC' => -10,
			'LITERAL_STRING' => -10,
			"use" => 29,
			"use constant" => -10,
			"if (" => -10,
			"[" => -10,
			'OP22_LOGICAL_NOT' => -10,
			'WORD_SCOPED' => -10,
			'OP01_NAMED_VOID' => -10,
			'OP01_NAMED' => -10,
			"for my integer" => -10,
			"\@{" => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			"%{" => -10,
			"my" => -10
		},
		GOTOS => {
			'Include' => 27,
			'STAR-4' => 28
		}
	},
	{#State 22
		DEFAULT => -5
	},
	{#State 23
		ACTIONS => {
			'WORD' => 30
		},
		GOTOS => {
			'PLUS-11' => 31
		}
	},
	{#State 24
		ACTIONS => {
			'WORD' => 10,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 25
		ACTIONS => {
			"our" => -21,
			"## no critic qw(" => 23,
			"use" => -21,
			"use constant" => -21
		},
		GOTOS => {
			'Critic' => 33,
			'STAR-8' => 34
		}
	},
	{#State 26
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 35
		}
	},
	{#State 27
		DEFAULT => -7
	},
	{#State 28
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			"%{" => -12,
			"\@{" => -12,
			"my" => -12,
			'OP22_LOGICAL_NOT' => -12,
			'WORD_SCOPED' => -12,
			"if (" => -12,
			"use constant" => 36,
			"[" => -12,
			'OP01_NAMED' => -12,
			"for my integer" => -12,
			'OP01_NAMED_VOID' => -12,
			'LITERAL_STRING' => -12,
			'OP03_MATH_INC_DEC' => -12,
			"(" => -12,
			'VARIABLE_SYMBOL' => -12,
			'OP19_LOOP_CONTROL' => -12,
			"{" => -12,
			'WORD' => -12,
			'OP05_LOGICAL_NEG' => -12,
			"undef" => -12,
			'LITERAL_NUMBER' => -12,
			"our" => -12,
			"while (" => -12,
			'OP05_MATH_NEG' => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			"foreach my" => -12,
			'OP10_NAMED_UNARY' => -12
		},
		GOTOS => {
			'STAR-5' => 38,
			'Constant' => 37
		}
	},
	{#State 29
		ACTIONS => {
			'WORD_SCOPED' => 11,
			'WORD' => 10
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 30
		DEFAULT => -29
	},
	{#State 31
		ACTIONS => {
			'WORD' => 40,
			")" => 41
		}
	},
	{#State 32
		ACTIONS => {
			")" => 42
		}
	},
	{#State 33
		DEFAULT => -18
	},
	{#State 34
		ACTIONS => {
			"use constant" => -23,
			"our" => -23,
			"use" => 29
		},
		GOTOS => {
			'STAR-9' => 44,
			'Include' => 43
		}
	},
	{#State 35
		DEFAULT => -27
	},
	{#State 36
		ACTIONS => {
			'WORD' => 45
		}
	},
	{#State 37
		DEFAULT => -9
	},
	{#State 38
		ACTIONS => {
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"{" => 50,
			'OP19_LOOP_CONTROL' => 48,
			'VARIABLE_SYMBOL' => 53,
			"my" => 54,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			'OP01_NAMED_VOID' => 59,
			"for my integer" => -159,
			'OP01_NAMED' => 58,
			"if (" => 83,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'OP10_NAMED_UNARY' => 66,
			"undef" => 73,
			"our" => 87,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 72,
			'LITERAL_NUMBER' => 71,
			"foreach my" => -159,
			'OP01_NAMED_VOID_PAREN' => 88,
			'OP05_MATH_NEG' => 76,
			"while (" => -159
		},
		GOTOS => {
			'Literal' => 52,
			'VariableDeclaration' => 49,
			'Operation' => 78,
			'OperatorVoid' => 51,
			'Subroutine' => 79,
			'Variable' => 82,
			'ArrayReference' => 56,
			'Conditional' => 55,
			'PLUS-6' => 69,
			'WordScoped' => 68,
			'Expression' => 67,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'OPTIONAL-50' => 64,
			'PAREN-49' => 84,
			'VariableModification' => 63,
			'Statement' => 62,
			'Operator' => 75,
			'LoopLabel' => 86,
			'ArrayDereferenced' => 70
		}
	},
	{#State 39
		ACTIONS => {
			";" => 89,
			"qw(" => 90
		}
	},
	{#State 40
		DEFAULT => -28
	},
	{#State 41
		DEFAULT => -30
	},
	{#State 42
		ACTIONS => {
			";" => 91
		}
	},
	{#State 43
		DEFAULT => -20
	},
	{#State 44
		ACTIONS => {
			"use constant" => 36,
			"our" => 87
		},
		GOTOS => {
			'Subroutine' => 92,
			'Constant' => 94,
			'PLUS-10' => 93
		}
	},
	{#State 45
		ACTIONS => {
			'OP20_HASH_FATARROW' => 95
		}
	},
	{#State 46
		DEFAULT => -225
	},
	{#State 47
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Variable' => 96
		}
	},
	{#State 48
		ACTIONS => {
			'WORD' => 98
		},
		GOTOS => {
			'LoopLabel' => 97
		}
	},
	{#State 49
		DEFAULT => -163
	},
	{#State 50
		ACTIONS => {
			"}" => 100,
			"%{" => 80,
			'WORD' => 102
		},
		GOTOS => {
			'HashEntry' => 101,
			'HashDereferenced' => 99
		}
	},
	{#State 51
		DEFAULT => -162
	},
	{#State 52
		DEFAULT => -144
	},
	{#State 53
		DEFAULT => -182,
		GOTOS => {
			'STAR-56' => 103
		}
	},
	{#State 54
		ACTIONS => {
			'WORD' => 104
		},
		GOTOS => {
			'Type' => 105
		}
	},
	{#State 55
		DEFAULT => -160
	},
	{#State 56
		DEFAULT => -146
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			"[" => 61
		},
		GOTOS => {
			'ArrayReference' => 106,
			'Variable' => 107
		}
	},
	{#State 58
		ACTIONS => {
			"(" => 108
		}
	},
	{#State 59
		ACTIONS => {
			'OP05_MATH_NEG' => 76,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'LITERAL_NUMBER' => 71,
			'OP10_NAMED_UNARY' => 66,
			'OP01_NAMED' => 58,
			'KEYS_OR_VALUES' => 115,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"{*" => 111,
			"my" => 116,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			";" => -131,
			"{" => 50,
			'OP01_NAMED_QW' => 109,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77
		},
		GOTOS => {
			'TypeInner' => 112,
			'ListElements' => 118,
			'Literal' => 52,
			'WordScoped' => 68,
			'HashReference' => 65,
			'Expression' => 117,
			'HashDereferenced' => 85,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'FileHandle' => 113,
			'OPTIONAL-45' => 119,
			'ListElement' => 114,
			'Variable' => 110,
			'Operator' => 75
		}
	},
	{#State 60
		ACTIONS => {
			'LITERAL_STRING' => 46,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			'OP01_NAMED' => 58,
			'OP10_NAMED_UNARY' => 66,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'OP05_MATH_NEG' => 76
		},
		GOTOS => {
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'Operator' => 75,
			'Variable' => 110,
			'WordScoped' => 68,
			'Literal' => 52,
			'HashDereferenced' => 85,
			'Expression' => 120,
			'HashReference' => 65
		}
	},
	{#State 61
		ACTIONS => {
			'OP01_NAMED_QW' => 109,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46,
			"]" => -202,
			'OP01_NAMED' => 58,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61,
			'KEYS_OR_VALUES' => 115,
			"my" => 123,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			'OP10_NAMED_UNARY' => 66,
			'OP05_MATH_NEG' => 76,
			'LITERAL_NUMBER' => 71,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 73,
			'WORD' => 10
		},
		GOTOS => {
			'WordScoped' => 68,
			'Literal' => 52,
			'HashDereferenced' => 85,
			'HashReference' => 65,
			'Expression' => 117,
			'TypeInner' => 112,
			'ListElements' => 121,
			'ListElement' => 114,
			'Variable' => 110,
			'Operator' => 75,
			'ArrayReference' => 56,
			'OPTIONAL-60' => 122,
			'ArrayDereferenced' => 70
		}
	},
	{#State 62
		DEFAULT => -99
	},
	{#State 63
		DEFAULT => -164
	},
	{#State 64
		ACTIONS => {
			"for my integer" => 129,
			"foreach my" => 125,
			"while (" => 128
		},
		GOTOS => {
			'LoopFor' => 124,
			'LoopWhile' => 126,
			'LoopForEach' => 130,
			'Loop' => 127
		}
	},
	{#State 65
		DEFAULT => -148
	},
	{#State 66
		ACTIONS => {
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			'OP01_NAMED' => 58,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'LITERAL_STRING' => 46,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			'WORD' => 10,
			"undef" => 73,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Operator' => 75,
			'Variable' => 110,
			'HashReference' => 65,
			'Expression' => 131,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68
		}
	},
	{#State 67
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 139,
			'OP23_LOGICAL_AND' => 145,
			'OP16_LOGICAL_OR' => 136,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP11_COMPARE_LT_GT' => 138,
			'OP18_TERNARY' => 133,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP04_MATH_POW' => 132,
			";" => 143,
			'OP17_LIST_RANGE' => 147,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			'OP08_STRING_CAT' => 140
		}
	},
	{#State 68
		ACTIONS => {
			"(" => 149
		}
	},
	{#State 69
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			'LITERAL_NUMBER' => 71,
			'WORD' => 72,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 73,
			"while (" => -159,
			'OP05_MATH_NEG' => 76,
			"foreach my" => -159,
			'OP01_NAMED_VOID_PAREN' => 88,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			'VARIABLE_SYMBOL' => 53,
			'OP19_LOOP_CONTROL' => 48,
			"{" => 50,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			'' => -15,
			"my" => 54,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			"if (" => 83,
			'OP01_NAMED' => 58,
			"for my integer" => -159,
			'OP01_NAMED_VOID' => 59
		},
		GOTOS => {
			'VariableDeclaration' => 49,
			'Operation' => 150,
			'OperatorVoid' => 51,
			'Literal' => 52,
			'Conditional' => 55,
			'ArrayReference' => 56,
			'Variable' => 82,
			'PAREN-49' => 84,
			'OPTIONAL-50' => 64,
			'VariableModification' => 63,
			'Statement' => 62,
			'Expression' => 67,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'WordScoped' => 68,
			'ArrayDereferenced' => 70,
			'LoopLabel' => 86,
			'Operator' => 75
		}
	},
	{#State 70
		DEFAULT => -147
	},
	{#State 71
		DEFAULT => -226
	},
	{#State 72
		ACTIONS => {
			"(" => -218,
			'COLON' => -224
		}
	},
	{#State 73
		DEFAULT => -143
	},
	{#State 74
		ACTIONS => {
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_STRING' => 46,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'OP01_NAMED' => 58,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"\@{" => 57,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			'OP10_NAMED_UNARY' => 66,
			'OP05_MATH_NEG' => 76,
			'LITERAL_NUMBER' => 71,
			'WORD' => 10,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74
		},
		GOTOS => {
			'HashDereferenced' => 85,
			'HashReference' => 65,
			'Expression' => 151,
			'WordScoped' => 68,
			'Literal' => 52,
			'Operator' => 75,
			'Variable' => 110,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56
		}
	},
	{#State 75
		DEFAULT => -151
	},
	{#State 76
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			"\@{" => 57,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			'OP01_NAMED' => 58,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 66,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			'WORD' => 10,
			'OP05_MATH_NEG' => 76
		},
		GOTOS => {
			'Operator' => 75,
			'Variable' => 110,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'HashDereferenced' => 85,
			'Expression' => 152,
			'HashReference' => 65,
			'WordScoped' => 68,
			'Literal' => 52
		}
	},
	{#State 77
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			'LITERAL_NUMBER' => 71,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			"undef" => 73,
			'OP05_MATH_NEG' => 76,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			'OP01_NAMED' => 58
		},
		GOTOS => {
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'Operator' => 75,
			'Variable' => 110,
			'Literal' => 52,
			'WordScoped' => 68,
			'HashReference' => 65,
			'Expression' => 153,
			'HashDereferenced' => 85
		}
	},
	{#State 78
		DEFAULT => -14
	},
	{#State 79
		DEFAULT => -11
	},
	{#State 80
		ACTIONS => {
			"{" => 156,
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'HashReference' => 155,
			'Variable' => 154
		}
	},
	{#State 81
		ACTIONS => {
			'OP05_MATH_NEG' => 76,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'OP10_NAMED_UNARY' => 66,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'OP01_NAMED' => 58,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			'LITERAL_STRING' => 46,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47
		},
		GOTOS => {
			'HashDereferenced' => 85,
			'HashReference' => 65,
			'Expression' => 157,
			'WordScoped' => 68,
			'Literal' => 52,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Variable' => 110,
			'Operator' => 75
		}
	},
	{#State 82
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 161,
			'OP17_LIST_RANGE' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP08_STRING_CAT' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 160,
			'OP11_COMPARE_LT_GT' => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			";" => -145,
			'OP04_MATH_POW' => -145,
			'OP19_VARIABLE_ASSIGN' => 159,
			'OP08_MATH_ADD_SUB' => -145,
			'OP18_TERNARY' => -145,
			'OP03_MATH_INC_DEC' => 158,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP15_LOGICAL_AND' => -145
		}
	},
	{#State 83
		ACTIONS => {
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'LITERAL_STRING' => 46,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			"\@{" => 57,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'OP01_NAMED' => 58,
			'OP10_NAMED_UNARY' => 66,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'LITERAL_NUMBER' => 71,
			'OP05_MATH_NEG' => 76
		},
		GOTOS => {
			'Operator' => 75,
			'Variable' => 110,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Expression' => 162,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68
		}
	},
	{#State 84
		DEFAULT => -158
	},
	{#State 85
		DEFAULT => -149
	},
	{#State 86
		ACTIONS => {
			'COLON' => 163
		}
	},
	{#State 87
		ACTIONS => {
			'WORD' => 104
		},
		GOTOS => {
			'Type' => 164
		}
	},
	{#State 88
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			'OP05_MATH_NEG' => 76,
			")" => -127,
			'OP10_NAMED_UNARY' => 66,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			"my" => 116,
			"{*" => 111,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61,
			'KEYS_OR_VALUES' => 115,
			'OP01_NAMED' => 58,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'LITERAL_STRING' => 46,
			'VARIABLE_SYMBOL' => 53,
			'OP01_NAMED_QW' => 109,
			"{" => 50
		},
		GOTOS => {
			'FileHandle' => 166,
			'ListElement' => 114,
			'Operator' => 75,
			'Variable' => 110,
			'ArrayReference' => 56,
			'OPTIONAL-43' => 165,
			'ArrayDereferenced' => 70,
			'Literal' => 52,
			'WordScoped' => 68,
			'Expression' => 117,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'TypeInner' => 112,
			'ListElements' => 167
		}
	},
	{#State 89
		DEFAULT => -33
	},
	{#State 90
		ACTIONS => {
			'WORD' => 168
		},
		GOTOS => {
			'PLUS-12' => 169
		}
	},
	{#State 91
		ACTIONS => {
			"use" => 29
		},
		GOTOS => {
			'Include' => 170
		}
	},
	{#State 92
		DEFAULT => -25
	},
	{#State 93
		ACTIONS => {
			"1;" => 172,
			"our" => 87
		},
		GOTOS => {
			'Subroutine' => 171
		}
	},
	{#State 94
		DEFAULT => -22
	},
	{#State 95
		ACTIONS => {
			"my" => 123
		},
		GOTOS => {
			'TypeInner' => 173
		}
	},
	{#State 96
		DEFAULT => -103
	},
	{#State 97
		ACTIONS => {
			";" => 174
		}
	},
	{#State 98
		DEFAULT => -224
	},
	{#State 99
		DEFAULT => -209
	},
	{#State 100
		DEFAULT => -150
	},
	{#State 101
		DEFAULT => -214,
		GOTOS => {
			'STAR-63' => 175
		}
	},
	{#State 102
		ACTIONS => {
			'OP20_HASH_FATARROW' => 176
		}
	},
	{#State 103
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -183,
			'OP24_LOGICAL_OR_XOR' => -183,
			'COLON' => -183,
			'OP19_VARIABLE_ASSIGN_BY' => -183,
			"]" => -183,
			'OP16_LOGICAL_OR' => -183,
			'OP23_LOGICAL_AND' => -183,
			'OP14_BITWISE_OR_XOR' => -183,
			'OP19_VARIABLE_ASSIGN' => -183,
			'OP02_ARRAY_THINARROW' => 178,
			'OP02_HASH_THINARROW' => 177,
			'OP04_MATH_POW' => -183,
			";" => -183,
			'OP15_LOGICAL_AND' => -183,
			'OP07_MATH_MULT_DIV_MOD' => -183,
			'OP03_MATH_INC_DEC' => -183,
			'OP18_TERNARY' => -183,
			'OP21_LIST_COMMA' => -183,
			'OP08_MATH_ADD_SUB' => -183,
			'OP02_METHOD_THINARROW' => -183,
			'OP13_BITWISE_AND' => -183,
			'OP12_COMPARE_EQ_NEQ' => -183,
			'OP17_LIST_RANGE' => -183,
			".." => -183,
			'OP08_STRING_CAT' => -183,
			"}" => -183,
			'OP09_BITWISE_SHIFT' => -183,
			'OP06_REGEX_MATCH' => -183,
			")" => -183
		},
		GOTOS => {
			'VariableRetrieval' => 179
		}
	},
	{#State 104
		DEFAULT => -223
	},
	{#State 105
		ACTIONS => {
			'VARIABLE_SYMBOL' => 180
		}
	},
	{#State 106
		ACTIONS => {
			"}" => 181
		}
	},
	{#State 107
		ACTIONS => {
			"}" => 182
		}
	},
	{#State 108
		ACTIONS => {
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'LITERAL_STRING' => 46,
			"{" => 50,
			'OP01_NAMED_QW' => 109,
			'VARIABLE_SYMBOL' => 53,
			"my" => 123,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			'OP01_NAMED' => 58,
			'KEYS_OR_VALUES' => 115,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			")" => -101,
			'OP10_NAMED_UNARY' => 66,
			'LITERAL_NUMBER' => 71,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			"undef" => 73,
			'OP05_MATH_NEG' => 76
		},
		GOTOS => {
			'TypeInner' => 112,
			'ListElements' => 184,
			'Expression' => 117,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'OPTIONAL-42' => 183,
			'Variable' => 110,
			'Operator' => 75,
			'ListElement' => 114
		}
	},
	{#State 109
		ACTIONS => {
			"(" => 185
		}
	},
	{#State 110
		ACTIONS => {
			".." => -145,
			'OP08_STRING_CAT' => -145,
			"}" => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP06_REGEX_MATCH' => -145,
			")" => -145,
			'OP02_METHOD_THINARROW' => 161,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP04_MATH_POW' => -145,
			";" => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP03_MATH_INC_DEC' => 158,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP18_TERNARY' => -145,
			'OP21_LIST_COMMA' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			"]" => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP14_BITWISE_OR_XOR' => -145
		}
	},
	{#State 111
		ACTIONS => {
			'WORD' => 186
		}
	},
	{#State 112
		ACTIONS => {
			"undef" => 73,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 57,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'OP01_NAMED' => 58,
			'LITERAL_STRING' => 46,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50
		},
		GOTOS => {
			'Expression' => 187,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Variable' => 110,
			'Operator' => 75
		}
	},
	{#State 113
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 73,
			'WORD' => 10,
			'LITERAL_NUMBER' => 71,
			'OP05_MATH_NEG' => 76,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			";" => -133,
			"{" => 50,
			'OP01_NAMED_QW' => 109,
			'VARIABLE_SYMBOL' => 53,
			"my" => 123,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			'OP01_NAMED' => 58,
			'KEYS_OR_VALUES' => 115,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60
		},
		GOTOS => {
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'ListElement' => 114,
			'OPTIONAL-46' => 188,
			'Variable' => 110,
			'Operator' => 75,
			'TypeInner' => 112,
			'ListElements' => 189,
			'WordScoped' => 68,
			'Literal' => 52,
			'HashDereferenced' => 85,
			'Expression' => 117,
			'HashReference' => 65
		}
	},
	{#State 114
		DEFAULT => -193,
		GOTOS => {
			'STAR-58' => 190
		}
	},
	{#State 115
		ACTIONS => {
			"%{" => 80
		},
		GOTOS => {
			'HashDereferenced' => 191
		}
	},
	{#State 116
		ACTIONS => {
			'WORD' => 104,
			"filehandle_ref" => 193
		},
		GOTOS => {
			'Type' => 192
		}
	},
	{#State 117
		ACTIONS => {
			")" => -198,
			'OP06_REGEX_MATCH' => 141,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_STRING_CAT' => 140,
			'OP17_LIST_RANGE' => 147,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP08_MATH_ADD_SUB' => 144,
			'OP21_LIST_COMMA' => -198,
			'OP18_TERNARY' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134,
			";" => -198,
			'OP04_MATH_POW' => 132,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => 145,
			"]" => -198,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137
		}
	},
	{#State 118
		DEFAULT => -130
	},
	{#State 119
		ACTIONS => {
			";" => 194
		}
	},
	{#State 120
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => -123,
			"]" => -123,
			'OP14_BITWISE_OR_XOR' => 139,
			";" => -123,
			'OP04_MATH_POW' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134,
			'OP08_MATH_ADD_SUB' => 144,
			'OP18_TERNARY' => 133,
			'OP21_LIST_COMMA' => -123,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148,
			'OP17_LIST_RANGE' => 147,
			".." => -123,
			'OP08_STRING_CAT' => 140,
			'OP06_REGEX_MATCH' => 141,
			"}" => -123,
			'OP09_BITWISE_SHIFT' => 146,
			")" => -123
		}
	},
	{#State 121
		DEFAULT => -201
	},
	{#State 122
		ACTIONS => {
			"]" => 195
		}
	},
	{#State 123
		ACTIONS => {
			'WORD' => 104
		},
		GOTOS => {
			'Type' => 192
		}
	},
	{#State 124
		DEFAULT => -172
	},
	{#State 125
		ACTIONS => {
			'WORD' => 104
		},
		GOTOS => {
			'Type' => 196
		}
	},
	{#State 126
		DEFAULT => -174
	},
	{#State 127
		DEFAULT => -161
	},
	{#State 128
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			'OP01_NAMED' => 58,
			'OP10_NAMED_UNARY' => 66,
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'OP05_MATH_NEG' => 76
		},
		GOTOS => {
			'WordScoped' => 68,
			'Literal' => 52,
			'HashDereferenced' => 85,
			'HashReference' => 65,
			'Expression' => 197,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'Variable' => 110,
			'Operator' => 75
		}
	},
	{#State 129
		ACTIONS => {
			'VARIABLE_SYMBOL' => 198
		}
	},
	{#State 130
		DEFAULT => -173
	},
	{#State 131
		ACTIONS => {
			")" => -113,
			"}" => -113,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			'OP08_STRING_CAT' => 140,
			".." => -113,
			'OP17_LIST_RANGE' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP12_COMPARE_EQ_NEQ' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP18_TERNARY' => -113,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP04_MATH_POW' => 132,
			";" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			"]" => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP24_LOGICAL_OR_XOR' => -113
		}
	},
	{#State 132
		ACTIONS => {
			'OP05_MATH_NEG' => 76,
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'OP10_NAMED_UNARY' => 66,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			'OP01_NAMED' => 58,
			"\@{" => 57,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46
		},
		GOTOS => {
			'WordScoped' => 68,
			'Literal' => 52,
			'HashDereferenced' => 85,
			'Expression' => 199,
			'HashReference' => 65,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'Variable' => 110,
			'Operator' => 75
		}
	},
	{#State 133
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Variable' => 200
		}
	},
	{#State 134
		ACTIONS => {
			'OP05_MATH_NEG' => 76,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'WORD' => 10,
			'OP10_NAMED_UNARY' => 66,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			'OP01_NAMED' => 58,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'LITERAL_STRING' => 46
		},
		GOTOS => {
			'Operator' => 75,
			'Variable' => 110,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'HashDereferenced' => 85,
			'HashReference' => 65,
			'Expression' => 201,
			'WordScoped' => 68,
			'Literal' => 52
		}
	},
	{#State 135
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'OP05_MATH_NEG' => 76,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'LITERAL_STRING' => 46,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			'OP01_NAMED' => 58
		},
		GOTOS => {
			'Literal' => 52,
			'WordScoped' => 68,
			'HashReference' => 65,
			'Expression' => 202,
			'HashDereferenced' => 85,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'Operator' => 75,
			'Variable' => 110
		}
	},
	{#State 136
		ACTIONS => {
			'OP05_MATH_NEG' => 76,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'OP10_NAMED_UNARY' => 66,
			'OP01_NAMED' => 58,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46
		},
		GOTOS => {
			'HashDereferenced' => 85,
			'HashReference' => 65,
			'Expression' => 203,
			'WordScoped' => 68,
			'Literal' => 52,
			'Operator' => 75,
			'Variable' => 110,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56
		}
	},
	{#State 137
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			'LITERAL_STRING' => 46,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61,
			'OP01_NAMED' => 58,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			'OP10_NAMED_UNARY' => 66,
			'OP05_MATH_NEG' => 76,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'LITERAL_NUMBER' => 71,
			"undef" => 73
		},
		GOTOS => {
			'Operator' => 75,
			'Variable' => 110,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'HashReference' => 65,
			'Expression' => 204,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68
		}
	},
	{#State 138
		ACTIONS => {
			'OP01_NAMED' => 58,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"\@{" => 57,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP05_MATH_NEG' => 76,
			'WORD' => 10,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'HashReference' => 65,
			'Expression' => 205,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Operator' => 75,
			'Variable' => 110
		}
	},
	{#State 139
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			'WORD' => 10,
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'OP05_MATH_NEG' => 76,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"\@{" => 57,
			'OP01_NAMED' => 58,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61
		},
		GOTOS => {
			'Expression' => 206,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Operator' => 75,
			'Variable' => 110
		}
	},
	{#State 140
		ACTIONS => {
			'LITERAL_NUMBER' => 71,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 73,
			'WORD' => 10,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			'OP01_NAMED' => 58,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50
		},
		GOTOS => {
			'Literal' => 52,
			'WordScoped' => 68,
			'Expression' => 207,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Variable' => 110,
			'Operator' => 75,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70
		}
	},
	{#State 141
		ACTIONS => {
			"/" => 208
		}
	},
	{#State 142
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			'OP05_MATH_NEG' => 76,
			'WORD' => 10,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP01_NAMED' => 58,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57
		},
		GOTOS => {
			'HashDereferenced' => 85,
			'Expression' => 209,
			'HashReference' => 65,
			'WordScoped' => 68,
			'Literal' => 52,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Variable' => 110,
			'Operator' => 75
		}
	},
	{#State 143
		DEFAULT => -98
	},
	{#State 144
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			'LITERAL_STRING' => 46,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'OP01_NAMED' => 58,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			'OP10_NAMED_UNARY' => 66,
			'OP05_MATH_NEG' => 76,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'LITERAL_NUMBER' => 71
		},
		GOTOS => {
			'Expression' => 210,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'Operator' => 75,
			'Variable' => 110,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56
		}
	},
	{#State 145
		ACTIONS => {
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'LITERAL_STRING' => 46,
			'OP01_NAMED' => 58,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			'OP10_NAMED_UNARY' => 66,
			'OP05_MATH_NEG' => 76,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 74
		},
		GOTOS => {
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Variable' => 110,
			'Operator' => 75,
			'HashReference' => 65,
			'Expression' => 211,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68
		}
	},
	{#State 146
		ACTIONS => {
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 47,
			'LITERAL_STRING' => 46,
			"(" => 77,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'LITERAL_NUMBER' => 71,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'Literal' => 52,
			'WordScoped' => 68,
			'HashReference' => 65,
			'Expression' => 212,
			'HashDereferenced' => 85,
			'Operator' => 75,
			'Variable' => 110,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70
		}
	},
	{#State 147
		ACTIONS => {
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			'OP01_NAMED' => 58,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			'OP10_NAMED_UNARY' => 66,
			'OP05_MATH_NEG' => 76,
			'LITERAL_NUMBER' => 71,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			"undef" => 73
		},
		GOTOS => {
			'Operator' => 75,
			'Variable' => 110,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'Literal' => 52,
			'WordScoped' => 68,
			'Expression' => 213,
			'HashReference' => 65,
			'HashDereferenced' => 85
		}
	},
	{#State 148
		ACTIONS => {
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			'OP01_NAMED' => 58,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 71,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			"undef" => 73,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'HashDereferenced' => 85,
			'Expression' => 214,
			'HashReference' => 65,
			'WordScoped' => 68,
			'Literal' => 52,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Variable' => 110,
			'Operator' => 75
		}
	},
	{#State 149
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			")" => -140,
			'OP05_MATH_NEG' => 76,
			"undef" => 73,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			'VARIABLE_SYMBOL' => 53,
			'OP01_NAMED_QW' => 109,
			"{" => 50,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			'KEYS_OR_VALUES' => 115,
			'OP01_NAMED' => 58,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			"my" => 123
		},
		GOTOS => {
			'Operator' => 75,
			'Variable' => 110,
			'ListElement' => 114,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'HashReference' => 65,
			'Expression' => 117,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'ListElements' => 216,
			'TypeInner' => 112,
			'OPTIONAL-47' => 215
		}
	},
	{#State 150
		DEFAULT => -13
	},
	{#State 151
		ACTIONS => {
			'OP17_LIST_RANGE' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP13_BITWISE_AND' => -106,
			")" => -106,
			'OP09_BITWISE_SHIFT' => -106,
			"}" => -106,
			'OP06_REGEX_MATCH' => -106,
			'OP08_STRING_CAT' => -106,
			".." => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			"]" => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP18_TERNARY' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP04_MATH_POW' => 132,
			";" => -106
		}
	},
	{#State 152
		ACTIONS => {
			'OP17_LIST_RANGE' => 147,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148,
			")" => 217,
			'OP06_REGEX_MATCH' => 141,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_STRING_CAT' => 140,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP23_LOGICAL_AND' => 145,
			'OP16_LOGICAL_OR' => 136,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP08_MATH_ADD_SUB' => 144,
			'OP18_TERNARY' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134,
			'OP04_MATH_POW' => 132
		}
	},
	{#State 153
		ACTIONS => {
			'OP23_LOGICAL_AND' => 145,
			'OP16_LOGICAL_OR' => 136,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP11_COMPARE_LT_GT' => 138,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP04_MATH_POW' => 132,
			'OP18_TERNARY' => 133,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP17_LIST_RANGE' => 147,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148,
			'OP08_STRING_CAT' => 140,
			")" => 218,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141
		}
	},
	{#State 154
		ACTIONS => {
			"}" => 219
		}
	},
	{#State 155
		ACTIONS => {
			"}" => 220
		}
	},
	{#State 156
		ACTIONS => {
			"%{" => 80,
			'WORD' => 102
		},
		GOTOS => {
			'HashDereferenced' => 99,
			'HashEntry' => 101
		}
	},
	{#State 157
		ACTIONS => {
			'OP15_LOGICAL_AND' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP18_TERNARY' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP08_MATH_ADD_SUB' => 144,
			'OP04_MATH_POW' => 132,
			";" => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			"]" => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP23_LOGICAL_AND' => -114,
			"}" => -114,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			")" => -114,
			".." => -114,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NEQ' => -114,
			'OP13_BITWISE_AND' => -114,
			'OP17_LIST_RANGE' => -114
		}
	},
	{#State 158
		DEFAULT => -104
	},
	{#State 159
		ACTIONS => {
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			'OP01_NAMED' => 58,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'OP05_MATH_NEG' => 76,
			"<STDIN>" => 222,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'Expression' => 223,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'Variable' => 110,
			'Operator' => 75,
			'ExpressionOrStdin' => 221,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56
		}
	},
	{#State 160
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			'OP05_MATH_NEG' => 76,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_STRING' => 46,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'OP01_NAMED' => 58,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57
		},
		GOTOS => {
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Variable' => 110,
			'Operator' => 75,
			'Expression' => 224,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68
		}
	},
	{#State 161
		ACTIONS => {
			'WORD' => 225
		}
	},
	{#State 162
		ACTIONS => {
			'OP04_MATH_POW' => 132,
			'OP18_TERNARY' => 133,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP23_LOGICAL_AND' => 145,
			'OP16_LOGICAL_OR' => 136,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP08_STRING_CAT' => 140,
			")" => 226,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			'OP17_LIST_RANGE' => 147,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148
		}
	},
	{#State 163
		DEFAULT => -157
	},
	{#State 164
		ACTIONS => {
			'VARIABLE_SYMBOL' => 227
		}
	},
	{#State 165
		ACTIONS => {
			")" => 228
		}
	},
	{#State 166
		ACTIONS => {
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'OP01_NAMED_QW' => 109,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			"my" => 123,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			'OP01_NAMED' => 58,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			'KEYS_OR_VALUES' => 115,
			")" => -129,
			'OP10_NAMED_UNARY' => 66,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'OP05_MATH_NEG' => 76
		},
		GOTOS => {
			'ListElement' => 114,
			'Variable' => 110,
			'Operator' => 75,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'Literal' => 52,
			'WordScoped' => 68,
			'Expression' => 117,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'ListElements' => 230,
			'OPTIONAL-44' => 229,
			'TypeInner' => 112
		}
	},
	{#State 167
		DEFAULT => -126
	},
	{#State 168
		DEFAULT => -32
	},
	{#State 169
		ACTIONS => {
			'WORD' => 231,
			")" => 232
		}
	},
	{#State 170
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 233
		}
	},
	{#State 171
		DEFAULT => -24
	},
	{#State 172
		ACTIONS => {
			"1;" => 234
		}
	},
	{#State 173
		ACTIONS => {
			'LITERAL_NUMBER' => 71,
			'LITERAL_STRING' => 46,
			"{" => 235,
			"[" => 237
		},
		GOTOS => {
			'ConstantValue' => 238,
			'Literal' => 236
		}
	},
	{#State 174
		DEFAULT => -138
	},
	{#State 175
		ACTIONS => {
			'OP21_LIST_COMMA' => 239,
			"}" => 241
		},
		GOTOS => {
			'PAREN-62' => 240
		}
	},
	{#State 176
		ACTIONS => {
			'OP05_MATH_NEG' => -207,
			"undef" => -207,
			'OP05_LOGICAL_NEG' => -207,
			'LITERAL_NUMBER' => -207,
			'WORD' => -207,
			'OP10_NAMED_UNARY' => -207,
			'OP22_LOGICAL_NOT' => -207,
			'WORD_SCOPED' => -207,
			"[" => -207,
			'OP01_NAMED' => -207,
			'OP10_NAMED_UNARY_STRINGIFY' => -207,
			"%{" => -207,
			"\@{" => -207,
			"my" => 123,
			'VARIABLE_SYMBOL' => -207,
			"{" => -207,
			"(" => -207,
			'LITERAL_STRING' => -207,
			'OP03_MATH_INC_DEC' => -207
		},
		GOTOS => {
			'OPTIONAL-61' => 243,
			'TypeInner' => 242
		}
	},
	{#State 177
		ACTIONS => {
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP01_NAMED' => 58,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"\@{" => 57,
			'OP10_NAMED_UNARY' => 66,
			'OP05_MATH_NEG' => 76,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 244
		},
		GOTOS => {
			'WordScoped' => 68,
			'Literal' => 52,
			'HashDereferenced' => 85,
			'Expression' => 245,
			'HashReference' => 65,
			'Operator' => 75,
			'Variable' => 110,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70
		}
	},
	{#State 178
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			'WORD' => 10,
			"undef" => 73,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			'OP01_NAMED' => 58,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'HashDereferenced' => 85,
			'Expression' => 246,
			'HashReference' => 65,
			'WordScoped' => 68,
			'Literal' => 52,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Variable' => 110,
			'Operator' => 75
		}
	},
	{#State 179
		DEFAULT => -181
	},
	{#State 180
		ACTIONS => {
			";" => 248,
			'OP19_VARIABLE_ASSIGN' => 247
		}
	},
	{#State 181
		DEFAULT => -205
	},
	{#State 182
		DEFAULT => -204
	},
	{#State 183
		ACTIONS => {
			")" => 249
		}
	},
	{#State 184
		DEFAULT => -100
	},
	{#State 185
		ACTIONS => {
			'WORD' => 251
		},
		GOTOS => {
			'PLUS-59' => 250
		}
	},
	{#State 186
		ACTIONS => {
			"}" => 252
		}
	},
	{#State 187
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134,
			'OP08_MATH_ADD_SUB' => 144,
			'OP18_TERNARY' => 133,
			'OP21_LIST_COMMA' => -199,
			";" => -199,
			'OP04_MATH_POW' => 132,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP23_LOGICAL_AND' => 145,
			'OP16_LOGICAL_OR' => 136,
			"]" => -199,
			'OP06_REGEX_MATCH' => 141,
			'OP09_BITWISE_SHIFT' => 146,
			")" => -199,
			'OP08_STRING_CAT' => 140,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP17_LIST_RANGE' => 147
		}
	},
	{#State 188
		ACTIONS => {
			";" => 253
		}
	},
	{#State 189
		DEFAULT => -132
	},
	{#State 190
		ACTIONS => {
			")" => -196,
			'OP21_LIST_COMMA' => 255,
			";" => -196,
			"]" => -196
		},
		GOTOS => {
			'PAREN-57' => 254
		}
	},
	{#State 191
		DEFAULT => -200
	},
	{#State 192
		ACTIONS => {
			"\$TYPED_" => 256
		}
	},
	{#State 193
		ACTIONS => {
			'VARIABLE_SYMBOL' => 257
		}
	},
	{#State 194
		DEFAULT => -136
	},
	{#State 195
		DEFAULT => -203
	},
	{#State 196
		ACTIONS => {
			'VARIABLE_SYMBOL' => 258
		}
	},
	{#State 197
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 144,
			'OP18_TERNARY' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134,
			'OP04_MATH_POW' => 132,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP23_LOGICAL_AND' => 145,
			'OP16_LOGICAL_OR' => 136,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP11_COMPARE_LT_GT' => 138,
			")" => 259,
			'OP06_REGEX_MATCH' => 141,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_STRING_CAT' => 140,
			'OP17_LIST_RANGE' => 147,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142
		}
	},
	{#State 198
		ACTIONS => {
			"(" => 260
		}
	},
	{#State 199
		ACTIONS => {
			'OP21_LIST_COMMA' => -105,
			'OP18_TERNARY' => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP04_MATH_POW' => 132,
			";" => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			"]" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			")" => -105,
			'OP09_BITWISE_SHIFT' => -105,
			"}" => -105,
			'OP06_REGEX_MATCH' => -105,
			'OP08_STRING_CAT' => -105,
			".." => -105,
			'OP17_LIST_RANGE' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105
		}
	},
	{#State 200
		ACTIONS => {
			'COLON' => 261
		}
	},
	{#State 201
		ACTIONS => {
			'OP17_LIST_RANGE' => -119,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148,
			")" => -119,
			"}" => -119,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			'OP08_STRING_CAT' => 140,
			".." => -119,
			'OP14_BITWISE_OR_XOR' => 139,
			"]" => -119,
			'OP16_LOGICAL_OR' => -119,
			'OP23_LOGICAL_AND' => -119,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP18_TERNARY' => -119,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP04_MATH_POW' => 132,
			";" => -119
		}
	},
	{#State 202
		ACTIONS => {
			'OP21_LIST_COMMA' => -109,
			'OP18_TERNARY' => -109,
			'OP08_MATH_ADD_SUB' => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP04_MATH_POW' => 132,
			";" => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			"]" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			")" => -109,
			'OP09_BITWISE_SHIFT' => -109,
			"}" => -109,
			'OP06_REGEX_MATCH' => 141,
			'OP08_STRING_CAT' => -109,
			".." => -109,
			'OP17_LIST_RANGE' => -109,
			'OP13_BITWISE_AND' => -109,
			'OP12_COMPARE_EQ_NEQ' => -109
		}
	},
	{#State 203
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 139,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP11_COMPARE_LT_GT' => 138,
			'OP23_LOGICAL_AND' => -120,
			'OP16_LOGICAL_OR' => -120,
			"]" => -120,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134,
			'OP08_MATH_ADD_SUB' => 144,
			'OP18_TERNARY' => -120,
			'OP21_LIST_COMMA' => -120,
			";" => -120,
			'OP04_MATH_POW' => 132,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148,
			'OP17_LIST_RANGE' => -120,
			'OP06_REGEX_MATCH' => 141,
			"}" => -120,
			'OP09_BITWISE_SHIFT' => 146,
			")" => -120,
			".." => -120,
			'OP08_STRING_CAT' => 140
		}
	},
	{#State 204
		ACTIONS => {
			"]" => -125,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP04_MATH_POW' => 132,
			";" => -125,
			'OP21_LIST_COMMA' => -125,
			'OP18_TERNARY' => 133,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP17_LIST_RANGE' => 147,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148,
			'OP08_STRING_CAT' => 140,
			".." => -125,
			")" => -125,
			'OP09_BITWISE_SHIFT' => 146,
			"}" => -125,
			'OP06_REGEX_MATCH' => 141
		}
	},
	{#State 205
		ACTIONS => {
			")" => -115,
			'OP09_BITWISE_SHIFT' => 146,
			"}" => -115,
			'OP06_REGEX_MATCH' => 141,
			'OP08_STRING_CAT' => 140,
			".." => -115,
			'OP17_LIST_RANGE' => -115,
			'OP13_BITWISE_AND' => -115,
			'OP12_COMPARE_EQ_NEQ' => -115,
			'OP21_LIST_COMMA' => -115,
			'OP18_TERNARY' => -115,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP04_MATH_POW' => 132,
			";" => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			"]" => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP11_COMPARE_LT_GT' => undef,
			'OP24_LOGICAL_OR_XOR' => -115
		}
	},
	{#State 206
		ACTIONS => {
			'OP21_LIST_COMMA' => -118,
			'OP18_TERNARY' => -118,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP04_MATH_POW' => 132,
			";" => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			"]" => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP11_COMPARE_LT_GT' => 138,
			")" => -118,
			"}" => -118,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			'OP08_STRING_CAT' => 140,
			".." => -118,
			'OP17_LIST_RANGE' => -118,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142
		}
	},
	{#State 207
		ACTIONS => {
			'OP17_LIST_RANGE' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP13_BITWISE_AND' => -111,
			")" => -111,
			'OP06_REGEX_MATCH' => 141,
			"}" => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP08_STRING_CAT' => -111,
			".." => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP23_LOGICAL_AND' => -111,
			"]" => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP08_MATH_ADD_SUB' => 144,
			'OP21_LIST_COMMA' => -111,
			'OP18_TERNARY' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => -111,
			";" => -111,
			'OP04_MATH_POW' => 132
		}
	},
	{#State 208
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 262
		}
	},
	{#State 209
		ACTIONS => {
			'OP13_BITWISE_AND' => -116,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP17_LIST_RANGE' => -116,
			".." => -116,
			'OP08_STRING_CAT' => 140,
			'OP06_REGEX_MATCH' => 141,
			'OP09_BITWISE_SHIFT' => 146,
			"}" => -116,
			")" => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP11_COMPARE_LT_GT' => 138,
			'OP23_LOGICAL_AND' => -116,
			'OP16_LOGICAL_OR' => -116,
			"]" => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			";" => -116,
			'OP04_MATH_POW' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => -116,
			'OP08_MATH_ADD_SUB' => 144,
			'OP18_TERNARY' => -116,
			'OP21_LIST_COMMA' => -116
		}
	},
	{#State 210
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -110,
			"]" => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP18_TERNARY' => -110,
			'OP08_MATH_ADD_SUB' => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP04_MATH_POW' => 132,
			";" => -110,
			'OP17_LIST_RANGE' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP13_BITWISE_AND' => -110,
			")" => -110,
			"}" => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP06_REGEX_MATCH' => 141,
			'OP08_STRING_CAT' => -110,
			".." => -110
		}
	},
	{#State 211
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148,
			'OP17_LIST_RANGE' => 147,
			".." => -124,
			'OP08_STRING_CAT' => 140,
			"}" => -124,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			")" => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP11_COMPARE_LT_GT' => 138,
			"]" => -124,
			'OP23_LOGICAL_AND' => -124,
			'OP16_LOGICAL_OR' => 136,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP04_MATH_POW' => 132,
			";" => -124,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP18_TERNARY' => 133,
			'OP21_LIST_COMMA' => -124,
			'OP08_MATH_ADD_SUB' => 144
		}
	},
	{#State 212
		ACTIONS => {
			'OP17_LIST_RANGE' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP08_STRING_CAT' => 140,
			".." => -112,
			")" => -112,
			'OP09_BITWISE_SHIFT' => -112,
			"}" => -112,
			'OP06_REGEX_MATCH' => 141,
			"]" => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP04_MATH_POW' => 132,
			";" => -112,
			'OP21_LIST_COMMA' => -112,
			'OP18_TERNARY' => -112,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 135
		}
	},
	{#State 213
		ACTIONS => {
			'OP17_LIST_RANGE' => undef,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP08_STRING_CAT' => 140,
			".." => -121,
			")" => -121,
			'OP09_BITWISE_SHIFT' => 146,
			"}" => -121,
			'OP06_REGEX_MATCH' => 141,
			"]" => -121,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP11_COMPARE_LT_GT' => 138,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP04_MATH_POW' => 132,
			";" => -121,
			'OP21_LIST_COMMA' => -121,
			'OP18_TERNARY' => -121,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135
		}
	},
	{#State 214
		ACTIONS => {
			'OP04_MATH_POW' => 132,
			";" => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP18_TERNARY' => -117,
			'OP21_LIST_COMMA' => -117,
			'OP08_MATH_ADD_SUB' => 144,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => -117,
			"]" => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP23_LOGICAL_AND' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			".." => -117,
			'OP08_STRING_CAT' => 140,
			'OP09_BITWISE_SHIFT' => 146,
			"}" => -117,
			'OP06_REGEX_MATCH' => 141,
			")" => -117,
			'OP13_BITWISE_AND' => -117,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP17_LIST_RANGE' => -117
		}
	},
	{#State 215
		ACTIONS => {
			")" => 263
		}
	},
	{#State 216
		DEFAULT => -139
	},
	{#State 217
		DEFAULT => -107
	},
	{#State 218
		DEFAULT => -154
	},
	{#State 219
		DEFAULT => -216
	},
	{#State 220
		DEFAULT => -217
	},
	{#State 221
		ACTIONS => {
			";" => 264
		}
	},
	{#State 222
		DEFAULT => -156
	},
	{#State 223
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 139,
			'OP23_LOGICAL_AND' => 145,
			'OP16_LOGICAL_OR' => 136,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP08_MATH_ADD_SUB' => 144,
			'OP18_TERNARY' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134,
			";" => -155,
			'OP04_MATH_POW' => 132,
			'OP17_LIST_RANGE' => 147,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148,
			'OP06_REGEX_MATCH' => 141,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_STRING_CAT' => 140
		}
	},
	{#State 224
		ACTIONS => {
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP17_LIST_RANGE' => 147,
			'OP08_STRING_CAT' => 140,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => 145,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP04_MATH_POW' => 132,
			";" => 265,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP18_TERNARY' => 133,
			'OP08_MATH_ADD_SUB' => 144
		}
	},
	{#State 225
		ACTIONS => {
			"(" => 266
		}
	},
	{#State 226
		ACTIONS => {
			"{" => 267
		},
		GOTOS => {
			'CodeBlock' => 268
		}
	},
	{#State 227
		ACTIONS => {
			"= sub {" => 269
		}
	},
	{#State 228
		ACTIONS => {
			";" => 270
		}
	},
	{#State 229
		ACTIONS => {
			")" => 271
		}
	},
	{#State 230
		DEFAULT => -128
	},
	{#State 231
		DEFAULT => -31
	},
	{#State 232
		ACTIONS => {
			";" => 272
		}
	},
	{#State 233
		ACTIONS => {
			"use constant" => -71,
			"our %properties = (" => -71,
			"use" => -71,
			"## no critic qw(" => 23
		},
		GOTOS => {
			'STAR-29' => 273,
			'Critic' => 274
		}
	},
	{#State 234
		DEFAULT => -26
	},
	{#State 235
		ACTIONS => {
			'WORD' => 275
		}
	},
	{#State 236
		DEFAULT => -50
	},
	{#State 237
		ACTIONS => {
			"my" => 123,
			'LITERAL_STRING' => -37,
			'LITERAL_NUMBER' => -37
		},
		GOTOS => {
			'TypeInner' => 276,
			'OPTIONAL-13' => 277
		}
	},
	{#State 238
		ACTIONS => {
			";" => 278
		}
	},
	{#State 239
		ACTIONS => {
			"%{" => 80,
			'WORD' => 102
		},
		GOTOS => {
			'HashDereferenced' => 99,
			'HashEntry' => 279
		}
	},
	{#State 240
		DEFAULT => -213
	},
	{#State 241
		DEFAULT => -215
	},
	{#State 242
		DEFAULT => -206
	},
	{#State 243
		ACTIONS => {
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP01_NAMED' => 58,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"\@{" => 57,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			'OP10_NAMED_UNARY' => 66,
			'OP05_MATH_NEG' => 76,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			'WORD' => 10
		},
		GOTOS => {
			'Literal' => 52,
			'WordScoped' => 68,
			'HashReference' => 65,
			'Expression' => 280,
			'HashDereferenced' => 85,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'Variable' => 110,
			'Operator' => 75
		}
	},
	{#State 244
		ACTIONS => {
			"}" => 281,
			"(" => -218
		}
	},
	{#State 245
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP11_COMPARE_LT_GT' => 138,
			'OP23_LOGICAL_AND' => 145,
			'OP16_LOGICAL_OR' => 136,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP04_MATH_POW' => 132,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134,
			'OP08_MATH_ADD_SUB' => 144,
			'OP18_TERNARY' => 133,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148,
			'OP17_LIST_RANGE' => 147,
			'OP08_STRING_CAT' => 140,
			'OP06_REGEX_MATCH' => 141,
			"}" => 282,
			'OP09_BITWISE_SHIFT' => 146
		}
	},
	{#State 246
		ACTIONS => {
			'OP08_STRING_CAT' => 140,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP17_LIST_RANGE' => 147,
			'OP04_MATH_POW' => 132,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP18_TERNARY' => 133,
			'OP08_MATH_ADD_SUB' => 144,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			"]" => 283,
			'OP23_LOGICAL_AND' => 145,
			'OP16_LOGICAL_OR' => 136,
			'OP14_BITWISE_OR_XOR' => 139
		}
	},
	{#State 247
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			"<STDIN>" => 222,
			'OP05_MATH_NEG' => 76,
			'LITERAL_NUMBER' => 71,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			"undef" => 73,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_STRING' => 46,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'OP01_NAMED' => 58,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80
		},
		GOTOS => {
			'Expression' => 223,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'Variable' => 110,
			'Operator' => 75,
			'ExpressionOrStdin' => 284,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56
		}
	},
	{#State 248
		DEFAULT => -187
	},
	{#State 249
		DEFAULT => -102
	},
	{#State 250
		ACTIONS => {
			")" => 286,
			'WORD' => 285
		}
	},
	{#State 251
		DEFAULT => -195
	},
	{#State 252
		DEFAULT => -220
	},
	{#State 253
		DEFAULT => -137
	},
	{#State 254
		DEFAULT => -192
	},
	{#State 255
		ACTIONS => {
			"my" => 123,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"\@{" => 57,
			'OP01_NAMED' => 58,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			'KEYS_OR_VALUES' => 115,
			'OP03_MATH_INC_DEC' => 47,
			'LITERAL_STRING' => 46,
			"(" => 77,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 74,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'TypeInner' => 112,
			'Expression' => 117,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Variable' => 110,
			'Operator' => 75,
			'ListElement' => 287
		}
	},
	{#State 256
		ACTIONS => {
			'WORD' => 288
		}
	},
	{#State 257
		DEFAULT => -221
	},
	{#State 258
		ACTIONS => {
			"(" => 289
		}
	},
	{#State 259
		ACTIONS => {
			"{" => 267
		},
		GOTOS => {
			'CodeBlock' => 290
		}
	},
	{#State 260
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'OP05_MATH_NEG' => 76,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			'OP01_NAMED' => 58,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'Literal' => 52,
			'WordScoped' => 68,
			'HashReference' => 65,
			'Expression' => 291,
			'HashDereferenced' => 85,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'Operator' => 75,
			'Variable' => 110
		}
	},
	{#State 261
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Variable' => 292
		}
	},
	{#State 262
		ACTIONS => {
			"/" => 293
		}
	},
	{#State 263
		DEFAULT => -152
	},
	{#State 264
		DEFAULT => -189
	},
	{#State 265
		DEFAULT => -190
	},
	{#State 266
		ACTIONS => {
			'OP01_NAMED_QW' => 109,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'OP01_NAMED' => 58,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			'KEYS_OR_VALUES' => 115,
			"my" => 123,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			'OP10_NAMED_UNARY' => 66,
			")" => -142,
			'OP05_MATH_NEG' => 76,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			'WORD' => 10,
			"undef" => 73
		},
		GOTOS => {
			'WordScoped' => 68,
			'Literal' => 52,
			'HashDereferenced' => 85,
			'HashReference' => 65,
			'Expression' => 117,
			'ListElements' => 295,
			'TypeInner' => 112,
			'ListElement' => 114,
			'Operator' => 75,
			'OPTIONAL-48' => 294,
			'Variable' => 110,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70
		}
	},
	{#State 267
		ACTIONS => {
			"if (" => 83,
			"[" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'OP01_NAMED_VOID' => 59,
			'OP01_NAMED' => 58,
			"for my integer" => -159,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"my" => 54,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			'OP19_LOOP_CONTROL' => 48,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			'OP05_MATH_NEG' => 76,
			"while (" => -159,
			'OP01_NAMED_VOID_PAREN' => 88,
			"foreach my" => -159,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'WORD' => 72,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'PAREN-49' => 84,
			'OPTIONAL-50' => 64,
			'VariableModification' => 63,
			'Statement' => 62,
			'PLUS-55' => 296,
			'WordScoped' => 68,
			'HashReference' => 65,
			'Expression' => 67,
			'HashDereferenced' => 85,
			'LoopLabel' => 86,
			'ArrayDereferenced' => 70,
			'Operator' => 75,
			'Literal' => 52,
			'VariableDeclaration' => 49,
			'Operation' => 297,
			'OperatorVoid' => 51,
			'ArrayReference' => 56,
			'Conditional' => 55,
			'Variable' => 82
		}
	},
	{#State 268
		DEFAULT => -167,
		GOTOS => {
			'STAR-52' => 298
		}
	},
	{#State 269
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -54,
			'LITERAL_STRING' => -54,
			"(" => -54,
			'OP19_LOOP_CONTROL' => -54,
			"{" => -54,
			'VARIABLE_SYMBOL' => -54,
			"my" => -54,
			"%{" => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			"\@{" => -54,
			'OP01_NAMED' => -54,
			"for my integer" => -54,
			'OP01_NAMED_VOID' => -54,
			'OP22_LOGICAL_NOT' => -54,
			'WORD_SCOPED' => -54,
			"if (" => -54,
			"[" => -54,
			'OP10_NAMED_UNARY' => -54,
			"( my" => 300,
			'OP05_LOGICAL_NEG' => -54,
			"undef" => -54,
			'LITERAL_NUMBER' => -54,
			'WORD' => -54,
			"foreach my" => -54,
			'OP01_NAMED_VOID_PAREN' => -54,
			"while (" => -54,
			'OP05_MATH_NEG' => -54
		},
		GOTOS => {
			'SubroutineArguments' => 299,
			'OPTIONAL-21' => 301
		}
	},
	{#State 270
		DEFAULT => -134
	},
	{#State 271
		ACTIONS => {
			";" => 302
		}
	},
	{#State 272
		DEFAULT => -34
	},
	{#State 273
		ACTIONS => {
			"use" => 29,
			"use constant" => -73,
			"our %properties = (" => -73
		},
		GOTOS => {
			'STAR-30' => 303,
			'Include' => 304
		}
	},
	{#State 274
		DEFAULT => -68
	},
	{#State 275
		ACTIONS => {
			'OP20_HASH_FATARROW' => 305
		}
	},
	{#State 276
		DEFAULT => -36
	},
	{#State 277
		ACTIONS => {
			'LITERAL_NUMBER' => 71,
			'LITERAL_STRING' => 46
		},
		GOTOS => {
			'Literal' => 306
		}
	},
	{#State 278
		DEFAULT => -35
	},
	{#State 279
		DEFAULT => -212
	},
	{#State 280
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134,
			'OP08_MATH_ADD_SUB' => 144,
			'OP18_TERNARY' => 133,
			'OP21_LIST_COMMA' => -208,
			'OP04_MATH_POW' => 132,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP23_LOGICAL_AND' => 145,
			'OP16_LOGICAL_OR' => 136,
			'OP06_REGEX_MATCH' => 141,
			"}" => -208,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148,
			'OP17_LIST_RANGE' => 147
		}
	},
	{#State 281
		DEFAULT => -186
	},
	{#State 282
		DEFAULT => -185
	},
	{#State 283
		DEFAULT => -184
	},
	{#State 284
		ACTIONS => {
			";" => 307
		}
	},
	{#State 285
		DEFAULT => -194
	},
	{#State 286
		DEFAULT => -197
	},
	{#State 287
		DEFAULT => -191
	},
	{#State 288
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 308
		}
	},
	{#State 289
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"my" => 123,
			"[" => 61,
			'KEYS_OR_VALUES' => 115,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			'OP01_NAMED' => 58,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			'OP01_NAMED_QW' => 109
		},
		GOTOS => {
			'Operator' => 75,
			'Variable' => 110,
			'ListElement' => 114,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Expression' => 117,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'ListElements' => 309,
			'TypeInner' => 112
		}
	},
	{#State 290
		DEFAULT => -177
	},
	{#State 291
		ACTIONS => {
			'OP04_MATH_POW' => 132,
			'OP18_TERNARY' => 133,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP08_STRING_CAT' => 140,
			".." => 310,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			'OP17_LIST_RANGE' => 147,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142
		}
	},
	{#State 292
		DEFAULT => -122
	},
	{#State 293
		DEFAULT => -108
	},
	{#State 294
		ACTIONS => {
			")" => 311
		}
	},
	{#State 295
		DEFAULT => -141
	},
	{#State 296
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			"}" => 313,
			"while (" => -159,
			'OP05_MATH_NEG' => 76,
			"foreach my" => -159,
			'OP01_NAMED_VOID_PAREN' => 88,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 72,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'VARIABLE_SYMBOL' => 53,
			'OP19_LOOP_CONTROL' => 48,
			"{" => 50,
			'LITERAL_STRING' => 46,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			"if (" => 83,
			'OP01_NAMED' => 58,
			"for my integer" => -159,
			'OP01_NAMED_VOID' => 59,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"\@{" => 57,
			"my" => 54
		},
		GOTOS => {
			'Literal' => 52,
			'OperatorVoid' => 51,
			'VariableDeclaration' => 49,
			'Operation' => 312,
			'Variable' => 82,
			'ArrayReference' => 56,
			'Conditional' => 55,
			'WordScoped' => 68,
			'Expression' => 67,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'PAREN-49' => 84,
			'OPTIONAL-50' => 64,
			'VariableModification' => 63,
			'Statement' => 62,
			'Operator' => 75,
			'LoopLabel' => 86,
			'ArrayDereferenced' => 70
		}
	},
	{#State 297
		DEFAULT => -179
	},
	{#State 298
		ACTIONS => {
			"{" => -170,
			'OP19_LOOP_CONTROL' => -170,
			'VARIABLE_SYMBOL' => -170,
			'OP03_MATH_INC_DEC' => -170,
			"(" => -170,
			'LITERAL_STRING' => -170,
			'OP01_NAMED_VOID' => -170,
			"for my integer" => -170,
			'OP01_NAMED' => -170,
			"if (" => -170,
			"[" => -170,
			'WORD_SCOPED' => -170,
			'OP22_LOGICAL_NOT' => -170,
			"my" => -170,
			"elsif (" => 317,
			"\@{" => -170,
			'' => -170,
			"%{" => -170,
			'OP10_NAMED_UNARY_STRINGIFY' => -170,
			'OP10_NAMED_UNARY' => -170,
			"else" => 316,
			"}" => -170,
			'OP01_NAMED_VOID_PAREN' => -170,
			"foreach my" => -170,
			'OP05_MATH_NEG' => -170,
			"while (" => -170,
			'OP05_LOGICAL_NEG' => -170,
			'LITERAL_NUMBER' => -170,
			"undef" => -170,
			'WORD' => -170
		},
		GOTOS => {
			'OPTIONAL-54' => 315,
			'PAREN-53' => 314,
			'PAREN-51' => 318
		}
	},
	{#State 299
		DEFAULT => -53
	},
	{#State 300
		ACTIONS => {
			'WORD' => 104
		},
		GOTOS => {
			'Type' => 319
		}
	},
	{#State 301
		ACTIONS => {
			"for my integer" => -159,
			'OP01_NAMED' => 58,
			'OP01_NAMED_VOID' => 59,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"if (" => 83,
			"[" => 61,
			"my" => 54,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"\@{" => 57,
			'OP19_LOOP_CONTROL' => 48,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"foreach my" => -159,
			'OP01_NAMED_VOID_PAREN' => 88,
			"while (" => -159,
			'OP05_MATH_NEG' => 76,
			'WORD' => 72,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'VariableDeclaration' => 49,
			'OperatorVoid' => 51,
			'Operation' => 320,
			'Literal' => 52,
			'Conditional' => 55,
			'ArrayReference' => 56,
			'Variable' => 82,
			'PAREN-49' => 84,
			'VariableModification' => 63,
			'OPTIONAL-50' => 64,
			'Statement' => 62,
			'HashReference' => 65,
			'Expression' => 67,
			'HashDereferenced' => 85,
			'WordScoped' => 68,
			'ArrayDereferenced' => 70,
			'LoopLabel' => 86,
			'Operator' => 75,
			'PLUS-22' => 321
		}
	},
	{#State 302
		DEFAULT => -135
	},
	{#State 303
		ACTIONS => {
			"use constant" => 36,
			"our %properties = (" => 322
		},
		GOTOS => {
			'Constant' => 323,
			'Properties' => 324
		}
	},
	{#State 304
		DEFAULT => -70
	},
	{#State 305
		ACTIONS => {
			'LITERAL_NUMBER' => -44,
			'LITERAL_STRING' => -44,
			"my" => 123
		},
		GOTOS => {
			'OPTIONAL-17' => 326,
			'TypeInner' => 325
		}
	},
	{#State 306
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 327
		}
	},
	{#State 307
		DEFAULT => -188
	},
	{#State 308
		DEFAULT => -222
	},
	{#State 309
		ACTIONS => {
			")" => 328
		}
	},
	{#State 310
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			'LITERAL_NUMBER' => 71,
			'WORD' => 10,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'OP05_MATH_NEG' => 76,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			'VARIABLE_SYMBOL' => 53,
			"{" => 50,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"\@{" => 57,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			'OP01_NAMED' => 58
		},
		GOTOS => {
			'Expression' => 329,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56,
			'Operator' => 75,
			'Variable' => 110
		}
	},
	{#State 311
		DEFAULT => -153
	},
	{#State 312
		DEFAULT => -178
	},
	{#State 313
		DEFAULT => -180
	},
	{#State 314
		DEFAULT => -169
	},
	{#State 315
		DEFAULT => -171
	},
	{#State 316
		ACTIONS => {
			"{" => 267
		},
		GOTOS => {
			'CodeBlock' => 330
		}
	},
	{#State 317
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"\@{" => 57,
			'OP01_NAMED' => 58,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'Literal' => 52,
			'WordScoped' => 68,
			'Expression' => 331,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Variable' => 110,
			'Operator' => 75,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70
		}
	},
	{#State 318
		DEFAULT => -166
	},
	{#State 319
		ACTIONS => {
			'VARIABLE_SYMBOL' => 332
		}
	},
	{#State 320
		DEFAULT => -56
	},
	{#State 321
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			"}" => 333,
			'OP01_NAMED_VOID_PAREN' => 88,
			"foreach my" => -159,
			"while (" => -159,
			'OP05_MATH_NEG' => 76,
			'WORD' => 72,
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'OP19_LOOP_CONTROL' => 48,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_STRING' => 46,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			"for my integer" => -159,
			'OP01_NAMED' => 58,
			'OP01_NAMED_VOID' => 59,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61,
			"if (" => 83,
			"my" => 54,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57
		},
		GOTOS => {
			'OperatorVoid' => 51,
			'Operation' => 334,
			'VariableDeclaration' => 49,
			'Literal' => 52,
			'Variable' => 82,
			'Conditional' => 55,
			'ArrayReference' => 56,
			'HashDereferenced' => 85,
			'HashReference' => 65,
			'Expression' => 67,
			'WordScoped' => 68,
			'Statement' => 62,
			'OPTIONAL-50' => 64,
			'PAREN-49' => 84,
			'VariableModification' => 63,
			'Operator' => 75,
			'ArrayDereferenced' => 70,
			'LoopLabel' => 86
		}
	},
	{#State 322
		ACTIONS => {
			'WORD' => 338,
			"%{" => 80,
			")" => 337
		},
		GOTOS => {
			'HashEntryTyped' => 336,
			'HashDereferenced' => 335
		}
	},
	{#State 323
		DEFAULT => -72
	},
	{#State 324
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 339
		}
	},
	{#State 325
		DEFAULT => -43
	},
	{#State 326
		ACTIONS => {
			'LITERAL_NUMBER' => 71,
			'LITERAL_STRING' => 46
		},
		GOTOS => {
			'Literal' => 340
		}
	},
	{#State 327
		ACTIONS => {
			"]" => 341,
			'OP21_LIST_COMMA' => 342
		},
		GOTOS => {
			'PAREN-15' => 343
		}
	},
	{#State 328
		ACTIONS => {
			"{" => 267
		},
		GOTOS => {
			'CodeBlock' => 344
		}
	},
	{#State 329
		ACTIONS => {
			'OP04_MATH_POW' => 132,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP18_TERNARY' => 133,
			'OP08_MATH_ADD_SUB' => 144,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => 145,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP08_STRING_CAT' => 140,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			")" => 345,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP17_LIST_RANGE' => 147
		}
	},
	{#State 330
		DEFAULT => -168
	},
	{#State 331
		ACTIONS => {
			'OP17_LIST_RANGE' => 147,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP13_BITWISE_AND' => 148,
			")" => 346,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			'OP08_STRING_CAT' => 140,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP18_TERNARY' => 133,
			'OP08_MATH_ADD_SUB' => 144,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP04_MATH_POW' => 132
		}
	},
	{#State 332
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 347
		}
	},
	{#State 333
		ACTIONS => {
			";" => 348
		}
	},
	{#State 334
		DEFAULT => -55
	},
	{#State 335
		DEFAULT => -211
	},
	{#State 336
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 349
		}
	},
	{#State 337
		ACTIONS => {
			";" => 350
		}
	},
	{#State 338
		ACTIONS => {
			'OP20_HASH_FATARROW' => 351
		}
	},
	{#State 339
		ACTIONS => {
			"1;" => 353,
			"our" => 352
		},
		GOTOS => {
			'Method' => 354
		}
	},
	{#State 340
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 355
		}
	},
	{#State 341
		DEFAULT => -51
	},
	{#State 342
		ACTIONS => {
			"my" => 123,
			'LITERAL_STRING' => -39,
			'LITERAL_NUMBER' => -39
		},
		GOTOS => {
			'TypeInner' => 356,
			'OPTIONAL-14' => 357
		}
	},
	{#State 343
		DEFAULT => -41
	},
	{#State 344
		DEFAULT => -176
	},
	{#State 345
		ACTIONS => {
			"{" => 267
		},
		GOTOS => {
			'CodeBlock' => 358
		}
	},
	{#State 346
		ACTIONS => {
			"{" => 267
		},
		GOTOS => {
			'CodeBlock' => 359
		}
	},
	{#State 347
		ACTIONS => {
			")" => 361,
			'OP21_LIST_COMMA' => 362
		},
		GOTOS => {
			'PAREN-23' => 360
		}
	},
	{#State 348
		DEFAULT => -57
	},
	{#State 349
		ACTIONS => {
			")" => 364,
			'OP21_LIST_COMMA' => 365
		},
		GOTOS => {
			'PAREN-35' => 363
		}
	},
	{#State 350
		DEFAULT => -86
	},
	{#State 351
		ACTIONS => {
			"my" => 123
		},
		GOTOS => {
			'TypeInner' => 366
		}
	},
	{#State 352
		ACTIONS => {
			'WORD' => 104
		},
		GOTOS => {
			'Type' => 367
		}
	},
	{#State 353
		ACTIONS => {
			"1;" => 368
		}
	},
	{#State 354
		DEFAULT => -74
	},
	{#State 355
		ACTIONS => {
			"}" => 371,
			'OP21_LIST_COMMA' => 369
		},
		GOTOS => {
			'PAREN-19' => 370
		}
	},
	{#State 356
		DEFAULT => -38
	},
	{#State 357
		ACTIONS => {
			'LITERAL_STRING' => 46,
			'LITERAL_NUMBER' => 71
		},
		GOTOS => {
			'Literal' => 372
		}
	},
	{#State 358
		DEFAULT => -175
	},
	{#State 359
		DEFAULT => -165
	},
	{#State 360
		DEFAULT => -59
	},
	{#State 361
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 373
		}
	},
	{#State 362
		ACTIONS => {
			"my" => 374
		}
	},
	{#State 363
		DEFAULT => -83
	},
	{#State 364
		ACTIONS => {
			";" => 375
		}
	},
	{#State 365
		ACTIONS => {
			'WORD' => 338,
			"%{" => 80
		},
		GOTOS => {
			'HashDereferenced' => 335,
			'HashEntryTyped' => 376
		}
	},
	{#State 366
		ACTIONS => {
			'OP05_MATH_NEG' => 76,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			'WORD' => 10,
			'OP10_NAMED_UNARY' => 66,
			'OP01_NAMED' => 58,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"\@{" => 57,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_STRING' => 46,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47
		},
		GOTOS => {
			'Literal' => 52,
			'WordScoped' => 68,
			'Expression' => 377,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'Operator' => 75,
			'Variable' => 110
		}
	},
	{#State 367
		ACTIONS => {
			'VARIABLE_SYMBOL' => 378
		}
	},
	{#State 368
		ACTIONS => {
			"package" => -80,
			'' => -80,
			"our" => 87
		},
		GOTOS => {
			'PAREN-33' => 381,
			'Subroutine' => 382,
			'PLUS-32' => 379,
			'OPTIONAL-34' => 380
		}
	},
	{#State 369
		ACTIONS => {
			'WORD' => 383
		}
	},
	{#State 370
		DEFAULT => -48
	},
	{#State 371
		DEFAULT => -52
	},
	{#State 372
		DEFAULT => -40
	},
	{#State 373
		ACTIONS => {
			"\@_;" => 384
		}
	},
	{#State 374
		ACTIONS => {
			'WORD' => 104
		},
		GOTOS => {
			'Type' => 385
		}
	},
	{#State 375
		DEFAULT => -85
	},
	{#State 376
		DEFAULT => -82
	},
	{#State 377
		ACTIONS => {
			'OP04_MATH_POW' => 132,
			'OP15_LOGICAL_AND' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP18_TERNARY' => 133,
			'OP21_LIST_COMMA' => -210,
			'OP08_MATH_ADD_SUB' => 144,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP11_COMPARE_LT_GT' => 138,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => 145,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP08_STRING_CAT' => 140,
			'OP09_BITWISE_SHIFT' => 146,
			'OP06_REGEX_MATCH' => 141,
			")" => -210,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP17_LIST_RANGE' => 147
		}
	},
	{#State 378
		ACTIONS => {
			"= sub {" => 386
		}
	},
	{#State 379
		ACTIONS => {
			"our" => 87,
			"1;" => 387
		},
		GOTOS => {
			'Subroutine' => 388
		}
	},
	{#State 380
		DEFAULT => -81
	},
	{#State 381
		DEFAULT => -79
	},
	{#State 382
		DEFAULT => -77
	},
	{#State 383
		ACTIONS => {
			'OP20_HASH_FATARROW' => 389
		}
	},
	{#State 384
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 390
		}
	},
	{#State 385
		ACTIONS => {
			'VARIABLE_SYMBOL' => 391
		}
	},
	{#State 386
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -88,
			'WORD' => -88,
			"undef" => -88,
			'LITERAL_NUMBER' => -88,
			'OP01_NAMED_VOID_PAREN' => -88,
			"foreach my" => -88,
			'OP05_MATH_NEG' => -88,
			"while (" => -88,
			'OP10_NAMED_UNARY' => -88,
			"( my" => 394,
			"my" => -88,
			"\@{" => -88,
			"%{" => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			'OP01_NAMED_VOID' => -88,
			"for my integer" => -88,
			'OP01_NAMED' => -88,
			"if (" => -88,
			"[" => -88,
			'WORD_SCOPED' => -88,
			'OP22_LOGICAL_NOT' => -88,
			'OP03_MATH_INC_DEC' => -88,
			'LITERAL_STRING' => -88,
			"(" => -88,
			"{" => -88,
			'OP19_LOOP_CONTROL' => -88,
			'VARIABLE_SYMBOL' => -88
		},
		GOTOS => {
			'OPTIONAL-37' => 392,
			'MethodArguments' => 393
		}
	},
	{#State 387
		ACTIONS => {
			"1;" => 395
		}
	},
	{#State 388
		DEFAULT => -76
	},
	{#State 389
		ACTIONS => {
			"my" => 123,
			'LITERAL_STRING' => -46,
			'LITERAL_NUMBER' => -46
		},
		GOTOS => {
			'OPTIONAL-18' => 396,
			'TypeInner' => 397
		}
	},
	{#State 390
		ACTIONS => {
			'OP22_LOGICAL_NOT' => -63,
			'WORD_SCOPED' => -63,
			"if (" => -63,
			"[" => -63,
			'OP01_NAMED' => -63,
			"for my integer" => -63,
			'OP01_NAMED_VOID' => -63,
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			"%{" => -63,
			"\@{" => -63,
			"my" => -63,
			'VARIABLE_SYMBOL' => -63,
			'OP19_LOOP_CONTROL' => -63,
			"{" => -63,
			'LITERAL_STRING' => -63,
			'OP03_MATH_INC_DEC' => -63,
			"(" => -63,
			'CHECK_OR_CHECKTRACE' => 398,
			"while (" => -63,
			'OP05_MATH_NEG' => -63,
			"foreach my" => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			"undef" => -63,
			'OP05_LOGICAL_NEG' => -63,
			'LITERAL_NUMBER' => -63,
			'WORD' => -63,
			'OP10_NAMED_UNARY' => -63
		},
		GOTOS => {
			'ArgumentCheck' => 399
		}
	},
	{#State 391
		DEFAULT => -58
	},
	{#State 392
		ACTIONS => {
			"while (" => -159,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED_VOID_PAREN' => 88,
			"foreach my" => -159,
			'WORD' => 72,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 73,
			'LITERAL_NUMBER' => 71,
			'OP10_NAMED_UNARY' => 66,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			"if (" => 83,
			'OP01_NAMED' => 58,
			"for my integer" => -159,
			'OP01_NAMED_VOID' => 59,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			"my" => 54,
			'VARIABLE_SYMBOL' => 53,
			'OP19_LOOP_CONTROL' => 48,
			"{" => 50,
			"(" => 77,
			'OP03_MATH_INC_DEC' => 47,
			'LITERAL_STRING' => 46
		},
		GOTOS => {
			'WordScoped' => 68,
			'HashDereferenced' => 85,
			'HashReference' => 65,
			'Expression' => 67,
			'PLUS-38' => 401,
			'Statement' => 62,
			'OPTIONAL-50' => 64,
			'VariableModification' => 63,
			'PAREN-49' => 84,
			'Operator' => 75,
			'LoopLabel' => 86,
			'ArrayDereferenced' => 70,
			'Literal' => 52,
			'Operation' => 400,
			'OperatorVoid' => 51,
			'VariableDeclaration' => 49,
			'Variable' => 82,
			'ArrayReference' => 56,
			'Conditional' => 55
		}
	},
	{#State 393
		DEFAULT => -87
	},
	{#State 394
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 402
		}
	},
	{#State 395
		DEFAULT => -78
	},
	{#State 396
		ACTIONS => {
			'LITERAL_STRING' => 46,
			'LITERAL_NUMBER' => 71
		},
		GOTOS => {
			'Literal' => 403
		}
	},
	{#State 397
		DEFAULT => -45
	},
	{#State 398
		ACTIONS => {
			"(" => 404
		}
	},
	{#State 399
		DEFAULT => -61
	},
	{#State 400
		DEFAULT => -90
	},
	{#State 401
		ACTIONS => {
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 72,
			'LITERAL_NUMBER' => 71,
			"while (" => -159,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED_VOID_PAREN' => 88,
			"foreach my" => -159,
			"}" => 406,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"%{" => 80,
			"\@{" => 57,
			"my" => 54,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			"if (" => 83,
			'OP01_NAMED' => 58,
			"for my integer" => -159,
			'OP01_NAMED_VOID' => 59,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'VARIABLE_SYMBOL' => 53,
			'OP19_LOOP_CONTROL' => 48,
			"{" => 50
		},
		GOTOS => {
			'Operation' => 405,
			'VariableDeclaration' => 49,
			'OperatorVoid' => 51,
			'Literal' => 52,
			'Variable' => 82,
			'Conditional' => 55,
			'ArrayReference' => 56,
			'HashDereferenced' => 85,
			'HashReference' => 65,
			'Expression' => 67,
			'WordScoped' => 68,
			'Statement' => 62,
			'PAREN-49' => 84,
			'VariableModification' => 63,
			'OPTIONAL-50' => 64,
			'Operator' => 75,
			'ArrayDereferenced' => 70,
			'LoopLabel' => 86
		}
	},
	{#State 402
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 407
		}
	},
	{#State 403
		DEFAULT => -47
	},
	{#State 404
		ACTIONS => {
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			'OP01_NAMED' => 58,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"[" => 61,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'Expression' => 408,
			'HashReference' => 65,
			'HashDereferenced' => 85,
			'Literal' => 52,
			'WordScoped' => 68,
			'Operator' => 75,
			'Variable' => 110,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 56
		}
	},
	{#State 405
		DEFAULT => -89
	},
	{#State 406
		ACTIONS => {
			";" => 409
		}
	},
	{#State 407
		ACTIONS => {
			")" => 410,
			'OP21_LIST_COMMA' => 411
		},
		GOTOS => {
			'PAREN-39' => 412
		}
	},
	{#State 408
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 139,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134,
			'OP08_MATH_ADD_SUB' => 144,
			'OP21_LIST_COMMA' => 415,
			'OP18_TERNARY' => 133,
			'OP04_MATH_POW' => 132,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP17_LIST_RANGE' => 147,
			'OP06_REGEX_MATCH' => 141,
			'OP09_BITWISE_SHIFT' => 146,
			")" => -66,
			'OP08_STRING_CAT' => 140
		},
		GOTOS => {
			'OPTIONAL-27' => 413,
			'PAREN-26' => 414
		}
	},
	{#State 409
		DEFAULT => -91
	},
	{#State 410
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 416
		}
	},
	{#State 411
		ACTIONS => {
			"my" => 417
		}
	},
	{#State 412
		DEFAULT => -93
	},
	{#State 413
		ACTIONS => {
			")" => 418
		}
	},
	{#State 414
		DEFAULT => -65
	},
	{#State 415
		ACTIONS => {
			'LITERAL_NUMBER' => 71,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'WORD' => 10,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 57,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			'OP01_NAMED' => 58,
			"[" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"(" => 77,
			'LITERAL_STRING' => 46,
			'OP03_MATH_INC_DEC' => 47,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Operator' => 75,
			'Variable' => 110,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'WordScoped' => 68,
			'Literal' => 52,
			'HashDereferenced' => 85,
			'Expression' => 419,
			'HashReference' => 65
		}
	},
	{#State 416
		ACTIONS => {
			"\@_;" => 420
		}
	},
	{#State 417
		ACTIONS => {
			'WORD' => 104
		},
		GOTOS => {
			'Type' => 421
		}
	},
	{#State 418
		ACTIONS => {
			";" => 422
		}
	},
	{#State 419
		ACTIONS => {
			'OP17_LIST_RANGE' => 147,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP08_STRING_CAT' => 140,
			'OP06_REGEX_MATCH' => 141,
			'OP09_BITWISE_SHIFT' => 146,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP14_BITWISE_OR_XOR' => 139,
			'OP04_MATH_POW' => 132,
			'OP08_MATH_ADD_SUB' => 144,
			'OP18_TERNARY' => 133,
			'OP21_LIST_COMMA' => 423,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134
		}
	},
	{#State 420
		DEFAULT => -96,
		GOTOS => {
			'STAR-41' => 424
		}
	},
	{#State 421
		ACTIONS => {
			'VARIABLE_SYMBOL' => 425
		}
	},
	{#State 422
		DEFAULT => -67
	},
	{#State 423
		ACTIONS => {
			'WORD' => 10,
			"undef" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'LITERAL_NUMBER' => 71,
			'OP05_MATH_NEG' => 76,
			'OP10_NAMED_UNARY' => 66,
			"%{" => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 81,
			"\@{" => 57,
			'OP01_NAMED' => 58,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 61,
			'OP03_MATH_INC_DEC' => 47,
			"(" => 77,
			'LITERAL_STRING' => 46,
			"{" => 50,
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Variable' => 110,
			'Operator' => 75,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 70,
			'Literal' => 52,
			'WordScoped' => 68,
			'HashReference' => 65,
			'Expression' => 426,
			'HashDereferenced' => 85
		}
	},
	{#State 424
		ACTIONS => {
			'OP10_NAMED_UNARY' => -97,
			'OP05_LOGICAL_NEG' => -97,
			"undef" => -97,
			'LITERAL_NUMBER' => -97,
			'WORD' => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			"foreach my" => -97,
			'OP05_MATH_NEG' => -97,
			'CHECK_OR_CHECKTRACE' => 398,
			"while (" => -97,
			'OP03_MATH_INC_DEC' => -97,
			"(" => -97,
			'LITERAL_STRING' => -97,
			"{" => -97,
			'OP19_LOOP_CONTROL' => -97,
			'VARIABLE_SYMBOL' => -97,
			"my" => -97,
			"\@{" => -97,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			"%{" => -97,
			'OP01_NAMED_VOID' => -97,
			'OP01_NAMED' => -97,
			"for my integer" => -97,
			"[" => -97,
			"if (" => -97,
			'OP22_LOGICAL_NOT' => -97,
			'WORD_SCOPED' => -97
		},
		GOTOS => {
			'ArgumentCheck' => 427
		}
	},
	{#State 425
		DEFAULT => -92
	},
	{#State 426
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 139,
			'OP11_COMPARE_LT_GT' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP16_LOGICAL_OR' => 136,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 135,
			'OP15_LOGICAL_AND' => 134,
			'OP08_MATH_ADD_SUB' => 144,
			'OP18_TERNARY' => 133,
			'OP04_MATH_POW' => 132,
			'OP13_BITWISE_AND' => 148,
			'OP12_COMPARE_EQ_NEQ' => 142,
			'OP17_LIST_RANGE' => 147,
			'OP06_REGEX_MATCH' => 141,
			'OP09_BITWISE_SHIFT' => 146,
			")" => -64,
			'OP08_STRING_CAT' => 140
		}
	},
	{#State 427
		DEFAULT => -95
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5611 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5618 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5625 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5636 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5647 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5654 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5661 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5668 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5675 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5682 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5689 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5696 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5703 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5710 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5717 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5728 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5739 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5750 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5757 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5764 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5771 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5778 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5785 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5792 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5799 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5806 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 10,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5817 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5828 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5835 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5842 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5853 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5860 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5867 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5878 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5889 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5900 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5907 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5914 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5921 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5928 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5935 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5942 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5949 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5956 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5963 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5970 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5977 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5984 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5991 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5998 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6009 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6031 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6038 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6045 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6052 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6059 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6070 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6077 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6084 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6091 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6098 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6105 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6116 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6123 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6130 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6137 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6148 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6155 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6162 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6169 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6176 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6183 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6190 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6197 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6211 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6218 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 3,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6225 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6239 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 17,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6250 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6257 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6264 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6271 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6282 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6293 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6307 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6321 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6332 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6339 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6346 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6353 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6360 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6367 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6378 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6389 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6400 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6407 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6414 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6425 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6436 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6447 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6458 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6469 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6480 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6491 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6502 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6524 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6535 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6546 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6557 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6568 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6579 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6590 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6601 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6612 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6623 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6634 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6645 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6656 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6667 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6678 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6685 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6692 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6699 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6706 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6713 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6720 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6727 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6734 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6745 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6756 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6767 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6778 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6789 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6796 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6803 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6810 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6817 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6828 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6905 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6916 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6927 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6938 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6949 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_155
		 'ExpressionOrStdin', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6960 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_156
		 'ExpressionOrStdin', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6971 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6978 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6985 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6992 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7003 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7014 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7025 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_163
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7036 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_164
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7047 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7054 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7061 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7068 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7075 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7082 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7089 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_171
		 'Conditional', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_173
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_174
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7133 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_175
		 'LoopFor', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7144 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_176
		 'LoopForEach', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7155 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_177
		 'LoopWhile', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7173 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7180 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_180
		 'CodeBlock', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7191 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7198 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_183
		 'Variable', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_185
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_186
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7249 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_187
		 'VariableDeclaration', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7260 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_188
		 'VariableDeclaration', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7271 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_189
		 'VariableModification', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7282 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_190
		 'VariableModification', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7293 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7300 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7307 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7314 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7321 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_196
		 'ListElements', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_197
		 'ListElements', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_198
		 'ListElement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_199
		 'ListElement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_200
		 'ListElement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7390 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7397 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_203
		 'ArrayReference', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_204
		 'ArrayDereferenced', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7419 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_205
		 'ArrayDereferenced', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7430 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_208
		 'HashEntry', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7455 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_209
		 'HashEntry', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7466 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_210
		 'HashEntryTyped', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7477 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_211
		 'HashEntryTyped', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-62', 2,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7495 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 2,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7502 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7509 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_215
		 'HashReference', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7520 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_216
		 'HashDereferenced', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7531 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_217
		 'HashDereferenced', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7542 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_218
		 'WordScoped', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7553 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_219
		 'WordScoped', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7564 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_220
		 'FileHandle', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7575 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_221
		 'FileHandle', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7586 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_222
		 'TypeInner', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7597 lib/RPerl/Grammar.pm
	],
	[#Rule Type_223
		 'Type', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7608 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_224
		 'LoopLabel', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7619 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_225
		 'Literal', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7630 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_226
		 'Literal', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7641 lib/RPerl/Grammar.pm
	]
],
#line 7644 lib/RPerl/Grammar.pm
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
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Program_15', 
         'Module_16', 
         'Module_17', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Package_26', 
         'Header_27', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Critic_30', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Include_33', 
         'Include_34', 
         'Constant_35', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ConstantValue_50', 
         'ConstantValue_51', 
         'ConstantValue_52', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Subroutine_57', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_63', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArgumentCheck_67', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Class_81', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_85', 
         'Properties_86', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Method_91', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_97', 
         'Operation_98', 
         'Operation_99', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Operator_102', 
         'Operator_103', 
         'Operator_104', 
         'Operator_105', 
         'Operator_106', 
         'Operator_107', 
         'Operator_108', 
         'Operator_109', 
         'Operator_110', 
         'Operator_111', 
         'Operator_112', 
         'Operator_113', 
         'Operator_114', 
         'Operator_115', 
         'Operator_116', 
         'Operator_117', 
         'Operator_118', 
         'Operator_119', 
         'Operator_120', 
         'Operator_121', 
         'Operator_122', 
         'Operator_123', 
         'Operator_124', 
         'Operator_125', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_134', 
         'OperatorVoid_135', 
         'OperatorVoid_136', 
         'OperatorVoid_137', 
         'OperatorVoid_138', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_143', 
         'Expression_144', 
         'Expression_145', 
         'Expression_146', 
         'Expression_147', 
         'Expression_148', 
         'Expression_149', 
         'Expression_150', 
         'Expression_151', 
         'Expression_152', 
         'Expression_153', 
         'Expression_154', 
         'ExpressionOrStdin_155', 
         'ExpressionOrStdin_156', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_160', 
         'Statement_161', 
         'Statement_162', 
         'Statement_163', 
         'Statement_164', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_171', 
         'Loop_172', 
         'Loop_173', 
         'Loop_174', 
         'LoopFor_175', 
         'LoopForEach_176', 
         'LoopWhile_177', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_180', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_183', 
         'VariableRetrieval_184', 
         'VariableRetrieval_185', 
         'VariableRetrieval_186', 
         'VariableDeclaration_187', 
         'VariableDeclaration_188', 
         'VariableModification_189', 
         'VariableModification_190', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_196', 
         'ListElements_197', 
         'ListElement_198', 
         'ListElement_199', 
         'ListElement_200', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_203', 
         'ArrayDereferenced_204', 
         'ArrayDereferenced_205', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_208', 
         'HashEntry_209', 
         'HashEntryTyped_210', 
         'HashEntryTyped_211', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_215', 
         'HashDereferenced_216', 
         'HashDereferenced_217', 
         'WordScoped_218', 
         'WordScoped_219', 
         'FileHandle_220', 
         'FileHandle_221', 
         'TypeInner_222', 
         'Type_223', 
         'LoopLabel_224', 
         'Literal_225', 
         'Literal_226', );
  $self;
}

#line 190 "lib/RPerl/Grammar.eyp"


{
# Rules from Grammar.output
# NEED FIX: UPDATE!?!
my string__hash_ref $rules = {

CompileUnit_3 => 'RPerl::CompileUnit',
CompileUnit_4 => 'RPerl::CompileUnit',
Program_9 => 'RPerl::CompileUnit::Program',
Module_10 => 'RPerl::CompileUnit::Module',
Module_11 => 'RPerl::CompileUnit::Module',
Package_14 => 'RPerl::CompileUnit::Module::Package',
Subroutine_38 => 'RPerl::CodeBlock::Subroutine',
Class_52 => 'RPerl::CompileUnit::Module::Class',
Properties_55 => 'RPerl::DataStructure::Hash::Properties',
Method_60 => 'RPerl::CodeBlock::Subroutine::Method',
Operation_65 => 'RPerl::Operation',
Operation_66 => 'RPerl::Operation',
Operator_69 => 'RPerl::Operation::Expression::Operator',

}; 
    1;
}

=for None

=cut


#line 7919 lib/RPerl/Grammar.pm



1;
