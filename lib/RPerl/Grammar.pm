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
    our $VERSION = 0.000_733;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

       m{\G((\s*\#[^\#\!].+\s*)+)}gc and $self->tokenline($1 =~ tr{\n}{}) ;

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|\#\!\/usr\/bin\/perl|for\ my\ integer|filehandle_ref|foreach\ my|elsif\ \(|package|\$TYPED_|while\ \(|\<STDIN\>|\=\ sub\ \{|undef|\(\ my|if\ \(|fuse|else|\@_\;|qw\(|our|1\;|\.\.|my|\@\{|\{\*|\%\{|\{|\]|\)|\;|\(|\[|\/|\})}gc and return ($1, $1);

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
			"#!/usr/bin/perl" => 2,
			"package" => 8
		},
		GOTOS => {
			'Module' => 3,
			'PLUS-1' => 1,
			'Package' => 4,
			'Program' => 6,
			'CompileUnit' => 5,
			'Class' => 7
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 8,
			'' => -4
		},
		GOTOS => {
			'Module' => 9,
			'Package' => 4,
			'Class' => 7
		}
	},
	{#State 2
		ACTIONS => {
			'USE_STRICT' => 10
		},
		GOTOS => {
			'Header' => 11
		}
	},
	{#State 3
		DEFAULT => -2
	},
	{#State 4
		DEFAULT => -16
	},
	{#State 5
		ACTIONS => {
			'' => 12
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		DEFAULT => -17
	},
	{#State 8
		ACTIONS => {
			'WORD_SCOPED' => 15,
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 14
		}
	},
	{#State 9
		DEFAULT => -1
	},
	{#State 10
		ACTIONS => {
			'USE_WARNINGS' => 16
		}
	},
	{#State 11
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 17
		}
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		DEFAULT => -218
	},
	{#State 14
		ACTIONS => {
			";" => 18
		}
	},
	{#State 15
		DEFAULT => -219
	},
	{#State 16
		ACTIONS => {
			'USE_RPERL' => 19
		}
	},
	{#State 17
		ACTIONS => {
			'LITERAL_NUMBER' => -8,
			"fuse" => -8,
			'WORD_SCOPED' => -8,
			"while (" => -8,
			'VARIABLE_SYMBOL' => -8,
			'WORD' => -8,
			"{" => -8,
			"for my integer" => -8,
			"undef" => -8,
			'USE_CONSTANT' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			"our" => -8,
			"## no critic qw(" => 22,
			'OP19_LOOP_CONTROL' => -8,
			"%{" => -8,
			'OP03_MATH_INC_DEC' => -8,
			"[" => -8,
			'OP01_NAMED' => -8,
			'OP05_LOGICAL_NEG' => -8,
			"if (" => -8,
			'OP10_NAMED_UNARY' => -8,
			"\@{" => -8,
			'OP22_LOGICAL_NOT' => -8,
			'LITERAL_STRING' => -8,
			'OP01_NAMED_VOID' => -8,
			"my" => -8,
			"foreach my" => -8,
			"(" => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			'OP05_MATH_NEG' => -8
		},
		GOTOS => {
			'STAR-3' => 21,
			'Critic' => 20
		}
	},
	{#State 18
		ACTIONS => {
			'USE_STRICT' => 10
		},
		GOTOS => {
			'Header' => 23
		}
	},
	{#State 19
		ACTIONS => {
			"our" => 24
		}
	},
	{#State 20
		DEFAULT => -5
	},
	{#State 21
		ACTIONS => {
			"while (" => -10,
			'VARIABLE_SYMBOL' => -10,
			'LITERAL_NUMBER' => -10,
			'WORD_SCOPED' => -10,
			"fuse" => 25,
			'OP19_LOOP_CONTROL' => -10,
			"%{" => -10,
			'USE_CONSTANT' => -10,
			"our" => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			"for my integer" => -10,
			"undef" => -10,
			'WORD' => -10,
			"{" => -10,
			'LITERAL_STRING' => -10,
			'OP01_NAMED_VOID' => -10,
			'OP10_NAMED_UNARY' => -10,
			"\@{" => -10,
			'OP22_LOGICAL_NOT' => -10,
			'OP05_LOGICAL_NEG' => -10,
			"if (" => -10,
			'OP03_MATH_INC_DEC' => -10,
			"[" => -10,
			'OP01_NAMED' => -10,
			'OP05_MATH_NEG' => -10,
			"(" => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"foreach my" => -10,
			"my" => -10
		},
		GOTOS => {
			'STAR-4' => 27,
			'Include' => 26
		}
	},
	{#State 22
		ACTIONS => {
			'WORD' => 28
		},
		GOTOS => {
			'PLUS-11' => 29
		}
	},
	{#State 23
		ACTIONS => {
			"fuse" => -19,
			'USE_PARENT' => 31,
			'USE_CONSTANT' => -19,
			"our" => -19,
			"## no critic qw(" => -19
		},
		GOTOS => {
			'STAR-7' => 30
		}
	},
	{#State 24
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 32
		}
	},
	{#State 25
		ACTIONS => {
			'WORD' => 13,
			'WORD_SCOPED' => 15
		},
		GOTOS => {
			'WordScoped' => 33
		}
	},
	{#State 26
		DEFAULT => -7
	},
	{#State 27
		ACTIONS => {
			"my" => -12,
			"foreach my" => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			"(" => -12,
			'OP05_MATH_NEG' => -12,
			'OP01_NAMED' => -12,
			"[" => -12,
			'OP03_MATH_INC_DEC' => -12,
			"if (" => -12,
			'OP05_LOGICAL_NEG' => -12,
			'OP22_LOGICAL_NOT' => -12,
			"\@{" => -12,
			'OP10_NAMED_UNARY' => -12,
			'LITERAL_STRING' => -12,
			'OP01_NAMED_VOID' => -12,
			"{" => -12,
			'WORD' => -12,
			"undef" => -12,
			"for my integer" => -12,
			"our" => -12,
			'USE_CONSTANT' => 36,
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			'OP19_LOOP_CONTROL' => -12,
			"%{" => -12,
			'WORD_SCOPED' => -12,
			'LITERAL_NUMBER' => -12,
			"while (" => -12,
			'VARIABLE_SYMBOL' => -12
		},
		GOTOS => {
			'Constant' => 34,
			'STAR-5' => 35
		}
	},
	{#State 28
		DEFAULT => -29
	},
	{#State 29
		ACTIONS => {
			")" => 37,
			'WORD' => 38
		}
	},
	{#State 30
		ACTIONS => {
			"our" => -21,
			'USE_CONSTANT' => -21,
			"## no critic qw(" => 22,
			"fuse" => -21
		},
		GOTOS => {
			'Critic' => 40,
			'STAR-8' => 39
		}
	},
	{#State 31
		ACTIONS => {
			"qw(" => 41
		}
	},
	{#State 32
		DEFAULT => -27
	},
	{#State 33
		ACTIONS => {
			"qw(" => 43,
			";" => 42
		}
	},
	{#State 34
		DEFAULT => -9
	},
	{#State 35
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			"while (" => -159,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			"%{" => 57,
			'OP19_LOOP_CONTROL' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"our" => 83,
			"undef" => 85,
			"for my integer" => -159,
			"{" => 86,
			'WORD' => 61,
			'OP01_NAMED_VOID' => 44,
			'LITERAL_STRING' => 62,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP10_NAMED_UNARY' => 65,
			"if (" => 47,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP05_MATH_NEG' => 70,
			'OP01_NAMED_VOID_PAREN' => 51,
			"(" => 73,
			"foreach my" => -159,
			"my" => 74
		},
		GOTOS => {
			'OperatorVoid' => 58,
			'PLUS-6' => 80,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'VariableDeclaration' => 84,
			'Operation' => 81,
			'Conditional' => 76,
			'VariableModification' => 56,
			'WordScoped' => 77,
			'Variable' => 55,
			'OPTIONAL-50' => 54,
			'ArrayReference' => 71,
			'LoopLabel' => 53,
			'Statement' => 72,
			'Expression' => 52,
			'HashReference' => 66,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'Subroutine' => 46,
			'PAREN-49' => 45
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 87
		}
	},
	{#State 37
		DEFAULT => -30
	},
	{#State 38
		DEFAULT => -28
	},
	{#State 39
		ACTIONS => {
			"fuse" => 25,
			"our" => -23,
			'USE_CONSTANT' => -23
		},
		GOTOS => {
			'STAR-9' => 89,
			'Include' => 88
		}
	},
	{#State 40
		DEFAULT => -18
	},
	{#State 41
		ACTIONS => {
			'WORD' => 13,
			'WORD_SCOPED' => 15
		},
		GOTOS => {
			'WordScoped' => 90
		}
	},
	{#State 42
		DEFAULT => -33
	},
	{#State 43
		ACTIONS => {
			'WORD' => 92
		},
		GOTOS => {
			'PLUS-12' => 91
		}
	},
	{#State 44
		ACTIONS => {
			"(" => 73,
			'OP01_NAMED_QW' => 103,
			'OP05_MATH_NEG' => 70,
			"my" => 101,
			";" => -131,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'LITERAL_STRING' => 62,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'KEYS_OR_VALUES' => 98,
			"%{" => 57,
			"{*" => 97,
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15
		},
		GOTOS => {
			'Variable' => 99,
			'ListElements' => 96,
			'HashReference' => 66,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'FileHandle' => 95,
			'Operator' => 79,
			'TypeInner' => 102,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Expression' => 94,
			'ListElement' => 100,
			'OPTIONAL-45' => 93
		}
	},
	{#State 45
		DEFAULT => -158
	},
	{#State 46
		DEFAULT => -11
	},
	{#State 47
		ACTIONS => {
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Expression' => 104,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Variable' => 99,
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'HashReference' => 66
		}
	},
	{#State 48
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			'WORD' => 13,
			"{" => 86,
			'LITERAL_STRING' => 62,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP05_MATH_NEG' => 70,
			"(" => 73
		},
		GOTOS => {
			'Expression' => 105,
			'Operator' => 79,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Variable' => 99,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'HashReference' => 66
		}
	},
	{#State 49
		DEFAULT => -149
	},
	{#State 50
		ACTIONS => {
			"(" => 106
		}
	},
	{#State 51
		ACTIONS => {
			'LITERAL_STRING' => 62,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP05_MATH_NEG' => 70,
			'OP01_NAMED_QW' => 103,
			"(" => 73,
			")" => -127,
			"my" => 101,
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			"{*" => 97,
			"%{" => 57,
			'KEYS_OR_VALUES' => 98,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			'WORD' => 13,
			"{" => 86
		},
		GOTOS => {
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'FileHandle' => 108,
			'HashReference' => 66,
			'Variable' => 99,
			'ListElements' => 107,
			'ListElement' => 100,
			'OPTIONAL-43' => 109,
			'Expression' => 94,
			'Operator' => 79,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'TypeInner' => 102
		}
	},
	{#State 52
		ACTIONS => {
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP15_LOGICAL_AND' => 122,
			'OP06_REGEX_MATCH' => 121,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP16_LOGICAL_OR' => 118,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => 110,
			'OP04_MATH_POW' => 119,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => 114,
			'OP18_TERNARY' => 113,
			";" => 120,
			'OP11_COMPARE_LT_GT' => 112
		}
	},
	{#State 53
		ACTIONS => {
			'COLON' => 127
		}
	},
	{#State 54
		ACTIONS => {
			"while (" => 130,
			"for my integer" => 132,
			"foreach my" => 128
		},
		GOTOS => {
			'LoopWhile' => 134,
			'LoopForEach' => 133,
			'Loop' => 131,
			'LoopFor' => 129
		}
	},
	{#State 55
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP08_STRING_CAT' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP19_VARIABLE_ASSIGN' => 137,
			'OP15_LOGICAL_AND' => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 138,
			'OP06_REGEX_MATCH' => -145,
			'OP02_METHOD_THINARROW' => 136,
			'OP09_BITWISE_SHIFT' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP18_TERNARY' => -145,
			";" => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP03_MATH_INC_DEC' => 135,
			'OP04_MATH_POW' => -145
		}
	},
	{#State 56
		DEFAULT => -164
	},
	{#State 57
		ACTIONS => {
			"{" => 139,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 141,
			'HashReference' => 140
		}
	},
	{#State 58
		DEFAULT => -162
	},
	{#State 59
		DEFAULT => -147
	},
	{#State 60
		ACTIONS => {
			'WORD' => 142
		},
		GOTOS => {
			'LoopLabel' => 143
		}
	},
	{#State 61
		ACTIONS => {
			"(" => -218,
			'COLON' => -224
		}
	},
	{#State 62
		DEFAULT => -225
	},
	{#State 63
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			"[" => 69
		},
		GOTOS => {
			'Variable' => 145,
			'ArrayReference' => 144
		}
	},
	{#State 64
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'LITERAL_STRING' => 62,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48
		},
		GOTOS => {
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Operator' => 79,
			'Expression' => 146,
			'Variable' => 99,
			'HashReference' => 66,
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49
		}
	},
	{#State 65
		ACTIONS => {
			"undef" => 85,
			'WORD' => 13,
			"{" => 86,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 75,
			'OP05_MATH_NEG' => 70,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'LITERAL_STRING' => 62,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP10_NAMED_UNARY' => 65
		},
		GOTOS => {
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'HashReference' => 66,
			'Variable' => 99,
			'Expression' => 147,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79
		}
	},
	{#State 66
		DEFAULT => -148
	},
	{#State 67
		DEFAULT => -144
	},
	{#State 68
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 148
		}
	},
	{#State 69
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			"[" => 69,
			"]" => -202,
			'OP03_MATH_INC_DEC' => 68,
			'LITERAL_STRING' => 62,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP10_NAMED_UNARY' => 65,
			"my" => 151,
			'OP05_MATH_NEG' => 70,
			'OP01_NAMED_QW' => 103,
			"(" => 73,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 75,
			"undef" => 85,
			"{" => 86,
			'WORD' => 13,
			"%{" => 57,
			'KEYS_OR_VALUES' => 98,
			'OP10_NAMED_UNARY_STRINGIFY' => 82
		},
		GOTOS => {
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'HashReference' => 66,
			'ListElements' => 149,
			'Variable' => 99,
			'ListElement' => 100,
			'Expression' => 94,
			'OPTIONAL-60' => 150,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'TypeInner' => 102
		}
	},
	{#State 70
		ACTIONS => {
			'OP05_MATH_NEG' => 70,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'LITERAL_STRING' => 62,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP10_NAMED_UNARY' => 65,
			"undef" => 85,
			'WORD' => 13,
			"{" => 86,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 99,
			'WordScoped' => 77,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'HashReference' => 66,
			'Expression' => 152,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79
		}
	},
	{#State 71
		DEFAULT => -146
	},
	{#State 72
		DEFAULT => -99
	},
	{#State 73
		ACTIONS => {
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 75,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP05_LOGICAL_NEG' => 48,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62,
			"(" => 73,
			'OP05_MATH_NEG' => 70
		},
		GOTOS => {
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Operator' => 79,
			'Expression' => 153,
			'Variable' => 99,
			'HashReference' => 66,
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => 155
		},
		GOTOS => {
			'Type' => 154
		}
	},
	{#State 75
		DEFAULT => -182,
		GOTOS => {
			'STAR-56' => 156
		}
	},
	{#State 76
		DEFAULT => -160
	},
	{#State 77
		ACTIONS => {
			"(" => 157
		}
	},
	{#State 78
		DEFAULT => -226
	},
	{#State 79
		DEFAULT => -151
	},
	{#State 80
		ACTIONS => {
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			"while (" => -159,
			'' => -15,
			'VARIABLE_SYMBOL' => 75,
			"{" => 86,
			'WORD' => 61,
			"for my integer" => -159,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'OP19_LOOP_CONTROL' => 60,
			"%{" => 57,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			"if (" => 47,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'LITERAL_STRING' => 62,
			'OP01_NAMED_VOID' => 44,
			"my" => 74,
			"foreach my" => -159,
			"(" => 73,
			'OP01_NAMED_VOID_PAREN' => 51,
			'OP05_MATH_NEG' => 70
		},
		GOTOS => {
			'Variable' => 55,
			'WordScoped' => 77,
			'Conditional' => 76,
			'VariableModification' => 56,
			'VariableDeclaration' => 84,
			'Operation' => 158,
			'ArrayDereferenced' => 59,
			'OperatorVoid' => 58,
			'Operator' => 79,
			'PAREN-49' => 45,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'HashReference' => 66,
			'LoopLabel' => 53,
			'Expression' => 52,
			'Statement' => 72,
			'ArrayReference' => 71,
			'OPTIONAL-50' => 54
		}
	},
	{#State 81
		DEFAULT => -14
	},
	{#State 82
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'LITERAL_STRING' => 62,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75,
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57
		},
		GOTOS => {
			'HashReference' => 66,
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'Variable' => 99,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Expression' => 159
		}
	},
	{#State 83
		ACTIONS => {
			'WORD' => 155
		},
		GOTOS => {
			'Type' => 160
		}
	},
	{#State 84
		DEFAULT => -163
	},
	{#State 85
		DEFAULT => -143
	},
	{#State 86
		ACTIONS => {
			"%{" => 57,
			"}" => 161,
			'WORD' => 164
		},
		GOTOS => {
			'HashDereferenced' => 163,
			'HashEntry' => 162
		}
	},
	{#State 87
		ACTIONS => {
			'OP20_HASH_FATARROW' => 165
		}
	},
	{#State 88
		DEFAULT => -20
	},
	{#State 89
		ACTIONS => {
			'USE_CONSTANT' => 36,
			"our" => 83
		},
		GOTOS => {
			'Subroutine' => 168,
			'Constant' => 167,
			'PLUS-10' => 166
		}
	},
	{#State 90
		ACTIONS => {
			")" => 169
		}
	},
	{#State 91
		ACTIONS => {
			'WORD' => 170,
			")" => 171
		}
	},
	{#State 92
		DEFAULT => -32
	},
	{#State 93
		ACTIONS => {
			";" => 172
		}
	},
	{#State 94
		ACTIONS => {
			")" => -198,
			";" => -198,
			'OP18_TERNARY' => 113,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => 114,
			'OP21_LIST_COMMA' => -198,
			'OP11_COMPARE_LT_GT' => 112,
			'OP04_MATH_POW' => 119,
			'OP23_LOGICAL_AND' => 110,
			"]" => -198,
			'OP08_MATH_ADD_SUB' => 111,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP16_LOGICAL_OR' => 118,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP06_REGEX_MATCH' => 121,
			'OP15_LOGICAL_AND' => 122
		}
	},
	{#State 95
		ACTIONS => {
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75,
			"undef" => 85,
			'WORD' => 13,
			"{" => 86,
			'KEYS_OR_VALUES' => 98,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'OP05_LOGICAL_NEG' => 48,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			";" => -133,
			"my" => 151,
			'OP01_NAMED_QW' => 103,
			'OP05_MATH_NEG' => 70,
			"(" => 73
		},
		GOTOS => {
			'ListElements' => 173,
			'Variable' => 99,
			'HashReference' => 66,
			'WordScoped' => 77,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'OPTIONAL-46' => 174,
			'TypeInner' => 102,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Expression' => 94,
			'ListElement' => 100
		}
	},
	{#State 96
		DEFAULT => -130
	},
	{#State 97
		ACTIONS => {
			'WORD' => 175
		}
	},
	{#State 98
		ACTIONS => {
			"%{" => 57
		},
		GOTOS => {
			'HashDereferenced' => 176
		}
	},
	{#State 99
		ACTIONS => {
			")" => -145,
			'OP18_TERNARY' => -145,
			";" => -145,
			'OP17_LIST_RANGE' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP21_LIST_COMMA' => -145,
			'OP04_MATH_POW' => -145,
			"]" => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP03_MATH_INC_DEC' => 135,
			'OP23_LOGICAL_AND' => -145,
			".." => -145,
			'OP13_BITWISE_AND' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP08_STRING_CAT' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP02_METHOD_THINARROW' => 136,
			"}" => -145,
			'OP15_LOGICAL_AND' => -145
		}
	},
	{#State 100
		DEFAULT => -193,
		GOTOS => {
			'STAR-58' => 177
		}
	},
	{#State 101
		ACTIONS => {
			'WORD' => 155,
			"filehandle_ref" => 179
		},
		GOTOS => {
			'Type' => 178
		}
	},
	{#State 102
		ACTIONS => {
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'Expression' => 180,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'HashReference' => 66,
			'Variable' => 99
		}
	},
	{#State 103
		ACTIONS => {
			"(" => 181
		}
	},
	{#State 104
		ACTIONS => {
			'OP04_MATH_POW' => 119,
			'OP23_LOGICAL_AND' => 110,
			'OP08_MATH_ADD_SUB' => 111,
			'OP18_TERNARY' => 113,
			")" => 182,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => 114,
			'OP11_COMPARE_LT_GT' => 112,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP06_REGEX_MATCH' => 121,
			'OP15_LOGICAL_AND' => 122,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP16_LOGICAL_OR' => 118
		}
	},
	{#State 105
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP13_BITWISE_AND' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP08_STRING_CAT' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP06_REGEX_MATCH' => -106,
			"}" => -106,
			'OP17_LIST_RANGE' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			";" => -106,
			")" => -106,
			'OP18_TERNARY' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP21_LIST_COMMA' => -106,
			"]" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP04_MATH_POW' => 119,
			".." => -106
		}
	},
	{#State 106
		ACTIONS => {
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75,
			"undef" => 85,
			"{" => 86,
			'WORD' => 13,
			'KEYS_OR_VALUES' => 98,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'OP05_LOGICAL_NEG' => 48,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			")" => -101,
			"my" => 151,
			'OP01_NAMED_QW' => 103,
			'OP05_MATH_NEG' => 70,
			"(" => 73
		},
		GOTOS => {
			'ListElements' => 183,
			'Variable' => 99,
			'HashReference' => 66,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'OPTIONAL-42' => 184,
			'WordScoped' => 77,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'TypeInner' => 102,
			'Expression' => 94,
			'ListElement' => 100
		}
	},
	{#State 107
		DEFAULT => -126
	},
	{#State 108
		ACTIONS => {
			"my" => 151,
			")" => -129,
			"(" => 73,
			'OP01_NAMED_QW' => 103,
			'OP05_MATH_NEG' => 70,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'LITERAL_STRING' => 62,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'KEYS_OR_VALUES' => 98,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Expression' => 94,
			'Operator' => 79,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'TypeInner' => 102,
			'ListElement' => 100,
			'ListElements' => 186,
			'Variable' => 99,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'OPTIONAL-44' => 185,
			'WordScoped' => 77,
			'HashReference' => 66
		}
	},
	{#State 109
		ACTIONS => {
			")" => 187
		}
	},
	{#State 110
		ACTIONS => {
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 75,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP05_LOGICAL_NEG' => 48,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 66,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'WordScoped' => 77,
			'Operator' => 79,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Expression' => 188
		}
	},
	{#State 111
		ACTIONS => {
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'LITERAL_STRING' => 62,
			"(" => 73,
			'OP05_MATH_NEG' => 70
		},
		GOTOS => {
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Expression' => 189,
			'HashReference' => 66,
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'Variable' => 99
		}
	},
	{#State 112
		ACTIONS => {
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP05_LOGICAL_NEG' => 48,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50,
			'OP05_MATH_NEG' => 70,
			"(" => 73,
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			"{" => 86,
			'WORD' => 13
		},
		GOTOS => {
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Expression' => 190,
			'Variable' => 99,
			'HashReference' => 66,
			'WordScoped' => 77,
			'HashDereferenced' => 49,
			'Literal' => 67
		}
	},
	{#State 113
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 191
		}
	},
	{#State 114
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'LITERAL_STRING' => 62,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57
		},
		GOTOS => {
			'HashReference' => 66,
			'WordScoped' => 77,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'Variable' => 99,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Expression' => 192
		}
	},
	{#State 115
		ACTIONS => {
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'LITERAL_STRING' => 62,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Expression' => 193,
			'Variable' => 99,
			'HashReference' => 66,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'WordScoped' => 77
		}
	},
	{#State 116
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			"{" => 86,
			'WORD' => 13,
			'LITERAL_STRING' => 62,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP10_NAMED_UNARY' => 65,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP05_MATH_NEG' => 70,
			"(" => 73
		},
		GOTOS => {
			'Expression' => 194,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'HashReference' => 66,
			'Variable' => 99
		}
	},
	{#State 117
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP05_LOGICAL_NEG' => 48,
			"(" => 73,
			'OP05_MATH_NEG' => 70
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 66,
			'WordScoped' => 77,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Operator' => 79,
			'Expression' => 195
		}
	},
	{#State 118
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP05_LOGICAL_NEG' => 48
		},
		GOTOS => {
			'WordScoped' => 77,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'HashReference' => 66,
			'Variable' => 99,
			'Expression' => 196,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79
		}
	},
	{#State 119
		ACTIONS => {
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 66,
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Expression' => 197
		}
	},
	{#State 120
		DEFAULT => -98
	},
	{#State 121
		ACTIONS => {
			"/" => 198
		}
	},
	{#State 122
		ACTIONS => {
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'LITERAL_STRING' => 62,
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Expression' => 199,
			'HashReference' => 66,
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'Variable' => 99
		}
	},
	{#State 123
		ACTIONS => {
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			'WORD' => 13,
			"{" => 86,
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'OP05_MATH_NEG' => 70,
			"(" => 73,
			'LITERAL_STRING' => 62,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68
		},
		GOTOS => {
			'Expression' => 200,
			'Operator' => 79,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'HashReference' => 66,
			'Variable' => 99
		}
	},
	{#State 124
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62,
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP05_LOGICAL_NEG' => 48,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85
		},
		GOTOS => {
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Operator' => 79,
			'Expression' => 201,
			'HashReference' => 66,
			'WordScoped' => 77,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'Variable' => 99
		}
	},
	{#State 125
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			"{" => 86,
			'WORD' => 13,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP05_LOGICAL_NEG' => 48,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'OP05_MATH_NEG' => 70,
			"(" => 73
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Literal' => 67,
			'WordScoped' => 77,
			'HashReference' => 66,
			'Variable' => 99,
			'Expression' => 202,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71
		}
	},
	{#State 126
		ACTIONS => {
			'OP05_MATH_NEG' => 70,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'LITERAL_STRING' => 62,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			"undef" => 85,
			"{" => 86,
			'WORD' => 13,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 66,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Expression' => 203
		}
	},
	{#State 127
		DEFAULT => -157
	},
	{#State 128
		ACTIONS => {
			'WORD' => 155
		},
		GOTOS => {
			'Type' => 204
		}
	},
	{#State 129
		DEFAULT => -172
	},
	{#State 130
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			'WORD' => 13,
			"{" => 86,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP05_LOGICAL_NEG' => 48,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50,
			'OP05_MATH_NEG' => 70,
			"(" => 73
		},
		GOTOS => {
			'Expression' => 205,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'WordScoped' => 77,
			'HashReference' => 66,
			'Variable' => 99
		}
	},
	{#State 131
		DEFAULT => -161
	},
	{#State 132
		ACTIONS => {
			'VARIABLE_SYMBOL' => 206
		}
	},
	{#State 133
		DEFAULT => -173
	},
	{#State 134
		DEFAULT => -174
	},
	{#State 135
		DEFAULT => -104
	},
	{#State 136
		ACTIONS => {
			'WORD' => 207
		}
	},
	{#State 137
		ACTIONS => {
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			"<STDIN>" => 209,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'Expression' => 208,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'WordScoped' => 77,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'HashReference' => 66,
			'ExpressionOrStdin' => 210,
			'Variable' => 99
		}
	},
	{#State 138
		ACTIONS => {
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'LITERAL_STRING' => 62,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15
		},
		GOTOS => {
			'Expression' => 211,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Variable' => 99,
			'WordScoped' => 77,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'HashReference' => 66
		}
	},
	{#State 139
		ACTIONS => {
			'WORD' => 164,
			"%{" => 57
		},
		GOTOS => {
			'HashEntry' => 162,
			'HashDereferenced' => 163
		}
	},
	{#State 140
		ACTIONS => {
			"}" => 212
		}
	},
	{#State 141
		ACTIONS => {
			"}" => 213
		}
	},
	{#State 142
		DEFAULT => -224
	},
	{#State 143
		ACTIONS => {
			";" => 214
		}
	},
	{#State 144
		ACTIONS => {
			"}" => 215
		}
	},
	{#State 145
		ACTIONS => {
			"}" => 216
		}
	},
	{#State 146
		ACTIONS => {
			".." => -123,
			'OP08_MATH_ADD_SUB' => 111,
			"]" => -123,
			'OP23_LOGICAL_AND' => -123,
			'OP04_MATH_POW' => 119,
			'OP11_COMPARE_LT_GT' => 112,
			'OP21_LIST_COMMA' => -123,
			'OP17_LIST_RANGE' => 114,
			'OP09_BITWISE_SHIFT' => 115,
			";" => -123,
			")" => -123,
			'OP18_TERNARY' => 113,
			'OP15_LOGICAL_AND' => 122,
			'OP06_REGEX_MATCH' => 121,
			"}" => -123,
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP16_LOGICAL_OR' => 118,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124
		}
	},
	{#State 147
		ACTIONS => {
			")" => -113,
			";" => -113,
			'OP18_TERNARY' => -113,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP04_MATH_POW' => 119,
			'OP08_MATH_ADD_SUB' => 111,
			"]" => -113,
			'OP23_LOGICAL_AND' => -113,
			".." => -113,
			'OP13_BITWISE_AND' => -113,
			'OP12_COMPARE_EQ_NEQ' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			"}" => -113,
			'OP06_REGEX_MATCH' => 121,
			'OP15_LOGICAL_AND' => -113
		}
	},
	{#State 148
		DEFAULT => -103
	},
	{#State 149
		DEFAULT => -201
	},
	{#State 150
		ACTIONS => {
			"]" => 217
		}
	},
	{#State 151
		ACTIONS => {
			'WORD' => 155
		},
		GOTOS => {
			'Type' => 178
		}
	},
	{#State 152
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP06_REGEX_MATCH' => 121,
			'OP15_LOGICAL_AND' => 122,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP16_LOGICAL_OR' => 118,
			'OP04_MATH_POW' => 119,
			'OP23_LOGICAL_AND' => 110,
			'OP08_MATH_ADD_SUB' => 111,
			'OP18_TERNARY' => 113,
			")" => 218,
			'OP17_LIST_RANGE' => 114,
			'OP09_BITWISE_SHIFT' => 115,
			'OP11_COMPARE_LT_GT' => 112
		}
	},
	{#State 153
		ACTIONS => {
			'OP06_REGEX_MATCH' => 121,
			'OP15_LOGICAL_AND' => 122,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP16_LOGICAL_OR' => 118,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP04_MATH_POW' => 119,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => 110,
			'OP11_COMPARE_LT_GT' => 112,
			")" => 219,
			'OP18_TERNARY' => 113,
			'OP17_LIST_RANGE' => 114,
			'OP09_BITWISE_SHIFT' => 115
		}
	},
	{#State 154
		ACTIONS => {
			'VARIABLE_SYMBOL' => 220
		}
	},
	{#State 155
		DEFAULT => -223
	},
	{#State 156
		ACTIONS => {
			'OP08_STRING_CAT' => -183,
			'OP07_MATH_MULT_DIV_MOD' => -183,
			'OP24_LOGICAL_OR_XOR' => -183,
			'OP15_LOGICAL_AND' => -183,
			'OP19_VARIABLE_ASSIGN' => -183,
			'OP06_REGEX_MATCH' => -183,
			'OP02_METHOD_THINARROW' => -183,
			"}" => -183,
			'OP19_VARIABLE_ASSIGN_BY' => -183,
			'OP14_BITWISE_OR_XOR' => -183,
			'COLON' => -183,
			'OP13_BITWISE_AND' => -183,
			'OP12_COMPARE_EQ_NEQ' => -183,
			'OP16_LOGICAL_OR' => -183,
			"]" => -183,
			'OP08_MATH_ADD_SUB' => -183,
			'OP23_LOGICAL_AND' => -183,
			'OP03_MATH_INC_DEC' => -183,
			'OP04_MATH_POW' => -183,
			'OP02_HASH_THINARROW' => 222,
			'OP02_ARRAY_THINARROW' => 223,
			".." => -183,
			'OP17_LIST_RANGE' => -183,
			'OP09_BITWISE_SHIFT' => -183,
			'OP18_TERNARY' => -183,
			")" => -183,
			";" => -183,
			'OP11_COMPARE_LT_GT' => -183,
			'OP21_LIST_COMMA' => -183
		},
		GOTOS => {
			'VariableRetrieval' => 221
		}
	},
	{#State 157
		ACTIONS => {
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP05_LOGICAL_NEG' => 48,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62,
			"my" => 151,
			")" => -140,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'OP01_NAMED_QW' => 103,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 75,
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'KEYS_OR_VALUES' => 98,
			"%{" => 57
		},
		GOTOS => {
			'ListElement' => 100,
			'Expression' => 94,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'TypeInner' => 102,
			'ArrayReference' => 71,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'WordScoped' => 77,
			'HashReference' => 66,
			'OPTIONAL-47' => 224,
			'ListElements' => 225,
			'Variable' => 99
		}
	},
	{#State 158
		DEFAULT => -13
	},
	{#State 159
		ACTIONS => {
			'OP15_LOGICAL_AND' => -114,
			'OP06_REGEX_MATCH' => 121,
			"}" => -114,
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP13_BITWISE_AND' => -114,
			'OP12_COMPARE_EQ_NEQ' => -114,
			".." => -114,
			'OP08_MATH_ADD_SUB' => 111,
			"]" => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP04_MATH_POW' => 119,
			'OP11_COMPARE_LT_GT' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP17_LIST_RANGE' => -114,
			'OP09_BITWISE_SHIFT' => 115,
			'OP18_TERNARY' => -114,
			")" => -114,
			";" => -114
		}
	},
	{#State 160
		ACTIONS => {
			'VARIABLE_SYMBOL' => 226
		}
	},
	{#State 161
		DEFAULT => -150
	},
	{#State 162
		DEFAULT => -214,
		GOTOS => {
			'STAR-63' => 227
		}
	},
	{#State 163
		DEFAULT => -209
	},
	{#State 164
		ACTIONS => {
			'OP20_HASH_FATARROW' => 228
		}
	},
	{#State 165
		ACTIONS => {
			"my" => 151
		},
		GOTOS => {
			'TypeInner' => 229
		}
	},
	{#State 166
		ACTIONS => {
			"1;" => 230,
			"our" => 83
		},
		GOTOS => {
			'Subroutine' => 231
		}
	},
	{#State 167
		DEFAULT => -22
	},
	{#State 168
		DEFAULT => -25
	},
	{#State 169
		ACTIONS => {
			";" => 232
		}
	},
	{#State 170
		DEFAULT => -31
	},
	{#State 171
		ACTIONS => {
			";" => 233
		}
	},
	{#State 172
		DEFAULT => -136
	},
	{#State 173
		DEFAULT => -132
	},
	{#State 174
		ACTIONS => {
			";" => 234
		}
	},
	{#State 175
		ACTIONS => {
			"}" => 235
		}
	},
	{#State 176
		DEFAULT => -200
	},
	{#State 177
		ACTIONS => {
			'OP21_LIST_COMMA' => 236,
			";" => -196,
			")" => -196,
			"]" => -196
		},
		GOTOS => {
			'PAREN-57' => 237
		}
	},
	{#State 178
		ACTIONS => {
			"\$TYPED_" => 238
		}
	},
	{#State 179
		ACTIONS => {
			'VARIABLE_SYMBOL' => 239
		}
	},
	{#State 180
		ACTIONS => {
			"]" => -199,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => 110,
			'OP04_MATH_POW' => 119,
			'OP17_LIST_RANGE' => 114,
			'OP09_BITWISE_SHIFT' => 115,
			";" => -199,
			")" => -199,
			'OP18_TERNARY' => 113,
			'OP11_COMPARE_LT_GT' => 112,
			'OP21_LIST_COMMA' => -199,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP15_LOGICAL_AND' => 122,
			'OP06_REGEX_MATCH' => 121,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP16_LOGICAL_OR' => 118
		}
	},
	{#State 181
		ACTIONS => {
			'WORD' => 240
		},
		GOTOS => {
			'PLUS-59' => 241
		}
	},
	{#State 182
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 242
		}
	},
	{#State 183
		DEFAULT => -100
	},
	{#State 184
		ACTIONS => {
			")" => 244
		}
	},
	{#State 185
		ACTIONS => {
			")" => 245
		}
	},
	{#State 186
		DEFAULT => -128
	},
	{#State 187
		ACTIONS => {
			";" => 246
		}
	},
	{#State 188
		ACTIONS => {
			".." => -124,
			'OP08_MATH_ADD_SUB' => 111,
			"]" => -124,
			'OP23_LOGICAL_AND' => -124,
			'OP04_MATH_POW' => 119,
			'OP21_LIST_COMMA' => -124,
			'OP11_COMPARE_LT_GT' => 112,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => 114,
			";" => -124,
			")" => -124,
			'OP18_TERNARY' => 113,
			'OP15_LOGICAL_AND' => 122,
			"}" => -124,
			'OP06_REGEX_MATCH' => 121,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP16_LOGICAL_OR' => 118,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => 125
		}
	},
	{#State 189
		ACTIONS => {
			".." => -110,
			'OP04_MATH_POW' => 119,
			"]" => -110,
			'OP08_MATH_ADD_SUB' => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP21_LIST_COMMA' => -110,
			")" => -110,
			";" => -110,
			'OP18_TERNARY' => -110,
			'OP17_LIST_RANGE' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP06_REGEX_MATCH' => 121,
			"}" => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP13_BITWISE_AND' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP14_BITWISE_OR_XOR' => -110
		}
	},
	{#State 190
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -115,
			'OP12_COMPARE_EQ_NEQ' => -115,
			'OP13_BITWISE_AND' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP15_LOGICAL_AND' => -115,
			"}" => -115,
			'OP06_REGEX_MATCH' => 121,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => -115,
			")" => -115,
			";" => -115,
			'OP18_TERNARY' => -115,
			'OP21_LIST_COMMA' => -115,
			'OP11_COMPARE_LT_GT' => undef,
			"]" => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP08_MATH_ADD_SUB' => 111,
			'OP04_MATH_POW' => 119,
			".." => -115
		}
	},
	{#State 191
		ACTIONS => {
			'COLON' => 247
		}
	},
	{#State 192
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP15_LOGICAL_AND' => 122,
			'OP06_REGEX_MATCH' => 121,
			"}" => -121,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP16_LOGICAL_OR' => 118,
			"]" => -121,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => -121,
			'OP04_MATH_POW' => 119,
			".." => -121,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 115,
			";" => -121,
			")" => -121,
			'OP18_TERNARY' => -121,
			'OP11_COMPARE_LT_GT' => 112,
			'OP21_LIST_COMMA' => -121
		}
	},
	{#State 193
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -112,
			'OP21_LIST_COMMA' => -112,
			";" => -112,
			")" => -112,
			'OP18_TERNARY' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			".." => -112,
			'OP04_MATH_POW' => 119,
			"]" => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP08_MATH_ADD_SUB' => 111,
			'OP16_LOGICAL_OR' => -112,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP06_REGEX_MATCH' => 121,
			"}" => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123
		}
	},
	{#State 194
		ACTIONS => {
			'OP16_LOGICAL_OR' => 118,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP15_LOGICAL_AND' => 122,
			'OP06_REGEX_MATCH' => 121,
			"}" => -125,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP11_COMPARE_LT_GT' => 112,
			'OP21_LIST_COMMA' => -125,
			'OP17_LIST_RANGE' => 114,
			'OP09_BITWISE_SHIFT' => 115,
			")" => -125,
			'OP18_TERNARY' => 113,
			";" => -125,
			".." => -125,
			'OP23_LOGICAL_AND' => 110,
			"]" => -125,
			'OP08_MATH_ADD_SUB' => 111,
			'OP04_MATH_POW' => 119
		}
	},
	{#State 195
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -111,
			'OP17_LIST_RANGE' => -111,
			")" => -111,
			'OP18_TERNARY' => -111,
			";" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			"]" => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP08_MATH_ADD_SUB' => 111,
			'OP04_MATH_POW' => 119,
			".." => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP13_BITWISE_AND' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP08_STRING_CAT' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP15_LOGICAL_AND' => -111,
			"}" => -111,
			'OP06_REGEX_MATCH' => 121
		}
	},
	{#State 196
		ACTIONS => {
			".." => -120,
			'OP08_MATH_ADD_SUB' => 111,
			"]" => -120,
			'OP23_LOGICAL_AND' => -120,
			'OP04_MATH_POW' => 119,
			'OP21_LIST_COMMA' => -120,
			'OP11_COMPARE_LT_GT' => 112,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => -120,
			'OP18_TERNARY' => -120,
			")" => -120,
			";" => -120,
			'OP15_LOGICAL_AND' => 122,
			"}" => -120,
			'OP06_REGEX_MATCH' => 121,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124
		}
	},
	{#State 197
		ACTIONS => {
			'OP04_MATH_POW' => 119,
			'OP08_MATH_ADD_SUB' => -105,
			"]" => -105,
			'OP23_LOGICAL_AND' => -105,
			".." => -105,
			")" => -105,
			'OP18_TERNARY' => -105,
			";" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP08_STRING_CAT' => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP06_REGEX_MATCH' => -105,
			"}" => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP16_LOGICAL_OR' => -105
		}
	},
	{#State 198
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 248
		}
	},
	{#State 199
		ACTIONS => {
			".." => -119,
			'OP04_MATH_POW' => 119,
			"]" => -119,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => -119,
			'OP11_COMPARE_LT_GT' => 112,
			'OP21_LIST_COMMA' => -119,
			'OP18_TERNARY' => -119,
			")" => -119,
			";" => -119,
			'OP17_LIST_RANGE' => -119,
			'OP09_BITWISE_SHIFT' => 115,
			'OP06_REGEX_MATCH' => 121,
			"}" => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP16_LOGICAL_OR' => -119,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP14_BITWISE_OR_XOR' => 126
		}
	},
	{#State 200
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -109,
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP13_BITWISE_AND' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP08_STRING_CAT' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP15_LOGICAL_AND' => -109,
			"}" => -109,
			'OP06_REGEX_MATCH' => 121,
			'OP09_BITWISE_SHIFT' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP18_TERNARY' => -109,
			")" => -109,
			";" => -109,
			'OP21_LIST_COMMA' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			"]" => -109,
			'OP08_MATH_ADD_SUB' => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP04_MATH_POW' => 119,
			".." => -109
		}
	},
	{#State 201
		ACTIONS => {
			")" => -116,
			";" => -116,
			'OP18_TERNARY' => -116,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP11_COMPARE_LT_GT' => 112,
			'OP04_MATH_POW' => 119,
			'OP08_MATH_ADD_SUB' => 111,
			"]" => -116,
			'OP23_LOGICAL_AND' => -116,
			".." => -116,
			'OP13_BITWISE_AND' => -116,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => -116,
			'OP06_REGEX_MATCH' => 121,
			'OP15_LOGICAL_AND' => -116
		}
	},
	{#State 202
		ACTIONS => {
			'OP15_LOGICAL_AND' => -117,
			"}" => -117,
			'OP06_REGEX_MATCH' => 121,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => -117,
			".." => -117,
			'OP23_LOGICAL_AND' => -117,
			"]" => -117,
			'OP08_MATH_ADD_SUB' => 111,
			'OP04_MATH_POW' => 119,
			'OP21_LIST_COMMA' => -117,
			'OP11_COMPARE_LT_GT' => 112,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => -117,
			'OP18_TERNARY' => -117,
			")" => -117,
			";" => -117
		}
	},
	{#State 203
		ACTIONS => {
			".." => -118,
			'OP23_LOGICAL_AND' => -118,
			"]" => -118,
			'OP08_MATH_ADD_SUB' => 111,
			'OP04_MATH_POW' => 119,
			'OP11_COMPARE_LT_GT' => 112,
			'OP21_LIST_COMMA' => -118,
			'OP17_LIST_RANGE' => -118,
			'OP09_BITWISE_SHIFT' => 115,
			'OP18_TERNARY' => -118,
			")" => -118,
			";" => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP06_REGEX_MATCH' => 121,
			"}" => -118,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => 125
		}
	},
	{#State 204
		ACTIONS => {
			'VARIABLE_SYMBOL' => 249
		}
	},
	{#State 205
		ACTIONS => {
			'OP23_LOGICAL_AND' => 110,
			'OP08_MATH_ADD_SUB' => 111,
			'OP04_MATH_POW' => 119,
			'OP11_COMPARE_LT_GT' => 112,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => 114,
			")" => 250,
			'OP18_TERNARY' => 113,
			'OP15_LOGICAL_AND' => 122,
			'OP06_REGEX_MATCH' => 121,
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP16_LOGICAL_OR' => 118,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124
		}
	},
	{#State 206
		ACTIONS => {
			"(" => 251
		}
	},
	{#State 207
		ACTIONS => {
			"(" => 252
		}
	},
	{#State 208
		ACTIONS => {
			'OP04_MATH_POW' => 119,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => 110,
			'OP11_COMPARE_LT_GT' => 112,
			'OP18_TERNARY' => 113,
			";" => -155,
			'OP17_LIST_RANGE' => 114,
			'OP09_BITWISE_SHIFT' => 115,
			'OP06_REGEX_MATCH' => 121,
			'OP15_LOGICAL_AND' => 122,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP16_LOGICAL_OR' => 118,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP14_BITWISE_OR_XOR' => 126
		}
	},
	{#State 209
		DEFAULT => -156
	},
	{#State 210
		ACTIONS => {
			";" => 253
		}
	},
	{#State 211
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP16_LOGICAL_OR' => 118,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP15_LOGICAL_AND' => 122,
			'OP06_REGEX_MATCH' => 121,
			'OP17_LIST_RANGE' => 114,
			'OP09_BITWISE_SHIFT' => 115,
			";" => 254,
			'OP18_TERNARY' => 113,
			'OP11_COMPARE_LT_GT' => 112,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => 110,
			'OP04_MATH_POW' => 119
		}
	},
	{#State 212
		DEFAULT => -217
	},
	{#State 213
		DEFAULT => -216
	},
	{#State 214
		DEFAULT => -138
	},
	{#State 215
		DEFAULT => -205
	},
	{#State 216
		DEFAULT => -204
	},
	{#State 217
		DEFAULT => -203
	},
	{#State 218
		DEFAULT => -107
	},
	{#State 219
		DEFAULT => -154
	},
	{#State 220
		ACTIONS => {
			";" => 255,
			'OP19_VARIABLE_ASSIGN' => 256
		}
	},
	{#State 221
		DEFAULT => -181
	},
	{#State 222
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'WORD' => 257,
			"{" => 86,
			"undef" => 85,
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62,
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP05_LOGICAL_NEG' => 48
		},
		GOTOS => {
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Expression' => 258,
			'Variable' => 99,
			'HashReference' => 66,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77
		}
	},
	{#State 223
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62,
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP05_LOGICAL_NEG' => 48
		},
		GOTOS => {
			'HashReference' => 66,
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'Variable' => 99,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Operator' => 79,
			'Expression' => 259
		}
	},
	{#State 224
		ACTIONS => {
			")" => 260
		}
	},
	{#State 225
		DEFAULT => -139
	},
	{#State 226
		ACTIONS => {
			"= sub {" => 261
		}
	},
	{#State 227
		ACTIONS => {
			'OP21_LIST_COMMA' => 262,
			"}" => 264
		},
		GOTOS => {
			'PAREN-62' => 263
		}
	},
	{#State 228
		ACTIONS => {
			'OP05_MATH_NEG' => -207,
			"(" => -207,
			"my" => 151,
			'LITERAL_STRING' => -207,
			"\@{" => -207,
			'OP22_LOGICAL_NOT' => -207,
			'OP10_NAMED_UNARY' => -207,
			'OP05_LOGICAL_NEG' => -207,
			'OP01_NAMED' => -207,
			'OP03_MATH_INC_DEC' => -207,
			"[" => -207,
			"%{" => -207,
			'OP10_NAMED_UNARY_STRINGIFY' => -207,
			"undef" => -207,
			'WORD' => -207,
			"{" => -207,
			'VARIABLE_SYMBOL' => -207,
			'WORD_SCOPED' => -207,
			'LITERAL_NUMBER' => -207
		},
		GOTOS => {
			'OPTIONAL-61' => 265,
			'TypeInner' => 266
		}
	},
	{#State 229
		ACTIONS => {
			'LITERAL_STRING' => 62,
			"[" => 270,
			'LITERAL_NUMBER' => 78,
			"{" => 267
		},
		GOTOS => {
			'Literal' => 269,
			'ConstantValue' => 268
		}
	},
	{#State 230
		ACTIONS => {
			"1;" => 271
		}
	},
	{#State 231
		DEFAULT => -24
	},
	{#State 232
		ACTIONS => {
			"fuse" => 25
		},
		GOTOS => {
			'Include' => 272
		}
	},
	{#State 233
		DEFAULT => -34
	},
	{#State 234
		DEFAULT => -137
	},
	{#State 235
		DEFAULT => -220
	},
	{#State 236
		ACTIONS => {
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'KEYS_OR_VALUES' => 98,
			"%{" => 57,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 75,
			"my" => 151,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP05_LOGICAL_NEG' => 48,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 66,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'TypeInner' => 102,
			'ArrayReference' => 71,
			'Expression' => 94,
			'ListElement' => 273
		}
	},
	{#State 237
		DEFAULT => -192
	},
	{#State 238
		ACTIONS => {
			'WORD' => 274
		}
	},
	{#State 239
		DEFAULT => -221
	},
	{#State 240
		DEFAULT => -195
	},
	{#State 241
		ACTIONS => {
			")" => 275,
			'WORD' => 276
		}
	},
	{#State 242
		DEFAULT => -167,
		GOTOS => {
			'STAR-52' => 277
		}
	},
	{#State 243
		ACTIONS => {
			"if (" => 47,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'LITERAL_STRING' => 62,
			'OP01_NAMED_VOID' => 44,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			"foreach my" => -159,
			"my" => 74,
			'OP05_MATH_NEG' => 70,
			'OP01_NAMED_VOID_PAREN' => 51,
			"(" => 73,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 75,
			"while (" => -159,
			"undef" => 85,
			"for my integer" => -159,
			"{" => 86,
			'WORD' => 61,
			"%{" => 57,
			'OP19_LOOP_CONTROL' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 82
		},
		GOTOS => {
			'OPTIONAL-50' => 54,
			'ArrayReference' => 71,
			'Expression' => 52,
			'Statement' => 72,
			'LoopLabel' => 53,
			'HashReference' => 66,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'PAREN-49' => 45,
			'Operator' => 79,
			'PLUS-55' => 278,
			'ArrayDereferenced' => 59,
			'OperatorVoid' => 58,
			'Operation' => 279,
			'VariableDeclaration' => 84,
			'VariableModification' => 56,
			'Conditional' => 76,
			'WordScoped' => 77,
			'Variable' => 55
		}
	},
	{#State 244
		DEFAULT => -102
	},
	{#State 245
		ACTIONS => {
			";" => 280
		}
	},
	{#State 246
		DEFAULT => -134
	},
	{#State 247
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 281
		}
	},
	{#State 248
		ACTIONS => {
			"/" => 282
		}
	},
	{#State 249
		ACTIONS => {
			"(" => 283
		}
	},
	{#State 250
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 284
		}
	},
	{#State 251
		ACTIONS => {
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62,
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'HashReference' => 66,
			'Variable' => 99,
			'Expression' => 285,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Operator' => 79
		}
	},
	{#State 252
		ACTIONS => {
			"%{" => 57,
			'KEYS_OR_VALUES' => 98,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			"{" => 86,
			'WORD' => 13,
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'OP01_NAMED_QW' => 103,
			'OP05_MATH_NEG' => 70,
			"(" => 73,
			")" => -142,
			"my" => 151,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP05_LOGICAL_NEG' => 48,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50
		},
		GOTOS => {
			'ListElement' => 100,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'TypeInner' => 102,
			'Expression' => 94,
			'OPTIONAL-48' => 287,
			'HashReference' => 66,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'Variable' => 99,
			'ListElements' => 286
		}
	},
	{#State 253
		DEFAULT => -189
	},
	{#State 254
		DEFAULT => -190
	},
	{#State 255
		DEFAULT => -187
	},
	{#State 256
		ACTIONS => {
			"<STDIN>" => 209,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			'WORD' => 13,
			"{" => 86,
			"undef" => 85,
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'LITERAL_STRING' => 62,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48
		},
		GOTOS => {
			'Expression' => 208,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Operator' => 79,
			'ExpressionOrStdin' => 288,
			'Variable' => 99,
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'HashReference' => 66
		}
	},
	{#State 257
		ACTIONS => {
			"}" => 289,
			"(" => -218
		}
	},
	{#State 258
		ACTIONS => {
			'OP06_REGEX_MATCH' => 121,
			"}" => 290,
			'OP15_LOGICAL_AND' => 122,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP16_LOGICAL_OR' => 118,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP04_MATH_POW' => 119,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => 110,
			'OP11_COMPARE_LT_GT' => 112,
			'OP18_TERNARY' => 113,
			'OP17_LIST_RANGE' => 114,
			'OP09_BITWISE_SHIFT' => 115
		}
	},
	{#State 259
		ACTIONS => {
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP16_LOGICAL_OR' => 118,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP06_REGEX_MATCH' => 121,
			'OP15_LOGICAL_AND' => 122,
			'OP18_TERNARY' => 113,
			'OP17_LIST_RANGE' => 114,
			'OP09_BITWISE_SHIFT' => 115,
			'OP11_COMPARE_LT_GT' => 112,
			'OP04_MATH_POW' => 119,
			"]" => 291,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => 110
		}
	},
	{#State 260
		DEFAULT => -152
	},
	{#State 261
		ACTIONS => {
			"%{" => -54,
			'OP19_LOOP_CONTROL' => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			"for my integer" => -54,
			"undef" => -54,
			'WORD' => -54,
			"{" => -54,
			'VARIABLE_SYMBOL' => -54,
			"while (" => -54,
			'LITERAL_NUMBER' => -54,
			'WORD_SCOPED' => -54,
			'OP05_MATH_NEG' => -54,
			"(" => -54,
			'OP01_NAMED_VOID_PAREN' => -54,
			"foreach my" => -54,
			"my" => -54,
			'OP01_NAMED_VOID' => -54,
			'LITERAL_STRING' => -54,
			'OP10_NAMED_UNARY' => -54,
			'OP22_LOGICAL_NOT' => -54,
			"\@{" => -54,
			'OP05_LOGICAL_NEG' => -54,
			"if (" => -54,
			'OP03_MATH_INC_DEC' => -54,
			"[" => -54,
			"( my" => 292,
			'OP01_NAMED' => -54
		},
		GOTOS => {
			'OPTIONAL-21' => 293,
			'SubroutineArguments' => 294
		}
	},
	{#State 262
		ACTIONS => {
			"%{" => 57,
			'WORD' => 164
		},
		GOTOS => {
			'HashDereferenced' => 163,
			'HashEntry' => 295
		}
	},
	{#State 263
		DEFAULT => -213
	},
	{#State 264
		DEFAULT => -215
	},
	{#State 265
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'LITERAL_STRING' => 62,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 66,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'WordScoped' => 77,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Expression' => 296
		}
	},
	{#State 266
		DEFAULT => -206
	},
	{#State 267
		ACTIONS => {
			'WORD' => 297
		}
	},
	{#State 268
		ACTIONS => {
			";" => 298
		}
	},
	{#State 269
		DEFAULT => -50
	},
	{#State 270
		ACTIONS => {
			'LITERAL_STRING' => -37,
			'LITERAL_NUMBER' => -37,
			"my" => 151
		},
		GOTOS => {
			'TypeInner' => 299,
			'OPTIONAL-13' => 300
		}
	},
	{#State 271
		DEFAULT => -26
	},
	{#State 272
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 301
		}
	},
	{#State 273
		DEFAULT => -191
	},
	{#State 274
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 302
		}
	},
	{#State 275
		DEFAULT => -197
	},
	{#State 276
		DEFAULT => -194
	},
	{#State 277
		ACTIONS => {
			'WORD' => -170,
			"{" => -170,
			"for my integer" => -170,
			"undef" => -170,
			'OP10_NAMED_UNARY_STRINGIFY' => -170,
			'OP19_LOOP_CONTROL' => -170,
			"%{" => -170,
			'LITERAL_NUMBER' => -170,
			'WORD_SCOPED' => -170,
			"}" => -170,
			'' => -170,
			"while (" => -170,
			'VARIABLE_SYMBOL' => -170,
			"else" => 303,
			"my" => -170,
			"foreach my" => -170,
			"(" => -170,
			'OP01_NAMED_VOID_PAREN' => -170,
			"elsif (" => 304,
			'OP05_MATH_NEG' => -170,
			'OP03_MATH_INC_DEC' => -170,
			"[" => -170,
			'OP01_NAMED' => -170,
			'OP05_LOGICAL_NEG' => -170,
			"if (" => -170,
			'OP10_NAMED_UNARY' => -170,
			"\@{" => -170,
			'OP22_LOGICAL_NOT' => -170,
			'OP01_NAMED_VOID' => -170,
			'LITERAL_STRING' => -170
		},
		GOTOS => {
			'PAREN-51' => 306,
			'OPTIONAL-54' => 307,
			'PAREN-53' => 305
		}
	},
	{#State 278
		ACTIONS => {
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 75,
			"while (" => -159,
			"}" => 309,
			"undef" => 85,
			"for my integer" => -159,
			'WORD' => 61,
			"{" => 86,
			'OP19_LOOP_CONTROL' => 60,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"if (" => 47,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'LITERAL_STRING' => 62,
			'OP01_NAMED_VOID' => 44,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			"foreach my" => -159,
			"my" => 74,
			'OP05_MATH_NEG' => 70,
			'OP01_NAMED_VOID_PAREN' => 51,
			"(" => 73
		},
		GOTOS => {
			'OPTIONAL-50' => 54,
			'LoopLabel' => 53,
			'Expression' => 52,
			'Statement' => 72,
			'ArrayReference' => 71,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'HashReference' => 66,
			'PAREN-49' => 45,
			'VariableDeclaration' => 84,
			'Operation' => 308,
			'OperatorVoid' => 58,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'WordScoped' => 77,
			'Conditional' => 76,
			'VariableModification' => 56,
			'Variable' => 55
		}
	},
	{#State 279
		DEFAULT => -179
	},
	{#State 280
		DEFAULT => -135
	},
	{#State 281
		DEFAULT => -122
	},
	{#State 282
		DEFAULT => -108
	},
	{#State 283
		ACTIONS => {
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'OP01_NAMED_QW' => 103,
			"my" => 151,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP10_NAMED_UNARY' => 65,
			'LITERAL_STRING' => 62,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP05_LOGICAL_NEG' => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'KEYS_OR_VALUES' => 98,
			"%{" => 57,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85,
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'HashReference' => 66,
			'ListElements' => 310,
			'Variable' => 99,
			'ListElement' => 100,
			'Expression' => 94,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'TypeInner' => 102
		}
	},
	{#State 284
		DEFAULT => -177
	},
	{#State 285
		ACTIONS => {
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP16_LOGICAL_OR' => 118,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP06_REGEX_MATCH' => 121,
			'OP15_LOGICAL_AND' => 122,
			'OP18_TERNARY' => 113,
			'OP17_LIST_RANGE' => 114,
			'OP09_BITWISE_SHIFT' => 115,
			'OP11_COMPARE_LT_GT' => 112,
			'OP04_MATH_POW' => 119,
			'OP23_LOGICAL_AND' => 110,
			'OP08_MATH_ADD_SUB' => 111,
			".." => 311
		}
	},
	{#State 286
		DEFAULT => -141
	},
	{#State 287
		ACTIONS => {
			")" => 312
		}
	},
	{#State 288
		ACTIONS => {
			";" => 313
		}
	},
	{#State 289
		DEFAULT => -186
	},
	{#State 290
		DEFAULT => -185
	},
	{#State 291
		DEFAULT => -184
	},
	{#State 292
		ACTIONS => {
			'WORD' => 155
		},
		GOTOS => {
			'Type' => 314
		}
	},
	{#State 293
		ACTIONS => {
			'OP05_MATH_NEG' => 70,
			"(" => 73,
			'OP01_NAMED_VOID_PAREN' => 51,
			"foreach my" => -159,
			"my" => 74,
			'OP01_NAMED_VOID' => 44,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP05_LOGICAL_NEG' => 48,
			"if (" => 47,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50,
			'OP19_LOOP_CONTROL' => 60,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"for my integer" => -159,
			"undef" => 85,
			"{" => 86,
			'WORD' => 61,
			'VARIABLE_SYMBOL' => 75,
			"while (" => -159,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15
		},
		GOTOS => {
			'LoopLabel' => 53,
			'Statement' => 72,
			'Expression' => 52,
			'PLUS-22' => 315,
			'ArrayReference' => 71,
			'OPTIONAL-50' => 54,
			'PAREN-49' => 45,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'HashReference' => 66,
			'VariableDeclaration' => 84,
			'Operation' => 316,
			'OperatorVoid' => 58,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Variable' => 55,
			'WordScoped' => 77,
			'Conditional' => 76,
			'VariableModification' => 56
		}
	},
	{#State 294
		DEFAULT => -53
	},
	{#State 295
		DEFAULT => -212
	},
	{#State 296
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP15_LOGICAL_AND' => 122,
			"}" => -208,
			'OP06_REGEX_MATCH' => 121,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP16_LOGICAL_OR' => 118,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => 110,
			'OP04_MATH_POW' => 119,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => 114,
			'OP18_TERNARY' => 113,
			'OP21_LIST_COMMA' => -208,
			'OP11_COMPARE_LT_GT' => 112
		}
	},
	{#State 297
		ACTIONS => {
			'OP20_HASH_FATARROW' => 317
		}
	},
	{#State 298
		DEFAULT => -35
	},
	{#State 299
		DEFAULT => -36
	},
	{#State 300
		ACTIONS => {
			'LITERAL_STRING' => 62,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Literal' => 318
		}
	},
	{#State 301
		ACTIONS => {
			"fuse" => -71,
			"our %properties = (" => -71,
			"## no critic qw(" => 22,
			'USE_CONSTANT' => -71
		},
		GOTOS => {
			'STAR-29' => 319,
			'Critic' => 320
		}
	},
	{#State 302
		DEFAULT => -222
	},
	{#State 303
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 321
		}
	},
	{#State 304
		ACTIONS => {
			'LITERAL_STRING' => 62,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP10_NAMED_UNARY' => 65,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP05_MATH_NEG' => 70,
			"(" => 73,
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			"{" => 86,
			'WORD' => 13
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 66,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Expression' => 322
		}
	},
	{#State 305
		DEFAULT => -169
	},
	{#State 306
		DEFAULT => -166
	},
	{#State 307
		DEFAULT => -171
	},
	{#State 308
		DEFAULT => -178
	},
	{#State 309
		DEFAULT => -180
	},
	{#State 310
		ACTIONS => {
			")" => 323
		}
	},
	{#State 311
		ACTIONS => {
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			'WORD' => 13,
			"{" => 86,
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'OP05_MATH_NEG' => 70,
			"(" => 73,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP05_LOGICAL_NEG' => 48,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50
		},
		GOTOS => {
			'Expression' => 324,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'WordScoped' => 77,
			'HashReference' => 66,
			'Variable' => 99
		}
	},
	{#State 312
		DEFAULT => -153
	},
	{#State 313
		DEFAULT => -188
	},
	{#State 314
		ACTIONS => {
			'VARIABLE_SYMBOL' => 325
		}
	},
	{#State 315
		ACTIONS => {
			"}" => 327,
			"while (" => -159,
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'OP19_LOOP_CONTROL' => 60,
			"%{" => 57,
			"{" => 86,
			'WORD' => 61,
			"for my integer" => -159,
			"undef" => 85,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP01_NAMED_VOID' => 44,
			'LITERAL_STRING' => 62,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			"if (" => 47,
			"(" => 73,
			'OP01_NAMED_VOID_PAREN' => 51,
			'OP05_MATH_NEG' => 70,
			"my" => 74,
			"foreach my" => -159
		},
		GOTOS => {
			'LoopLabel' => 53,
			'Expression' => 52,
			'Statement' => 72,
			'ArrayReference' => 71,
			'OPTIONAL-50' => 54,
			'PAREN-49' => 45,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'HashReference' => 66,
			'VariableDeclaration' => 84,
			'Operation' => 326,
			'OperatorVoid' => 58,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Variable' => 55,
			'WordScoped' => 77,
			'Conditional' => 76,
			'VariableModification' => 56
		}
	},
	{#State 316
		DEFAULT => -56
	},
	{#State 317
		ACTIONS => {
			'LITERAL_NUMBER' => -44,
			"my" => 151,
			'LITERAL_STRING' => -44
		},
		GOTOS => {
			'OPTIONAL-17' => 329,
			'TypeInner' => 328
		}
	},
	{#State 318
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 330
		}
	},
	{#State 319
		ACTIONS => {
			"our %properties = (" => -73,
			"fuse" => 25,
			'USE_CONSTANT' => -73
		},
		GOTOS => {
			'STAR-30' => 332,
			'Include' => 331
		}
	},
	{#State 320
		DEFAULT => -68
	},
	{#State 321
		DEFAULT => -168
	},
	{#State 322
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 112,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => 114,
			'OP18_TERNARY' => 113,
			")" => 333,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => 110,
			'OP04_MATH_POW' => 119,
			'OP16_LOGICAL_OR' => 118,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP15_LOGICAL_AND' => 122,
			'OP06_REGEX_MATCH' => 121,
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP24_LOGICAL_OR_XOR' => 116
		}
	},
	{#State 323
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 334
		}
	},
	{#State 324
		ACTIONS => {
			")" => 335,
			'OP18_TERNARY' => 113,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => 114,
			'OP11_COMPARE_LT_GT' => 112,
			'OP04_MATH_POW' => 119,
			'OP23_LOGICAL_AND' => 110,
			'OP08_MATH_ADD_SUB' => 111,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP16_LOGICAL_OR' => 118,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP06_REGEX_MATCH' => 121,
			'OP15_LOGICAL_AND' => 122
		}
	},
	{#State 325
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 336
		}
	},
	{#State 326
		DEFAULT => -55
	},
	{#State 327
		ACTIONS => {
			";" => 337
		}
	},
	{#State 328
		DEFAULT => -43
	},
	{#State 329
		ACTIONS => {
			'LITERAL_STRING' => 62,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Literal' => 338
		}
	},
	{#State 330
		ACTIONS => {
			"]" => 341,
			'OP21_LIST_COMMA' => 339
		},
		GOTOS => {
			'PAREN-15' => 340
		}
	},
	{#State 331
		DEFAULT => -70
	},
	{#State 332
		ACTIONS => {
			'USE_CONSTANT' => 36,
			"our %properties = (" => 342
		},
		GOTOS => {
			'Constant' => 344,
			'Properties' => 343
		}
	},
	{#State 333
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 345
		}
	},
	{#State 334
		DEFAULT => -176
	},
	{#State 335
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 346
		}
	},
	{#State 336
		ACTIONS => {
			'OP21_LIST_COMMA' => 348,
			")" => 347
		},
		GOTOS => {
			'PAREN-23' => 349
		}
	},
	{#State 337
		DEFAULT => -57
	},
	{#State 338
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 350
		}
	},
	{#State 339
		ACTIONS => {
			'LITERAL_STRING' => -39,
			"my" => 151,
			'LITERAL_NUMBER' => -39
		},
		GOTOS => {
			'OPTIONAL-14' => 352,
			'TypeInner' => 351
		}
	},
	{#State 340
		DEFAULT => -41
	},
	{#State 341
		DEFAULT => -51
	},
	{#State 342
		ACTIONS => {
			"%{" => 57,
			")" => 353,
			'WORD' => 356
		},
		GOTOS => {
			'HashEntryTyped' => 355,
			'HashDereferenced' => 354
		}
	},
	{#State 343
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 357
		}
	},
	{#State 344
		DEFAULT => -72
	},
	{#State 345
		DEFAULT => -165
	},
	{#State 346
		DEFAULT => -175
	},
	{#State 347
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 358
		}
	},
	{#State 348
		ACTIONS => {
			"my" => 359
		}
	},
	{#State 349
		DEFAULT => -59
	},
	{#State 350
		ACTIONS => {
			"}" => 361,
			'OP21_LIST_COMMA' => 360
		},
		GOTOS => {
			'PAREN-19' => 362
		}
	},
	{#State 351
		DEFAULT => -38
	},
	{#State 352
		ACTIONS => {
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'Literal' => 363
		}
	},
	{#State 353
		ACTIONS => {
			";" => 364
		}
	},
	{#State 354
		DEFAULT => -211
	},
	{#State 355
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 365
		}
	},
	{#State 356
		ACTIONS => {
			'OP20_HASH_FATARROW' => 366
		}
	},
	{#State 357
		ACTIONS => {
			"our" => 369,
			"1;" => 368
		},
		GOTOS => {
			'Method' => 367
		}
	},
	{#State 358
		ACTIONS => {
			"\@_;" => 370
		}
	},
	{#State 359
		ACTIONS => {
			'WORD' => 155
		},
		GOTOS => {
			'Type' => 371
		}
	},
	{#State 360
		ACTIONS => {
			'WORD' => 372
		}
	},
	{#State 361
		DEFAULT => -52
	},
	{#State 362
		DEFAULT => -48
	},
	{#State 363
		DEFAULT => -40
	},
	{#State 364
		DEFAULT => -86
	},
	{#State 365
		ACTIONS => {
			")" => 373,
			'OP21_LIST_COMMA' => 374
		},
		GOTOS => {
			'PAREN-35' => 375
		}
	},
	{#State 366
		ACTIONS => {
			"my" => 151
		},
		GOTOS => {
			'TypeInner' => 376
		}
	},
	{#State 367
		DEFAULT => -74
	},
	{#State 368
		ACTIONS => {
			"1;" => 377
		}
	},
	{#State 369
		ACTIONS => {
			'WORD' => 155
		},
		GOTOS => {
			'Type' => 378
		}
	},
	{#State 370
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 379
		}
	},
	{#State 371
		ACTIONS => {
			'VARIABLE_SYMBOL' => 380
		}
	},
	{#State 372
		ACTIONS => {
			'OP20_HASH_FATARROW' => 381
		}
	},
	{#State 373
		ACTIONS => {
			";" => 382
		}
	},
	{#State 374
		ACTIONS => {
			"%{" => 57,
			'WORD' => 356
		},
		GOTOS => {
			'HashDereferenced' => 354,
			'HashEntryTyped' => 383
		}
	},
	{#State 375
		DEFAULT => -83
	},
	{#State 376
		ACTIONS => {
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'LITERAL_STRING' => 62,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50,
			'OP05_LOGICAL_NEG' => 48,
			"(" => 73,
			'OP05_MATH_NEG' => 70,
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"%{" => 57,
			"{" => 86,
			'WORD' => 13,
			"undef" => 85
		},
		GOTOS => {
			'HashReference' => 66,
			'WordScoped' => 77,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'Variable' => 99,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Operator' => 79,
			'Expression' => 384
		}
	},
	{#State 377
		ACTIONS => {
			"our" => 83,
			'' => -80,
			"package" => -80
		},
		GOTOS => {
			'OPTIONAL-34' => 386,
			'PAREN-33' => 387,
			'Subroutine' => 388,
			'PLUS-32' => 385
		}
	},
	{#State 378
		ACTIONS => {
			'VARIABLE_SYMBOL' => 389
		}
	},
	{#State 379
		ACTIONS => {
			'OP05_MATH_NEG' => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			"(" => -63,
			"foreach my" => -63,
			"my" => -63,
			'LITERAL_STRING' => -63,
			'OP01_NAMED_VOID' => -63,
			"\@{" => -63,
			'OP22_LOGICAL_NOT' => -63,
			'OP10_NAMED_UNARY' => -63,
			"if (" => -63,
			'OP05_LOGICAL_NEG' => -63,
			'OP01_NAMED' => -63,
			'OP03_MATH_INC_DEC' => -63,
			"[" => -63,
			"%{" => -63,
			'OP19_LOOP_CONTROL' => -63,
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			"undef" => -63,
			"for my integer" => -63,
			"{" => -63,
			'WORD' => -63,
			'VARIABLE_SYMBOL' => -63,
			"while (" => -63,
			'CHECK_OR_CHECKTRACE' => 391,
			'WORD_SCOPED' => -63,
			'LITERAL_NUMBER' => -63
		},
		GOTOS => {
			'ArgumentCheck' => 390
		}
	},
	{#State 380
		DEFAULT => -58
	},
	{#State 381
		ACTIONS => {
			'LITERAL_STRING' => -46,
			'LITERAL_NUMBER' => -46,
			"my" => 151
		},
		GOTOS => {
			'OPTIONAL-18' => 392,
			'TypeInner' => 393
		}
	},
	{#State 382
		DEFAULT => -85
	},
	{#State 383
		DEFAULT => -82
	},
	{#State 384
		ACTIONS => {
			'OP06_REGEX_MATCH' => 121,
			'OP15_LOGICAL_AND' => 122,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP16_LOGICAL_OR' => 118,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP04_MATH_POW' => 119,
			'OP08_MATH_ADD_SUB' => 111,
			'OP23_LOGICAL_AND' => 110,
			'OP21_LIST_COMMA' => -210,
			'OP11_COMPARE_LT_GT' => 112,
			")" => -210,
			'OP18_TERNARY' => 113,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => 114
		}
	},
	{#State 385
		ACTIONS => {
			"our" => 83,
			"1;" => 395
		},
		GOTOS => {
			'Subroutine' => 394
		}
	},
	{#State 386
		DEFAULT => -81
	},
	{#State 387
		DEFAULT => -79
	},
	{#State 388
		DEFAULT => -77
	},
	{#State 389
		ACTIONS => {
			"= sub {" => 396
		}
	},
	{#State 390
		DEFAULT => -61
	},
	{#State 391
		ACTIONS => {
			"(" => 397
		}
	},
	{#State 392
		ACTIONS => {
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'Literal' => 398
		}
	},
	{#State 393
		DEFAULT => -45
	},
	{#State 394
		DEFAULT => -76
	},
	{#State 395
		ACTIONS => {
			"1;" => 399
		}
	},
	{#State 396
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -88,
			"[" => -88,
			'OP01_NAMED' => -88,
			"( my" => 401,
			'OP05_LOGICAL_NEG' => -88,
			"if (" => -88,
			'OP10_NAMED_UNARY' => -88,
			"\@{" => -88,
			'OP22_LOGICAL_NOT' => -88,
			'LITERAL_STRING' => -88,
			'OP01_NAMED_VOID' => -88,
			"my" => -88,
			"foreach my" => -88,
			"(" => -88,
			'OP01_NAMED_VOID_PAREN' => -88,
			'OP05_MATH_NEG' => -88,
			'LITERAL_NUMBER' => -88,
			'WORD_SCOPED' => -88,
			'VARIABLE_SYMBOL' => -88,
			"while (" => -88,
			"{" => -88,
			'WORD' => -88,
			"for my integer" => -88,
			"undef" => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			"%{" => -88,
			'OP19_LOOP_CONTROL' => -88
		},
		GOTOS => {
			'MethodArguments' => 400,
			'OPTIONAL-37' => 402
		}
	},
	{#State 397
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			'WORD' => 13,
			"{" => 86,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			'OP05_LOGICAL_NEG' => 48,
			'OP03_MATH_INC_DEC' => 68,
			"[" => 69,
			'OP01_NAMED' => 50,
			'OP05_MATH_NEG' => 70,
			"(" => 73
		},
		GOTOS => {
			'HashReference' => 66,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'WordScoped' => 77,
			'Variable' => 99,
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Expression' => 403
		}
	},
	{#State 398
		DEFAULT => -47
	},
	{#State 399
		DEFAULT => -78
	},
	{#State 400
		DEFAULT => -87
	},
	{#State 401
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 404
		}
	},
	{#State 402
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 48,
			"if (" => 47,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'LITERAL_STRING' => 62,
			'OP01_NAMED_VOID' => 44,
			'OP10_NAMED_UNARY' => 65,
			'OP22_LOGICAL_NOT' => 64,
			"\@{" => 63,
			"foreach my" => -159,
			"my" => 74,
			'OP05_MATH_NEG' => 70,
			"(" => 73,
			'OP01_NAMED_VOID_PAREN' => 51,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75,
			"while (" => -159,
			"for my integer" => -159,
			"undef" => 85,
			"{" => 86,
			'WORD' => 61,
			"%{" => 57,
			'OP19_LOOP_CONTROL' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 82
		},
		GOTOS => {
			'Variable' => 55,
			'WordScoped' => 77,
			'Conditional' => 76,
			'VariableModification' => 56,
			'VariableDeclaration' => 84,
			'Operation' => 406,
			'ArrayDereferenced' => 59,
			'OperatorVoid' => 58,
			'Operator' => 79,
			'PAREN-49' => 45,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'HashReference' => 66,
			'LoopLabel' => 53,
			'Statement' => 72,
			'Expression' => 52,
			'PLUS-38' => 405,
			'ArrayReference' => 71,
			'OPTIONAL-50' => 54
		}
	},
	{#State 403
		ACTIONS => {
			'OP16_LOGICAL_OR' => 118,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP15_LOGICAL_AND' => 122,
			'OP06_REGEX_MATCH' => 121,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP11_COMPARE_LT_GT' => 112,
			'OP21_LIST_COMMA' => 408,
			'OP17_LIST_RANGE' => 114,
			'OP09_BITWISE_SHIFT' => 115,
			")" => -66,
			'OP18_TERNARY' => 113,
			'OP23_LOGICAL_AND' => 110,
			'OP08_MATH_ADD_SUB' => 111,
			'OP04_MATH_POW' => 119
		},
		GOTOS => {
			'PAREN-26' => 409,
			'OPTIONAL-27' => 407
		}
	},
	{#State 404
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 410
		}
	},
	{#State 405
		ACTIONS => {
			'OP05_MATH_NEG' => 70,
			'OP01_NAMED_VOID_PAREN' => 51,
			"(" => 73,
			"foreach my" => -159,
			"my" => 74,
			'OP01_NAMED_VOID' => 44,
			'LITERAL_STRING' => 62,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			"if (" => 47,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			"%{" => 57,
			'OP19_LOOP_CONTROL' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			"undef" => 85,
			"for my integer" => -159,
			"{" => 86,
			'WORD' => 61,
			'VARIABLE_SYMBOL' => 75,
			"while (" => -159,
			"}" => 412,
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Variable' => 55,
			'Conditional' => 76,
			'VariableModification' => 56,
			'WordScoped' => 77,
			'ArrayDereferenced' => 59,
			'OperatorVoid' => 58,
			'Operator' => 79,
			'VariableDeclaration' => 84,
			'Operation' => 411,
			'PAREN-49' => 45,
			'HashReference' => 66,
			'Literal' => 67,
			'HashDereferenced' => 49,
			'ArrayReference' => 71,
			'LoopLabel' => 53,
			'Statement' => 72,
			'Expression' => 52,
			'OPTIONAL-50' => 54
		}
	},
	{#State 406
		DEFAULT => -90
	},
	{#State 407
		ACTIONS => {
			")" => 413
		}
	},
	{#State 408
		ACTIONS => {
			'WORD_SCOPED' => 15,
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 75,
			"undef" => 85,
			'WORD' => 13,
			"{" => 86,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'OP05_LOGICAL_NEG' => 48,
			'OP01_NAMED' => 50,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'LITERAL_STRING' => 62,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64,
			'OP10_NAMED_UNARY' => 65,
			'OP05_MATH_NEG' => 70,
			"(" => 73
		},
		GOTOS => {
			'Operator' => 79,
			'ArrayDereferenced' => 59,
			'ArrayReference' => 71,
			'Expression' => 414,
			'HashReference' => 66,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'WordScoped' => 77,
			'Variable' => 99
		}
	},
	{#State 409
		DEFAULT => -65
	},
	{#State 410
		ACTIONS => {
			'OP21_LIST_COMMA' => 416,
			")" => 415
		},
		GOTOS => {
			'PAREN-39' => 417
		}
	},
	{#State 411
		DEFAULT => -89
	},
	{#State 412
		ACTIONS => {
			";" => 418
		}
	},
	{#State 413
		ACTIONS => {
			";" => 419
		}
	},
	{#State 414
		ACTIONS => {
			'OP23_LOGICAL_AND' => 110,
			'OP08_MATH_ADD_SUB' => 111,
			'OP04_MATH_POW' => 119,
			'OP21_LIST_COMMA' => 420,
			'OP11_COMPARE_LT_GT' => 112,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => 114,
			'OP18_TERNARY' => 113,
			'OP15_LOGICAL_AND' => 122,
			'OP06_REGEX_MATCH' => 121,
			'OP08_STRING_CAT' => 117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP16_LOGICAL_OR' => 118,
			'OP14_BITWISE_OR_XOR' => 126,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => 125
		}
	},
	{#State 415
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 421
		}
	},
	{#State 416
		ACTIONS => {
			"my" => 422
		}
	},
	{#State 417
		DEFAULT => -93
	},
	{#State 418
		DEFAULT => -91
	},
	{#State 419
		DEFAULT => -67
	},
	{#State 420
		ACTIONS => {
			"undef" => 85,
			"{" => 86,
			'WORD' => 13,
			"%{" => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 82,
			'LITERAL_NUMBER' => 78,
			'WORD_SCOPED' => 15,
			'VARIABLE_SYMBOL' => 75,
			'OP05_MATH_NEG' => 70,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 48,
			"[" => 69,
			'OP03_MATH_INC_DEC' => 68,
			'OP01_NAMED' => 50,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 65,
			"\@{" => 63,
			'OP22_LOGICAL_NOT' => 64
		},
		GOTOS => {
			'HashReference' => 66,
			'WordScoped' => 77,
			'HashDereferenced' => 49,
			'Literal' => 67,
			'Variable' => 99,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 59,
			'Operator' => 79,
			'Expression' => 423
		}
	},
	{#State 421
		ACTIONS => {
			"\@_;" => 424
		}
	},
	{#State 422
		ACTIONS => {
			'WORD' => 155
		},
		GOTOS => {
			'Type' => 425
		}
	},
	{#State 423
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 126,
			'OP12_COMPARE_EQ_NEQ' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP16_LOGICAL_OR' => 118,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 117,
			'OP24_LOGICAL_OR_XOR' => 116,
			'OP15_LOGICAL_AND' => 122,
			'OP06_REGEX_MATCH' => 121,
			'OP09_BITWISE_SHIFT' => 115,
			'OP17_LIST_RANGE' => 114,
			")" => -64,
			'OP18_TERNARY' => 113,
			'OP11_COMPARE_LT_GT' => 112,
			'OP23_LOGICAL_AND' => 110,
			'OP08_MATH_ADD_SUB' => 111,
			'OP04_MATH_POW' => 119
		}
	},
	{#State 424
		DEFAULT => -96,
		GOTOS => {
			'STAR-41' => 426
		}
	},
	{#State 425
		ACTIONS => {
			'VARIABLE_SYMBOL' => 427
		}
	},
	{#State 426
		ACTIONS => {
			'OP05_MATH_NEG' => -97,
			"(" => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			"foreach my" => -97,
			"my" => -97,
			'OP01_NAMED_VOID' => -97,
			'LITERAL_STRING' => -97,
			'OP10_NAMED_UNARY' => -97,
			'OP22_LOGICAL_NOT' => -97,
			"\@{" => -97,
			'OP05_LOGICAL_NEG' => -97,
			"if (" => -97,
			'OP03_MATH_INC_DEC' => -97,
			"[" => -97,
			'OP01_NAMED' => -97,
			"%{" => -97,
			'OP19_LOOP_CONTROL' => -97,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			"for my integer" => -97,
			"undef" => -97,
			'WORD' => -97,
			"{" => -97,
			'VARIABLE_SYMBOL' => -97,
			"while (" => -97,
			'CHECK_OR_CHECKTRACE' => 391,
			'LITERAL_NUMBER' => -97,
			'WORD_SCOPED' => -97
		},
		GOTOS => {
			'ArgumentCheck' => 428
		}
	},
	{#State 427
		DEFAULT => -92
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
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5628 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5635 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5646 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5657 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5664 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5671 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5678 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5685 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5692 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5699 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5706 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5713 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5720 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5727 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5738 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5749 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5760 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5767 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5774 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5781 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5788 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5795 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5802 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5809 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5816 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 10,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 5,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5838 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5845 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5852 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5863 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5877 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5888 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5899 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5910 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5917 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5924 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5931 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5938 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5945 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5952 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5973 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5980 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5987 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5994 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6001 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6008 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6019 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6030 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6041 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6048 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6055 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6062 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6069 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6080 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6087 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6094 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6108 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6115 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6126 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6140 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6147 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6172 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6179 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6186 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6193 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6200 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6207 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6214 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6221 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6228 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 3,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6235 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6242 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 18,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6260 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6267 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6274 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6281 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 5,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6303 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6310 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6317 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6324 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6331 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6342 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6349 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6356 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6363 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6370 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6377 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6388 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6399 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6410 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6417 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6446 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6457 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6468 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6479 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6490 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6501 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6512 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6523 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6534 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6556 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6600 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6611 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6622 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6633 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6644 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6655 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6666 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6677 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6688 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6695 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6755 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6766 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6777 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6788 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6799 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6806 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6813 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6820 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6827 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6838 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6849 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6860 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6871 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6904 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6926 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6937 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6948 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_155
		 'ExpressionOrStdin', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6970 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_156
		 'ExpressionOrStdin', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6981 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6988 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7035 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_163
		 'Statement', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7046 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_164
		 'Statement', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7092 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7099 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_171
		 'Conditional', 6,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7110 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7121 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_173
		 'Loop', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7132 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_174
		 'Loop', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7143 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_175
		 'LoopFor', 8,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_176
		 'LoopForEach', 7,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7165 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_177
		 'LoopWhile', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7176 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7190 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_180
		 'CodeBlock', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7208 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7215 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_183
		 'Variable', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7226 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7237 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_185
		 'VariableRetrieval', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7248 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_186
		 'VariableRetrieval', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7259 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_187
		 'VariableDeclaration', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7270 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_188
		 'VariableDeclaration', 6,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7281 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_189
		 'VariableModification', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_190
		 'VariableModification', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7303 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7324 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7331 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_196
		 'ListElements', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7349 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_197
		 'ListElements', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7360 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_198
		 'ListElement', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7371 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_199
		 'ListElement', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7382 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_200
		 'ListElement', 2,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7393 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7400 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7407 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_203
		 'ArrayReference', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7418 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_204
		 'ArrayDereferenced', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7429 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_205
		 'ArrayDereferenced', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7447 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7454 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_208
		 'HashEntry', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7465 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_209
		 'HashEntry', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7476 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_210
		 'HashEntryTyped', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7487 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_211
		 'HashEntryTyped', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7498 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-62', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7512 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_215
		 'HashReference', 4,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_216
		 'HashDereferenced', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_217
		 'HashDereferenced', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7552 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_218
		 'WordScoped', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7563 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_219
		 'WordScoped', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7574 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_220
		 'FileHandle', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7585 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_221
		 'FileHandle', 3,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7596 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_222
		 'TypeInner', 5,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule Type_223
		 'Type', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7618 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_224
		 'LoopLabel', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_225
		 'Literal', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_226
		 'Literal', 1,
sub {
#line 30 "lib/RPerl/Grammar.eyp"

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

#line 205 "lib/RPerl/Grammar.eyp"


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
