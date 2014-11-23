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
    our $VERSION = 0.000_738;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|filehandle_ref|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\$TYPED_|\<STDIN\>|package|\=\ sub\ \{|elsif\ \(|while\ \(|undef|if\ \(|\(\ my|else|qw\(|\@_\;|use|our|\.\.|\{\*|my|\%\{|\@\{|1\;|\(|\[|\]|\{|\/|\)|\}|\;)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
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


#line 115 lib/RPerl/Grammar.pm

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
  [ 'Program_15' => 'Program', [ 'SHEBANG', 'Header', 'STAR-2', 'STAR-3', 'STAR-4', 'STAR-5', 'PLUS-6' ], 0 ],
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
  [ 'Properties_85' => 'Properties', [ 'our %properties = (', 'Critic', 'HashEntryTyped', 'STAR-36', ')', ';' ], 0 ],
  [ 'Properties_86' => 'Properties', [ 'our %properties = (', ')', ';', 'Critic' ], 0 ],
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
	SHEBANG => { ISSEMANTIC => 1 },
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
			"package" => 8,
			'SHEBANG' => 6
		},
		GOTOS => {
			'Module' => 5,
			'PLUS-1' => 4,
			'Program' => 3,
			'Package' => 7,
			'Class' => 2,
			'CompileUnit' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'' => 9
		}
	},
	{#State 2
		DEFAULT => -17
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		ACTIONS => {
			"package" => 8,
			'' => -4
		},
		GOTOS => {
			'Package' => 7,
			'Class' => 2,
			'Module' => 10
		}
	},
	{#State 5
		DEFAULT => -2
	},
	{#State 6
		ACTIONS => {
			"use strict;" => 12
		},
		GOTOS => {
			'Header' => 11
		}
	},
	{#State 7
		DEFAULT => -16
	},
	{#State 8
		ACTIONS => {
			'WORD' => 15,
			'WORD_SCOPED' => 13
		},
		GOTOS => {
			'WordScoped' => 14
		}
	},
	{#State 9
		DEFAULT => 0
	},
	{#State 10
		DEFAULT => -1
	},
	{#State 11
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 16
		}
	},
	{#State 12
		ACTIONS => {
			"use warnings;" => 17
		}
	},
	{#State 13
		DEFAULT => -219
	},
	{#State 14
		ACTIONS => {
			";" => 18
		}
	},
	{#State 15
		DEFAULT => -218
	},
	{#State 16
		ACTIONS => {
			"while (" => -8,
			'OP10_NAMED_UNARY' => -8,
			'WORD_SCOPED' => -8,
			'LITERAL_STRING' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			"%{" => -8,
			"undef" => -8,
			"## no critic qw(" => 20,
			'OP01_NAMED' => -8,
			"\@{" => -8,
			'OP19_LOOP_CONTROL' => -8,
			"use constant" => -8,
			"[" => -8,
			'VARIABLE_SYMBOL' => -8,
			'OP05_LOGICAL_NEG' => -8,
			'OP05_MATH_NEG' => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"our" => -8,
			"my" => -8,
			"(" => -8,
			"if (" => -8,
			"foreach my" => -8,
			'OP01_NAMED_VOID' => -8,
			"for my integer" => -8,
			'OP03_MATH_INC_DEC' => -8,
			'WORD' => -8,
			"{" => -8,
			'LITERAL_NUMBER' => -8,
			"use" => -8,
			'OP22_LOGICAL_NOT' => -8
		},
		GOTOS => {
			'Critic' => 19,
			'STAR-3' => 21
		}
	},
	{#State 17
		ACTIONS => {
			"use RPerl;" => 22
		}
	},
	{#State 18
		ACTIONS => {
			"use strict;" => 12
		},
		GOTOS => {
			'Header' => 23
		}
	},
	{#State 19
		DEFAULT => -5
	},
	{#State 20
		ACTIONS => {
			'WORD' => 25
		},
		GOTOS => {
			'PLUS-11' => 24
		}
	},
	{#State 21
		ACTIONS => {
			'OP05_MATH_NEG' => -10,
			'OP05_LOGICAL_NEG' => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			'VARIABLE_SYMBOL' => -10,
			"[" => -10,
			"if (" => -10,
			"(" => -10,
			"my" => -10,
			"our" => -10,
			'WORD' => -10,
			"for my integer" => -10,
			'OP03_MATH_INC_DEC' => -10,
			'OP01_NAMED_VOID' => -10,
			"foreach my" => -10,
			"use" => 28,
			'OP22_LOGICAL_NOT' => -10,
			'LITERAL_NUMBER' => -10,
			"{" => -10,
			'OP10_NAMED_UNARY' => -10,
			"while (" => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			'LITERAL_STRING' => -10,
			'WORD_SCOPED' => -10,
			'OP19_LOOP_CONTROL' => -10,
			"use constant" => -10,
			"\@{" => -10,
			'OP01_NAMED' => -10,
			"undef" => -10,
			"%{" => -10
		},
		GOTOS => {
			'STAR-4' => 26,
			'Include' => 27
		}
	},
	{#State 22
		ACTIONS => {
			"our" => 29
		}
	},
	{#State 23
		ACTIONS => {
			"use parent qw(" => 31,
			"use constant" => -19,
			"## no critic qw(" => -19,
			"use" => -19,
			"our" => -19
		},
		GOTOS => {
			'STAR-7' => 30
		}
	},
	{#State 24
		ACTIONS => {
			")" => 33,
			'WORD' => 32
		}
	},
	{#State 25
		DEFAULT => -29
	},
	{#State 26
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			'OP05_MATH_NEG' => -12,
			'VARIABLE_SYMBOL' => -12,
			"[" => -12,
			"if (" => -12,
			"(" => -12,
			"my" => -12,
			"our" => -12,
			'WORD' => -12,
			"for my integer" => -12,
			'OP03_MATH_INC_DEC' => -12,
			'OP01_NAMED_VOID' => -12,
			"foreach my" => -12,
			'OP22_LOGICAL_NOT' => -12,
			'LITERAL_NUMBER' => -12,
			"{" => -12,
			'OP10_NAMED_UNARY' => -12,
			"while (" => -12,
			'LITERAL_STRING' => -12,
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			'WORD_SCOPED' => -12,
			'OP19_LOOP_CONTROL' => -12,
			"use constant" => 35,
			"\@{" => -12,
			'OP01_NAMED' => -12,
			"undef" => -12,
			"%{" => -12
		},
		GOTOS => {
			'Constant' => 34,
			'STAR-5' => 36
		}
	},
	{#State 27
		DEFAULT => -7
	},
	{#State 28
		ACTIONS => {
			'WORD' => 15,
			'WORD_SCOPED' => 13
		},
		GOTOS => {
			'WordScoped' => 37
		}
	},
	{#State 29
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 38
		}
	},
	{#State 30
		ACTIONS => {
			"## no critic qw(" => 20,
			"use constant" => -21,
			"our" => -21,
			"use" => -21
		},
		GOTOS => {
			'STAR-8' => 39,
			'Critic' => 40
		}
	},
	{#State 31
		ACTIONS => {
			'WORD' => 15,
			'WORD_SCOPED' => 13
		},
		GOTOS => {
			'WordScoped' => 41
		}
	},
	{#State 32
		DEFAULT => -28
	},
	{#State 33
		DEFAULT => -30
	},
	{#State 34
		DEFAULT => -9
	},
	{#State 35
		ACTIONS => {
			'WORD' => 42
		}
	},
	{#State 36
		ACTIONS => {
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"undef" => 48,
			"%{" => 68,
			'OP19_LOOP_CONTROL' => 73,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			"while (" => -159,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'OP01_NAMED_VOID' => 58,
			"foreach my" => -159,
			'WORD' => 81,
			'OP03_MATH_INC_DEC' => 60,
			"for my integer" => -159,
			"my" => 78,
			"our" => 55,
			"(" => 57,
			"if (" => 80,
			"[" => 51,
			'OP01_NAMED_VOID_PAREN' => 77,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54
		},
		GOTOS => {
			'ArrayDereferenced' => 50,
			'VariableDeclaration' => 76,
			'PLUS-6' => 75,
			'Variable' => 79,
			'Operator' => 56,
			'LoopLabel' => 59,
			'OperatorVoid' => 61,
			'Conditional' => 85,
			'WordScoped' => 84,
			'Statement' => 43,
			'Expression' => 63,
			'Literal' => 44,
			'Operation' => 45,
			'HashDereferenced' => 69,
			'VariableModification' => 67,
			'PAREN-49' => 72,
			'OPTIONAL-50' => 49,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'Subroutine' => 74
		}
	},
	{#State 37
		ACTIONS => {
			";" => 86,
			"qw(" => 87
		}
	},
	{#State 38
		DEFAULT => -27
	},
	{#State 39
		ACTIONS => {
			"use" => 28,
			"our" => -23,
			"use constant" => -23
		},
		GOTOS => {
			'Include' => 88,
			'STAR-9' => 89
		}
	},
	{#State 40
		DEFAULT => -18
	},
	{#State 41
		ACTIONS => {
			")" => 90
		}
	},
	{#State 42
		ACTIONS => {
			'OP20_HASH_FATARROW' => 91
		}
	},
	{#State 43
		DEFAULT => -99
	},
	{#State 44
		DEFAULT => -144
	},
	{#State 45
		DEFAULT => -14
	},
	{#State 46
		ACTIONS => {
			"[" => 51,
			'VARIABLE_SYMBOL' => 54
		},
		GOTOS => {
			'Variable' => 92,
			'ArrayReference' => 93
		}
	},
	{#State 47
		ACTIONS => {
			"(" => 94
		}
	},
	{#State 48
		DEFAULT => -143
	},
	{#State 49
		ACTIONS => {
			"for my integer" => 101,
			"while (" => 95,
			"foreach my" => 99
		},
		GOTOS => {
			'LoopFor' => 97,
			'LoopWhile' => 100,
			'Loop' => 96,
			'LoopForEach' => 98
		}
	},
	{#State 50
		DEFAULT => -147
	},
	{#State 51
		ACTIONS => {
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"undef" => 48,
			"%{" => 68,
			'OP01_NAMED_QW' => 106,
			'OP10_NAMED_UNARY' => 64,
			"]" => -202,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51,
			"(" => 57,
			'KEYS_OR_VALUES' => 107,
			"my" => 102
		},
		GOTOS => {
			'Literal' => 44,
			'ListElement' => 108,
			'Variable' => 103,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 104,
			'TypeInner' => 109,
			'WordScoped' => 84,
			'OPTIONAL-60' => 105,
			'ListElements' => 110,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71
		}
	},
	{#State 52
		ACTIONS => {
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			"(" => 57,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54
		},
		GOTOS => {
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'WordScoped' => 84,
			'ArrayDereferenced' => 50,
			'Expression' => 111,
			'Literal' => 44,
			'Variable' => 103,
			'Operator' => 56
		}
	},
	{#State 53
		ACTIONS => {
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 64,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51,
			"(" => 57
		},
		GOTOS => {
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103,
			'Expression' => 112,
			'ArrayDereferenced' => 50,
			'WordScoped' => 84,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69
		}
	},
	{#State 54
		DEFAULT => -182,
		GOTOS => {
			'STAR-56' => 113
		}
	},
	{#State 55
		ACTIONS => {
			'WORD' => 114
		},
		GOTOS => {
			'Type' => 115
		}
	},
	{#State 56
		DEFAULT => -151
	},
	{#State 57
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			"(" => 57,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"undef" => 48,
			"%{" => 68,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64
		},
		GOTOS => {
			'ArrayDereferenced' => 50,
			'Expression' => 116,
			'Variable' => 103,
			'Literal' => 44,
			'Operator' => 56,
			'HashDereferenced' => 69,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'WordScoped' => 84
		}
	},
	{#State 58
		ACTIONS => {
			'WORD_SCOPED' => 13,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'OP10_NAMED_UNARY' => 64,
			'OP01_NAMED_QW' => 106,
			";" => -131,
			"%{" => 68,
			"undef" => 48,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			'KEYS_OR_VALUES' => 107,
			"(" => 57,
			"my" => 118,
			'VARIABLE_SYMBOL' => 54,
			"{*" => 120,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 62,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15
		},
		GOTOS => {
			'WordScoped' => 84,
			'HashDereferenced' => 69,
			'ListElements' => 121,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'Variable' => 103,
			'ListElement' => 108,
			'Literal' => 44,
			'FileHandle' => 117,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'OPTIONAL-45' => 119,
			'TypeInner' => 109,
			'Expression' => 104
		}
	},
	{#State 59
		ACTIONS => {
			'COLON' => 122
		}
	},
	{#State 60
		ACTIONS => {
			'VARIABLE_SYMBOL' => 54
		},
		GOTOS => {
			'Variable' => 123
		}
	},
	{#State 61
		DEFAULT => -162
	},
	{#State 62
		ACTIONS => {
			"undef" => 48,
			"%{" => 68,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY' => 64,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			"(" => 57,
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53
		},
		GOTOS => {
			'WordScoped' => 84,
			'HashDereferenced' => 69,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'Variable' => 103,
			'Literal' => 44,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 124
		}
	},
	{#State 63
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 131,
			'OP16_LOGICAL_OR' => 138,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP08_MATH_ADD_SUB' => 127,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP18_TERNARY' => 137,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 129,
			'OP17_LIST_RANGE' => 128,
			'OP23_LOGICAL_AND' => 140,
			";" => 134,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP08_STRING_CAT' => 141,
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139
		}
	},
	{#State 64
		ACTIONS => {
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48,
			"(" => 57,
			"[" => 51,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60
		},
		GOTOS => {
			'Expression' => 142,
			'ArrayDereferenced' => 50,
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69,
			'WordScoped' => 84
		}
	},
	{#State 65
		ACTIONS => {
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51,
			"(" => 57
		},
		GOTOS => {
			'ArrayDereferenced' => 50,
			'Expression' => 143,
			'Literal' => 44,
			'Variable' => 103,
			'Operator' => 56,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'WordScoped' => 84
		}
	},
	{#State 66
		DEFAULT => -225
	},
	{#State 67
		DEFAULT => -164
	},
	{#State 68
		ACTIONS => {
			"{" => 144,
			'VARIABLE_SYMBOL' => 54
		},
		GOTOS => {
			'HashReference' => 146,
			'Variable' => 145
		}
	},
	{#State 69
		DEFAULT => -149
	},
	{#State 70
		DEFAULT => -146
	},
	{#State 71
		DEFAULT => -148
	},
	{#State 72
		DEFAULT => -158
	},
	{#State 73
		ACTIONS => {
			'WORD' => 147
		},
		GOTOS => {
			'LoopLabel' => 148
		}
	},
	{#State 74
		DEFAULT => -11
	},
	{#State 75
		ACTIONS => {
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP05_MATH_NEG' => 53,
			'OP01_NAMED_VOID_PAREN' => 77,
			'OP05_LOGICAL_NEG' => 52,
			"my" => 78,
			"(" => 57,
			"if (" => 80,
			"foreach my" => -159,
			'OP01_NAMED_VOID' => 58,
			"for my integer" => -159,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 81,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62,
			"while (" => -159,
			'OP10_NAMED_UNARY' => 64,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			"undef" => 48,
			"%{" => 68,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			'OP19_LOOP_CONTROL' => 73,
			'' => -15
		},
		GOTOS => {
			'Operation' => 149,
			'Literal' => 44,
			'Statement' => 43,
			'Expression' => 63,
			'HashDereferenced' => 69,
			'VariableModification' => 67,
			'PAREN-49' => 72,
			'OPTIONAL-50' => 49,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'Variable' => 79,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'VariableDeclaration' => 76,
			'OperatorVoid' => 61,
			'Conditional' => 85,
			'WordScoped' => 84,
			'LoopLabel' => 59
		}
	},
	{#State 76
		DEFAULT => -163
	},
	{#State 77
		ACTIONS => {
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54,
			"{*" => 120,
			"[" => 51,
			"(" => 57,
			'KEYS_OR_VALUES' => 107,
			"my" => 118,
			")" => -127,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP10_NAMED_UNARY' => 64,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48,
			'OP01_NAMED_QW' => 106
		},
		GOTOS => {
			'WordScoped' => 84,
			'ListElements' => 152,
			'HashDereferenced' => 69,
			'OPTIONAL-43' => 151,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'FileHandle' => 150,
			'Literal' => 44,
			'ListElement' => 108,
			'Variable' => 103,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 104,
			'TypeInner' => 109
		}
	},
	{#State 78
		ACTIONS => {
			'WORD' => 114
		},
		GOTOS => {
			'Type' => 153
		}
	},
	{#State 79
		ACTIONS => {
			'OP17_LIST_RANGE' => -145,
			'OP18_TERNARY' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP04_MATH_POW' => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP03_MATH_INC_DEC' => 154,
			'OP09_BITWISE_SHIFT' => -145,
			'OP02_METHOD_THINARROW' => 156,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP08_STRING_CAT' => -145,
			";" => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 157,
			'OP19_VARIABLE_ASSIGN' => 155,
			'OP23_LOGICAL_AND' => -145
		}
	},
	{#State 80
		ACTIONS => {
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			"(" => 57,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54
		},
		GOTOS => {
			'Expression' => 158,
			'ArrayDereferenced' => 50,
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69,
			'WordScoped' => 84
		}
	},
	{#State 81
		ACTIONS => {
			'COLON' => -224,
			"(" => -218
		}
	},
	{#State 82
		DEFAULT => -226
	},
	{#State 83
		ACTIONS => {
			"%{" => 68,
			"}" => 159,
			'WORD' => 161
		},
		GOTOS => {
			'HashEntry' => 162,
			'HashDereferenced' => 160
		}
	},
	{#State 84
		ACTIONS => {
			"(" => 163
		}
	},
	{#State 85
		DEFAULT => -160
	},
	{#State 86
		DEFAULT => -33
	},
	{#State 87
		ACTIONS => {
			'WORD' => 164
		},
		GOTOS => {
			'PLUS-12' => 165
		}
	},
	{#State 88
		DEFAULT => -20
	},
	{#State 89
		ACTIONS => {
			"our" => 55,
			"use constant" => 35
		},
		GOTOS => {
			'PLUS-10' => 167,
			'Constant' => 168,
			'Subroutine' => 166
		}
	},
	{#State 90
		ACTIONS => {
			";" => 169
		}
	},
	{#State 91
		ACTIONS => {
			"my" => 102
		},
		GOTOS => {
			'TypeInner' => 170
		}
	},
	{#State 92
		ACTIONS => {
			"}" => 171
		}
	},
	{#State 93
		ACTIONS => {
			"}" => 172
		}
	},
	{#State 94
		ACTIONS => {
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			"my" => 102,
			"(" => 57,
			'KEYS_OR_VALUES' => 107,
			'WORD' => 15,
			")" => -101,
			'OP03_MATH_INC_DEC' => 60,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'OP10_NAMED_UNARY' => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48,
			'OP01_NAMED_QW' => 106
		},
		GOTOS => {
			'ListElements' => 174,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'WordScoped' => 84,
			'OPTIONAL-42' => 173,
			'ArrayDereferenced' => 50,
			'Expression' => 104,
			'TypeInner' => 109,
			'Literal' => 44,
			'ListElement' => 108,
			'Variable' => 103,
			'Operator' => 56
		}
	},
	{#State 95
		ACTIONS => {
			'VARIABLE_SYMBOL' => 54,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			"[" => 51,
			"(" => 57,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			'OP22_LOGICAL_NOT' => 62,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP10_NAMED_UNARY' => 64,
			'WORD_SCOPED' => 13,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			"%{" => 68,
			"undef" => 48,
			'OP01_NAMED' => 47,
			"\@{" => 46
		},
		GOTOS => {
			'WordScoped' => 84,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'HashDereferenced' => 69,
			'Operator' => 56,
			'Variable' => 103,
			'Literal' => 44,
			'Expression' => 175,
			'ArrayDereferenced' => 50
		}
	},
	{#State 96
		DEFAULT => -161
	},
	{#State 97
		DEFAULT => -172
	},
	{#State 98
		DEFAULT => -173
	},
	{#State 99
		ACTIONS => {
			'WORD' => 114
		},
		GOTOS => {
			'Type' => 176
		}
	},
	{#State 100
		DEFAULT => -174
	},
	{#State 101
		ACTIONS => {
			'VARIABLE_SYMBOL' => 177
		}
	},
	{#State 102
		ACTIONS => {
			'WORD' => 114
		},
		GOTOS => {
			'Type' => 178
		}
	},
	{#State 103
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP04_MATH_POW' => -145,
			".." => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP18_TERNARY' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			")" => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP03_MATH_INC_DEC' => 154,
			"]" => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP02_METHOD_THINARROW' => 156,
			'OP11_COMPARE_LT_GT' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP21_LIST_COMMA' => -145,
			'OP08_STRING_CAT' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			"}" => -145,
			";" => -145
		}
	},
	{#State 104
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 138,
			")" => -198,
			'OP09_BITWISE_SHIFT' => 131,
			'OP17_LIST_RANGE' => 128,
			'OP18_TERNARY' => 137,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 129,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP08_MATH_ADD_SUB' => 127,
			'OP08_STRING_CAT' => 141,
			";" => -198,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP23_LOGICAL_AND' => 140,
			'OP21_LIST_COMMA' => -198,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			"]" => -198
		}
	},
	{#State 105
		ACTIONS => {
			"]" => 179
		}
	},
	{#State 106
		ACTIONS => {
			"(" => 180
		}
	},
	{#State 107
		ACTIONS => {
			"%{" => 68
		},
		GOTOS => {
			'HashDereferenced' => 181
		}
	},
	{#State 108
		DEFAULT => -193,
		GOTOS => {
			'STAR-58' => 182
		}
	},
	{#State 109
		ACTIONS => {
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"undef" => 48,
			"%{" => 68,
			'OP10_NAMED_UNARY' => 64,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			"(" => 57
		},
		GOTOS => {
			'Expression' => 183,
			'ArrayDereferenced' => 50,
			'Operator' => 56,
			'Variable' => 103,
			'Literal' => 44,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'HashDereferenced' => 69,
			'WordScoped' => 84
		}
	},
	{#State 110
		DEFAULT => -201
	},
	{#State 111
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			")" => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP13_BITWISE_AND' => -106,
			".." => -106,
			'OP04_MATH_POW' => 125,
			'OP08_MATH_ADD_SUB' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP06_REGEX_MATCH' => -106,
			'OP18_TERNARY' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP08_STRING_CAT' => -106,
			";" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			"}" => -106,
			"]" => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP11_COMPARE_LT_GT' => -106
		}
	},
	{#State 112
		ACTIONS => {
			'OP23_LOGICAL_AND' => 140,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			'OP09_BITWISE_SHIFT' => 131,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 138,
			")" => 184,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => 136,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => 128,
			'OP18_TERNARY' => 137,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 129
		}
	},
	{#State 113
		ACTIONS => {
			"}" => -183,
			";" => -183,
			'OP14_BITWISE_OR_XOR' => -183,
			'OP02_ARRAY_THINARROW' => 187,
			'OP08_STRING_CAT' => -183,
			'OP21_LIST_COMMA' => -183,
			'OP23_LOGICAL_AND' => -183,
			'COLON' => -183,
			'OP19_VARIABLE_ASSIGN' => -183,
			'OP19_VARIABLE_ASSIGN_BY' => -183,
			'OP11_COMPARE_LT_GT' => -183,
			'OP07_MATH_MULT_DIV_MOD' => -183,
			'OP02_METHOD_THINARROW' => -183,
			"]" => -183,
			")" => -183,
			'OP03_MATH_INC_DEC' => -183,
			'OP16_LOGICAL_OR' => -183,
			'OP12_COMPARE_EQ_NEQ' => -183,
			'OP09_BITWISE_SHIFT' => -183,
			'OP02_HASH_THINARROW' => 186,
			'OP15_LOGICAL_AND' => -183,
			'OP06_REGEX_MATCH' => -183,
			'OP18_TERNARY' => -183,
			'OP17_LIST_RANGE' => -183,
			'OP08_MATH_ADD_SUB' => -183,
			'OP24_LOGICAL_OR_XOR' => -183,
			'OP04_MATH_POW' => -183,
			'OP13_BITWISE_AND' => -183,
			".." => -183
		},
		GOTOS => {
			'VariableRetrieval' => 185
		}
	},
	{#State 114
		DEFAULT => -223
	},
	{#State 115
		ACTIONS => {
			'VARIABLE_SYMBOL' => 188
		}
	},
	{#State 116
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP23_LOGICAL_AND' => 140,
			'OP17_LIST_RANGE' => 128,
			'OP18_TERNARY' => 137,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => 136,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP08_MATH_ADD_SUB' => 127,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 138,
			")" => 189,
			'OP09_BITWISE_SHIFT' => 131
		}
	},
	{#State 117
		ACTIONS => {
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			"my" => 102,
			'KEYS_OR_VALUES' => 107,
			"(" => 57,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62,
			'OP10_NAMED_UNARY' => 64,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			"undef" => 48,
			"%{" => 68,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			";" => -133,
			'OP01_NAMED_QW' => 106
		},
		GOTOS => {
			'TypeInner' => 109,
			'OPTIONAL-46' => 190,
			'Expression' => 104,
			'ArrayDereferenced' => 50,
			'Operator' => 56,
			'Variable' => 103,
			'Literal' => 44,
			'ListElement' => 108,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'HashDereferenced' => 69,
			'ListElements' => 191,
			'WordScoped' => 84
		}
	},
	{#State 118
		ACTIONS => {
			"filehandle_ref" => 192,
			'WORD' => 114
		},
		GOTOS => {
			'Type' => 178
		}
	},
	{#State 119
		ACTIONS => {
			";" => 193
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 194
		}
	},
	{#State 121
		DEFAULT => -130
	},
	{#State 122
		DEFAULT => -157
	},
	{#State 123
		DEFAULT => -103
	},
	{#State 124
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			"]" => -123,
			";" => -123,
			'OP14_BITWISE_OR_XOR' => 135,
			"}" => -123,
			'OP08_STRING_CAT' => 141,
			'OP21_LIST_COMMA' => -123,
			'OP23_LOGICAL_AND' => -123,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP18_TERNARY' => 137,
			'OP17_LIST_RANGE' => 128,
			'OP08_MATH_ADD_SUB' => 127,
			'OP24_LOGICAL_OR_XOR' => -123,
			".." => -123,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => 136,
			")" => -123,
			'OP16_LOGICAL_OR' => 138,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP09_BITWISE_SHIFT' => 131
		}
	},
	{#State 125
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 62,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			"(" => 57,
			'VARIABLE_SYMBOL' => 54,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			"[" => 51,
			"%{" => 68,
			"undef" => 48,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			'WORD_SCOPED' => 13,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'OP10_NAMED_UNARY' => 64
		},
		GOTOS => {
			'Operator' => 56,
			'Variable' => 103,
			'Literal' => 44,
			'Expression' => 195,
			'ArrayDereferenced' => 50,
			'WordScoped' => 84,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'HashDereferenced' => 69
		}
	},
	{#State 126
		ACTIONS => {
			"undef" => 48,
			"%{" => 68,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			'OP10_NAMED_UNARY' => 64,
			'WORD_SCOPED' => 13,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62,
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			"(" => 57
		},
		GOTOS => {
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103,
			'Expression' => 196,
			'ArrayDereferenced' => 50,
			'WordScoped' => 84,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69
		}
	},
	{#State 127
		ACTIONS => {
			"(" => 57,
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			'WORD_SCOPED' => 13,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'OP10_NAMED_UNARY' => 64,
			"%{" => 68,
			"undef" => 48,
			'OP01_NAMED' => 47,
			"\@{" => 46
		},
		GOTOS => {
			'Variable' => 103,
			'Literal' => 44,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 197,
			'WordScoped' => 84,
			'HashDereferenced' => 69,
			'HashReference' => 71,
			'ArrayReference' => 70
		}
	},
	{#State 128
		ACTIONS => {
			"[" => 51,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54,
			"(" => 57,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'OP10_NAMED_UNARY' => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48
		},
		GOTOS => {
			'WordScoped' => 84,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69,
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103,
			'Expression' => 198,
			'ArrayDereferenced' => 50
		}
	},
	{#State 129
		ACTIONS => {
			'OP10_NAMED_UNARY' => 64,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			"%{" => 68,
			"undef" => 48,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			"(" => 57,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62
		},
		GOTOS => {
			'Expression' => 199,
			'ArrayDereferenced' => 50,
			'Operator' => 56,
			'Variable' => 103,
			'Literal' => 44,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'HashDereferenced' => 69,
			'WordScoped' => 84
		}
	},
	{#State 130
		ACTIONS => {
			"/" => 200
		}
	},
	{#State 131
		ACTIONS => {
			"(" => 57,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"undef" => 48,
			"%{" => 68
		},
		GOTOS => {
			'Operator' => 56,
			'Variable' => 103,
			'Literal' => 44,
			'Expression' => 201,
			'ArrayDereferenced' => 50,
			'WordScoped' => 84,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'HashDereferenced' => 69
		}
	},
	{#State 132
		ACTIONS => {
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY' => 64,
			"%{" => 68,
			"undef" => 48,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"(" => 57,
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15
		},
		GOTOS => {
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'WordScoped' => 84,
			'ArrayDereferenced' => 50,
			'Expression' => 202,
			'Literal' => 44,
			'Variable' => 103,
			'Operator' => 56
		}
	},
	{#State 133
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48,
			"(" => 57,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60
		},
		GOTOS => {
			'Expression' => 203,
			'ArrayDereferenced' => 50,
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69,
			'WordScoped' => 84
		}
	},
	{#State 134
		DEFAULT => -98
	},
	{#State 135
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			"(" => 57,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64
		},
		GOTOS => {
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69,
			'WordScoped' => 84,
			'Expression' => 204,
			'ArrayDereferenced' => 50,
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103
		}
	},
	{#State 136
		ACTIONS => {
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			"(" => 57,
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			"%{" => 68,
			"undef" => 48,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY' => 64
		},
		GOTOS => {
			'Expression' => 205,
			'ArrayDereferenced' => 50,
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69,
			'WordScoped' => 84
		}
	},
	{#State 137
		ACTIONS => {
			'VARIABLE_SYMBOL' => 54
		},
		GOTOS => {
			'Variable' => 206
		}
	},
	{#State 138
		ACTIONS => {
			"undef" => 48,
			"%{" => 68,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			'OP10_NAMED_UNARY' => 64,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			'OP22_LOGICAL_NOT' => 62,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 54,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			"[" => 51,
			"(" => 57
		},
		GOTOS => {
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69,
			'WordScoped' => 84,
			'Expression' => 207,
			'ArrayDereferenced' => 50,
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103
		}
	},
	{#State 139
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			"(" => 57,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64
		},
		GOTOS => {
			'WordScoped' => 84,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69,
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103,
			'Expression' => 208,
			'ArrayDereferenced' => 50
		}
	},
	{#State 140
		ACTIONS => {
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			"(" => 57,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 64,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13
		},
		GOTOS => {
			'Literal' => 44,
			'Variable' => 103,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 209,
			'WordScoped' => 84,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71
		}
	},
	{#State 141
		ACTIONS => {
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			"(" => 57,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51
		},
		GOTOS => {
			'WordScoped' => 84,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'Literal' => 44,
			'Variable' => 103,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 210
		}
	},
	{#State 142
		ACTIONS => {
			"]" => -113,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP08_STRING_CAT' => 141,
			";" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			"}" => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP13_BITWISE_AND' => -113,
			".." => -113,
			'OP04_MATH_POW' => 125,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP06_REGEX_MATCH' => 130,
			'OP18_TERNARY' => -113,
			'OP09_BITWISE_SHIFT' => 131,
			'OP12_COMPARE_EQ_NEQ' => -113,
			")" => -113,
			'OP16_LOGICAL_OR' => -113
		}
	},
	{#State 143
		ACTIONS => {
			'OP23_LOGICAL_AND' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP08_STRING_CAT' => 141,
			";" => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			"}" => -114,
			"]" => -114,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => -114,
			'OP09_BITWISE_SHIFT' => 131,
			'OP12_COMPARE_EQ_NEQ' => -114,
			")" => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP04_MATH_POW' => 125,
			".." => -114,
			'OP13_BITWISE_AND' => -114,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => -114,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => -114,
			'OP18_TERNARY' => -114
		}
	},
	{#State 144
		ACTIONS => {
			"%{" => 68,
			'WORD' => 161
		},
		GOTOS => {
			'HashDereferenced' => 160,
			'HashEntry' => 162
		}
	},
	{#State 145
		ACTIONS => {
			"}" => 211
		}
	},
	{#State 146
		ACTIONS => {
			"}" => 212
		}
	},
	{#State 147
		DEFAULT => -224
	},
	{#State 148
		ACTIONS => {
			";" => 213
		}
	},
	{#State 149
		DEFAULT => -13
	},
	{#State 150
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			'OP01_NAMED_QW' => 106,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48,
			"(" => 57,
			'KEYS_OR_VALUES' => 107,
			"my" => 102,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			")" => -129,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60
		},
		GOTOS => {
			'ListElement' => 108,
			'Literal' => 44,
			'Variable' => 103,
			'OPTIONAL-44' => 214,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 104,
			'TypeInner' => 109,
			'WordScoped' => 84,
			'ListElements' => 215,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71
		}
	},
	{#State 151
		ACTIONS => {
			")" => 216
		}
	},
	{#State 152
		DEFAULT => -126
	},
	{#State 153
		ACTIONS => {
			'VARIABLE_SYMBOL' => 217
		}
	},
	{#State 154
		DEFAULT => -104
	},
	{#State 155
		ACTIONS => {
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			"(" => 57,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62,
			"<STDIN>" => 218,
			'OP10_NAMED_UNARY' => 64,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			"undef" => 48,
			"%{" => 68,
			"\@{" => 46,
			'OP01_NAMED' => 47
		},
		GOTOS => {
			'ArrayDereferenced' => 50,
			'Expression' => 219,
			'Literal' => 44,
			'Variable' => 103,
			'ExpressionOrStdin' => 220,
			'Operator' => 56,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'WordScoped' => 84
		}
	},
	{#State 156
		ACTIONS => {
			'WORD' => 221
		}
	},
	{#State 157
		ACTIONS => {
			'OP10_NAMED_UNARY' => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51,
			"(" => 57,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83
		},
		GOTOS => {
			'Expression' => 222,
			'ArrayDereferenced' => 50,
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69,
			'WordScoped' => 84
		}
	},
	{#State 158
		ACTIONS => {
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP18_TERNARY' => 137,
			'OP17_LIST_RANGE' => 128,
			'OP08_MATH_ADD_SUB' => 127,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125,
			")" => 223,
			'OP16_LOGICAL_OR' => 138,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP09_BITWISE_SHIFT' => 131,
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP08_STRING_CAT' => 141,
			'OP23_LOGICAL_AND' => 140
		}
	},
	{#State 159
		DEFAULT => -150
	},
	{#State 160
		DEFAULT => -209
	},
	{#State 161
		ACTIONS => {
			'OP20_HASH_FATARROW' => 224
		}
	},
	{#State 162
		DEFAULT => -214,
		GOTOS => {
			'STAR-63' => 225
		}
	},
	{#State 163
		ACTIONS => {
			'KEYS_OR_VALUES' => 107,
			"(" => 57,
			"my" => 102,
			'VARIABLE_SYMBOL' => 54,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 62,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP03_MATH_INC_DEC' => 60,
			")" => -140,
			'WORD' => 15,
			'WORD_SCOPED' => 13,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'OP10_NAMED_UNARY' => 64,
			'OP01_NAMED_QW' => 106,
			"undef" => 48,
			"%{" => 68,
			'OP01_NAMED' => 47,
			"\@{" => 46
		},
		GOTOS => {
			'Operator' => 56,
			'Variable' => 103,
			'Literal' => 44,
			'ListElement' => 108,
			'TypeInner' => 109,
			'Expression' => 104,
			'OPTIONAL-47' => 227,
			'ArrayDereferenced' => 50,
			'WordScoped' => 84,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'HashDereferenced' => 69,
			'ListElements' => 226
		}
	},
	{#State 164
		DEFAULT => -32
	},
	{#State 165
		ACTIONS => {
			")" => 228,
			'WORD' => 229
		}
	},
	{#State 166
		DEFAULT => -25
	},
	{#State 167
		ACTIONS => {
			"1;" => 230,
			"our" => 55
		},
		GOTOS => {
			'Subroutine' => 231
		}
	},
	{#State 168
		DEFAULT => -22
	},
	{#State 169
		ACTIONS => {
			"use" => 28
		},
		GOTOS => {
			'Include' => 232
		}
	},
	{#State 170
		ACTIONS => {
			"{" => 236,
			'LITERAL_STRING' => 66,
			'LITERAL_NUMBER' => 82,
			"[" => 233
		},
		GOTOS => {
			'ConstantValue' => 234,
			'Literal' => 235
		}
	},
	{#State 171
		DEFAULT => -204
	},
	{#State 172
		DEFAULT => -205
	},
	{#State 173
		ACTIONS => {
			")" => 237
		}
	},
	{#State 174
		DEFAULT => -100
	},
	{#State 175
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 131,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 138,
			")" => 238,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => 136,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => 128,
			'OP18_TERNARY' => 137,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP23_LOGICAL_AND' => 140,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133
		}
	},
	{#State 176
		ACTIONS => {
			'VARIABLE_SYMBOL' => 239
		}
	},
	{#State 177
		ACTIONS => {
			"(" => 240
		}
	},
	{#State 178
		ACTIONS => {
			"\$TYPED_" => 241
		}
	},
	{#State 179
		DEFAULT => -203
	},
	{#State 180
		ACTIONS => {
			'WORD' => 243
		},
		GOTOS => {
			'PLUS-59' => 242
		}
	},
	{#State 181
		DEFAULT => -200
	},
	{#State 182
		ACTIONS => {
			"]" => -196,
			'OP21_LIST_COMMA' => 245,
			")" => -196,
			";" => -196
		},
		GOTOS => {
			'PAREN-57' => 244
		}
	},
	{#State 183
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			"]" => -199,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 135,
			";" => -199,
			'OP23_LOGICAL_AND' => 140,
			'OP21_LIST_COMMA' => -199,
			'OP17_LIST_RANGE' => 128,
			'OP18_TERNARY' => 137,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 129,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => 136,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP08_MATH_ADD_SUB' => 127,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 138,
			")" => -199,
			'OP09_BITWISE_SHIFT' => 131
		}
	},
	{#State 184
		DEFAULT => -107
	},
	{#State 185
		DEFAULT => -181
	},
	{#State 186
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48,
			"(" => 57,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'WORD' => 247,
			'OP03_MATH_INC_DEC' => 60
		},
		GOTOS => {
			'Operator' => 56,
			'Variable' => 103,
			'Literal' => 44,
			'Expression' => 246,
			'ArrayDereferenced' => 50,
			'WordScoped' => 84,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'HashDereferenced' => 69
		}
	},
	{#State 187
		ACTIONS => {
			"(" => 57,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48
		},
		GOTOS => {
			'HashReference' => 71,
			'ArrayReference' => 70,
			'HashDereferenced' => 69,
			'WordScoped' => 84,
			'Expression' => 248,
			'ArrayDereferenced' => 50,
			'Operator' => 56,
			'Variable' => 103,
			'Literal' => 44
		}
	},
	{#State 188
		ACTIONS => {
			"= sub {" => 249
		}
	},
	{#State 189
		DEFAULT => -154
	},
	{#State 190
		ACTIONS => {
			";" => 250
		}
	},
	{#State 191
		DEFAULT => -132
	},
	{#State 192
		ACTIONS => {
			'VARIABLE_SYMBOL' => 251
		}
	},
	{#State 193
		DEFAULT => -136
	},
	{#State 194
		ACTIONS => {
			"}" => 252
		}
	},
	{#State 195
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP04_MATH_POW' => 125,
			".." => -105,
			'OP13_BITWISE_AND' => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP06_REGEX_MATCH' => -105,
			'OP18_TERNARY' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			")" => -105,
			'OP16_LOGICAL_OR' => -105,
			"]" => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP08_STRING_CAT' => -105,
			";" => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			"}" => -105
		}
	},
	{#State 196
		ACTIONS => {
			'OP18_TERNARY' => 137,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP17_LIST_RANGE' => 128,
			'OP08_MATH_ADD_SUB' => 127,
			".." => -125,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP16_LOGICAL_OR' => 138,
			")" => -125,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP09_BITWISE_SHIFT' => 131,
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			"]" => -125,
			";" => -125,
			'OP14_BITWISE_OR_XOR' => 135,
			"}" => -125,
			'OP08_STRING_CAT' => 141,
			'OP21_LIST_COMMA' => -125,
			'OP23_LOGICAL_AND' => 140
		}
	},
	{#State 197
		ACTIONS => {
			'OP15_LOGICAL_AND' => -110,
			'OP06_REGEX_MATCH' => 130,
			'OP18_TERNARY' => -110,
			'OP17_LIST_RANGE' => -110,
			'OP08_MATH_ADD_SUB' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			".." => -110,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => -110,
			")" => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			"]" => -110,
			";" => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			"}" => -110,
			'OP08_STRING_CAT' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP23_LOGICAL_AND' => -110
		}
	},
	{#State 198
		ACTIONS => {
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 135,
			";" => -121,
			"}" => -121,
			'OP23_LOGICAL_AND' => -121,
			'OP21_LIST_COMMA' => -121,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			"]" => -121,
			'OP12_COMPARE_EQ_NEQ' => 132,
			")" => -121,
			'OP16_LOGICAL_OR' => 138,
			'OP09_BITWISE_SHIFT' => 131,
			'OP17_LIST_RANGE' => undef,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP18_TERNARY' => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP13_BITWISE_AND' => 136,
			".." => -121,
			'OP04_MATH_POW' => 125,
			'OP08_MATH_ADD_SUB' => 127
		}
	},
	{#State 199
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 131,
			'OP12_COMPARE_EQ_NEQ' => 132,
			")" => -119,
			'OP16_LOGICAL_OR' => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP13_BITWISE_AND' => 136,
			".." => -119,
			'OP04_MATH_POW' => 125,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => -119,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => -119,
			'OP18_TERNARY' => -119,
			'OP23_LOGICAL_AND' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 135,
			";" => -119,
			"}" => -119,
			"]" => -119,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133
		}
	},
	{#State 200
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 253
		}
	},
	{#State 201
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => -112,
			"]" => -112,
			'OP08_STRING_CAT' => 141,
			";" => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			"}" => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP18_TERNARY' => -112,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => -112,
			'OP04_MATH_POW' => 125,
			".." => -112,
			'OP13_BITWISE_AND' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP08_MATH_ADD_SUB' => 127,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP16_LOGICAL_OR' => -112,
			")" => -112,
			'OP09_BITWISE_SHIFT' => -112
		}
	},
	{#State 202
		ACTIONS => {
			'OP23_LOGICAL_AND' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP08_STRING_CAT' => 141,
			";" => -116,
			"}" => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			"]" => -116,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			'OP09_BITWISE_SHIFT' => 131,
			'OP12_COMPARE_EQ_NEQ' => undef,
			")" => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP13_BITWISE_AND' => -116,
			".." => -116,
			'OP04_MATH_POW' => 125,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP06_REGEX_MATCH' => 130,
			'OP18_TERNARY' => -116
		}
	},
	{#State 203
		ACTIONS => {
			";" => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			"}" => -115,
			'OP08_STRING_CAT' => 141,
			'OP21_LIST_COMMA' => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP11_COMPARE_LT_GT' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			"]" => -115,
			")" => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP12_COMPARE_EQ_NEQ' => -115,
			'OP09_BITWISE_SHIFT' => 131,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => -115,
			'OP18_TERNARY' => -115,
			'OP17_LIST_RANGE' => -115,
			'OP08_MATH_ADD_SUB' => 127,
			'OP24_LOGICAL_OR_XOR' => -115,
			".." => -115,
			'OP13_BITWISE_AND' => -115,
			'OP04_MATH_POW' => 125
		}
	},
	{#State 204
		ACTIONS => {
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => -118,
			";" => -118,
			"}" => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP21_LIST_COMMA' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			"]" => -118,
			'OP12_COMPARE_EQ_NEQ' => 132,
			")" => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP09_BITWISE_SHIFT' => 131,
			'OP17_LIST_RANGE' => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP06_REGEX_MATCH' => 130,
			'OP18_TERNARY' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP13_BITWISE_AND' => 136,
			".." => -118,
			'OP04_MATH_POW' => 125,
			'OP08_MATH_ADD_SUB' => 127
		}
	},
	{#State 205
		ACTIONS => {
			'OP21_LIST_COMMA' => -117,
			'OP23_LOGICAL_AND' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			";" => -117,
			"}" => -117,
			'OP08_STRING_CAT' => 141,
			"]" => -117,
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP09_BITWISE_SHIFT' => 131,
			'OP16_LOGICAL_OR' => -117,
			")" => -117,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP08_MATH_ADD_SUB' => 127,
			".." => -117,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP18_TERNARY' => -117,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => -117,
			'OP17_LIST_RANGE' => -117
		}
	},
	{#State 206
		ACTIONS => {
			'COLON' => 254
		}
	},
	{#State 207
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			"]" => -120,
			";" => -120,
			'OP14_BITWISE_OR_XOR' => 135,
			"}" => -120,
			'OP08_STRING_CAT' => 141,
			'OP21_LIST_COMMA' => -120,
			'OP23_LOGICAL_AND' => -120,
			'OP18_TERNARY' => -120,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP17_LIST_RANGE' => -120,
			'OP08_MATH_ADD_SUB' => 127,
			".." => -120,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP16_LOGICAL_OR' => -120,
			")" => -120,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP09_BITWISE_SHIFT' => 131
		}
	},
	{#State 208
		ACTIONS => {
			'OP04_MATH_POW' => 125,
			".." => -109,
			'OP13_BITWISE_AND' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP08_MATH_ADD_SUB' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP18_TERNARY' => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP06_REGEX_MATCH' => 130,
			'OP09_BITWISE_SHIFT' => -109,
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP16_LOGICAL_OR' => -109,
			")" => -109,
			"]" => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP08_STRING_CAT' => -109,
			";" => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			"}" => -109
		}
	},
	{#State 209
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			"]" => -124,
			"}" => -124,
			";" => -124,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP08_STRING_CAT' => 141,
			'OP21_LIST_COMMA' => -124,
			'OP23_LOGICAL_AND' => -124,
			'OP18_TERNARY' => 137,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 129,
			'OP17_LIST_RANGE' => 128,
			'OP08_MATH_ADD_SUB' => 127,
			".." => -124,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP16_LOGICAL_OR' => 138,
			")" => -124,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP09_BITWISE_SHIFT' => 131
		}
	},
	{#State 210
		ACTIONS => {
			'OP23_LOGICAL_AND' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP08_STRING_CAT' => -111,
			";" => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			"}" => -111,
			"]" => -111,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP16_LOGICAL_OR' => -111,
			")" => -111,
			'OP13_BITWISE_AND' => -111,
			".." => -111,
			'OP04_MATH_POW' => 125,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => -111,
			'OP18_TERNARY' => -111,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => -111
		}
	},
	{#State 211
		DEFAULT => -216
	},
	{#State 212
		DEFAULT => -217
	},
	{#State 213
		DEFAULT => -138
	},
	{#State 214
		ACTIONS => {
			")" => 255
		}
	},
	{#State 215
		DEFAULT => -128
	},
	{#State 216
		ACTIONS => {
			";" => 256
		}
	},
	{#State 217
		ACTIONS => {
			";" => 257,
			'OP19_VARIABLE_ASSIGN' => 258
		}
	},
	{#State 218
		DEFAULT => -156
	},
	{#State 219
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => 128,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP18_TERNARY' => 137,
			'OP09_BITWISE_SHIFT' => 131,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			'OP23_LOGICAL_AND' => 140,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 135,
			";" => -155
		}
	},
	{#State 220
		ACTIONS => {
			";" => 259
		}
	},
	{#State 221
		ACTIONS => {
			"(" => 260
		}
	},
	{#State 222
		ACTIONS => {
			'OP23_LOGICAL_AND' => 140,
			'OP08_STRING_CAT' => 141,
			";" => 261,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			'OP09_BITWISE_SHIFT' => 131,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 138,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => 136,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => 128,
			'OP18_TERNARY' => 137,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 129
		}
	},
	{#State 223
		ACTIONS => {
			"{" => 263
		},
		GOTOS => {
			'CodeBlock' => 262
		}
	},
	{#State 224
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -207,
			'WORD' => -207,
			'OP22_LOGICAL_NOT' => -207,
			"{" => -207,
			'LITERAL_NUMBER' => -207,
			'VARIABLE_SYMBOL' => -207,
			'OP05_MATH_NEG' => -207,
			'OP05_LOGICAL_NEG' => -207,
			"[" => -207,
			"(" => -207,
			"my" => 102,
			"undef" => -207,
			"%{" => -207,
			"\@{" => -207,
			'OP01_NAMED' => -207,
			'OP10_NAMED_UNARY' => -207,
			'WORD_SCOPED' => -207,
			'LITERAL_STRING' => -207,
			'OP10_NAMED_UNARY_STRINGIFY' => -207
		},
		GOTOS => {
			'TypeInner' => 265,
			'OPTIONAL-61' => 264
		}
	},
	{#State 225
		ACTIONS => {
			"}" => 266,
			'OP21_LIST_COMMA' => 268
		},
		GOTOS => {
			'PAREN-62' => 267
		}
	},
	{#State 226
		DEFAULT => -139
	},
	{#State 227
		ACTIONS => {
			")" => 269
		}
	},
	{#State 228
		ACTIONS => {
			";" => 270
		}
	},
	{#State 229
		DEFAULT => -31
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
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 272
		}
	},
	{#State 233
		ACTIONS => {
			"my" => 102,
			'LITERAL_STRING' => -37,
			'LITERAL_NUMBER' => -37
		},
		GOTOS => {
			'TypeInner' => 274,
			'OPTIONAL-13' => 273
		}
	},
	{#State 234
		ACTIONS => {
			";" => 275
		}
	},
	{#State 235
		DEFAULT => -50
	},
	{#State 236
		ACTIONS => {
			'WORD' => 276
		}
	},
	{#State 237
		DEFAULT => -102
	},
	{#State 238
		ACTIONS => {
			"{" => 263
		},
		GOTOS => {
			'CodeBlock' => 277
		}
	},
	{#State 239
		ACTIONS => {
			"(" => 278
		}
	},
	{#State 240
		ACTIONS => {
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48,
			'OP10_NAMED_UNARY' => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51,
			"(" => 57
		},
		GOTOS => {
			'WordScoped' => 84,
			'HashDereferenced' => 69,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'Variable' => 103,
			'Literal' => 44,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 279
		}
	},
	{#State 241
		ACTIONS => {
			'WORD' => 280
		}
	},
	{#State 242
		ACTIONS => {
			'WORD' => 282,
			")" => 281
		}
	},
	{#State 243
		DEFAULT => -195
	},
	{#State 244
		DEFAULT => -192
	},
	{#State 245
		ACTIONS => {
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			"[" => 51,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54,
			"my" => 102,
			"(" => 57,
			'KEYS_OR_VALUES' => 107,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"undef" => 48,
			"%{" => 68,
			'OP10_NAMED_UNARY' => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13
		},
		GOTOS => {
			'ListElement' => 283,
			'Literal' => 44,
			'Variable' => 103,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 104,
			'TypeInner' => 109,
			'WordScoped' => 84,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71
		}
	},
	{#State 246
		ACTIONS => {
			'OP16_LOGICAL_OR' => 138,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP09_BITWISE_SHIFT' => 131,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 129,
			'OP18_TERNARY' => 137,
			'OP17_LIST_RANGE' => 128,
			'OP08_MATH_ADD_SUB' => 127,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => 136,
			"}" => 284,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP08_STRING_CAT' => 141,
			'OP23_LOGICAL_AND' => 140,
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139
		}
	},
	{#State 247
		ACTIONS => {
			"(" => -218,
			"}" => 285
		}
	},
	{#State 248
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 131,
			'OP16_LOGICAL_OR' => 138,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP08_MATH_ADD_SUB' => 127,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP18_TERNARY' => 137,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP17_LIST_RANGE' => 128,
			'OP23_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP08_STRING_CAT' => 141,
			"]" => 286,
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139
		}
	},
	{#State 249
		ACTIONS => {
			"( my" => 287,
			'LITERAL_STRING' => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			'WORD_SCOPED' => -54,
			'OP10_NAMED_UNARY' => -54,
			"while (" => -54,
			'OP19_LOOP_CONTROL' => -54,
			'OP01_NAMED' => -54,
			"\@{" => -54,
			"%{" => -54,
			"undef" => -54,
			"if (" => -54,
			"(" => -54,
			"my" => -54,
			'OP05_MATH_NEG' => -54,
			'OP05_LOGICAL_NEG' => -54,
			'OP01_NAMED_VOID_PAREN' => -54,
			'VARIABLE_SYMBOL' => -54,
			"[" => -54,
			'OP22_LOGICAL_NOT' => -54,
			'LITERAL_NUMBER' => -54,
			"{" => -54,
			'WORD' => -54,
			"for my integer" => -54,
			'OP03_MATH_INC_DEC' => -54,
			'OP01_NAMED_VOID' => -54,
			"foreach my" => -54
		},
		GOTOS => {
			'OPTIONAL-21' => 288,
			'SubroutineArguments' => 289
		}
	},
	{#State 250
		DEFAULT => -137
	},
	{#State 251
		DEFAULT => -221
	},
	{#State 252
		DEFAULT => -220
	},
	{#State 253
		ACTIONS => {
			"/" => 290
		}
	},
	{#State 254
		ACTIONS => {
			'VARIABLE_SYMBOL' => 54
		},
		GOTOS => {
			'Variable' => 291
		}
	},
	{#State 255
		ACTIONS => {
			";" => 292
		}
	},
	{#State 256
		DEFAULT => -134
	},
	{#State 257
		DEFAULT => -187
	},
	{#State 258
		ACTIONS => {
			"(" => 57,
			'VARIABLE_SYMBOL' => 54,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 62,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			"<STDIN>" => 218,
			'OP10_NAMED_UNARY' => 64,
			"undef" => 48,
			"%{" => 68,
			"\@{" => 46,
			'OP01_NAMED' => 47
		},
		GOTOS => {
			'WordScoped' => 84,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'HashDereferenced' => 69,
			'Operator' => 56,
			'ExpressionOrStdin' => 293,
			'Variable' => 103,
			'Literal' => 44,
			'Expression' => 219,
			'ArrayDereferenced' => 50
		}
	},
	{#State 259
		DEFAULT => -189
	},
	{#State 260
		ACTIONS => {
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51,
			"(" => 57,
			'KEYS_OR_VALUES' => 107,
			"my" => 102,
			")" => -142,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP10_NAMED_UNARY' => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48,
			'OP01_NAMED_QW' => 106
		},
		GOTOS => {
			'ArrayDereferenced' => 50,
			'Expression' => 104,
			'TypeInner' => 109,
			'Literal' => 44,
			'ListElement' => 108,
			'Variable' => 103,
			'Operator' => 56,
			'OPTIONAL-48' => 294,
			'ListElements' => 295,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'WordScoped' => 84
		}
	},
	{#State 261
		DEFAULT => -190
	},
	{#State 262
		DEFAULT => -167,
		GOTOS => {
			'STAR-52' => 296
		}
	},
	{#State 263
		ACTIONS => {
			'OP01_NAMED_VOID' => 58,
			"foreach my" => -159,
			'WORD' => 81,
			'OP03_MATH_INC_DEC' => 60,
			"for my integer" => -159,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'OP01_NAMED_VOID_PAREN' => 77,
			'VARIABLE_SYMBOL' => 54,
			"my" => 78,
			"(" => 57,
			"if (" => 80,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"undef" => 48,
			"%{" => 68,
			'OP19_LOOP_CONTROL' => 73,
			'OP10_NAMED_UNARY' => 64,
			"while (" => -159,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13
		},
		GOTOS => {
			'Operation' => 298,
			'Literal' => 44,
			'Expression' => 63,
			'Statement' => 43,
			'VariableModification' => 67,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'OPTIONAL-50' => 49,
			'PAREN-49' => 72,
			'HashReference' => 71,
			'Variable' => 79,
			'Operator' => 56,
			'VariableDeclaration' => 76,
			'ArrayDereferenced' => 50,
			'OperatorVoid' => 61,
			'WordScoped' => 84,
			'Conditional' => 85,
			'LoopLabel' => 59,
			'PLUS-55' => 297
		}
	},
	{#State 264
		ACTIONS => {
			"%{" => 68,
			"undef" => 48,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY' => 64,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			"(" => 57,
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53
		},
		GOTOS => {
			'Operator' => 56,
			'Literal' => 44,
			'Variable' => 103,
			'Expression' => 299,
			'ArrayDereferenced' => 50,
			'WordScoped' => 84,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'HashDereferenced' => 69
		}
	},
	{#State 265
		DEFAULT => -206
	},
	{#State 266
		DEFAULT => -215
	},
	{#State 267
		DEFAULT => -213
	},
	{#State 268
		ACTIONS => {
			'WORD' => 161,
			"%{" => 68
		},
		GOTOS => {
			'HashEntry' => 300,
			'HashDereferenced' => 160
		}
	},
	{#State 269
		DEFAULT => -152
	},
	{#State 270
		DEFAULT => -34
	},
	{#State 271
		DEFAULT => -26
	},
	{#State 272
		ACTIONS => {
			"use" => -71,
			"use constant" => -71,
			"## no critic qw(" => 20,
			"our %properties = (" => -71
		},
		GOTOS => {
			'STAR-29' => 302,
			'Critic' => 301
		}
	},
	{#State 273
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			'LITERAL_STRING' => 66
		},
		GOTOS => {
			'Literal' => 303
		}
	},
	{#State 274
		DEFAULT => -36
	},
	{#State 275
		DEFAULT => -35
	},
	{#State 276
		ACTIONS => {
			'OP20_HASH_FATARROW' => 304
		}
	},
	{#State 277
		DEFAULT => -177
	},
	{#State 278
		ACTIONS => {
			'OP01_NAMED_QW' => 106,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"undef" => 48,
			"%{" => 68,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			"my" => 102,
			"(" => 57,
			'KEYS_OR_VALUES' => 107,
			"[" => 51,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			'VARIABLE_SYMBOL' => 54
		},
		GOTOS => {
			'WordScoped' => 84,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'ListElements' => 305,
			'HashDereferenced' => 69,
			'Operator' => 56,
			'Literal' => 44,
			'ListElement' => 108,
			'Variable' => 103,
			'Expression' => 104,
			'TypeInner' => 109,
			'ArrayDereferenced' => 50
		}
	},
	{#State 279
		ACTIONS => {
			'OP23_LOGICAL_AND' => 140,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			'OP09_BITWISE_SHIFT' => 131,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 138,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP04_MATH_POW' => 125,
			".." => 306,
			'OP13_BITWISE_AND' => 136,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => 128,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP18_TERNARY' => 137
		}
	},
	{#State 280
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 307
		}
	},
	{#State 281
		DEFAULT => -197
	},
	{#State 282
		DEFAULT => -194
	},
	{#State 283
		DEFAULT => -191
	},
	{#State 284
		DEFAULT => -185
	},
	{#State 285
		DEFAULT => -186
	},
	{#State 286
		DEFAULT => -184
	},
	{#State 287
		ACTIONS => {
			'WORD' => 114
		},
		GOTOS => {
			'Type' => 308
		}
	},
	{#State 288
		ACTIONS => {
			"(" => 57,
			"if (" => 80,
			"my" => 78,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'OP01_NAMED_VOID_PAREN' => 77,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'WORD' => 81,
			"for my integer" => -159,
			'OP03_MATH_INC_DEC' => 60,
			'OP01_NAMED_VOID' => 58,
			"foreach my" => -159,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			"while (" => -159,
			'OP19_LOOP_CONTROL' => 73,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48
		},
		GOTOS => {
			'Literal' => 44,
			'Operation' => 310,
			'Statement' => 43,
			'Expression' => 63,
			'HashDereferenced' => 69,
			'VariableModification' => 67,
			'HashReference' => 71,
			'OPTIONAL-50' => 49,
			'PAREN-49' => 72,
			'ArrayReference' => 70,
			'Variable' => 79,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'VariableDeclaration' => 76,
			'PLUS-22' => 309,
			'OperatorVoid' => 61,
			'Conditional' => 85,
			'WordScoped' => 84,
			'LoopLabel' => 59
		}
	},
	{#State 289
		DEFAULT => -53
	},
	{#State 290
		DEFAULT => -108
	},
	{#State 291
		DEFAULT => -122
	},
	{#State 292
		DEFAULT => -135
	},
	{#State 293
		ACTIONS => {
			";" => 311
		}
	},
	{#State 294
		ACTIONS => {
			")" => 312
		}
	},
	{#State 295
		DEFAULT => -141
	},
	{#State 296
		ACTIONS => {
			'WORD_SCOPED' => -170,
			'OP10_NAMED_UNARY_STRINGIFY' => -170,
			'LITERAL_STRING' => -170,
			"elsif (" => 315,
			"while (" => -170,
			'OP10_NAMED_UNARY' => -170,
			'' => -170,
			"%{" => -170,
			"undef" => -170,
			"else" => 314,
			'OP01_NAMED' => -170,
			"\@{" => -170,
			'OP19_LOOP_CONTROL' => -170,
			"}" => -170,
			"my" => -170,
			"(" => -170,
			"if (" => -170,
			"[" => -170,
			'VARIABLE_SYMBOL' => -170,
			'OP05_MATH_NEG' => -170,
			'OP05_LOGICAL_NEG' => -170,
			'OP01_NAMED_VOID_PAREN' => -170,
			"{" => -170,
			'LITERAL_NUMBER' => -170,
			'OP22_LOGICAL_NOT' => -170,
			"foreach my" => -170,
			'OP01_NAMED_VOID' => -170,
			"for my integer" => -170,
			'OP03_MATH_INC_DEC' => -170,
			'WORD' => -170
		},
		GOTOS => {
			'PAREN-53' => 313,
			'OPTIONAL-54' => 316,
			'PAREN-51' => 317
		}
	},
	{#State 297
		ACTIONS => {
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62,
			"foreach my" => -159,
			'OP01_NAMED_VOID' => 58,
			"for my integer" => -159,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 81,
			"my" => 78,
			"(" => 57,
			"if (" => 80,
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'OP01_NAMED_VOID_PAREN' => 77,
			"%{" => 68,
			"undef" => 48,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			'OP19_LOOP_CONTROL' => 73,
			"}" => 318,
			'WORD_SCOPED' => 13,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			"while (" => -159,
			'OP10_NAMED_UNARY' => 64
		},
		GOTOS => {
			'OperatorVoid' => 61,
			'WordScoped' => 84,
			'Conditional' => 85,
			'LoopLabel' => 59,
			'Variable' => 79,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'VariableDeclaration' => 76,
			'VariableModification' => 67,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'OPTIONAL-50' => 49,
			'PAREN-49' => 72,
			'Literal' => 44,
			'Operation' => 319,
			'Expression' => 63,
			'Statement' => 43
		}
	},
	{#State 298
		DEFAULT => -179
	},
	{#State 299
		ACTIONS => {
			'OP18_TERNARY' => 137,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP17_LIST_RANGE' => 128,
			'OP08_MATH_ADD_SUB' => 127,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP16_LOGICAL_OR' => 138,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP09_BITWISE_SHIFT' => 131,
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			"}" => -208,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP08_STRING_CAT' => 141,
			'OP21_LIST_COMMA' => -208,
			'OP23_LOGICAL_AND' => 140
		}
	},
	{#State 300
		DEFAULT => -212
	},
	{#State 301
		DEFAULT => -68
	},
	{#State 302
		ACTIONS => {
			"use" => 28,
			"use constant" => -73,
			"our %properties = (" => -73
		},
		GOTOS => {
			'Include' => 321,
			'STAR-30' => 320
		}
	},
	{#State 303
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 322
		}
	},
	{#State 304
		ACTIONS => {
			'LITERAL_NUMBER' => -44,
			'LITERAL_STRING' => -44,
			"my" => 102
		},
		GOTOS => {
			'OPTIONAL-17' => 324,
			'TypeInner' => 323
		}
	},
	{#State 305
		ACTIONS => {
			")" => 325
		}
	},
	{#State 306
		ACTIONS => {
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			"(" => 57,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'OP10_NAMED_UNARY' => 64,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"undef" => 48,
			"%{" => 68
		},
		GOTOS => {
			'ArrayDereferenced' => 50,
			'Expression' => 326,
			'Literal' => 44,
			'Variable' => 103,
			'Operator' => 56,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'WordScoped' => 84
		}
	},
	{#State 307
		DEFAULT => -222
	},
	{#State 308
		ACTIONS => {
			'VARIABLE_SYMBOL' => 327
		}
	},
	{#State 309
		ACTIONS => {
			"undef" => 48,
			"%{" => 68,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			'OP19_LOOP_CONTROL' => 73,
			"}" => 329,
			"while (" => -159,
			'OP10_NAMED_UNARY' => 64,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			"foreach my" => -159,
			'OP01_NAMED_VOID' => 58,
			'OP03_MATH_INC_DEC' => 60,
			"for my integer" => -159,
			'WORD' => 81,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'OP22_LOGICAL_NOT' => 62,
			"[" => 51,
			'VARIABLE_SYMBOL' => 54,
			'OP01_NAMED_VOID_PAREN' => 77,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			"my" => 78,
			"(" => 57,
			"if (" => 80
		},
		GOTOS => {
			'HashDereferenced' => 69,
			'VariableModification' => 67,
			'OPTIONAL-50' => 49,
			'PAREN-49' => 72,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'Operation' => 328,
			'Literal' => 44,
			'Statement' => 43,
			'Expression' => 63,
			'OperatorVoid' => 61,
			'Conditional' => 85,
			'WordScoped' => 84,
			'LoopLabel' => 59,
			'Variable' => 79,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'VariableDeclaration' => 76
		}
	},
	{#State 310
		DEFAULT => -56
	},
	{#State 311
		DEFAULT => -188
	},
	{#State 312
		DEFAULT => -153
	},
	{#State 313
		DEFAULT => -169
	},
	{#State 314
		ACTIONS => {
			"{" => 263
		},
		GOTOS => {
			'CodeBlock' => 330
		}
	},
	{#State 315
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			"(" => 57,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64
		},
		GOTOS => {
			'WordScoped' => 84,
			'HashDereferenced' => 69,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'Variable' => 103,
			'Literal' => 44,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 331
		}
	},
	{#State 316
		DEFAULT => -171
	},
	{#State 317
		DEFAULT => -166
	},
	{#State 318
		DEFAULT => -180
	},
	{#State 319
		DEFAULT => -178
	},
	{#State 320
		ACTIONS => {
			"our %properties = (" => 333,
			"use constant" => 35
		},
		GOTOS => {
			'Properties' => 334,
			'Constant' => 332
		}
	},
	{#State 321
		DEFAULT => -70
	},
	{#State 322
		ACTIONS => {
			"]" => 335,
			'OP21_LIST_COMMA' => 336
		},
		GOTOS => {
			'PAREN-15' => 337
		}
	},
	{#State 323
		DEFAULT => -43
	},
	{#State 324
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			'LITERAL_STRING' => 66
		},
		GOTOS => {
			'Literal' => 338
		}
	},
	{#State 325
		ACTIONS => {
			"{" => 263
		},
		GOTOS => {
			'CodeBlock' => 339
		}
	},
	{#State 326
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP23_LOGICAL_AND' => 140,
			'OP17_LIST_RANGE' => 128,
			'OP18_TERNARY' => 137,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 129,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP08_MATH_ADD_SUB' => 127,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 138,
			")" => 340,
			'OP09_BITWISE_SHIFT' => 131
		}
	},
	{#State 327
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 341
		}
	},
	{#State 328
		DEFAULT => -55
	},
	{#State 329
		ACTIONS => {
			";" => 342
		}
	},
	{#State 330
		DEFAULT => -168
	},
	{#State 331
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			'OP23_LOGICAL_AND' => 140,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => 128,
			'OP18_TERNARY' => 137,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP09_BITWISE_SHIFT' => 131,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 138,
			")" => 343
		}
	},
	{#State 332
		DEFAULT => -72
	},
	{#State 333
		ACTIONS => {
			")" => 344,
			"## no critic qw(" => 20
		},
		GOTOS => {
			'Critic' => 345
		}
	},
	{#State 334
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 346
		}
	},
	{#State 335
		DEFAULT => -51
	},
	{#State 336
		ACTIONS => {
			'LITERAL_STRING' => -39,
			"my" => 102,
			'LITERAL_NUMBER' => -39
		},
		GOTOS => {
			'OPTIONAL-14' => 347,
			'TypeInner' => 348
		}
	},
	{#State 337
		DEFAULT => -41
	},
	{#State 338
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 349
		}
	},
	{#State 339
		DEFAULT => -176
	},
	{#State 340
		ACTIONS => {
			"{" => 263
		},
		GOTOS => {
			'CodeBlock' => 350
		}
	},
	{#State 341
		ACTIONS => {
			")" => 351,
			'OP21_LIST_COMMA' => 352
		},
		GOTOS => {
			'PAREN-23' => 353
		}
	},
	{#State 342
		DEFAULT => -57
	},
	{#State 343
		ACTIONS => {
			"{" => 263
		},
		GOTOS => {
			'CodeBlock' => 354
		}
	},
	{#State 344
		ACTIONS => {
			";" => 355
		}
	},
	{#State 345
		ACTIONS => {
			"%{" => 68,
			'WORD' => 357
		},
		GOTOS => {
			'HashDereferenced' => 356,
			'HashEntryTyped' => 358
		}
	},
	{#State 346
		ACTIONS => {
			"our" => 359,
			"1;" => 361
		},
		GOTOS => {
			'Method' => 360
		}
	},
	{#State 347
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			'LITERAL_STRING' => 66
		},
		GOTOS => {
			'Literal' => 362
		}
	},
	{#State 348
		DEFAULT => -38
	},
	{#State 349
		ACTIONS => {
			"}" => 365,
			'OP21_LIST_COMMA' => 363
		},
		GOTOS => {
			'PAREN-19' => 364
		}
	},
	{#State 350
		DEFAULT => -175
	},
	{#State 351
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 366
		}
	},
	{#State 352
		ACTIONS => {
			"my" => 367
		}
	},
	{#State 353
		DEFAULT => -59
	},
	{#State 354
		DEFAULT => -165
	},
	{#State 355
		ACTIONS => {
			"## no critic qw(" => 20
		},
		GOTOS => {
			'Critic' => 368
		}
	},
	{#State 356
		DEFAULT => -211
	},
	{#State 357
		ACTIONS => {
			'OP20_HASH_FATARROW' => 369
		}
	},
	{#State 358
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 370
		}
	},
	{#State 359
		ACTIONS => {
			'WORD' => 114
		},
		GOTOS => {
			'Type' => 371
		}
	},
	{#State 360
		DEFAULT => -74
	},
	{#State 361
		ACTIONS => {
			"1;" => 372
		}
	},
	{#State 362
		DEFAULT => -40
	},
	{#State 363
		ACTIONS => {
			'WORD' => 373
		}
	},
	{#State 364
		DEFAULT => -48
	},
	{#State 365
		DEFAULT => -52
	},
	{#State 366
		ACTIONS => {
			"\@_;" => 374
		}
	},
	{#State 367
		ACTIONS => {
			'WORD' => 114
		},
		GOTOS => {
			'Type' => 375
		}
	},
	{#State 368
		DEFAULT => -86
	},
	{#State 369
		ACTIONS => {
			"my" => 102
		},
		GOTOS => {
			'TypeInner' => 376
		}
	},
	{#State 370
		ACTIONS => {
			")" => 377,
			'OP21_LIST_COMMA' => 379
		},
		GOTOS => {
			'PAREN-35' => 378
		}
	},
	{#State 371
		ACTIONS => {
			'VARIABLE_SYMBOL' => 380
		}
	},
	{#State 372
		ACTIONS => {
			"package" => -80,
			'' => -80,
			"our" => 55
		},
		GOTOS => {
			'Subroutine' => 381,
			'OPTIONAL-34' => 383,
			'PAREN-33' => 382,
			'PLUS-32' => 384
		}
	},
	{#State 373
		ACTIONS => {
			'OP20_HASH_FATARROW' => 385
		}
	},
	{#State 374
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 386
		}
	},
	{#State 375
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 376
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			"(" => 57,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64
		},
		GOTOS => {
			'HashDereferenced' => 69,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'WordScoped' => 84,
			'ArrayDereferenced' => 50,
			'Expression' => 388,
			'Variable' => 103,
			'Literal' => 44,
			'Operator' => 56
		}
	},
	{#State 377
		ACTIONS => {
			";" => 389
		}
	},
	{#State 378
		DEFAULT => -83
	},
	{#State 379
		ACTIONS => {
			"%{" => 68,
			'WORD' => 357
		},
		GOTOS => {
			'HashDereferenced' => 356,
			'HashEntryTyped' => 390
		}
	},
	{#State 380
		ACTIONS => {
			"= sub {" => 391
		}
	},
	{#State 381
		DEFAULT => -77
	},
	{#State 382
		DEFAULT => -79
	},
	{#State 383
		DEFAULT => -81
	},
	{#State 384
		ACTIONS => {
			"1;" => 393,
			"our" => 55
		},
		GOTOS => {
			'Subroutine' => 392
		}
	},
	{#State 385
		ACTIONS => {
			'LITERAL_NUMBER' => -46,
			'LITERAL_STRING' => -46,
			"my" => 102
		},
		GOTOS => {
			'TypeInner' => 395,
			'OPTIONAL-18' => 394
		}
	},
	{#State 386
		ACTIONS => {
			'OP10_NAMED_UNARY' => -63,
			"while (" => -63,
			'LITERAL_STRING' => -63,
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			'WORD_SCOPED' => -63,
			"\@{" => -63,
			'OP01_NAMED' => -63,
			"%{" => -63,
			"undef" => -63,
			'CHECK_OR_CHECKTRACE' => 397,
			'OP19_LOOP_CONTROL' => -63,
			"[" => -63,
			'OP05_LOGICAL_NEG' => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			'OP05_MATH_NEG' => -63,
			'VARIABLE_SYMBOL' => -63,
			"my" => -63,
			"(" => -63,
			"if (" => -63,
			'OP01_NAMED_VOID' => -63,
			"foreach my" => -63,
			'WORD' => -63,
			"for my integer" => -63,
			'OP03_MATH_INC_DEC' => -63,
			'LITERAL_NUMBER' => -63,
			"{" => -63,
			'OP22_LOGICAL_NOT' => -63
		},
		GOTOS => {
			'ArgumentCheck' => 396
		}
	},
	{#State 387
		DEFAULT => -58
	},
	{#State 388
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP21_LIST_COMMA' => -210,
			'OP23_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP08_STRING_CAT' => 141,
			'OP08_MATH_ADD_SUB' => 127,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => 136,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP18_TERNARY' => 137,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP17_LIST_RANGE' => 128,
			'OP09_BITWISE_SHIFT' => 131,
			'OP16_LOGICAL_OR' => 138,
			")" => -210,
			'OP12_COMPARE_EQ_NEQ' => 132
		}
	},
	{#State 389
		DEFAULT => -85
	},
	{#State 390
		DEFAULT => -82
	},
	{#State 391
		ACTIONS => {
			"if (" => -88,
			"(" => -88,
			"my" => -88,
			'VARIABLE_SYMBOL' => -88,
			'OP01_NAMED_VOID_PAREN' => -88,
			'OP05_LOGICAL_NEG' => -88,
			'OP05_MATH_NEG' => -88,
			"[" => -88,
			'OP22_LOGICAL_NOT' => -88,
			"{" => -88,
			'LITERAL_NUMBER' => -88,
			'OP03_MATH_INC_DEC' => -88,
			"for my integer" => -88,
			'WORD' => -88,
			"foreach my" => -88,
			'OP01_NAMED_VOID' => -88,
			"( my" => 400,
			'WORD_SCOPED' => -88,
			'LITERAL_STRING' => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			"while (" => -88,
			'OP10_NAMED_UNARY' => -88,
			'OP19_LOOP_CONTROL' => -88,
			"%{" => -88,
			"undef" => -88,
			"\@{" => -88,
			'OP01_NAMED' => -88
		},
		GOTOS => {
			'MethodArguments' => 399,
			'OPTIONAL-37' => 398
		}
	},
	{#State 392
		DEFAULT => -76
	},
	{#State 393
		ACTIONS => {
			"1;" => 401
		}
	},
	{#State 394
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			'LITERAL_STRING' => 66
		},
		GOTOS => {
			'Literal' => 402
		}
	},
	{#State 395
		DEFAULT => -45
	},
	{#State 396
		DEFAULT => -61
	},
	{#State 397
		ACTIONS => {
			"(" => 403
		}
	},
	{#State 398
		ACTIONS => {
			'VARIABLE_SYMBOL' => 54,
			'OP01_NAMED_VOID_PAREN' => 77,
			'OP05_MATH_NEG' => 53,
			'OP05_LOGICAL_NEG' => 52,
			"[" => 51,
			"if (" => 80,
			"(" => 57,
			"my" => 78,
			"for my integer" => -159,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 81,
			"foreach my" => -159,
			'OP01_NAMED_VOID' => 58,
			'OP22_LOGICAL_NOT' => 62,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			"while (" => -159,
			'OP10_NAMED_UNARY' => 64,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'OP19_LOOP_CONTROL' => 73,
			"undef" => 48,
			"%{" => 68,
			'OP01_NAMED' => 47,
			"\@{" => 46
		},
		GOTOS => {
			'ArrayDereferenced' => 50,
			'VariableDeclaration' => 76,
			'Operator' => 56,
			'Variable' => 79,
			'LoopLabel' => 59,
			'Conditional' => 85,
			'WordScoped' => 84,
			'OperatorVoid' => 61,
			'Statement' => 43,
			'Expression' => 63,
			'Operation' => 404,
			'Literal' => 44,
			'OPTIONAL-50' => 49,
			'HashReference' => 71,
			'PAREN-49' => 72,
			'ArrayReference' => 70,
			'PLUS-38' => 405,
			'HashDereferenced' => 69,
			'VariableModification' => 67
		}
	},
	{#State 399
		DEFAULT => -87
	},
	{#State 400
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 406
		}
	},
	{#State 401
		DEFAULT => -78
	},
	{#State 402
		DEFAULT => -47
	},
	{#State 403
		ACTIONS => {
			"(" => 57,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			'OP01_NAMED' => 47,
			"\@{" => 46,
			"%{" => 68,
			"undef" => 48
		},
		GOTOS => {
			'Operator' => 56,
			'Variable' => 103,
			'Literal' => 44,
			'Expression' => 407,
			'ArrayDereferenced' => 50,
			'WordScoped' => 84,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'HashDereferenced' => 69
		}
	},
	{#State 404
		DEFAULT => -90
	},
	{#State 405
		ACTIONS => {
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"undef" => 48,
			"%{" => 68,
			"}" => 408,
			'OP19_LOOP_CONTROL' => 73,
			'OP10_NAMED_UNARY' => 64,
			"while (" => -159,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'LITERAL_STRING' => 66,
			'WORD_SCOPED' => 13,
			'OP01_NAMED_VOID' => 58,
			"foreach my" => -159,
			'WORD' => 81,
			"for my integer" => -159,
			'OP03_MATH_INC_DEC' => 60,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'OP22_LOGICAL_NOT' => 62,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'OP01_NAMED_VOID_PAREN' => 77,
			'VARIABLE_SYMBOL' => 54,
			"my" => 78,
			"if (" => 80,
			"(" => 57
		},
		GOTOS => {
			'Operation' => 409,
			'Literal' => 44,
			'Expression' => 63,
			'Statement' => 43,
			'VariableModification' => 67,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'PAREN-49' => 72,
			'HashReference' => 71,
			'OPTIONAL-50' => 49,
			'Variable' => 79,
			'Operator' => 56,
			'VariableDeclaration' => 76,
			'ArrayDereferenced' => 50,
			'OperatorVoid' => 61,
			'WordScoped' => 84,
			'Conditional' => 85,
			'LoopLabel' => 59
		}
	},
	{#State 406
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 410
		}
	},
	{#State 407
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP08_STRING_CAT' => 141,
			'OP21_LIST_COMMA' => 411,
			'OP23_LOGICAL_AND' => 140,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP18_TERNARY' => 137,
			'OP17_LIST_RANGE' => 128,
			'OP08_MATH_ADD_SUB' => 127,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => 136,
			")" => -66,
			'OP16_LOGICAL_OR' => 138,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP09_BITWISE_SHIFT' => 131
		},
		GOTOS => {
			'OPTIONAL-27' => 412,
			'PAREN-26' => 413
		}
	},
	{#State 408
		ACTIONS => {
			";" => 414
		}
	},
	{#State 409
		DEFAULT => -89
	},
	{#State 410
		ACTIONS => {
			")" => 415,
			'OP21_LIST_COMMA' => 417
		},
		GOTOS => {
			'PAREN-39' => 416
		}
	},
	{#State 411
		ACTIONS => {
			"%{" => 68,
			"undef" => 48,
			"\@{" => 46,
			'OP01_NAMED' => 47,
			'OP10_NAMED_UNARY' => 64,
			'WORD_SCOPED' => 13,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'OP03_MATH_INC_DEC' => 60,
			'WORD' => 15,
			'OP22_LOGICAL_NOT' => 62,
			"{" => 83,
			'LITERAL_NUMBER' => 82,
			'VARIABLE_SYMBOL' => 54,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			"[" => 51,
			"(" => 57
		},
		GOTOS => {
			'WordScoped' => 84,
			'HashDereferenced' => 69,
			'ArrayReference' => 70,
			'HashReference' => 71,
			'Literal' => 44,
			'Variable' => 103,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 418
		}
	},
	{#State 412
		ACTIONS => {
			")" => 419
		}
	},
	{#State 413
		DEFAULT => -65
	},
	{#State 414
		DEFAULT => -91
	},
	{#State 415
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 420
		}
	},
	{#State 416
		DEFAULT => -93
	},
	{#State 417
		ACTIONS => {
			"my" => 421
		}
	},
	{#State 418
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP04_MATH_POW' => 125,
			'OP13_BITWISE_AND' => 136,
			'OP08_MATH_ADD_SUB' => 127,
			'OP17_LIST_RANGE' => 128,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 129,
			'OP18_TERNARY' => 137,
			'OP09_BITWISE_SHIFT' => 131,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP16_LOGICAL_OR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP11_COMPARE_LT_GT' => 133,
			'OP23_LOGICAL_AND' => 140,
			'OP21_LIST_COMMA' => 422,
			'OP08_STRING_CAT' => 141,
			'OP14_BITWISE_OR_XOR' => 135
		}
	},
	{#State 419
		ACTIONS => {
			";" => 423
		}
	},
	{#State 420
		ACTIONS => {
			"\@_;" => 424
		}
	},
	{#State 421
		ACTIONS => {
			'WORD' => 114
		},
		GOTOS => {
			'Type' => 425
		}
	},
	{#State 422
		ACTIONS => {
			"\@{" => 46,
			'OP01_NAMED' => 47,
			"%{" => 68,
			"undef" => 48,
			'LITERAL_STRING' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 65,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 64,
			'OP22_LOGICAL_NOT' => 62,
			'LITERAL_NUMBER' => 82,
			"{" => 83,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 60,
			"(" => 57,
			'OP05_LOGICAL_NEG' => 52,
			'OP05_MATH_NEG' => 53,
			'VARIABLE_SYMBOL' => 54,
			"[" => 51
		},
		GOTOS => {
			'WordScoped' => 84,
			'HashDereferenced' => 69,
			'HashReference' => 71,
			'ArrayReference' => 70,
			'Variable' => 103,
			'Literal' => 44,
			'Operator' => 56,
			'ArrayDereferenced' => 50,
			'Expression' => 426
		}
	},
	{#State 423
		DEFAULT => -67
	},
	{#State 424
		DEFAULT => -96,
		GOTOS => {
			'STAR-41' => 427
		}
	},
	{#State 425
		ACTIONS => {
			'VARIABLE_SYMBOL' => 428
		}
	},
	{#State 426
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 135,
			'OP08_STRING_CAT' => 141,
			'OP23_LOGICAL_AND' => 140,
			'OP11_COMPARE_LT_GT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			")" => -64,
			'OP16_LOGICAL_OR' => 138,
			'OP12_COMPARE_EQ_NEQ' => 132,
			'OP09_BITWISE_SHIFT' => 131,
			'OP15_LOGICAL_AND' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP18_TERNARY' => 137,
			'OP17_LIST_RANGE' => 128,
			'OP08_MATH_ADD_SUB' => 127,
			'OP24_LOGICAL_OR_XOR' => 126,
			'OP13_BITWISE_AND' => 136,
			'OP04_MATH_POW' => 125
		}
	},
	{#State 427
		ACTIONS => {
			'OP22_LOGICAL_NOT' => -97,
			"{" => -97,
			'LITERAL_NUMBER' => -97,
			"for my integer" => -97,
			'OP03_MATH_INC_DEC' => -97,
			'WORD' => -97,
			"foreach my" => -97,
			'OP01_NAMED_VOID' => -97,
			"if (" => -97,
			"(" => -97,
			"my" => -97,
			'VARIABLE_SYMBOL' => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			'OP05_LOGICAL_NEG' => -97,
			'OP05_MATH_NEG' => -97,
			"[" => -97,
			'OP19_LOOP_CONTROL' => -97,
			'CHECK_OR_CHECKTRACE' => 397,
			"%{" => -97,
			"undef" => -97,
			'OP01_NAMED' => -97,
			"\@{" => -97,
			'WORD_SCOPED' => -97,
			'LITERAL_STRING' => -97,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			"while (" => -97,
			'OP10_NAMED_UNARY' => -97
		},
		GOTOS => {
			'ArgumentCheck' => 429
		}
	},
	{#State 428
		DEFAULT => -92
	},
	{#State 429
		DEFAULT => -95
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5628 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5635 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5642 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5653 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5664 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5671 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5678 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5685 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5692 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5699 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5706 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5713 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5720 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5727 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5734 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5745 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5756 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5767 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5774 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5781 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5788 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5795 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5802 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5809 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5816 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5823 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 10,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5845 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5852 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5859 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5877 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5884 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5895 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5906 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5917 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5924 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5931 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5938 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5945 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5952 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5959 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5973 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5980 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5987 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5994 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6001 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6008 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6015 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6026 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6037 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6048 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6055 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6062 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6069 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6076 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6087 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6094 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6108 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6115 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6122 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6140 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6147 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6154 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6172 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6179 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6186 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6193 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6200 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6207 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6214 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6221 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6228 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6235 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 3,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6242 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6256 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 17,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6267 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6274 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6281 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6288 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6299 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6310 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6317 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6324 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6331 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6338 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6349 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6356 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6363 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6370 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6377 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6384 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6395 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6406 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6417 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6431 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6442 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6453 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6464 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6475 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6486 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6497 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6508 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6519 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6530 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6541 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6552 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6563 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6574 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6585 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6596 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6607 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6618 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6629 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6640 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6651 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6662 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6673 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6684 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6695 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6762 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6773 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6784 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6795 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6806 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6813 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6820 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6827 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6834 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6845 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6856 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6867 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6878 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6889 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6900 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6911 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6944 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6955 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_155
		 'ExpressionOrStdin', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6977 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_156
		 'ExpressionOrStdin', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6988 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7009 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7020 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7031 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7042 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_163
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7053 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_164
		 'Statement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7092 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7099 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7106 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_171
		 'Conditional', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7117 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7128 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_173
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7139 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_174
		 'Loop', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7150 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_175
		 'LoopFor', 8,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_176
		 'LoopForEach', 7,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_177
		 'LoopWhile', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7190 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7197 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_180
		 'CodeBlock', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7208 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7215 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7222 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_183
		 'Variable', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7233 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7244 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_185
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7255 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_186
		 'VariableRetrieval', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7266 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_187
		 'VariableDeclaration', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7277 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_188
		 'VariableDeclaration', 6,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7288 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_189
		 'VariableModification', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7299 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_190
		 'VariableModification', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7324 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7331 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 1,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7345 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_196
		 'ListElements', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7356 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_197
		 'ListElements', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7367 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_198
		 'ListElement', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7378 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_199
		 'ListElement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7389 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_200
		 'ListElement', 2,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7400 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7407 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7414 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_203
		 'ArrayReference', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7425 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_204
		 'ArrayDereferenced', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7436 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_205
		 'ArrayDereferenced', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7447 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7454 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7461 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_208
		 'HashEntry', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7472 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_209
		 'HashEntry', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7483 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_210
		 'HashEntryTyped', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7494 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_211
		 'HashEntryTyped', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-62', 2,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7512 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 2,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7526 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_215
		 'HashReference', 4,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7537 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_216
		 'HashDereferenced', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_217
		 'HashDereferenced', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7559 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_218
		 'WordScoped', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7570 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_219
		 'WordScoped', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7581 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_220
		 'FileHandle', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7592 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_221
		 'FileHandle', 3,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7603 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_222
		 'TypeInner', 5,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7614 lib/RPerl/Grammar.pm
	],
	[#Rule Type_223
		 'Type', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7625 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_224
		 'LoopLabel', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7636 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_225
		 'Literal', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7647 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_226
		 'Literal', 1,
sub {
#line 16 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7658 lib/RPerl/Grammar.pm
	]
],
#line 7661 lib/RPerl/Grammar.pm
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

#line 181 "lib/RPerl/Grammar.eyp"


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


#line 7936 lib/RPerl/Grammar.pm



1;
