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
    our $VERSION = 0.000_734;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G(\s*(?:#[^#\!].*)?\s*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|\#\!\/usr\/bin\/perl|filehandle_ref|for\ my\ integer|foreach\ my|elsif\ \(|while\ \(|\<STDIN\>|package|\$TYPED_|\=\ sub\ \{|undef|fuse|\(\ my|if\ \(|else|\@_\;|qw\(|our|1\;|\@\{|\{\*|my|\%\{|\.\.|\(|\{|\[|\}|\)|\;|\]|\/)}gc and return ($1, $1);

      /\G(use\ strict\;)/gc and return ('USE_STRICT', $1);
      /\G(use\ warnings\;)/gc and return ('USE_WARNINGS', $1);
      /\G(use\ RPerl\;)/gc and return ('USE_RPERL', $1);
      /\G(use\ constant)/gc and return ('USE_CONSTANT', $1);
      /\G(use\ parent)/gc and return ('USE_PARENT', $1);
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


#line 119 lib/RPerl/Grammar.pm

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
  [ 'Header_27' => 'Header', [ 'USE_STRICT', 'USE_WARNINGS', 'USE_RPERL', 'our', 'VERSION_NUMBER_ASSIGN' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-11', [ 'PLUS-11', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-11', [ 'WORD' ], 0 ],
  [ 'Critic_30' => 'Critic', [ '## no critic qw(', 'PLUS-11', ')' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-12', [ 'PLUS-12', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-12', [ 'WORD' ], 0 ],
  [ 'Include_33' => 'Include', [ 'fuse', 'WordScoped', ';' ], 0 ],
  [ 'Include_34' => 'Include', [ 'fuse', 'WordScoped', 'qw(', 'PLUS-12', ')', ';' ], 0 ],
  [ 'Constant_35' => 'Constant', [ 'USE_CONSTANT', 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'ConstantValue', ';' ], 0 ],
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
  [ 'Class_81' => 'Class', [ 'package', 'WordScoped', ';', 'Header', 'USE_PARENT', 'qw(', 'WordScoped', ')', ';', 'Include', 'STAR-28', 'STAR-29', 'STAR-30', 'Properties', 'STAR-31', '1;', '1;', 'OPTIONAL-34' ], 0 ],
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
	'fuse' => { ISSEMANTIC => 0 },
	'if (' => { ISSEMANTIC => 0 },
	'my' => { ISSEMANTIC => 0 },
	'our %properties = (' => { ISSEMANTIC => 0 },
	'our' => { ISSEMANTIC => 0 },
	'package' => { ISSEMANTIC => 0 },
	'qw(' => { ISSEMANTIC => 0 },
	'undef' => { ISSEMANTIC => 0 },
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
	USE_CONSTANT => { ISSEMANTIC => 1 },
	USE_PARENT => { ISSEMANTIC => 1 },
	USE_RPERL => { ISSEMANTIC => 1 },
	USE_STRICT => { ISSEMANTIC => 1 },
	USE_WARNINGS => { ISSEMANTIC => 1 },
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
			"package" => 2,
			"#!/usr/bin/perl" => 6
		},
		GOTOS => {
			'CompileUnit' => 8,
			'Package' => 3,
			'PLUS-1' => 5,
			'Module' => 4,
			'Class' => 7,
			'Program' => 1
		}
	},
	{#State 1
		DEFAULT => -3
	},
	{#State 2
		ACTIONS => {
			'WORD' => 10,
			'WORD_SCOPED' => 9
		},
		GOTOS => {
			'WordScoped' => 11
		}
	},
	{#State 3
		DEFAULT => -16
	},
	{#State 4
		DEFAULT => -2
	},
	{#State 5
		ACTIONS => {
			"package" => 2,
			'' => -4
		},
		GOTOS => {
			'Module' => 12,
			'Class' => 7,
			'Package' => 3
		}
	},
	{#State 6
		ACTIONS => {
			'USE_STRICT' => 13
		},
		GOTOS => {
			'Header' => 14
		}
	},
	{#State 7
		DEFAULT => -17
	},
	{#State 8
		ACTIONS => {
			'' => 15
		}
	},
	{#State 9
		DEFAULT => -219
	},
	{#State 10
		DEFAULT => -218
	},
	{#State 11
		ACTIONS => {
			";" => 16
		}
	},
	{#State 12
		DEFAULT => -1
	},
	{#State 13
		ACTIONS => {
			'USE_WARNINGS' => 17
		}
	},
	{#State 14
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 18
		}
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		ACTIONS => {
			'USE_STRICT' => 13
		},
		GOTOS => {
			'Header' => 19
		}
	},
	{#State 17
		ACTIONS => {
			'USE_RPERL' => 20
		}
	},
	{#State 18
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => -8,
			"{" => -8,
			"(" => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			"fuse" => -8,
			'LITERAL_STRING' => -8,
			'OP10_NAMED_UNARY' => -8,
			"undef" => -8,
			'OP03_MATH_INC_DEC' => -8,
			"if (" => -8,
			"foreach my" => -8,
			'WORD_SCOPED' => -8,
			'USE_CONSTANT' => -8,
			'OP01_NAMED_VOID' => -8,
			"our" => -8,
			'OP19_LOOP_CONTROL' => -8,
			"\@{" => -8,
			'LITERAL_NUMBER' => -8,
			'OP05_MATH_NEG' => -8,
			"[" => -8,
			"while (" => -8,
			'VARIABLE_SYMBOL' => -8,
			'OP22_LOGICAL_NOT' => -8,
			"## no critic qw(" => 21,
			"%{" => -8,
			'OP01_NAMED' => -8,
			"my" => -8,
			"for my integer" => -8,
			'OP05_LOGICAL_NEG' => -8,
			'WORD' => -8
		},
		GOTOS => {
			'STAR-3' => 22,
			'Critic' => 23
		}
	},
	{#State 19
		ACTIONS => {
			"## no critic qw(" => -19,
			'USE_CONSTANT' => -19,
			"fuse" => -19,
			"our" => -19,
			'USE_PARENT' => 25
		},
		GOTOS => {
			'STAR-7' => 24
		}
	},
	{#State 20
		ACTIONS => {
			"our" => 26
		}
	},
	{#State 21
		ACTIONS => {
			'WORD' => 27
		},
		GOTOS => {
			'PLUS-11' => 28
		}
	},
	{#State 22
		ACTIONS => {
			"foreach my" => -10,
			'WORD_SCOPED' => -10,
			'USE_CONSTANT' => -10,
			'OP01_NAMED_VOID' => -10,
			"our" => -10,
			'OP19_LOOP_CONTROL' => -10,
			"\@{" => -10,
			'LITERAL_NUMBER' => -10,
			'OP05_MATH_NEG' => -10,
			"[" => -10,
			"while (" => -10,
			'VARIABLE_SYMBOL' => -10,
			'OP22_LOGICAL_NOT' => -10,
			"%{" => -10,
			'OP01_NAMED' => -10,
			"my" => -10,
			"for my integer" => -10,
			'OP05_LOGICAL_NEG' => -10,
			'WORD' => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"{" => -10,
			"(" => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			"fuse" => 29,
			'LITERAL_STRING' => -10,
			'OP10_NAMED_UNARY' => -10,
			"undef" => -10,
			'OP03_MATH_INC_DEC' => -10,
			"if (" => -10
		},
		GOTOS => {
			'Include' => 31,
			'STAR-4' => 30
		}
	},
	{#State 23
		DEFAULT => -5
	},
	{#State 24
		ACTIONS => {
			"fuse" => -21,
			"our" => -21,
			"## no critic qw(" => 21,
			'USE_CONSTANT' => -21
		},
		GOTOS => {
			'Critic' => 33,
			'STAR-8' => 32
		}
	},
	{#State 25
		ACTIONS => {
			"qw(" => 34
		}
	},
	{#State 26
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 35
		}
	},
	{#State 27
		DEFAULT => -29
	},
	{#State 28
		ACTIONS => {
			")" => 37,
			'WORD' => 36
		}
	},
	{#State 29
		ACTIONS => {
			'WORD' => 10,
			'WORD_SCOPED' => 9
		},
		GOTOS => {
			'WordScoped' => 38
		}
	},
	{#State 30
		ACTIONS => {
			'WORD_SCOPED' => -12,
			"foreach my" => -12,
			'USE_CONSTANT' => 41,
			'OP19_LOOP_CONTROL' => -12,
			"\@{" => -12,
			'LITERAL_NUMBER' => -12,
			'OP05_MATH_NEG' => -12,
			'OP01_NAMED_VOID' => -12,
			"our" => -12,
			"%{" => -12,
			'OP22_LOGICAL_NOT' => -12,
			"[" => -12,
			"while (" => -12,
			'VARIABLE_SYMBOL' => -12,
			'WORD' => -12,
			'OP05_LOGICAL_NEG' => -12,
			'OP01_NAMED' => -12,
			"for my integer" => -12,
			"my" => -12,
			"{" => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			"(" => -12,
			'OP10_NAMED_UNARY' => -12,
			"undef" => -12,
			'LITERAL_STRING' => -12,
			"if (" => -12,
			'OP03_MATH_INC_DEC' => -12
		},
		GOTOS => {
			'STAR-5' => 39,
			'Constant' => 40
		}
	},
	{#State 31
		DEFAULT => -7
	},
	{#State 32
		ACTIONS => {
			"fuse" => 29,
			"our" => -23,
			'USE_CONSTANT' => -23
		},
		GOTOS => {
			'Include' => 42,
			'STAR-9' => 43
		}
	},
	{#State 33
		DEFAULT => -18
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 9,
			'WORD' => 10
		},
		GOTOS => {
			'WordScoped' => 44
		}
	},
	{#State 35
		DEFAULT => -27
	},
	{#State 36
		DEFAULT => -28
	},
	{#State 37
		DEFAULT => -30
	},
	{#State 38
		ACTIONS => {
			"qw(" => 45,
			";" => 46
		}
	},
	{#State 39
		ACTIONS => {
			"our" => 88,
			'OP01_NAMED_VOID' => 87,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'OP19_LOOP_CONTROL' => 84,
			"foreach my" => -159,
			'WORD_SCOPED' => 9,
			"for my integer" => -159,
			"my" => 63,
			'OP01_NAMED' => 80,
			'WORD' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"while (" => -159,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			'OP01_NAMED_VOID_PAREN' => 71,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			"if (" => 52,
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47
		},
		GOTOS => {
			'HashDereferenced' => 69,
			'Literal' => 68,
			'WordScoped' => 50,
			'OperatorVoid' => 51,
			'Conditional' => 54,
			'HashReference' => 56,
			'Statement' => 72,
			'Operator' => 76,
			'VariableModification' => 61,
			'OPTIONAL-50' => 75,
			'ArrayDereferenced' => 74,
			'PAREN-49' => 62,
			'Expression' => 79,
			'Variable' => 81,
			'VariableDeclaration' => 82,
			'LoopLabel' => 64,
			'ArrayReference' => 83,
			'PLUS-6' => 85,
			'Operation' => 89,
			'Subroutine' => 67
		}
	},
	{#State 40
		DEFAULT => -9
	},
	{#State 41
		ACTIONS => {
			'WORD' => 90
		}
	},
	{#State 42
		DEFAULT => -20
	},
	{#State 43
		ACTIONS => {
			'USE_CONSTANT' => 41,
			"our" => 88
		},
		GOTOS => {
			'PLUS-10' => 92,
			'Subroutine' => 93,
			'Constant' => 91
		}
	},
	{#State 44
		ACTIONS => {
			")" => 94
		}
	},
	{#State 45
		ACTIONS => {
			'WORD' => 96
		},
		GOTOS => {
			'PLUS-12' => 95
		}
	},
	{#State 46
		DEFAULT => -33
	},
	{#State 47
		ACTIONS => {
			'WORD_SCOPED' => 9,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'OP01_NAMED' => 80,
			"{" => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP03_MATH_INC_DEC' => 70
		},
		GOTOS => {
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'WordScoped' => 50,
			'Expression' => 98
		}
	},
	{#State 48
		DEFAULT => -143
	},
	{#State 49
		DEFAULT => -225
	},
	{#State 50
		ACTIONS => {
			"(" => 99
		}
	},
	{#State 51
		DEFAULT => -162
	},
	{#State 52
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'WORD_SCOPED' => 9,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'OP01_NAMED' => 80,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49
		},
		GOTOS => {
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'WordScoped' => 50,
			'Expression' => 100
		}
	},
	{#State 53
		ACTIONS => {
			"%{" => 73,
			"}" => 101,
			'WORD' => 104
		},
		GOTOS => {
			'HashEntry' => 102,
			'HashDereferenced' => 103
		}
	},
	{#State 54
		DEFAULT => -160
	},
	{#State 55
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'OP01_NAMED' => 80,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'WORD_SCOPED' => 9,
			'OP03_MATH_INC_DEC' => 70,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53
		},
		GOTOS => {
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'WordScoped' => 50,
			'Expression' => 105
		}
	},
	{#State 56
		DEFAULT => -148
	},
	{#State 57
		ACTIONS => {
			'OP01_NAMED' => 80,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'WORD_SCOPED' => 9,
			'OP03_MATH_INC_DEC' => 70,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"{" => 53
		},
		GOTOS => {
			'WordScoped' => 50,
			'Expression' => 106,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'HashReference' => 56,
			'Variable' => 97,
			'ArrayReference' => 83
		}
	},
	{#State 58
		ACTIONS => {
			'WORD_SCOPED' => 9,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			"{" => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP03_MATH_INC_DEC' => 70
		},
		GOTOS => {
			'WordScoped' => 50,
			'Expression' => 107,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'HashReference' => 56,
			'Variable' => 97,
			'ArrayReference' => 83
		}
	},
	{#State 59
		ACTIONS => {
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			'LITERAL_STRING' => 49,
			"]" => -202,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'KEYS_OR_VALUES' => 112,
			'OP03_MATH_INC_DEC' => 70,
			'WORD_SCOPED' => 9,
			'OP01_NAMED_QW' => 113,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'OP01_NAMED' => 80,
			"my" => 110,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10
		},
		GOTOS => {
			'Literal' => 68,
			'ListElement' => 115,
			'ArrayDereferenced' => 74,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'Expression' => 114,
			'WordScoped' => 50,
			'OPTIONAL-60' => 109,
			'ArrayReference' => 83,
			'Variable' => 97,
			'ListElements' => 111,
			'HashReference' => 56,
			'TypeInner' => 108
		}
	},
	{#State 60
		DEFAULT => -182,
		GOTOS => {
			'STAR-56' => 116
		}
	},
	{#State 61
		DEFAULT => -164
	},
	{#State 62
		DEFAULT => -158
	},
	{#State 63
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 117
		}
	},
	{#State 64
		ACTIONS => {
			'COLON' => 119
		}
	},
	{#State 65
		ACTIONS => {
			'VARIABLE_SYMBOL' => 60,
			"[" => 59
		},
		GOTOS => {
			'Variable' => 120,
			'ArrayReference' => 121
		}
	},
	{#State 66
		ACTIONS => {
			'WORD_SCOPED' => 9,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'OP01_NAMED' => 80,
			"{" => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP03_MATH_INC_DEC' => 70
		},
		GOTOS => {
			'HashReference' => 56,
			'Variable' => 97,
			'ArrayReference' => 83,
			'WordScoped' => 50,
			'Expression' => 122,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'HashDereferenced' => 69,
			'Operator' => 76
		}
	},
	{#State 67
		DEFAULT => -11
	},
	{#State 68
		DEFAULT => -144
	},
	{#State 69
		DEFAULT => -149
	},
	{#State 70
		ACTIONS => {
			'VARIABLE_SYMBOL' => 60
		},
		GOTOS => {
			'Variable' => 123
		}
	},
	{#State 71
		ACTIONS => {
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			")" => -127,
			'OP03_MATH_INC_DEC' => 70,
			'KEYS_OR_VALUES' => 112,
			"{" => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"{*" => 124,
			"(" => 57,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			"my" => 126,
			'OP01_NAMED' => 80,
			'WORD_SCOPED' => 9,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'OP01_NAMED_QW' => 113
		},
		GOTOS => {
			'Operator' => 76,
			'HashDereferenced' => 69,
			'ListElement' => 115,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'WordScoped' => 50,
			'Expression' => 114,
			'FileHandle' => 125,
			'Variable' => 97,
			'OPTIONAL-43' => 127,
			'ArrayReference' => 83,
			'ListElements' => 128,
			'TypeInner' => 108,
			'HashReference' => 56
		}
	},
	{#State 72
		DEFAULT => -99
	},
	{#State 73
		ACTIONS => {
			"{" => 130,
			'VARIABLE_SYMBOL' => 60
		},
		GOTOS => {
			'HashReference' => 129,
			'Variable' => 131
		}
	},
	{#State 74
		DEFAULT => -147
	},
	{#State 75
		ACTIONS => {
			"while (" => 133,
			"foreach my" => 134,
			"for my integer" => 138
		},
		GOTOS => {
			'LoopFor' => 135,
			'LoopForEach' => 136,
			'LoopWhile' => 137,
			'Loop' => 132
		}
	},
	{#State 76
		DEFAULT => -151
	},
	{#State 77
		ACTIONS => {
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'WORD_SCOPED' => 9,
			'OP01_NAMED' => 80,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58
		},
		GOTOS => {
			'Operator' => 76,
			'HashDereferenced' => 69,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'WordScoped' => 50,
			'Expression' => 139,
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56
		}
	},
	{#State 78
		ACTIONS => {
			'COLON' => -224,
			"(" => -218
		}
	},
	{#State 79
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 142,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP17_LIST_RANGE' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 153,
			'OP08_STRING_CAT' => 148,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP16_LOGICAL_OR' => 149,
			";" => 155,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP23_LOGICAL_AND' => 151,
			'OP06_REGEX_MATCH' => 156
		}
	},
	{#State 80
		ACTIONS => {
			"(" => 157
		}
	},
	{#State 81
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP19_VARIABLE_ASSIGN' => 161,
			'OP13_BITWISE_AND' => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 160,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP18_TERNARY' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP04_MATH_POW' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP17_LIST_RANGE' => -145,
			";" => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP02_METHOD_THINARROW' => 158,
			'OP15_LOGICAL_AND' => -145,
			'OP08_STRING_CAT' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP03_MATH_INC_DEC' => 159
		}
	},
	{#State 82
		DEFAULT => -163
	},
	{#State 83
		DEFAULT => -146
	},
	{#State 84
		ACTIONS => {
			'WORD' => 162
		},
		GOTOS => {
			'LoopLabel' => 163
		}
	},
	{#State 85
		ACTIONS => {
			"{" => 53,
			'OP01_NAMED_VOID_PAREN' => 71,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			'' => -15,
			"(" => 57,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP03_MATH_INC_DEC' => 70,
			"if (" => 52,
			"foreach my" => -159,
			'WORD_SCOPED' => 9,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'OP19_LOOP_CONTROL' => 84,
			'OP01_NAMED_VOID' => 87,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"while (" => -159,
			'WORD' => 78,
			'OP05_LOGICAL_NEG' => 77,
			"for my integer" => -159,
			"my" => 63,
			'OP01_NAMED' => 80
		},
		GOTOS => {
			'Conditional' => 54,
			'HashReference' => 56,
			'HashDereferenced' => 69,
			'Literal' => 68,
			'WordScoped' => 50,
			'OperatorVoid' => 51,
			'Variable' => 81,
			'VariableDeclaration' => 82,
			'LoopLabel' => 64,
			'ArrayReference' => 83,
			'Operation' => 164,
			'Statement' => 72,
			'VariableModification' => 61,
			'Operator' => 76,
			'OPTIONAL-50' => 75,
			'ArrayDereferenced' => 74,
			'PAREN-49' => 62,
			'Expression' => 79
		}
	},
	{#State 86
		DEFAULT => -226
	},
	{#State 87
		ACTIONS => {
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED_QW' => 113,
			'WORD_SCOPED' => 9,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			"my" => 126,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{*" => 124,
			"{" => 53,
			";" => -131,
			'KEYS_OR_VALUES' => 112,
			'OP03_MATH_INC_DEC' => 70,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'LITERAL_STRING' => 49
		},
		GOTOS => {
			'FileHandle' => 166,
			'Variable' => 97,
			'ArrayReference' => 83,
			'OPTIONAL-45' => 167,
			'ListElements' => 165,
			'HashReference' => 56,
			'TypeInner' => 108,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'ListElement' => 115,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'WordScoped' => 50,
			'Expression' => 114
		}
	},
	{#State 88
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 168
		}
	},
	{#State 89
		DEFAULT => -14
	},
	{#State 90
		ACTIONS => {
			'OP20_HASH_FATARROW' => 169
		}
	},
	{#State 91
		DEFAULT => -22
	},
	{#State 92
		ACTIONS => {
			"our" => 88,
			"1;" => 170
		},
		GOTOS => {
			'Subroutine' => 171
		}
	},
	{#State 93
		DEFAULT => -25
	},
	{#State 94
		ACTIONS => {
			";" => 172
		}
	},
	{#State 95
		ACTIONS => {
			")" => 173,
			'WORD' => 174
		}
	},
	{#State 96
		DEFAULT => -32
	},
	{#State 97
		ACTIONS => {
			'OP18_TERNARY' => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			"}" => -145,
			".." => -145,
			'OP17_LIST_RANGE' => -145,
			'OP04_MATH_POW' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP08_STRING_CAT' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP21_LIST_COMMA' => -145,
			")" => -145,
			'OP02_METHOD_THINARROW' => 158,
			"]" => -145,
			'OP03_MATH_INC_DEC' => 159,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			";" => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP23_LOGICAL_AND' => -145
		}
	},
	{#State 98
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 150,
			";" => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => -113,
			'OP08_STRING_CAT' => 148,
			'OP21_LIST_COMMA' => -113,
			")" => -113,
			'OP15_LOGICAL_AND' => -113,
			"]" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => -113,
			'OP18_TERNARY' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			"}" => -113,
			".." => -113,
			'OP17_LIST_RANGE' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => -113
		}
	},
	{#State 99
		ACTIONS => {
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			")" => -140,
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'OP03_MATH_INC_DEC' => 70,
			'KEYS_OR_VALUES' => 112,
			'WORD_SCOPED' => 9,
			'OP01_NAMED_QW' => 113,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			"my" => 110,
			'OP01_NAMED' => 80,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10
		},
		GOTOS => {
			'WordScoped' => 50,
			'Expression' => 114,
			'ArrayDereferenced' => 74,
			'ListElement' => 115,
			'Literal' => 68,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'TypeInner' => 108,
			'ListElements' => 175,
			'HashReference' => 56,
			'OPTIONAL-47' => 176,
			'Variable' => 97,
			'ArrayReference' => 83
		}
	},
	{#State 100
		ACTIONS => {
			'OP18_TERNARY' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 152,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP08_STRING_CAT' => 148,
			'OP15_LOGICAL_AND' => 153,
			")" => 177,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => 149,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => 151
		}
	},
	{#State 101
		DEFAULT => -150
	},
	{#State 102
		DEFAULT => -214,
		GOTOS => {
			'STAR-63' => 178
		}
	},
	{#State 103
		DEFAULT => -209
	},
	{#State 104
		ACTIONS => {
			'OP20_HASH_FATARROW' => 179
		}
	},
	{#State 105
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP13_BITWISE_AND' => -114,
			'OP18_TERNARY' => -114,
			"}" => -114,
			".." => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP17_LIST_RANGE' => -114,
			'OP12_COMPARE_EQ_NEQ' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP04_MATH_POW' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => -114,
			";" => -114,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => -114,
			'OP21_LIST_COMMA' => -114,
			")" => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP08_STRING_CAT' => 148,
			"]" => -114,
			'OP14_BITWISE_OR_XOR' => -114
		}
	},
	{#State 106
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => 149,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => 151,
			'OP08_STRING_CAT' => 148,
			'OP15_LOGICAL_AND' => 153,
			")" => 180,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP18_TERNARY' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 152
		}
	},
	{#State 107
		ACTIONS => {
			".." => -123,
			"}" => -123,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP18_TERNARY' => 141,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP17_LIST_RANGE' => 144,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP13_BITWISE_AND' => 147,
			"]" => -123,
			")" => -123,
			'OP21_LIST_COMMA' => -123,
			'OP15_LOGICAL_AND' => 153,
			'OP08_STRING_CAT' => 148,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP16_LOGICAL_OR' => 149,
			";" => -123,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP23_LOGICAL_AND' => -123,
			'OP06_REGEX_MATCH' => 156
		}
	},
	{#State 108
		ACTIONS => {
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'OP03_MATH_INC_DEC' => 70,
			'WORD_SCOPED' => 9,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'OP01_NAMED' => 80,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10
		},
		GOTOS => {
			'WordScoped' => 50,
			'Expression' => 181,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'HashReference' => 56,
			'Variable' => 97,
			'ArrayReference' => 83
		}
	},
	{#State 109
		ACTIONS => {
			"]" => 182
		}
	},
	{#State 110
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 183
		}
	},
	{#State 111
		DEFAULT => -201
	},
	{#State 112
		ACTIONS => {
			"%{" => 73
		},
		GOTOS => {
			'HashDereferenced' => 184
		}
	},
	{#State 113
		ACTIONS => {
			"(" => 185
		}
	},
	{#State 114
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 142,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP17_LIST_RANGE' => 144,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP13_BITWISE_AND' => 147,
			"]" => -198,
			'OP15_LOGICAL_AND' => 153,
			'OP21_LIST_COMMA' => -198,
			")" => -198,
			'OP08_STRING_CAT' => 148,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP16_LOGICAL_OR' => 149,
			";" => -198,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP23_LOGICAL_AND' => 151,
			'OP06_REGEX_MATCH' => 156
		}
	},
	{#State 115
		DEFAULT => -193,
		GOTOS => {
			'STAR-58' => 186
		}
	},
	{#State 116
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -183,
			";" => -183,
			'OP16_LOGICAL_OR' => -183,
			'OP06_REGEX_MATCH' => -183,
			'OP23_LOGICAL_AND' => -183,
			'OP08_STRING_CAT' => -183,
			'OP15_LOGICAL_AND' => -183,
			'COLON' => -183,
			'OP21_LIST_COMMA' => -183,
			")" => -183,
			'OP02_METHOD_THINARROW' => -183,
			"]" => -183,
			'OP02_ARRAY_THINARROW' => 189,
			'OP02_HASH_THINARROW' => 187,
			'OP03_MATH_INC_DEC' => -183,
			'OP14_BITWISE_OR_XOR' => -183,
			'OP08_MATH_ADD_SUB' => -183,
			'OP09_BITWISE_SHIFT' => -183,
			'OP19_VARIABLE_ASSIGN' => -183,
			'OP19_VARIABLE_ASSIGN_BY' => -183,
			'OP13_BITWISE_AND' => -183,
			'OP18_TERNARY' => -183,
			'OP24_LOGICAL_OR_XOR' => -183,
			"}" => -183,
			".." => -183,
			'OP17_LIST_RANGE' => -183,
			'OP12_COMPARE_EQ_NEQ' => -183,
			'OP04_MATH_POW' => -183,
			'OP11_COMPARE_LT_GT' => -183
		},
		GOTOS => {
			'VariableRetrieval' => 188
		}
	},
	{#State 117
		ACTIONS => {
			'VARIABLE_SYMBOL' => 190
		}
	},
	{#State 118
		DEFAULT => -223
	},
	{#State 119
		DEFAULT => -157
	},
	{#State 120
		ACTIONS => {
			"}" => 191
		}
	},
	{#State 121
		ACTIONS => {
			"}" => 192
		}
	},
	{#State 122
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 152,
			'OP17_LIST_RANGE' => 144,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP13_BITWISE_AND' => 147,
			")" => 193,
			'OP15_LOGICAL_AND' => 153,
			'OP08_STRING_CAT' => 148,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP16_LOGICAL_OR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP23_LOGICAL_AND' => 151,
			'OP06_REGEX_MATCH' => 156
		}
	},
	{#State 123
		DEFAULT => -103
	},
	{#State 124
		ACTIONS => {
			'WORD' => 194
		}
	},
	{#State 125
		ACTIONS => {
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			"my" => 110,
			'OP01_NAMED' => 80,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'OP01_NAMED_QW' => 113,
			'WORD_SCOPED' => 9,
			'OP03_MATH_INC_DEC' => 70,
			'KEYS_OR_VALUES' => 112,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			")" => -129,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53
		},
		GOTOS => {
			'Operator' => 76,
			'HashDereferenced' => 69,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'ListElement' => 115,
			'Expression' => 114,
			'WordScoped' => 50,
			'ArrayReference' => 83,
			'Variable' => 97,
			'ListElements' => 195,
			'HashReference' => 56,
			'TypeInner' => 108,
			'OPTIONAL-44' => 196
		}
	},
	{#State 126
		ACTIONS => {
			'WORD' => 118,
			"filehandle_ref" => 197
		},
		GOTOS => {
			'Type' => 183
		}
	},
	{#State 127
		ACTIONS => {
			")" => 198
		}
	},
	{#State 128
		DEFAULT => -126
	},
	{#State 129
		ACTIONS => {
			"}" => 199
		}
	},
	{#State 130
		ACTIONS => {
			"%{" => 73,
			'WORD' => 104
		},
		GOTOS => {
			'HashEntry' => 102,
			'HashDereferenced' => 103
		}
	},
	{#State 131
		ACTIONS => {
			"}" => 200
		}
	},
	{#State 132
		DEFAULT => -161
	},
	{#State 133
		ACTIONS => {
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'WORD_SCOPED' => 9,
			'OP01_NAMED' => 80,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73
		},
		GOTOS => {
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'WordScoped' => 50,
			'Expression' => 201
		}
	},
	{#State 134
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 202
		}
	},
	{#State 135
		DEFAULT => -172
	},
	{#State 136
		DEFAULT => -173
	},
	{#State 137
		DEFAULT => -174
	},
	{#State 138
		ACTIONS => {
			'VARIABLE_SYMBOL' => 203
		}
	},
	{#State 139
		ACTIONS => {
			'OP13_BITWISE_AND' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => -106,
			'OP18_TERNARY' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			"}" => -106,
			".." => -106,
			'OP06_REGEX_MATCH' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP16_LOGICAL_OR' => -106,
			";" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP08_STRING_CAT' => -106,
			")" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => -106,
			"]" => -106
		}
	},
	{#State 140
		ACTIONS => {
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'WORD_SCOPED' => 9,
			'OP01_NAMED' => 80,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58
		},
		GOTOS => {
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'WordScoped' => 50,
			'Expression' => 204
		}
	},
	{#State 141
		ACTIONS => {
			'VARIABLE_SYMBOL' => 60
		},
		GOTOS => {
			'Variable' => 205
		}
	},
	{#State 142
		ACTIONS => {
			"{" => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP03_MATH_INC_DEC' => 70,
			'WORD_SCOPED' => 9,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'OP01_NAMED' => 80
		},
		GOTOS => {
			'ArrayReference' => 83,
			'Variable' => 97,
			'HashReference' => 56,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'Expression' => 206,
			'WordScoped' => 50
		}
	},
	{#State 143
		ACTIONS => {
			'OP01_NAMED' => 80,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'WORD_SCOPED' => 9,
			'OP03_MATH_INC_DEC' => 70,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"{" => 53
		},
		GOTOS => {
			'HashDereferenced' => 69,
			'Operator' => 76,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'Expression' => 207,
			'WordScoped' => 50,
			'ArrayReference' => 83,
			'Variable' => 97,
			'HashReference' => 56
		}
	},
	{#State 144
		ACTIONS => {
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'OP01_NAMED' => 80,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'WORD_SCOPED' => 9,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'OP03_MATH_INC_DEC' => 70,
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55
		},
		GOTOS => {
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'WordScoped' => 50,
			'Expression' => 208,
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56
		}
	},
	{#State 145
		ACTIONS => {
			'OP01_NAMED' => 80,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 9,
			'OP03_MATH_INC_DEC' => 70,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"{" => 53
		},
		GOTOS => {
			'ArrayReference' => 83,
			'Variable' => 97,
			'HashReference' => 56,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'Expression' => 209,
			'WordScoped' => 50
		}
	},
	{#State 146
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'OP01_NAMED' => 80,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			'WORD_SCOPED' => 9,
			'OP03_MATH_INC_DEC' => 70,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53
		},
		GOTOS => {
			'HashReference' => 56,
			'Variable' => 97,
			'ArrayReference' => 83,
			'WordScoped' => 50,
			'Expression' => 210,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'Literal' => 68,
			'ArrayDereferenced' => 74
		}
	},
	{#State 147
		ACTIONS => {
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'OP03_MATH_INC_DEC' => 70,
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'OP01_NAMED' => 80,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'WORD_SCOPED' => 9,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66
		},
		GOTOS => {
			'Operator' => 76,
			'HashDereferenced' => 69,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'Expression' => 211,
			'WordScoped' => 50,
			'ArrayReference' => 83,
			'Variable' => 97,
			'HashReference' => 56
		}
	},
	{#State 148
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 70,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 9
		},
		GOTOS => {
			'Operator' => 76,
			'HashDereferenced' => 69,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'Expression' => 212,
			'WordScoped' => 50,
			'ArrayReference' => 83,
			'Variable' => 97,
			'HashReference' => 56
		}
	},
	{#State 149
		ACTIONS => {
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'OP01_NAMED' => 80,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'WORD_SCOPED' => 9,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'OP03_MATH_INC_DEC' => 70,
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55
		},
		GOTOS => {
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'Expression' => 213,
			'WordScoped' => 50,
			'ArrayReference' => 83,
			'Variable' => 97,
			'HashReference' => 56
		}
	},
	{#State 150
		ACTIONS => {
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'OP01_NAMED' => 80,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'WORD_SCOPED' => 9,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'OP03_MATH_INC_DEC' => 70,
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55
		},
		GOTOS => {
			'WordScoped' => 50,
			'Expression' => 214,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'HashReference' => 56,
			'Variable' => 97,
			'ArrayReference' => 83
		}
	},
	{#State 151
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 70,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			'WORD_SCOPED' => 9
		},
		GOTOS => {
			'WordScoped' => 50,
			'Expression' => 215,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'HashReference' => 56,
			'Variable' => 97,
			'ArrayReference' => 83
		}
	},
	{#State 152
		ACTIONS => {
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 9,
			'OP03_MATH_INC_DEC' => 70,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53
		},
		GOTOS => {
			'Expression' => 216,
			'WordScoped' => 50,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'HashReference' => 56,
			'ArrayReference' => 83,
			'Variable' => 97
		}
	},
	{#State 153
		ACTIONS => {
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 9,
			'OP01_NAMED' => 80,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58
		},
		GOTOS => {
			'HashReference' => 56,
			'ArrayReference' => 83,
			'Variable' => 97,
			'Expression' => 217,
			'WordScoped' => 50,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'Operator' => 76,
			'HashDereferenced' => 69
		}
	},
	{#State 154
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 70,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"{" => 53,
			'OP01_NAMED' => 80,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 9
		},
		GOTOS => {
			'WordScoped' => 50,
			'Expression' => 218,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'HashReference' => 56,
			'Variable' => 97,
			'ArrayReference' => 83
		}
	},
	{#State 155
		DEFAULT => -98
	},
	{#State 156
		ACTIONS => {
			"/" => 219
		}
	},
	{#State 157
		ACTIONS => {
			")" => -101,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'KEYS_OR_VALUES' => 112,
			'OP03_MATH_INC_DEC' => 70,
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'OP01_NAMED' => 80,
			"my" => 110,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'WORD_SCOPED' => 9,
			'OP01_NAMED_QW' => 113,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'WordScoped' => 50,
			'Expression' => 114,
			'ListElement' => 115,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'HashReference' => 56,
			'ListElements' => 221,
			'TypeInner' => 108,
			'Variable' => 97,
			'OPTIONAL-42' => 220,
			'ArrayReference' => 83
		}
	},
	{#State 158
		ACTIONS => {
			'WORD' => 222
		}
	},
	{#State 159
		DEFAULT => -104
	},
	{#State 160
		ACTIONS => {
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'OP03_MATH_INC_DEC' => 70,
			'WORD_SCOPED' => 9,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'OP01_NAMED' => 80,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10
		},
		GOTOS => {
			'HashDereferenced' => 69,
			'Operator' => 76,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'WordScoped' => 50,
			'Expression' => 223,
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56
		}
	},
	{#State 161
		ACTIONS => {
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'WORD_SCOPED' => 9,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"<STDIN>" => 224,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49
		},
		GOTOS => {
			'HashDereferenced' => 69,
			'Operator' => 76,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'ExpressionOrStdin' => 226,
			'WordScoped' => 50,
			'Expression' => 225,
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56
		}
	},
	{#State 162
		DEFAULT => -224
	},
	{#State 163
		ACTIONS => {
			";" => 227
		}
	},
	{#State 164
		DEFAULT => -13
	},
	{#State 165
		DEFAULT => -130
	},
	{#State 166
		ACTIONS => {
			"{" => 53,
			";" => -133,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'KEYS_OR_VALUES' => 112,
			'OP03_MATH_INC_DEC' => 70,
			'WORD_SCOPED' => 9,
			'OP01_NAMED_QW' => 113,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'OP01_NAMED' => 80,
			"my" => 110,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77
		},
		GOTOS => {
			'ListElement' => 115,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'WordScoped' => 50,
			'OPTIONAL-46' => 228,
			'Expression' => 114,
			'Variable' => 97,
			'ArrayReference' => 83,
			'ListElements' => 229,
			'HashReference' => 56,
			'TypeInner' => 108
		}
	},
	{#State 167
		ACTIONS => {
			";" => 230
		}
	},
	{#State 168
		ACTIONS => {
			'VARIABLE_SYMBOL' => 231
		}
	},
	{#State 169
		ACTIONS => {
			"my" => 110
		},
		GOTOS => {
			'TypeInner' => 232
		}
	},
	{#State 170
		ACTIONS => {
			"1;" => 233
		}
	},
	{#State 171
		DEFAULT => -24
	},
	{#State 172
		ACTIONS => {
			"fuse" => 29
		},
		GOTOS => {
			'Include' => 234
		}
	},
	{#State 173
		ACTIONS => {
			";" => 235
		}
	},
	{#State 174
		DEFAULT => -31
	},
	{#State 175
		DEFAULT => -139
	},
	{#State 176
		ACTIONS => {
			")" => 236
		}
	},
	{#State 177
		ACTIONS => {
			"{" => 238
		},
		GOTOS => {
			'CodeBlock' => 237
		}
	},
	{#State 178
		ACTIONS => {
			'OP21_LIST_COMMA' => 239,
			"}" => 241
		},
		GOTOS => {
			'PAREN-62' => 240
		}
	},
	{#State 179
		ACTIONS => {
			'LITERAL_STRING' => -207,
			'OP10_NAMED_UNARY' => -207,
			"undef" => -207,
			'OP03_MATH_INC_DEC' => -207,
			"{" => -207,
			"(" => -207,
			'OP10_NAMED_UNARY_STRINGIFY' => -207,
			"[" => -207,
			'VARIABLE_SYMBOL' => -207,
			"%{" => -207,
			'OP22_LOGICAL_NOT' => -207,
			'OP01_NAMED' => -207,
			"my" => 110,
			'WORD' => -207,
			'OP05_LOGICAL_NEG' => -207,
			'WORD_SCOPED' => -207,
			"\@{" => -207,
			'OP05_MATH_NEG' => -207,
			'LITERAL_NUMBER' => -207
		},
		GOTOS => {
			'TypeInner' => 242,
			'OPTIONAL-61' => 243
		}
	},
	{#State 180
		DEFAULT => -154
	},
	{#State 181
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 154,
			"]" => -199,
			'OP08_STRING_CAT' => 148,
			'OP15_LOGICAL_AND' => 153,
			'OP21_LIST_COMMA' => -199,
			")" => -199,
			'OP23_LOGICAL_AND' => 151,
			'OP06_REGEX_MATCH' => 156,
			'OP16_LOGICAL_OR' => 149,
			";" => -199,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP17_LIST_RANGE' => 144,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 141,
			'OP13_BITWISE_AND' => 147,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146
		}
	},
	{#State 182
		DEFAULT => -203
	},
	{#State 183
		ACTIONS => {
			"\$TYPED_" => 244
		}
	},
	{#State 184
		DEFAULT => -200
	},
	{#State 185
		ACTIONS => {
			'WORD' => 245
		},
		GOTOS => {
			'PLUS-59' => 246
		}
	},
	{#State 186
		ACTIONS => {
			")" => -196,
			'OP21_LIST_COMMA' => 248,
			";" => -196,
			"]" => -196
		},
		GOTOS => {
			'PAREN-57' => 247
		}
	},
	{#State 187
		ACTIONS => {
			'WORD_SCOPED' => 9,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'WORD' => 250,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			"{" => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP03_MATH_INC_DEC' => 70
		},
		GOTOS => {
			'HashReference' => 56,
			'Variable' => 97,
			'ArrayReference' => 83,
			'WordScoped' => 50,
			'Expression' => 249,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'HashDereferenced' => 69,
			'Operator' => 76
		}
	},
	{#State 188
		DEFAULT => -181
	},
	{#State 189
		ACTIONS => {
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 9,
			'OP03_MATH_INC_DEC' => 70,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53
		},
		GOTOS => {
			'Expression' => 251,
			'WordScoped' => 50,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'HashReference' => 56,
			'ArrayReference' => 83,
			'Variable' => 97
		}
	},
	{#State 190
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 253,
			";" => 252
		}
	},
	{#State 191
		DEFAULT => -204
	},
	{#State 192
		DEFAULT => -205
	},
	{#State 193
		DEFAULT => -107
	},
	{#State 194
		ACTIONS => {
			"}" => 254
		}
	},
	{#State 195
		DEFAULT => -128
	},
	{#State 196
		ACTIONS => {
			")" => 255
		}
	},
	{#State 197
		ACTIONS => {
			'VARIABLE_SYMBOL' => 256
		}
	},
	{#State 198
		ACTIONS => {
			";" => 257
		}
	},
	{#State 199
		DEFAULT => -217
	},
	{#State 200
		DEFAULT => -216
	},
	{#State 201
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => 149,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => 151,
			")" => 258,
			'OP15_LOGICAL_AND' => 153,
			'OP08_STRING_CAT' => 148,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP18_TERNARY' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 142,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => 143
		}
	},
	{#State 202
		ACTIONS => {
			'VARIABLE_SYMBOL' => 259
		}
	},
	{#State 203
		ACTIONS => {
			"(" => 260
		}
	},
	{#State 204
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 154,
			'OP21_LIST_COMMA' => -125,
			'OP15_LOGICAL_AND' => 153,
			")" => -125,
			'OP08_STRING_CAT' => 148,
			"]" => -125,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => 149,
			";" => -125,
			'OP17_LIST_RANGE' => 144,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP18_TERNARY' => 141,
			"}" => -125,
			".." => -125,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP13_BITWISE_AND' => 147,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 205
		ACTIONS => {
			'COLON' => 261
		}
	},
	{#State 206
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			".." => -115,
			"}" => -115,
			'OP18_TERNARY' => -115,
			'OP11_COMPARE_LT_GT' => undef,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => -115,
			'OP17_LIST_RANGE' => -115,
			'OP16_LOGICAL_OR' => -115,
			";" => -115,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP23_LOGICAL_AND' => -115,
			'OP06_REGEX_MATCH' => 156,
			"]" => -115,
			'OP08_STRING_CAT' => 148,
			'OP21_LIST_COMMA' => -115,
			")" => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP14_BITWISE_OR_XOR' => -115
		}
	},
	{#State 207
		ACTIONS => {
			'OP13_BITWISE_AND' => -116,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP17_LIST_RANGE' => -116,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP11_COMPARE_LT_GT' => 142,
			'OP18_TERNARY' => -116,
			"}" => -116,
			".." => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => -116,
			";" => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP21_LIST_COMMA' => -116,
			")" => -116,
			'OP08_STRING_CAT' => 148,
			"]" => -116
		}
	},
	{#State 208
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => 149,
			";" => -121,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => -121,
			'OP08_STRING_CAT' => 148,
			'OP21_LIST_COMMA' => -121,
			'OP15_LOGICAL_AND' => 153,
			")" => -121,
			"]" => -121,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP13_BITWISE_AND' => 147,
			'OP18_TERNARY' => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			"}" => -121,
			".." => -121,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP11_COMPARE_LT_GT' => 142,
			'OP04_MATH_POW' => 152
		}
	},
	{#State 209
		ACTIONS => {
			"]" => -110,
			'OP08_STRING_CAT' => -110,
			")" => -110,
			'OP21_LIST_COMMA' => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP16_LOGICAL_OR' => -110,
			";" => -110,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP23_LOGICAL_AND' => -110,
			'OP06_REGEX_MATCH' => 156,
			'OP24_LOGICAL_OR_XOR' => -110,
			".." => -110,
			"}" => -110,
			'OP18_TERNARY' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP04_MATH_POW' => 152,
			'OP17_LIST_RANGE' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP08_MATH_ADD_SUB' => -110,
			'OP13_BITWISE_AND' => -110
		}
	},
	{#State 210
		ACTIONS => {
			'OP13_BITWISE_AND' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP08_MATH_ADD_SUB' => 145,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			".." => -112,
			"}" => -112,
			'OP18_TERNARY' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP06_REGEX_MATCH' => 156,
			'OP16_LOGICAL_OR' => -112,
			";" => -112,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP14_BITWISE_OR_XOR' => -112,
			"]" => -112,
			'OP08_STRING_CAT' => 148,
			'OP21_LIST_COMMA' => -112,
			'OP15_LOGICAL_AND' => -112,
			")" => -112
		}
	},
	{#State 211
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -117,
			"]" => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP21_LIST_COMMA' => -117,
			")" => -117,
			'OP08_STRING_CAT' => 148,
			'OP23_LOGICAL_AND' => -117,
			'OP06_REGEX_MATCH' => 156,
			'OP16_LOGICAL_OR' => -117,
			";" => -117,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP17_LIST_RANGE' => -117,
			".." => -117,
			"}" => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP18_TERNARY' => -117,
			'OP13_BITWISE_AND' => -117,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146
		}
	},
	{#State 212
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP15_LOGICAL_AND' => -111,
			")" => -111,
			'OP08_STRING_CAT' => -111,
			"]" => -111,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			";" => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP04_MATH_POW' => 152,
			'OP18_TERNARY' => -111,
			"}" => -111,
			".." => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP13_BITWISE_AND' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 213
		ACTIONS => {
			'OP23_LOGICAL_AND' => -120,
			'OP06_REGEX_MATCH' => 156,
			";" => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP14_BITWISE_OR_XOR' => 154,
			"]" => -120,
			'OP21_LIST_COMMA' => -120,
			'OP15_LOGICAL_AND' => 153,
			")" => -120,
			'OP08_STRING_CAT' => 148,
			'OP13_BITWISE_AND' => 147,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP17_LIST_RANGE' => -120,
			".." => -120,
			"}" => -120,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP18_TERNARY' => -120
		}
	},
	{#State 214
		ACTIONS => {
			'OP23_LOGICAL_AND' => -109,
			'OP06_REGEX_MATCH' => 156,
			'OP16_LOGICAL_OR' => -109,
			";" => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			"]" => -109,
			'OP21_LIST_COMMA' => -109,
			'OP15_LOGICAL_AND' => -109,
			")" => -109,
			'OP08_STRING_CAT' => -109,
			'OP13_BITWISE_AND' => -109,
			'OP08_MATH_ADD_SUB' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP17_LIST_RANGE' => -109,
			".." => -109,
			"}" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP18_TERNARY' => -109
		}
	},
	{#State 215
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 154,
			'OP21_LIST_COMMA' => -124,
			'OP15_LOGICAL_AND' => 153,
			")" => -124,
			'OP08_STRING_CAT' => 148,
			"]" => -124,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => -124,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			";" => -124,
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP18_TERNARY' => 141,
			"}" => -124,
			".." => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP13_BITWISE_AND' => 147,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 216
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP15_LOGICAL_AND' => -105,
			")" => -105,
			'OP08_STRING_CAT' => -105,
			"]" => -105,
			'OP06_REGEX_MATCH' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			";" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP04_MATH_POW' => 152,
			'OP18_TERNARY' => -105,
			"}" => -105,
			".." => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP09_BITWISE_SHIFT' => -105
		}
	},
	{#State 217
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP18_TERNARY' => -119,
			"}" => -119,
			".." => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP17_LIST_RANGE' => -119,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => -119,
			";" => -119,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => -119,
			'OP21_LIST_COMMA' => -119,
			")" => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP08_STRING_CAT' => 148,
			"]" => -119,
			'OP14_BITWISE_OR_XOR' => 154
		}
	},
	{#State 218
		ACTIONS => {
			'OP17_LIST_RANGE' => -118,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP18_TERNARY' => -118,
			"}" => -118,
			".." => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP13_BITWISE_AND' => 147,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP21_LIST_COMMA' => -118,
			")" => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP08_STRING_CAT' => 148,
			"]" => -118,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => -118,
			";" => -118
		}
	},
	{#State 219
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 262
		}
	},
	{#State 220
		ACTIONS => {
			")" => 263
		}
	},
	{#State 221
		DEFAULT => -100
	},
	{#State 222
		ACTIONS => {
			"(" => 264
		}
	},
	{#State 223
		ACTIONS => {
			'OP17_LIST_RANGE' => 144,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP11_COMPARE_LT_GT' => 142,
			'OP18_TERNARY' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP13_BITWISE_AND' => 147,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP15_LOGICAL_AND' => 153,
			'OP08_STRING_CAT' => 148,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			";" => 265,
			'OP16_LOGICAL_OR' => 149
		}
	},
	{#State 224
		DEFAULT => -156
	},
	{#State 225
		ACTIONS => {
			'OP16_LOGICAL_OR' => 149,
			";" => -155,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP23_LOGICAL_AND' => 151,
			'OP06_REGEX_MATCH' => 156,
			'OP08_STRING_CAT' => 148,
			'OP15_LOGICAL_AND' => 153,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 141,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP17_LIST_RANGE' => 144
		}
	},
	{#State 226
		ACTIONS => {
			";" => 266
		}
	},
	{#State 227
		DEFAULT => -138
	},
	{#State 228
		ACTIONS => {
			";" => 267
		}
	},
	{#State 229
		DEFAULT => -132
	},
	{#State 230
		DEFAULT => -136
	},
	{#State 231
		ACTIONS => {
			"= sub {" => 268
		}
	},
	{#State 232
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			"{" => 272,
			'LITERAL_STRING' => 49,
			"[" => 270
		},
		GOTOS => {
			'ConstantValue' => 271,
			'Literal' => 269
		}
	},
	{#State 233
		DEFAULT => -26
	},
	{#State 234
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 273
		}
	},
	{#State 235
		DEFAULT => -34
	},
	{#State 236
		DEFAULT => -152
	},
	{#State 237
		DEFAULT => -167,
		GOTOS => {
			'STAR-52' => 274
		}
	},
	{#State 238
		ACTIONS => {
			"if (" => 52,
			'OP03_MATH_INC_DEC' => 70,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53,
			'OP01_NAMED_VOID_PAREN' => 71,
			'WORD' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			"for my integer" => -159,
			"my" => 63,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			"[" => 59,
			"while (" => -159,
			'VARIABLE_SYMBOL' => 60,
			'OP19_LOOP_CONTROL' => 84,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'OP01_NAMED_VOID' => 87,
			'WORD_SCOPED' => 9,
			"foreach my" => -159
		},
		GOTOS => {
			'WordScoped' => 50,
			'OperatorVoid' => 51,
			'Literal' => 68,
			'HashDereferenced' => 69,
			'Conditional' => 54,
			'HashReference' => 56,
			'PAREN-49' => 62,
			'PLUS-55' => 275,
			'Expression' => 79,
			'Statement' => 72,
			'OPTIONAL-50' => 75,
			'ArrayDereferenced' => 74,
			'Operator' => 76,
			'VariableModification' => 61,
			'Operation' => 276,
			'LoopLabel' => 64,
			'Variable' => 81,
			'VariableDeclaration' => 82,
			'ArrayReference' => 83
		}
	},
	{#State 239
		ACTIONS => {
			"%{" => 73,
			'WORD' => 104
		},
		GOTOS => {
			'HashDereferenced' => 103,
			'HashEntry' => 277
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
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP03_MATH_INC_DEC' => 70,
			"{" => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			'WORD_SCOPED' => 9,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'HashReference' => 56,
			'ArrayReference' => 83,
			'Variable' => 97,
			'Expression' => 278,
			'WordScoped' => 50,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'Literal' => 68,
			'ArrayDereferenced' => 74
		}
	},
	{#State 244
		ACTIONS => {
			'WORD' => 279
		}
	},
	{#State 245
		DEFAULT => -195
	},
	{#State 246
		ACTIONS => {
			'WORD' => 280,
			")" => 281
		}
	},
	{#State 247
		DEFAULT => -192
	},
	{#State 248
		ACTIONS => {
			'WORD_SCOPED' => 9,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			"my" => 110,
			"{" => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'LITERAL_STRING' => 49,
			'KEYS_OR_VALUES' => 112,
			'OP03_MATH_INC_DEC' => 70
		},
		GOTOS => {
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56,
			'TypeInner' => 108,
			'ArrayDereferenced' => 74,
			'ListElement' => 282,
			'Literal' => 68,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'WordScoped' => 50,
			'Expression' => 114
		}
	},
	{#State 249
		ACTIONS => {
			'OP15_LOGICAL_AND' => 153,
			'OP08_STRING_CAT' => 148,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP16_LOGICAL_OR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP23_LOGICAL_AND' => 151,
			'OP06_REGEX_MATCH' => 156,
			"}" => 283,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 142,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP17_LIST_RANGE' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 147
		}
	},
	{#State 250
		ACTIONS => {
			"(" => -218,
			"}" => 284
		}
	},
	{#State 251
		ACTIONS => {
			'OP18_TERNARY' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP17_LIST_RANGE' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP13_BITWISE_AND' => 147,
			'OP15_LOGICAL_AND' => 153,
			'OP08_STRING_CAT' => 148,
			"]" => 285,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => 149,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => 151
		}
	},
	{#State 252
		DEFAULT => -187
	},
	{#State 253
		ACTIONS => {
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'WORD_SCOPED' => 9,
			'OP01_NAMED' => 80,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"<STDIN>" => 224,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73
		},
		GOTOS => {
			'Expression' => 225,
			'ExpressionOrStdin' => 286,
			'WordScoped' => 50,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'HashReference' => 56,
			'ArrayReference' => 83,
			'Variable' => 97
		}
	},
	{#State 254
		DEFAULT => -220
	},
	{#State 255
		ACTIONS => {
			";" => 287
		}
	},
	{#State 256
		DEFAULT => -221
	},
	{#State 257
		DEFAULT => -134
	},
	{#State 258
		ACTIONS => {
			"{" => 238
		},
		GOTOS => {
			'CodeBlock' => 288
		}
	},
	{#State 259
		ACTIONS => {
			"(" => 289
		}
	},
	{#State 260
		ACTIONS => {
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP03_MATH_INC_DEC' => 70,
			"{" => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			'WORD_SCOPED' => 9,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'WordScoped' => 50,
			'Expression' => 290,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'HashReference' => 56,
			'Variable' => 97,
			'ArrayReference' => 83
		}
	},
	{#State 261
		ACTIONS => {
			'VARIABLE_SYMBOL' => 60
		},
		GOTOS => {
			'Variable' => 291
		}
	},
	{#State 262
		ACTIONS => {
			"/" => 292
		}
	},
	{#State 263
		DEFAULT => -102
	},
	{#State 264
		ACTIONS => {
			'WORD_SCOPED' => 9,
			'OP01_NAMED_QW' => 113,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'OP01_NAMED' => 80,
			"my" => 110,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			")" => -142,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'KEYS_OR_VALUES' => 112,
			'OP03_MATH_INC_DEC' => 70
		},
		GOTOS => {
			'Variable' => 97,
			'ArrayReference' => 83,
			'OPTIONAL-48' => 294,
			'HashReference' => 56,
			'ListElements' => 293,
			'TypeInner' => 108,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'ListElement' => 115,
			'WordScoped' => 50,
			'Expression' => 114
		}
	},
	{#State 265
		DEFAULT => -190
	},
	{#State 266
		DEFAULT => -189
	},
	{#State 267
		DEFAULT => -137
	},
	{#State 268
		ACTIONS => {
			'LITERAL_STRING' => -54,
			"undef" => -54,
			'OP10_NAMED_UNARY' => -54,
			'OP03_MATH_INC_DEC' => -54,
			"if (" => -54,
			'OP01_NAMED_VOID_PAREN' => -54,
			"{" => -54,
			"(" => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			'VARIABLE_SYMBOL' => -54,
			"[" => -54,
			"while (" => -54,
			"%{" => -54,
			'OP22_LOGICAL_NOT' => -54,
			"for my integer" => -54,
			"my" => -54,
			'OP01_NAMED' => -54,
			'OP05_LOGICAL_NEG' => -54,
			'WORD' => -54,
			"foreach my" => -54,
			'WORD_SCOPED' => -54,
			'OP01_NAMED_VOID' => -54,
			'LITERAL_NUMBER' => -54,
			"\@{" => -54,
			'OP05_MATH_NEG' => -54,
			"( my" => 296,
			'OP19_LOOP_CONTROL' => -54
		},
		GOTOS => {
			'OPTIONAL-21' => 295,
			'SubroutineArguments' => 297
		}
	},
	{#State 269
		DEFAULT => -50
	},
	{#State 270
		ACTIONS => {
			'LITERAL_NUMBER' => -37,
			"my" => 110,
			'LITERAL_STRING' => -37
		},
		GOTOS => {
			'OPTIONAL-13' => 298,
			'TypeInner' => 299
		}
	},
	{#State 271
		ACTIONS => {
			";" => 300
		}
	},
	{#State 272
		ACTIONS => {
			'WORD' => 301
		}
	},
	{#State 273
		ACTIONS => {
			"fuse" => -71,
			"our %properties = (" => -71,
			"## no critic qw(" => 21,
			'USE_CONSTANT' => -71
		},
		GOTOS => {
			'STAR-29' => 303,
			'Critic' => 302
		}
	},
	{#State 274
		ACTIONS => {
			"}" => -170,
			'OP22_LOGICAL_NOT' => -170,
			"%{" => -170,
			'VARIABLE_SYMBOL' => -170,
			"[" => -170,
			"while (" => -170,
			'OP05_LOGICAL_NEG' => -170,
			'WORD' => -170,
			"my" => -170,
			"for my integer" => -170,
			"else" => 305,
			"elsif (" => 304,
			'OP01_NAMED' => -170,
			'WORD_SCOPED' => -170,
			"foreach my" => -170,
			'OP05_MATH_NEG' => -170,
			"\@{" => -170,
			'LITERAL_NUMBER' => -170,
			'OP19_LOOP_CONTROL' => -170,
			'OP01_NAMED_VOID' => -170,
			"undef" => -170,
			'OP10_NAMED_UNARY' => -170,
			'LITERAL_STRING' => -170,
			'OP03_MATH_INC_DEC' => -170,
			"if (" => -170,
			"{" => -170,
			'OP01_NAMED_VOID_PAREN' => -170,
			'OP10_NAMED_UNARY_STRINGIFY' => -170,
			'' => -170,
			"(" => -170
		},
		GOTOS => {
			'PAREN-51' => 307,
			'OPTIONAL-54' => 306,
			'PAREN-53' => 308
		}
	},
	{#State 275
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => 71,
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			"if (" => 52,
			'OP03_MATH_INC_DEC' => 70,
			"foreach my" => -159,
			'WORD_SCOPED' => 9,
			'OP01_NAMED_VOID' => 87,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'OP19_LOOP_CONTROL' => 84,
			'VARIABLE_SYMBOL' => 60,
			"while (" => -159,
			"[" => 59,
			"}" => 309,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			"my" => 63,
			"for my integer" => -159,
			'OP01_NAMED' => 80,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 78
		},
		GOTOS => {
			'Expression' => 79,
			'PAREN-49' => 62,
			'VariableModification' => 61,
			'Operator' => 76,
			'ArrayDereferenced' => 74,
			'OPTIONAL-50' => 75,
			'Statement' => 72,
			'Operation' => 310,
			'ArrayReference' => 83,
			'Variable' => 81,
			'VariableDeclaration' => 82,
			'LoopLabel' => 64,
			'OperatorVoid' => 51,
			'WordScoped' => 50,
			'HashDereferenced' => 69,
			'Literal' => 68,
			'HashReference' => 56,
			'Conditional' => 54
		}
	},
	{#State 276
		DEFAULT => -179
	},
	{#State 277
		DEFAULT => -212
	},
	{#State 278
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 140,
			"}" => -208,
			'OP18_TERNARY' => 141,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP17_LIST_RANGE' => 144,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP13_BITWISE_AND' => 147,
			'OP08_STRING_CAT' => 148,
			'OP21_LIST_COMMA' => -208,
			'OP15_LOGICAL_AND' => 153,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP16_LOGICAL_OR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP23_LOGICAL_AND' => 151,
			'OP06_REGEX_MATCH' => 156
		}
	},
	{#State 279
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 311
		}
	},
	{#State 280
		DEFAULT => -194
	},
	{#State 281
		DEFAULT => -197
	},
	{#State 282
		DEFAULT => -191
	},
	{#State 283
		DEFAULT => -185
	},
	{#State 284
		DEFAULT => -186
	},
	{#State 285
		DEFAULT => -184
	},
	{#State 286
		ACTIONS => {
			";" => 312
		}
	},
	{#State 287
		DEFAULT => -135
	},
	{#State 288
		DEFAULT => -177
	},
	{#State 289
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'OP01_NAMED' => 80,
			"my" => 110,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED_QW' => 113,
			'WORD_SCOPED' => 9,
			'KEYS_OR_VALUES' => 112,
			'OP03_MATH_INC_DEC' => 70,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53
		},
		GOTOS => {
			'HashDereferenced' => 69,
			'Operator' => 76,
			'ArrayDereferenced' => 74,
			'ListElement' => 115,
			'Literal' => 68,
			'Expression' => 114,
			'WordScoped' => 50,
			'ArrayReference' => 83,
			'Variable' => 97,
			'HashReference' => 56,
			'ListElements' => 313,
			'TypeInner' => 108
		}
	},
	{#State 290
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 154,
			'OP08_STRING_CAT' => 148,
			'OP15_LOGICAL_AND' => 153,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => 144,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP11_COMPARE_LT_GT' => 142,
			'OP18_TERNARY' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			".." => 314,
			'OP13_BITWISE_AND' => 147,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146
		}
	},
	{#State 291
		DEFAULT => -122
	},
	{#State 292
		DEFAULT => -108
	},
	{#State 293
		DEFAULT => -141
	},
	{#State 294
		ACTIONS => {
			")" => 315
		}
	},
	{#State 295
		ACTIONS => {
			'OP01_NAMED_VOID' => 87,
			"\@{" => 65,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			'OP19_LOOP_CONTROL' => 84,
			"foreach my" => -159,
			'WORD_SCOPED' => 9,
			"for my integer" => -159,
			"my" => 63,
			'OP01_NAMED' => 80,
			'WORD' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"while (" => -159,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			'OP01_NAMED_VOID_PAREN' => 71,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			"if (" => 52,
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47
		},
		GOTOS => {
			'Operation' => 316,
			'LoopLabel' => 64,
			'Variable' => 81,
			'VariableDeclaration' => 82,
			'ArrayReference' => 83,
			'PAREN-49' => 62,
			'Expression' => 79,
			'Statement' => 72,
			'OPTIONAL-50' => 75,
			'ArrayDereferenced' => 74,
			'Operator' => 76,
			'VariableModification' => 61,
			'Conditional' => 54,
			'HashReference' => 56,
			'PLUS-22' => 317,
			'WordScoped' => 50,
			'OperatorVoid' => 51,
			'Literal' => 68,
			'HashDereferenced' => 69
		}
	},
	{#State 296
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 318
		}
	},
	{#State 297
		DEFAULT => -53
	},
	{#State 298
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 49
		},
		GOTOS => {
			'Literal' => 319
		}
	},
	{#State 299
		DEFAULT => -36
	},
	{#State 300
		DEFAULT => -35
	},
	{#State 301
		ACTIONS => {
			'OP20_HASH_FATARROW' => 320
		}
	},
	{#State 302
		DEFAULT => -68
	},
	{#State 303
		ACTIONS => {
			"fuse" => 29,
			"our %properties = (" => -73,
			'USE_CONSTANT' => -73
		},
		GOTOS => {
			'Include' => 321,
			'STAR-30' => 322
		}
	},
	{#State 304
		ACTIONS => {
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			"[" => 59,
			'VARIABLE_SYMBOL' => 60,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			'WORD_SCOPED' => 9,
			'OP03_MATH_INC_DEC' => 70,
			'OP10_NAMED_UNARY' => 47,
			"undef" => 48,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53
		},
		GOTOS => {
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'WordScoped' => 50,
			'Expression' => 323
		}
	},
	{#State 305
		ACTIONS => {
			"{" => 238
		},
		GOTOS => {
			'CodeBlock' => 324
		}
	},
	{#State 306
		DEFAULT => -171
	},
	{#State 307
		DEFAULT => -166
	},
	{#State 308
		DEFAULT => -169
	},
	{#State 309
		DEFAULT => -180
	},
	{#State 310
		DEFAULT => -178
	},
	{#State 311
		DEFAULT => -222
	},
	{#State 312
		DEFAULT => -188
	},
	{#State 313
		ACTIONS => {
			")" => 325
		}
	},
	{#State 314
		ACTIONS => {
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'WORD_SCOPED' => 9,
			'OP01_NAMED' => 80,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58
		},
		GOTOS => {
			'Expression' => 326,
			'WordScoped' => 50,
			'Literal' => 68,
			'ArrayDereferenced' => 74,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'HashReference' => 56,
			'ArrayReference' => 83,
			'Variable' => 97
		}
	},
	{#State 315
		DEFAULT => -153
	},
	{#State 316
		DEFAULT => -56
	},
	{#State 317
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 70,
			"if (" => 52,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53,
			'OP01_NAMED_VOID_PAREN' => 71,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 78,
			"for my integer" => -159,
			"my" => 63,
			'OP01_NAMED' => 80,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			"}" => 327,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"while (" => -159,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			'OP19_LOOP_CONTROL' => 84,
			'OP01_NAMED_VOID' => 87,
			'WORD_SCOPED' => 9,
			"foreach my" => -159
		},
		GOTOS => {
			'Operation' => 328,
			'ArrayReference' => 83,
			'VariableDeclaration' => 82,
			'Variable' => 81,
			'LoopLabel' => 64,
			'Expression' => 79,
			'PAREN-49' => 62,
			'Operator' => 76,
			'VariableModification' => 61,
			'ArrayDereferenced' => 74,
			'OPTIONAL-50' => 75,
			'Statement' => 72,
			'HashReference' => 56,
			'Conditional' => 54,
			'OperatorVoid' => 51,
			'WordScoped' => 50,
			'HashDereferenced' => 69,
			'Literal' => 68
		}
	},
	{#State 318
		ACTIONS => {
			'VARIABLE_SYMBOL' => 329
		}
	},
	{#State 319
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 330
		}
	},
	{#State 320
		ACTIONS => {
			'LITERAL_STRING' => -44,
			"my" => 110,
			'LITERAL_NUMBER' => -44
		},
		GOTOS => {
			'OPTIONAL-17' => 332,
			'TypeInner' => 331
		}
	},
	{#State 321
		DEFAULT => -70
	},
	{#State 322
		ACTIONS => {
			'USE_CONSTANT' => 41,
			"our %properties = (" => 334
		},
		GOTOS => {
			'Properties' => 335,
			'Constant' => 333
		}
	},
	{#State 323
		ACTIONS => {
			'OP18_TERNARY' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP17_LIST_RANGE' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP08_STRING_CAT' => 148,
			")" => 336,
			'OP15_LOGICAL_AND' => 153,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => 149,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => 151
		}
	},
	{#State 324
		DEFAULT => -168
	},
	{#State 325
		ACTIONS => {
			"{" => 238
		},
		GOTOS => {
			'CodeBlock' => 337
		}
	},
	{#State 326
		ACTIONS => {
			'OP17_LIST_RANGE' => 144,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP11_COMPARE_LT_GT' => 142,
			'OP18_TERNARY' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP13_BITWISE_AND' => 147,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP08_STRING_CAT' => 148,
			")" => 338,
			'OP15_LOGICAL_AND' => 153,
			'OP06_REGEX_MATCH' => 156,
			'OP23_LOGICAL_AND' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP16_LOGICAL_OR' => 149
		}
	},
	{#State 327
		ACTIONS => {
			";" => 339
		}
	},
	{#State 328
		DEFAULT => -55
	},
	{#State 329
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 340
		}
	},
	{#State 330
		ACTIONS => {
			"]" => 342,
			'OP21_LIST_COMMA' => 343
		},
		GOTOS => {
			'PAREN-15' => 341
		}
	},
	{#State 331
		DEFAULT => -43
	},
	{#State 332
		ACTIONS => {
			'LITERAL_STRING' => 49,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 344
		}
	},
	{#State 333
		DEFAULT => -72
	},
	{#State 334
		ACTIONS => {
			'WORD' => 345,
			"%{" => 73,
			")" => 348
		},
		GOTOS => {
			'HashEntryTyped' => 346,
			'HashDereferenced' => 347
		}
	},
	{#State 335
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 349
		}
	},
	{#State 336
		ACTIONS => {
			"{" => 238
		},
		GOTOS => {
			'CodeBlock' => 350
		}
	},
	{#State 337
		DEFAULT => -176
	},
	{#State 338
		ACTIONS => {
			"{" => 238
		},
		GOTOS => {
			'CodeBlock' => 351
		}
	},
	{#State 339
		DEFAULT => -57
	},
	{#State 340
		ACTIONS => {
			'OP21_LIST_COMMA' => 353,
			")" => 352
		},
		GOTOS => {
			'PAREN-23' => 354
		}
	},
	{#State 341
		DEFAULT => -41
	},
	{#State 342
		DEFAULT => -51
	},
	{#State 343
		ACTIONS => {
			'LITERAL_STRING' => -39,
			'LITERAL_NUMBER' => -39,
			"my" => 110
		},
		GOTOS => {
			'TypeInner' => 356,
			'OPTIONAL-14' => 355
		}
	},
	{#State 344
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 357
		}
	},
	{#State 345
		ACTIONS => {
			'OP20_HASH_FATARROW' => 358
		}
	},
	{#State 346
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 359
		}
	},
	{#State 347
		DEFAULT => -211
	},
	{#State 348
		ACTIONS => {
			";" => 360
		}
	},
	{#State 349
		ACTIONS => {
			"our" => 363,
			"1;" => 361
		},
		GOTOS => {
			'Method' => 362
		}
	},
	{#State 350
		DEFAULT => -165
	},
	{#State 351
		DEFAULT => -175
	},
	{#State 352
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 364
		}
	},
	{#State 353
		ACTIONS => {
			"my" => 365
		}
	},
	{#State 354
		DEFAULT => -59
	},
	{#State 355
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 49
		},
		GOTOS => {
			'Literal' => 366
		}
	},
	{#State 356
		DEFAULT => -38
	},
	{#State 357
		ACTIONS => {
			'OP21_LIST_COMMA' => 369,
			"}" => 367
		},
		GOTOS => {
			'PAREN-19' => 368
		}
	},
	{#State 358
		ACTIONS => {
			"my" => 110
		},
		GOTOS => {
			'TypeInner' => 370
		}
	},
	{#State 359
		ACTIONS => {
			")" => 371,
			'OP21_LIST_COMMA' => 372
		},
		GOTOS => {
			'PAREN-35' => 373
		}
	},
	{#State 360
		DEFAULT => -86
	},
	{#State 361
		ACTIONS => {
			"1;" => 374
		}
	},
	{#State 362
		DEFAULT => -74
	},
	{#State 363
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 375
		}
	},
	{#State 364
		ACTIONS => {
			"\@_;" => 376
		}
	},
	{#State 365
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 377
		}
	},
	{#State 366
		DEFAULT => -40
	},
	{#State 367
		DEFAULT => -52
	},
	{#State 368
		DEFAULT => -48
	},
	{#State 369
		ACTIONS => {
			'WORD' => 378
		}
	},
	{#State 370
		ACTIONS => {
			'WORD_SCOPED' => 9,
			'OP05_MATH_NEG' => 66,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'OP01_NAMED' => 80,
			"{" => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP03_MATH_INC_DEC' => 70
		},
		GOTOS => {
			'HashReference' => 56,
			'ArrayReference' => 83,
			'Variable' => 97,
			'Expression' => 379,
			'WordScoped' => 50,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'ArrayDereferenced' => 74,
			'Literal' => 68
		}
	},
	{#State 371
		ACTIONS => {
			";" => 380
		}
	},
	{#State 372
		ACTIONS => {
			'WORD' => 345,
			"%{" => 73
		},
		GOTOS => {
			'HashEntryTyped' => 381,
			'HashDereferenced' => 347
		}
	},
	{#State 373
		DEFAULT => -83
	},
	{#State 374
		ACTIONS => {
			"package" => -80,
			'' => -80,
			"our" => 88
		},
		GOTOS => {
			'OPTIONAL-34' => 383,
			'PLUS-32' => 384,
			'PAREN-33' => 385,
			'Subroutine' => 382
		}
	},
	{#State 375
		ACTIONS => {
			'VARIABLE_SYMBOL' => 386
		}
	},
	{#State 376
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 387
		}
	},
	{#State 377
		ACTIONS => {
			'VARIABLE_SYMBOL' => 388
		}
	},
	{#State 378
		ACTIONS => {
			'OP20_HASH_FATARROW' => 389
		}
	},
	{#State 379
		ACTIONS => {
			'OP23_LOGICAL_AND' => 151,
			'OP06_REGEX_MATCH' => 156,
			'OP16_LOGICAL_OR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP08_STRING_CAT' => 148,
			")" => -210,
			'OP21_LIST_COMMA' => -210,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 147,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP17_LIST_RANGE' => 144,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 141
		}
	},
	{#State 380
		DEFAULT => -85
	},
	{#State 381
		DEFAULT => -82
	},
	{#State 382
		DEFAULT => -77
	},
	{#State 383
		DEFAULT => -81
	},
	{#State 384
		ACTIONS => {
			"our" => 88,
			"1;" => 391
		},
		GOTOS => {
			'Subroutine' => 390
		}
	},
	{#State 385
		DEFAULT => -79
	},
	{#State 386
		ACTIONS => {
			"= sub {" => 392
		}
	},
	{#State 387
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			"(" => -63,
			"{" => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			'OP03_MATH_INC_DEC' => -63,
			"if (" => -63,
			"undef" => -63,
			'OP10_NAMED_UNARY' => -63,
			'LITERAL_STRING' => -63,
			"\@{" => -63,
			'OP05_MATH_NEG' => -63,
			'LITERAL_NUMBER' => -63,
			'OP19_LOOP_CONTROL' => -63,
			'CHECK_OR_CHECKTRACE' => 394,
			'OP01_NAMED_VOID' => -63,
			'WORD_SCOPED' => -63,
			"foreach my" => -63,
			'WORD' => -63,
			'OP05_LOGICAL_NEG' => -63,
			"for my integer" => -63,
			"my" => -63,
			'OP01_NAMED' => -63,
			'OP22_LOGICAL_NOT' => -63,
			"%{" => -63,
			'VARIABLE_SYMBOL' => -63,
			"[" => -63,
			"while (" => -63
		},
		GOTOS => {
			'ArgumentCheck' => 393
		}
	},
	{#State 388
		DEFAULT => -58
	},
	{#State 389
		ACTIONS => {
			'LITERAL_STRING' => -46,
			"my" => 110,
			'LITERAL_NUMBER' => -46
		},
		GOTOS => {
			'OPTIONAL-18' => 395,
			'TypeInner' => 396
		}
	},
	{#State 390
		DEFAULT => -76
	},
	{#State 391
		ACTIONS => {
			"1;" => 397
		}
	},
	{#State 392
		ACTIONS => {
			'OP01_NAMED_VOID' => -88,
			'OP19_LOOP_CONTROL' => -88,
			"( my" => 399,
			'LITERAL_NUMBER' => -88,
			"\@{" => -88,
			'OP05_MATH_NEG' => -88,
			"foreach my" => -88,
			'WORD_SCOPED' => -88,
			'OP01_NAMED' => -88,
			"for my integer" => -88,
			"my" => -88,
			'WORD' => -88,
			'OP05_LOGICAL_NEG' => -88,
			"[" => -88,
			"while (" => -88,
			'VARIABLE_SYMBOL' => -88,
			'OP22_LOGICAL_NOT' => -88,
			"%{" => -88,
			"(" => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			'OP01_NAMED_VOID_PAREN' => -88,
			"{" => -88,
			"if (" => -88,
			'OP03_MATH_INC_DEC' => -88,
			'LITERAL_STRING' => -88,
			'OP10_NAMED_UNARY' => -88,
			"undef" => -88
		},
		GOTOS => {
			'OPTIONAL-37' => 400,
			'MethodArguments' => 398
		}
	},
	{#State 393
		DEFAULT => -61
	},
	{#State 394
		ACTIONS => {
			"(" => 401
		}
	},
	{#State 395
		ACTIONS => {
			'LITERAL_STRING' => 49,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 402
		}
	},
	{#State 396
		DEFAULT => -45
	},
	{#State 397
		DEFAULT => -78
	},
	{#State 398
		DEFAULT => -87
	},
	{#State 399
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 403
		}
	},
	{#State 400
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"while (" => -159,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 78,
			"my" => 63,
			"for my integer" => -159,
			'OP01_NAMED' => 80,
			'WORD_SCOPED' => 9,
			"foreach my" => -159,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'OP19_LOOP_CONTROL' => 84,
			'OP01_NAMED_VOID' => 87,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP03_MATH_INC_DEC' => 70,
			"if (" => 52,
			"{" => 53,
			'OP01_NAMED_VOID_PAREN' => 71,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57
		},
		GOTOS => {
			'Literal' => 68,
			'HashDereferenced' => 69,
			'OperatorVoid' => 51,
			'WordScoped' => 50,
			'HashReference' => 56,
			'Conditional' => 54,
			'ArrayDereferenced' => 74,
			'OPTIONAL-50' => 75,
			'VariableModification' => 61,
			'Operator' => 76,
			'Statement' => 72,
			'Expression' => 79,
			'PLUS-38' => 405,
			'PAREN-49' => 62,
			'ArrayReference' => 83,
			'LoopLabel' => 64,
			'VariableDeclaration' => 82,
			'Variable' => 81,
			'Operation' => 404
		}
	},
	{#State 401
		ACTIONS => {
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'WORD_SCOPED' => 9,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49
		},
		GOTOS => {
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56,
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'WordScoped' => 50,
			'Expression' => 406
		}
	},
	{#State 402
		DEFAULT => -47
	},
	{#State 403
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 407
		}
	},
	{#State 404
		DEFAULT => -90
	},
	{#State 405
		ACTIONS => {
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			"while (" => -159,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			"}" => 408,
			"my" => 63,
			"for my integer" => -159,
			'OP01_NAMED' => 80,
			'WORD' => 78,
			'OP05_LOGICAL_NEG' => 77,
			"foreach my" => -159,
			'WORD_SCOPED' => 9,
			'OP01_NAMED_VOID' => 87,
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			'OP19_LOOP_CONTROL' => 84,
			'LITERAL_STRING' => 49,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'OP03_MATH_INC_DEC' => 70,
			"if (" => 52,
			'OP01_NAMED_VOID_PAREN' => 71,
			"{" => 53,
			"(" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 55
		},
		GOTOS => {
			'PAREN-49' => 62,
			'Expression' => 79,
			'Statement' => 72,
			'ArrayDereferenced' => 74,
			'OPTIONAL-50' => 75,
			'VariableModification' => 61,
			'Operator' => 76,
			'Operation' => 409,
			'LoopLabel' => 64,
			'Variable' => 81,
			'VariableDeclaration' => 82,
			'ArrayReference' => 83,
			'WordScoped' => 50,
			'OperatorVoid' => 51,
			'Literal' => 68,
			'HashDereferenced' => 69,
			'Conditional' => 54,
			'HashReference' => 56
		}
	},
	{#State 406
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 147,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 141,
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP11_COMPARE_LT_GT' => 142,
			'OP17_LIST_RANGE' => 144,
			'OP16_LOGICAL_OR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP23_LOGICAL_AND' => 151,
			'OP06_REGEX_MATCH' => 156,
			'OP21_LIST_COMMA' => 411,
			")" => -66,
			'OP15_LOGICAL_AND' => 153,
			'OP08_STRING_CAT' => 148,
			'OP14_BITWISE_OR_XOR' => 154
		},
		GOTOS => {
			'PAREN-26' => 410,
			'OPTIONAL-27' => 412
		}
	},
	{#State 407
		ACTIONS => {
			'OP21_LIST_COMMA' => 413,
			")" => 415
		},
		GOTOS => {
			'PAREN-39' => 414
		}
	},
	{#State 408
		ACTIONS => {
			";" => 416
		}
	},
	{#State 409
		DEFAULT => -89
	},
	{#State 410
		DEFAULT => -65
	},
	{#State 411
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 70,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_NAMED' => 80,
			"%{" => 73,
			'OP22_LOGICAL_NOT' => 58,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'OP05_MATH_NEG' => 66,
			'LITERAL_NUMBER' => 86,
			"\@{" => 65,
			'WORD_SCOPED' => 9
		},
		GOTOS => {
			'HashReference' => 56,
			'ArrayReference' => 83,
			'Variable' => 97,
			'Expression' => 417,
			'WordScoped' => 50,
			'HashDereferenced' => 69,
			'Operator' => 76,
			'ArrayDereferenced' => 74,
			'Literal' => 68
		}
	},
	{#State 412
		ACTIONS => {
			")" => 418
		}
	},
	{#State 413
		ACTIONS => {
			"my" => 419
		}
	},
	{#State 414
		DEFAULT => -93
	},
	{#State 415
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 420
		}
	},
	{#State 416
		DEFAULT => -91
	},
	{#State 417
		ACTIONS => {
			'OP23_LOGICAL_AND' => 151,
			'OP06_REGEX_MATCH' => 156,
			'OP16_LOGICAL_OR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP08_STRING_CAT' => 148,
			'OP21_LIST_COMMA' => 421,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 147,
			'OP08_MATH_ADD_SUB' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 142,
			'OP17_LIST_RANGE' => 144,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 141
		}
	},
	{#State 418
		ACTIONS => {
			";" => 422
		}
	},
	{#State 419
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 423
		}
	},
	{#State 420
		ACTIONS => {
			"\@_;" => 424
		}
	},
	{#State 421
		ACTIONS => {
			"\@{" => 65,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG' => 66,
			'WORD_SCOPED' => 9,
			'OP05_LOGICAL_NEG' => 77,
			'WORD' => 10,
			'OP01_NAMED' => 80,
			'OP22_LOGICAL_NOT' => 58,
			"%{" => 73,
			'VARIABLE_SYMBOL' => 60,
			"[" => 59,
			'OP10_NAMED_UNARY_STRINGIFY' => 55,
			"(" => 57,
			"{" => 53,
			'OP03_MATH_INC_DEC' => 70,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 47,
			'LITERAL_STRING' => 49
		},
		GOTOS => {
			'ArrayDereferenced' => 74,
			'Literal' => 68,
			'Operator' => 76,
			'HashDereferenced' => 69,
			'WordScoped' => 50,
			'Expression' => 425,
			'Variable' => 97,
			'ArrayReference' => 83,
			'HashReference' => 56
		}
	},
	{#State 422
		DEFAULT => -67
	},
	{#State 423
		ACTIONS => {
			'VARIABLE_SYMBOL' => 426
		}
	},
	{#State 424
		DEFAULT => -96,
		GOTOS => {
			'STAR-41' => 427
		}
	},
	{#State 425
		ACTIONS => {
			'OP04_MATH_POW' => 152,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP11_COMPARE_LT_GT' => 142,
			'OP17_LIST_RANGE' => 144,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 141,
			'OP13_BITWISE_AND' => 147,
			'OP09_BITWISE_SHIFT' => 146,
			'OP08_MATH_ADD_SUB' => 145,
			'OP14_BITWISE_OR_XOR' => 154,
			'OP08_STRING_CAT' => 148,
			'OP15_LOGICAL_AND' => 153,
			")" => -64,
			'OP23_LOGICAL_AND' => 151,
			'OP06_REGEX_MATCH' => 156,
			'OP16_LOGICAL_OR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 150
		}
	},
	{#State 426
		DEFAULT => -92
	},
	{#State 427
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -97,
			"if (" => -97,
			'LITERAL_STRING' => -97,
			"undef" => -97,
			'OP10_NAMED_UNARY' => -97,
			"(" => -97,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			"{" => -97,
			"for my integer" => -97,
			"my" => -97,
			'OP01_NAMED' => -97,
			'WORD' => -97,
			'OP05_LOGICAL_NEG' => -97,
			'VARIABLE_SYMBOL' => -97,
			"while (" => -97,
			"[" => -97,
			'OP22_LOGICAL_NOT' => -97,
			"%{" => -97,
			'OP01_NAMED_VOID' => -97,
			'CHECK_OR_CHECKTRACE' => 394,
			"\@{" => -97,
			'LITERAL_NUMBER' => -97,
			'OP05_MATH_NEG' => -97,
			'OP19_LOOP_CONTROL' => -97,
			"foreach my" => -97,
			'WORD_SCOPED' => -97
		},
		GOTOS => {
			'ArgumentCheck' => 428
		}
	},
	{#State 428
		DEFAULT => -95
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5621 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5628 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5635 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5646 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5657 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5664 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5671 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5678 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5685 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5692 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5699 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5706 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5713 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5720 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5727 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5738 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5749 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5760 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5767 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5774 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5781 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5788 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5795 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5802 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5809 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5816 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5838 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5845 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5852 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5863 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5877 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5888 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5899 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5910 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5917 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5924 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5931 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5938 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5945 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5952 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5973 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5980 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5987 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5994 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6001 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6008 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6019 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6030 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6041 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6048 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6055 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6062 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6069 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6080 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6087 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6094 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6108 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6115 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6126 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6140 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6147 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6172 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6179 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6186 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6193 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6200 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6207 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6214 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6221 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6228 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 3,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6235 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6242 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 18,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6260 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6267 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6274 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6281 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6303 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6310 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6317 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6324 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6331 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6342 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6349 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6356 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6363 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6370 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6377 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6388 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6399 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6410 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6417 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6446 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6457 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6468 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6479 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6490 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6501 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6512 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6523 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6534 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6556 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6600 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6611 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6622 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6633 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6644 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6655 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6666 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6677 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6688 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6695 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6755 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6766 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6777 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6788 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6799 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6806 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6813 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6820 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6827 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6838 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6849 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6860 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6871 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6904 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6926 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6937 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6948 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_155
		 'ExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6970 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_156
		 'ExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6981 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6988 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7035 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_163
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7046 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_164
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7092 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7099 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_171
		 'Conditional', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7110 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7121 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_173
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7132 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_174
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7143 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_175
		 'LoopFor', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_176
		 'LoopForEach', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7165 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_177
		 'LoopWhile', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7176 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7190 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_180
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7208 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7215 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_183
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7226 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7237 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_185
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7248 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_186
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7259 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_187
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7270 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_188
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7281 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_189
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_190
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7303 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7324 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7331 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_196
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7349 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_197
		 'ListElements', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7360 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_198
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7371 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_199
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7382 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_200
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7393 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7400 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7407 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_203
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7418 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_204
		 'ArrayDereferenced', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7429 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_205
		 'ArrayDereferenced', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7447 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7454 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_208
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7465 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_209
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7476 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_210
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7487 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_211
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7498 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-62', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7512 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_215
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_216
		 'HashDereferenced', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_217
		 'HashDereferenced', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7552 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_218
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7563 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_219
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7574 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_220
		 'FileHandle', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7585 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_221
		 'FileHandle', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7596 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_222
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule Type_223
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7618 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_224
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_225
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_226
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7651 lib/RPerl/Grammar.pm
	]
],
#line 7654 lib/RPerl/Grammar.pm
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

#line 189 "lib/RPerl/Grammar.eyp"


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


#line 7929 lib/RPerl/Grammar.pm



1;
