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
    our $VERSION = 0.000_731;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G(\s*(\#.+)*\s*)+/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|for\ my\ integer|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|package|\$TYPED_|while\ \(|\<STDIN\>|elsif\ \(|\=\ sub\ \{|undef|\(\ my|else|if\ \(|\@_\;|our|qw\(|use|\@\{|1\;|\{\*|my|\%\{|\.\.|\[|\]|\)|\}|\/|\(|\{|\;)}gc and return ($1, $1);

      /\G(^(\#\!\/[\w\/]*\/perl)$)/gc and return ('SHEBANG', $1);
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
      /\G(^.)/gc and return ('OP06_REGEX_PATTERN', $1);
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
      /\G(^.)/gc and return ('OP01_NAMED', $1);
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
			"package" => 5,
			'SHEBANG' => 3
		},
		GOTOS => {
			'Program' => 4,
			'PLUS-1' => 7,
			'CompileUnit' => 6,
			'Package' => 1,
			'Class' => 2,
			'Module' => 8
		}
	},
	{#State 1
		DEFAULT => -16
	},
	{#State 2
		DEFAULT => -17
	},
	{#State 3
		ACTIONS => {
			"use strict;" => 9
		},
		GOTOS => {
			'Header' => 10
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			'WORD_SCOPED' => 12,
			'WORD' => 11
		},
		GOTOS => {
			'WordScoped' => 13
		}
	},
	{#State 6
		ACTIONS => {
			'' => 14
		}
	},
	{#State 7
		ACTIONS => {
			"package" => 5,
			'' => -4
		},
		GOTOS => {
			'Module' => 15,
			'Package' => 1,
			'Class' => 2
		}
	},
	{#State 8
		DEFAULT => -2
	},
	{#State 9
		ACTIONS => {
			"use warnings;" => 16
		}
	},
	{#State 10
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 17
		}
	},
	{#State 11
		DEFAULT => -218
	},
	{#State 12
		DEFAULT => -219
	},
	{#State 13
		ACTIONS => {
			";" => 18
		}
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		ACTIONS => {
			"use RPerl;" => 19
		}
	},
	{#State 17
		ACTIONS => {
			'VARIABLE_SYMBOL' => -8,
			'OP01_NAMED_VOID' => -8,
			'OP10_NAMED_UNARY' => -8,
			"(" => -8,
			"undef" => -8,
			"if (" => -8,
			'OP03_MATH_INC_DEC' => -8,
			"## no critic qw(" => 22,
			"\@{" => -8,
			"%{" => -8,
			"foreach my" => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"while (" => -8,
			"use" => -8,
			'WORD' => -8,
			"my" => -8,
			'OP01_NAMED' => -8,
			"for my integer" => -8,
			'OP22_LOGICAL_NOT' => -8,
			'OP19_LOOP_CONTROL' => -8,
			"[" => -8,
			"use constant" => -8,
			'WORD_SCOPED' => -8,
			"{" => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			'LITERAL_NUMBER' => -8,
			'OP05_LOGICAL_NEG' => -8,
			"our" => -8,
			'LITERAL_STRING' => -8,
			'OP05_MATH_NEG' => -8
		},
		GOTOS => {
			'STAR-3' => 21,
			'Critic' => 20
		}
	},
	{#State 18
		ACTIONS => {
			"use strict;" => 9
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
			'VARIABLE_SYMBOL' => -10,
			'OP01_NAMED_VOID' => -10,
			'OP10_NAMED_UNARY' => -10,
			"(" => -10,
			"undef" => -10,
			"if (" => -10,
			'OP03_MATH_INC_DEC' => -10,
			"%{" => -10,
			"\@{" => -10,
			"foreach my" => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"while (" => -10,
			"my" => -10,
			'WORD' => -10,
			"use" => 26,
			'OP01_NAMED' => -10,
			"for my integer" => -10,
			'OP22_LOGICAL_NOT' => -10,
			"{" => -10,
			"[" => -10,
			'OP19_LOOP_CONTROL' => -10,
			"use constant" => -10,
			'WORD_SCOPED' => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			'LITERAL_NUMBER' => -10,
			'OP05_LOGICAL_NEG' => -10,
			"our" => -10,
			'LITERAL_STRING' => -10,
			'OP05_MATH_NEG' => -10
		},
		GOTOS => {
			'Include' => 27,
			'STAR-4' => 25
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
			"## no critic qw(" => -19,
			"use" => -19,
			"use parent qw(" => 30,
			"our" => -19,
			"use constant" => -19
		},
		GOTOS => {
			'STAR-7' => 31
		}
	},
	{#State 24
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 32
		}
	},
	{#State 25
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			'LITERAL_NUMBER' => -12,
			'OP19_LOOP_CONTROL' => -12,
			"[" => -12,
			'WORD_SCOPED' => -12,
			"{" => -12,
			"use constant" => 34,
			'LITERAL_STRING' => -12,
			'OP05_MATH_NEG' => -12,
			'OP05_LOGICAL_NEG' => -12,
			"our" => -12,
			'OP03_MATH_INC_DEC' => -12,
			"\@{" => -12,
			"%{" => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			"foreach my" => -12,
			'OP01_NAMED_VOID' => -12,
			'VARIABLE_SYMBOL' => -12,
			"(" => -12,
			'OP10_NAMED_UNARY' => -12,
			"if (" => -12,
			"undef" => -12,
			"my" => -12,
			'WORD' => -12,
			'OP01_NAMED' => -12,
			'OP22_LOGICAL_NOT' => -12,
			"for my integer" => -12,
			"while (" => -12
		},
		GOTOS => {
			'Constant' => 35,
			'STAR-5' => 33
		}
	},
	{#State 26
		ACTIONS => {
			'WORD' => 11,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 27
		DEFAULT => -7
	},
	{#State 28
		DEFAULT => -29
	},
	{#State 29
		ACTIONS => {
			")" => 38,
			'WORD' => 37
		}
	},
	{#State 30
		ACTIONS => {
			'WORD' => 11,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 31
		ACTIONS => {
			"use" => -21,
			"## no critic qw(" => 22,
			"use constant" => -21,
			"our" => -21
		},
		GOTOS => {
			'STAR-8' => 40,
			'Critic' => 41
		}
	},
	{#State 32
		DEFAULT => -27
	},
	{#State 33
		ACTIONS => {
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50,
			"our" => 71,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP19_LOOP_CONTROL' => 68,
			"{" => 67,
			"[" => 46,
			'WORD_SCOPED' => 12,
			"for my integer" => -159,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			"my" => 61,
			'WORD' => 84,
			"while (" => -159,
			'OP01_NAMED_VOID_PAREN' => 53,
			"foreach my" => -159,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			"if (" => 57,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'VARIABLE_SYMBOL' => 79,
			'OP01_NAMED_VOID' => 78
		},
		GOTOS => {
			'VariableDeclaration' => 45,
			'LoopLabel' => 47,
			'WordScoped' => 44,
			'Subroutine' => 66,
			'OPTIONAL-50' => 65,
			'Operation' => 64,
			'ArrayReference' => 42,
			'PAREN-49' => 73,
			'OperatorVoid' => 52,
			'VariableModification' => 72,
			'Variable' => 51,
			'HashDereferenced' => 49,
			'PLUS-6' => 69,
			'ArrayDereferenced' => 80,
			'Operator' => 77,
			'HashReference' => 75,
			'Statement' => 56,
			'Conditional' => 60,
			'Expression' => 83,
			'Literal' => 62
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => 85
		}
	},
	{#State 35
		DEFAULT => -9
	},
	{#State 36
		ACTIONS => {
			";" => 87,
			"qw(" => 86
		}
	},
	{#State 37
		DEFAULT => -28
	},
	{#State 38
		DEFAULT => -30
	},
	{#State 39
		ACTIONS => {
			")" => 88
		}
	},
	{#State 40
		ACTIONS => {
			"use" => 26,
			"our" => -23,
			"use constant" => -23
		},
		GOTOS => {
			'Include' => 89,
			'STAR-9' => 90
		}
	},
	{#State 41
		DEFAULT => -18
	},
	{#State 42
		DEFAULT => -146
	},
	{#State 43
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			"undef" => 76,
			'OP03_MATH_INC_DEC' => 74,
			"\@{" => 55,
			"%{" => 54,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			'OP22_LOGICAL_NOT' => 81,
			'WORD_SCOPED' => 12,
			"{" => 67,
			"[" => 46,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48
		},
		GOTOS => {
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'Operator' => 77,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'Literal' => 62,
			'Expression' => 92
		}
	},
	{#State 44
		ACTIONS => {
			"(" => 93
		}
	},
	{#State 45
		DEFAULT => -163
	},
	{#State 46
		ACTIONS => {
			'OP01_NAMED_QW' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50,
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 81,
			'WORD' => 11,
			"my" => 97,
			'OP01_NAMED' => 82,
			"]" => -202,
			'KEYS_OR_VALUES' => 96
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Variable' => 91,
			'OPTIONAL-60' => 94,
			'Literal' => 62,
			'Expression' => 100,
			'TypeInner' => 98,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'ListElements' => 101,
			'WordScoped' => 44,
			'ListElement' => 99,
			'ArrayReference' => 42,
			'HashReference' => 75
		}
	},
	{#State 47
		ACTIONS => {
			'COLON' => 102
		}
	},
	{#State 48
		ACTIONS => {
			'WORD_SCOPED' => 12,
			"{" => 67,
			"[" => 46,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'OP03_MATH_INC_DEC' => 74,
			"%{" => 54,
			"\@{" => 55,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Variable' => 91,
			'Expression' => 103,
			'Literal' => 62,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'ArrayReference' => 42,
			'HashReference' => 75
		}
	},
	{#State 49
		DEFAULT => -149
	},
	{#State 50
		ACTIONS => {
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 81,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Variable' => 91,
			'Literal' => 62,
			'Expression' => 104,
			'Operator' => 77,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 42,
			'HashReference' => 75
		}
	},
	{#State 51
		ACTIONS => {
			'OP13_BITWISE_AND' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP03_MATH_INC_DEC' => 107,
			'OP19_VARIABLE_ASSIGN_BY' => 108,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP02_METHOD_THINARROW' => 105,
			'OP19_VARIABLE_ASSIGN' => 106,
			'OP06_REGEX_MATCH' => -145,
			'OP18_TERNARY' => -145,
			'OP23_LOGICAL_AND' => -145,
			";" => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP04_MATH_POW' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP08_STRING_CAT' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP16_LOGICAL_OR' => -145
		}
	},
	{#State 52
		DEFAULT => -162
	},
	{#State 53
		ACTIONS => {
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50,
			'OP01_NAMED_QW' => 95,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD_SCOPED' => 12,
			"{" => 67,
			"{*" => 110,
			"[" => 46,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			"my" => 109,
			")" => -127,
			'KEYS_OR_VALUES' => 96,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'HashReference' => 75,
			'ArrayReference' => 42,
			'ListElements' => 111,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'ListElement' => 99,
			'Operator' => 77,
			'FileHandle' => 112,
			'Literal' => 62,
			'Expression' => 100,
			'OPTIONAL-43' => 113,
			'TypeInner' => 98,
			'Variable' => 91,
			'HashDereferenced' => 49
		}
	},
	{#State 54
		ACTIONS => {
			"{" => 114,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'HashReference' => 115,
			'Variable' => 116
		}
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			"[" => 46
		},
		GOTOS => {
			'ArrayReference' => 118,
			'Variable' => 117
		}
	},
	{#State 56
		DEFAULT => -99
	},
	{#State 57
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'WORD_SCOPED' => 12,
			"[" => 46,
			"{" => 67,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'OP03_MATH_INC_DEC' => 74,
			"\@{" => 55,
			"%{" => 54
		},
		GOTOS => {
			'Literal' => 62,
			'Expression' => 119,
			'HashDereferenced' => 49,
			'Variable' => 91,
			'ArrayReference' => 42,
			'HashReference' => 75,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44
		}
	},
	{#State 58
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43
		},
		GOTOS => {
			'Literal' => 62,
			'Expression' => 120,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77
		}
	},
	{#State 59
		ACTIONS => {
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"[" => 46,
			"{" => 67,
			'WORD_SCOPED' => 12,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50
		},
		GOTOS => {
			'ArrayReference' => 42,
			'HashReference' => 75,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'Expression' => 121,
			'Literal' => 62,
			'HashDereferenced' => 49,
			'Variable' => 91
		}
	},
	{#State 60
		DEFAULT => -160
	},
	{#State 61
		ACTIONS => {
			'WORD' => 123
		},
		GOTOS => {
			'Type' => 122
		}
	},
	{#State 62
		DEFAULT => -144
	},
	{#State 63
		DEFAULT => -226
	},
	{#State 64
		DEFAULT => -14
	},
	{#State 65
		ACTIONS => {
			"for my integer" => 129,
			"foreach my" => 126,
			"while (" => 130
		},
		GOTOS => {
			'LoopFor' => 125,
			'Loop' => 128,
			'LoopForEach' => 127,
			'LoopWhile' => 124
		}
	},
	{#State 66
		DEFAULT => -11
	},
	{#State 67
		ACTIONS => {
			"%{" => 54,
			"}" => 132,
			'WORD' => 131
		},
		GOTOS => {
			'HashDereferenced' => 134,
			'HashEntry' => 133
		}
	},
	{#State 68
		ACTIONS => {
			'WORD' => 135
		},
		GOTOS => {
			'LoopLabel' => 136
		}
	},
	{#State 69
		ACTIONS => {
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP19_LOOP_CONTROL' => 68,
			"{" => 67,
			'WORD_SCOPED' => 12,
			"[" => 46,
			'' => -15,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50,
			"foreach my" => -159,
			'OP01_NAMED_VOID_PAREN' => 53,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			"undef" => 76,
			"if (" => 57,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'VARIABLE_SYMBOL' => 79,
			'OP01_NAMED_VOID' => 78,
			'OP22_LOGICAL_NOT' => 81,
			"for my integer" => -159,
			'OP01_NAMED' => 82,
			'WORD' => 84,
			"my" => 61,
			"while (" => -159
		},
		GOTOS => {
			'ArrayReference' => 42,
			'OPTIONAL-50' => 65,
			'Operation' => 137,
			'LoopLabel' => 47,
			'VariableDeclaration' => 45,
			'WordScoped' => 44,
			'HashDereferenced' => 49,
			'OperatorVoid' => 52,
			'PAREN-49' => 73,
			'VariableModification' => 72,
			'Variable' => 51,
			'Statement' => 56,
			'HashReference' => 75,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'Expression' => 83,
			'Conditional' => 60,
			'Literal' => 62
		}
	},
	{#State 70
		DEFAULT => -225
	},
	{#State 71
		ACTIONS => {
			'WORD' => 123
		},
		GOTOS => {
			'Type' => 138
		}
	},
	{#State 72
		DEFAULT => -164
	},
	{#State 73
		DEFAULT => -158
	},
	{#State 74
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Variable' => 139
		}
	},
	{#State 75
		DEFAULT => -148
	},
	{#State 76
		DEFAULT => -143
	},
	{#State 77
		DEFAULT => -151
	},
	{#State 78
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			"{" => 67,
			'WORD_SCOPED' => 12,
			"[" => 46,
			"{*" => 110,
			'OP01_NAMED_QW' => 95,
			'LITERAL_NUMBER' => 63,
			";" => -131,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'KEYS_OR_VALUES' => 96,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			"my" => 109,
			'WORD' => 11,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'VARIABLE_SYMBOL' => 79,
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74
		},
		GOTOS => {
			'Expression' => 100,
			'Literal' => 62,
			'TypeInner' => 98,
			'OPTIONAL-45' => 142,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'ArrayDereferenced' => 80,
			'ListElements' => 141,
			'ListElement' => 99,
			'WordScoped' => 44,
			'Operator' => 77,
			'FileHandle' => 140
		}
	},
	{#State 79
		DEFAULT => -182,
		GOTOS => {
			'STAR-56' => 143
		}
	},
	{#State 80
		DEFAULT => -147
	},
	{#State 81
		ACTIONS => {
			'WORD_SCOPED' => 12,
			"[" => 46,
			"{" => 67,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'VARIABLE_SYMBOL' => 79,
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11
		},
		GOTOS => {
			'Expression' => 144,
			'Literal' => 62,
			'HashDereferenced' => 49,
			'Variable' => 91,
			'ArrayReference' => 42,
			'HashReference' => 75,
			'Operator' => 77,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80
		}
	},
	{#State 82
		ACTIONS => {
			"(" => 145
		}
	},
	{#State 83
		ACTIONS => {
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			'OP06_REGEX_MATCH' => 159,
			'OP18_TERNARY' => 148,
			'OP23_LOGICAL_AND' => 150,
			";" => 149,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP04_MATH_POW' => 146,
			'OP17_LIST_RANGE' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP16_LOGICAL_OR' => 147
		}
	},
	{#State 84
		ACTIONS => {
			'COLON' => -224,
			"(" => -218
		}
	},
	{#State 85
		ACTIONS => {
			'OP20_HASH_FATARROW' => 163
		}
	},
	{#State 86
		ACTIONS => {
			'WORD' => 165
		},
		GOTOS => {
			'PLUS-12' => 164
		}
	},
	{#State 87
		DEFAULT => -33
	},
	{#State 88
		ACTIONS => {
			";" => 166
		}
	},
	{#State 89
		DEFAULT => -20
	},
	{#State 90
		ACTIONS => {
			"use constant" => 34,
			"our" => 71
		},
		GOTOS => {
			'PLUS-10' => 168,
			'Subroutine' => 169,
			'Constant' => 167
		}
	},
	{#State 91
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP03_MATH_INC_DEC' => 107,
			"}" => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP13_BITWISE_AND' => -145,
			".." => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			"]" => -145,
			")" => -145,
			";" => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP21_LIST_COMMA' => -145,
			'OP18_TERNARY' => -145,
			'OP02_METHOD_THINARROW' => 105,
			'OP16_LOGICAL_OR' => -145,
			'OP08_STRING_CAT' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP04_MATH_POW' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP08_MATH_ADD_SUB' => -145
		}
	},
	{#State 92
		ACTIONS => {
			"]" => -114,
			")" => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP15_LOGICAL_AND' => -114,
			'OP13_BITWISE_AND' => -114,
			".." => -114,
			"}" => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP17_LIST_RANGE' => -114,
			'OP08_MATH_ADD_SUB' => 156,
			'OP12_COMPARE_EQ_NEQ' => -114,
			'OP04_MATH_POW' => 146,
			'OP16_LOGICAL_OR' => -114,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP23_LOGICAL_AND' => -114,
			";" => -114,
			'OP18_TERNARY' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP06_REGEX_MATCH' => 159
		}
	},
	{#State 93
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			"my" => 97,
			")" => -140,
			'KEYS_OR_VALUES' => 96,
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'VARIABLE_SYMBOL' => 79,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50,
			'OP01_NAMED_QW' => 95,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"{" => 67,
			"[" => 46,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'Operator' => 77,
			'WordScoped' => 44,
			'ListElement' => 99,
			'ArrayDereferenced' => 80,
			'ListElements' => 170,
			'ArrayReference' => 42,
			'OPTIONAL-47' => 171,
			'HashReference' => 75,
			'HashDereferenced' => 49,
			'Variable' => 91,
			'TypeInner' => 98,
			'Expression' => 100,
			'Literal' => 62
		}
	},
	{#State 94
		ACTIONS => {
			"]" => 172
		}
	},
	{#State 95
		ACTIONS => {
			"(" => 173
		}
	},
	{#State 96
		ACTIONS => {
			"%{" => 54
		},
		GOTOS => {
			'HashDereferenced' => 174
		}
	},
	{#State 97
		ACTIONS => {
			'WORD' => 123
		},
		GOTOS => {
			'Type' => 175
		}
	},
	{#State 98
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			'OP22_LOGICAL_NOT' => 81,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74
		},
		GOTOS => {
			'Expression' => 176,
			'Literal' => 62,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'Operator' => 77
		}
	},
	{#State 99
		DEFAULT => -193,
		GOTOS => {
			'STAR-58' => 177
		}
	},
	{#State 100
		ACTIONS => {
			'OP18_TERNARY' => 148,
			'OP21_LIST_COMMA' => -198,
			'OP06_REGEX_MATCH' => 159,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP23_LOGICAL_AND' => 150,
			";" => -198,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			")" => -198,
			"]" => -198
		}
	},
	{#State 101
		DEFAULT => -201
	},
	{#State 102
		DEFAULT => -157
	},
	{#State 103
		ACTIONS => {
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152,
			'OP24_LOGICAL_OR_XOR' => 162,
			")" => 178,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP23_LOGICAL_AND' => 150,
			'OP18_TERNARY' => 148,
			'OP06_REGEX_MATCH' => 159,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP16_LOGICAL_OR' => 147,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158
		}
	},
	{#State 104
		ACTIONS => {
			"}" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP13_BITWISE_AND' => -106,
			".." => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			"]" => -106,
			")" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP23_LOGICAL_AND' => -106,
			";" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP18_TERNARY' => -106,
			'OP06_REGEX_MATCH' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP08_STRING_CAT' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP04_MATH_POW' => 146
		}
	},
	{#State 105
		ACTIONS => {
			'WORD' => 179
		}
	},
	{#State 106
		ACTIONS => {
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 81,
			"<STDIN>" => 181,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			'WORD_SCOPED' => 12,
			"[" => 46,
			"{" => 67,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Variable' => 91,
			'Literal' => 62,
			'Expression' => 180,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'ExpressionOrStdin' => 182,
			'ArrayReference' => 42,
			'HashReference' => 75
		}
	},
	{#State 107
		DEFAULT => -104
	},
	{#State 108
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			"{" => 67,
			"[" => 46,
			'WORD_SCOPED' => 12,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			'OP22_LOGICAL_NOT' => 81,
			'WORD' => 11,
			'OP01_NAMED' => 82
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Variable' => 91,
			'Literal' => 62,
			'Expression' => 183,
			'Operator' => 77,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 42,
			'HashReference' => 75
		}
	},
	{#State 109
		ACTIONS => {
			"filehandle_ref" => 184,
			'WORD' => 123
		},
		GOTOS => {
			'Type' => 175
		}
	},
	{#State 110
		ACTIONS => {
			'WORD' => 185
		}
	},
	{#State 111
		DEFAULT => -126
	},
	{#State 112
		ACTIONS => {
			"my" => 97,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			'OP22_LOGICAL_NOT' => 81,
			'KEYS_OR_VALUES' => 96,
			")" => -129,
			'OP03_MATH_INC_DEC' => 74,
			"\@{" => 55,
			"%{" => 54,
			'VARIABLE_SYMBOL' => 79,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			"undef" => 76,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			'OP01_NAMED_QW' => 95,
			"{" => 67,
			'WORD_SCOPED' => 12,
			"[" => 46
		},
		GOTOS => {
			'HashReference' => 75,
			'ArrayReference' => 42,
			'WordScoped' => 44,
			'ListElement' => 99,
			'ListElements' => 187,
			'ArrayDereferenced' => 80,
			'Operator' => 77,
			'TypeInner' => 98,
			'Literal' => 62,
			'Expression' => 100,
			'Variable' => 91,
			'OPTIONAL-44' => 186,
			'HashDereferenced' => 49
		}
	},
	{#State 113
		ACTIONS => {
			")" => 188
		}
	},
	{#State 114
		ACTIONS => {
			'WORD' => 131,
			"%{" => 54
		},
		GOTOS => {
			'HashEntry' => 133,
			'HashDereferenced' => 134
		}
	},
	{#State 115
		ACTIONS => {
			"}" => 189
		}
	},
	{#State 116
		ACTIONS => {
			"}" => 190
		}
	},
	{#State 117
		ACTIONS => {
			"}" => 191
		}
	},
	{#State 118
		ACTIONS => {
			"}" => 192
		}
	},
	{#State 119
		ACTIONS => {
			'OP18_TERNARY' => 148,
			'OP06_REGEX_MATCH' => 159,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP23_LOGICAL_AND' => 150,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP16_LOGICAL_OR' => 147,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			")" => 193
		}
	},
	{#State 120
		ACTIONS => {
			")" => 194,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP17_LIST_RANGE' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP16_LOGICAL_OR' => 147,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP23_LOGICAL_AND' => 150,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP06_REGEX_MATCH' => 159,
			'OP18_TERNARY' => 148
		}
	},
	{#State 121
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			"]" => -113,
			")" => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			"}" => -113,
			'OP13_BITWISE_AND' => -113,
			'OP15_LOGICAL_AND' => -113,
			".." => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP12_COMPARE_EQ_NEQ' => -113,
			'OP04_MATH_POW' => 146,
			'OP17_LIST_RANGE' => -113,
			'OP08_MATH_ADD_SUB' => 156,
			'OP23_LOGICAL_AND' => -113,
			";" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP06_REGEX_MATCH' => 159,
			'OP18_TERNARY' => -113,
			'OP21_LIST_COMMA' => -113
		}
	},
	{#State 122
		ACTIONS => {
			'VARIABLE_SYMBOL' => 195
		}
	},
	{#State 123
		DEFAULT => -223
	},
	{#State 124
		DEFAULT => -174
	},
	{#State 125
		DEFAULT => -172
	},
	{#State 126
		ACTIONS => {
			'WORD' => 123
		},
		GOTOS => {
			'Type' => 196
		}
	},
	{#State 127
		DEFAULT => -173
	},
	{#State 128
		DEFAULT => -161
	},
	{#State 129
		ACTIONS => {
			'VARIABLE_SYMBOL' => 197
		}
	},
	{#State 130
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			"{" => 67,
			'WORD_SCOPED' => 12,
			"[" => 46,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			'OP22_LOGICAL_NOT' => 81,
			'VARIABLE_SYMBOL' => 79,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			"undef" => 76,
			'OP03_MATH_INC_DEC' => 74,
			"\@{" => 55,
			"%{" => 54
		},
		GOTOS => {
			'Literal' => 62,
			'Expression' => 198,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77
		}
	},
	{#State 131
		ACTIONS => {
			'OP20_HASH_FATARROW' => 199
		}
	},
	{#State 132
		DEFAULT => -150
	},
	{#State 133
		DEFAULT => -214,
		GOTOS => {
			'STAR-63' => 200
		}
	},
	{#State 134
		DEFAULT => -209
	},
	{#State 135
		DEFAULT => -224
	},
	{#State 136
		ACTIONS => {
			";" => 201
		}
	},
	{#State 137
		DEFAULT => -13
	},
	{#State 138
		ACTIONS => {
			'VARIABLE_SYMBOL' => 202
		}
	},
	{#State 139
		DEFAULT => -103
	},
	{#State 140
		ACTIONS => {
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			";" => -133,
			'OP01_NAMED_QW' => 95,
			"[" => 46,
			"{" => 67,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			"my" => 97,
			'OP22_LOGICAL_NOT' => 81,
			'KEYS_OR_VALUES' => 96,
			'OP03_MATH_INC_DEC' => 74,
			"%{" => 54,
			"\@{" => 55,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59
		},
		GOTOS => {
			'ListElements' => 204,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'ListElement' => 99,
			'Operator' => 77,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'OPTIONAL-46' => 203,
			'Expression' => 100,
			'Literal' => 62,
			'TypeInner' => 98
		}
	},
	{#State 141
		DEFAULT => -130
	},
	{#State 142
		ACTIONS => {
			";" => 205
		}
	},
	{#State 143
		ACTIONS => {
			".." => -183,
			'OP13_BITWISE_AND' => -183,
			'OP15_LOGICAL_AND' => -183,
			"}" => -183,
			'OP24_LOGICAL_OR_XOR' => -183,
			'OP03_MATH_INC_DEC' => -183,
			'OP02_ARRAY_THINARROW' => 207,
			'OP19_VARIABLE_ASSIGN_BY' => -183,
			")" => -183,
			"]" => -183,
			'OP07_MATH_MULT_DIV_MOD' => -183,
			'OP11_COMPARE_LT_GT' => -183,
			'OP02_METHOD_THINARROW' => -183,
			'OP02_HASH_THINARROW' => 206,
			'OP19_VARIABLE_ASSIGN' => -183,
			'OP21_LIST_COMMA' => -183,
			'OP18_TERNARY' => -183,
			'OP06_REGEX_MATCH' => -183,
			'OP14_BITWISE_OR_XOR' => -183,
			'OP23_LOGICAL_AND' => -183,
			";" => -183,
			'OP08_MATH_ADD_SUB' => -183,
			'OP17_LIST_RANGE' => -183,
			'OP04_MATH_POW' => -183,
			'OP12_COMPARE_EQ_NEQ' => -183,
			'OP08_STRING_CAT' => -183,
			'OP09_BITWISE_SHIFT' => -183,
			'COLON' => -183,
			'OP16_LOGICAL_OR' => -183
		},
		GOTOS => {
			'VariableRetrieval' => 208
		}
	},
	{#State 144
		ACTIONS => {
			";" => -123,
			'OP23_LOGICAL_AND' => -123,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP06_REGEX_MATCH' => 159,
			'OP18_TERNARY' => 148,
			'OP21_LIST_COMMA' => -123,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP16_LOGICAL_OR' => 147,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152,
			".." => -123,
			'OP24_LOGICAL_OR_XOR' => -123,
			"}" => -123,
			"]" => -123,
			")" => -123,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151
		}
	},
	{#State 145
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'WORD_SCOPED' => 12,
			"[" => 46,
			"{" => 67,
			'OP01_NAMED_QW' => 95,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			")" => -101,
			'KEYS_OR_VALUES' => 96,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			"my" => 97,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74
		},
		GOTOS => {
			'Variable' => 91,
			'HashDereferenced' => 49,
			'TypeInner' => 98,
			'Literal' => 62,
			'Expression' => 100,
			'ListElement' => 99,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'ListElements' => 209,
			'Operator' => 77,
			'OPTIONAL-42' => 210,
			'HashReference' => 75,
			'ArrayReference' => 42
		}
	},
	{#State 146
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'VARIABLE_SYMBOL' => 79,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"[" => 46,
			"{" => 67,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'Literal' => 62,
			'Expression' => 211,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77
		}
	},
	{#State 147
		ACTIONS => {
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			"{" => 67,
			'WORD_SCOPED' => 12,
			"[" => 46,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'Operator' => 77,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 42,
			'HashReference' => 75,
			'HashDereferenced' => 49,
			'Variable' => 91,
			'Literal' => 62,
			'Expression' => 212
		}
	},
	{#State 148
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Variable' => 213
		}
	},
	{#State 149
		DEFAULT => -98
	},
	{#State 150
		ACTIONS => {
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'OP03_MATH_INC_DEC' => 74,
			"%{" => 54,
			"\@{" => 55,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			"{" => 67,
			'WORD_SCOPED' => 12,
			"[" => 46,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43
		},
		GOTOS => {
			'Variable' => 91,
			'HashDereferenced' => 49,
			'Expression' => 214,
			'Literal' => 62,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77,
			'HashReference' => 75,
			'ArrayReference' => 42
		}
	},
	{#State 151
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			'OP22_LOGICAL_NOT' => 81,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74
		},
		GOTOS => {
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'Literal' => 62,
			'Expression' => 215
		}
	},
	{#State 152
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 81,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			"[" => 46,
			"{" => 67,
			'WORD_SCOPED' => 12,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63
		},
		GOTOS => {
			'Literal' => 62,
			'Expression' => 216,
			'HashDereferenced' => 49,
			'Variable' => 91,
			'ArrayReference' => 42,
			'HashReference' => 75,
			'Operator' => 77,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80
		}
	},
	{#State 153
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'OP03_MATH_INC_DEC' => 74,
			"%{" => 54,
			"\@{" => 55,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81,
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48
		},
		GOTOS => {
			'Variable' => 91,
			'HashDereferenced' => 49,
			'Literal' => 62,
			'Expression' => 217,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'Operator' => 77,
			'HashReference' => 75,
			'ArrayReference' => 42
		}
	},
	{#State 154
		ACTIONS => {
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'WORD_SCOPED' => 12,
			"[" => 46,
			"{" => 67,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'ArrayReference' => 42,
			'HashReference' => 75,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'Literal' => 62,
			'Expression' => 218,
			'HashDereferenced' => 49,
			'Variable' => 91
		}
	},
	{#State 155
		ACTIONS => {
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81,
			'OP03_MATH_INC_DEC' => 74,
			"%{" => 54,
			"\@{" => 55,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD_SCOPED' => 12,
			"[" => 46,
			"{" => 67
		},
		GOTOS => {
			'HashReference' => 75,
			'ArrayReference' => 42,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'Operator' => 77,
			'Expression' => 219,
			'Literal' => 62,
			'Variable' => 91,
			'HashDereferenced' => 49
		}
	},
	{#State 156
		ACTIONS => {
			'WORD' => 11,
			'OP01_NAMED' => 82,
			'OP22_LOGICAL_NOT' => 81,
			'OP03_MATH_INC_DEC' => 74,
			"\@{" => 55,
			"%{" => 54,
			'VARIABLE_SYMBOL' => 79,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			"undef" => 76,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67
		},
		GOTOS => {
			'ArrayReference' => 42,
			'HashReference' => 75,
			'Operator' => 77,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Expression' => 220,
			'Literal' => 62,
			'HashDereferenced' => 49,
			'Variable' => 91
		}
	},
	{#State 157
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			"undef" => 76,
			'OP03_MATH_INC_DEC' => 74,
			"%{" => 54,
			"\@{" => 55,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			'OP22_LOGICAL_NOT' => 81,
			'WORD_SCOPED' => 12,
			"{" => 67,
			"[" => 46,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Variable' => 91,
			'Literal' => 62,
			'Expression' => 221,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'ArrayReference' => 42,
			'HashReference' => 75
		}
	},
	{#State 158
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 74,
			"\@{" => 55,
			"%{" => 54,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"{" => 67,
			"[" => 46,
			'WORD_SCOPED' => 12,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50
		},
		GOTOS => {
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'Operator' => 77,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'Literal' => 62,
			'Expression' => 222
		}
	},
	{#State 159
		ACTIONS => {
			"/" => 223
		}
	},
	{#State 160
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'WORD_SCOPED' => 12,
			"{" => 67,
			"[" => 46,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'OP03_MATH_INC_DEC' => 74,
			"\@{" => 55,
			"%{" => 54
		},
		GOTOS => {
			'Expression' => 224,
			'Literal' => 62,
			'HashDereferenced' => 49,
			'Variable' => 91,
			'ArrayReference' => 42,
			'HashReference' => 75,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44
		}
	},
	{#State 161
		ACTIONS => {
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			"[" => 46,
			"{" => 67,
			'WORD_SCOPED' => 12,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			'OP22_LOGICAL_NOT' => 81,
			'OP03_MATH_INC_DEC' => 74,
			"\@{" => 55,
			"%{" => 54,
			'VARIABLE_SYMBOL' => 79,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			"undef" => 76
		},
		GOTOS => {
			'Expression' => 225,
			'Literal' => 62,
			'HashDereferenced' => 49,
			'Variable' => 91,
			'ArrayReference' => 42,
			'HashReference' => 75,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44
		}
	},
	{#State 162
		ACTIONS => {
			'WORD_SCOPED' => 12,
			"[" => 46,
			"{" => 67,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'OP03_MATH_INC_DEC' => 74,
			"%{" => 54,
			"\@{" => 55,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81
		},
		GOTOS => {
			'Expression' => 226,
			'Literal' => 62,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'Operator' => 77
		}
	},
	{#State 163
		ACTIONS => {
			"my" => 97
		},
		GOTOS => {
			'TypeInner' => 227
		}
	},
	{#State 164
		ACTIONS => {
			'WORD' => 229,
			")" => 228
		}
	},
	{#State 165
		DEFAULT => -32
	},
	{#State 166
		ACTIONS => {
			"use" => 26
		},
		GOTOS => {
			'Include' => 230
		}
	},
	{#State 167
		DEFAULT => -22
	},
	{#State 168
		ACTIONS => {
			"our" => 71,
			"1;" => 231
		},
		GOTOS => {
			'Subroutine' => 232
		}
	},
	{#State 169
		DEFAULT => -25
	},
	{#State 170
		DEFAULT => -139
	},
	{#State 171
		ACTIONS => {
			")" => 233
		}
	},
	{#State 172
		DEFAULT => -203
	},
	{#State 173
		ACTIONS => {
			'WORD' => 235
		},
		GOTOS => {
			'PLUS-59' => 234
		}
	},
	{#State 174
		DEFAULT => -200
	},
	{#State 175
		ACTIONS => {
			"\$TYPED_" => 236
		}
	},
	{#State 176
		ACTIONS => {
			'OP23_LOGICAL_AND' => 150,
			";" => -199,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP06_REGEX_MATCH' => 159,
			'OP21_LIST_COMMA' => -199,
			'OP18_TERNARY' => 148,
			'OP16_LOGICAL_OR' => 147,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP17_LIST_RANGE' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			"]" => -199,
			")" => -199
		}
	},
	{#State 177
		ACTIONS => {
			";" => -196,
			'OP21_LIST_COMMA' => 237,
			"]" => -196,
			")" => -196
		},
		GOTOS => {
			'PAREN-57' => 238
		}
	},
	{#State 178
		DEFAULT => -107
	},
	{#State 179
		ACTIONS => {
			"(" => 239
		}
	},
	{#State 180
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP04_MATH_POW' => 146,
			'OP17_LIST_RANGE' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP16_LOGICAL_OR' => 147,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP23_LOGICAL_AND' => 150,
			";" => -155,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP06_REGEX_MATCH' => 159,
			'OP18_TERNARY' => 148,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			'OP24_LOGICAL_OR_XOR' => 162
		}
	},
	{#State 181
		DEFAULT => -156
	},
	{#State 182
		ACTIONS => {
			";" => 240
		}
	},
	{#State 183
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP16_LOGICAL_OR' => 147,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP04_MATH_POW' => 146,
			'OP18_TERNARY' => 148,
			'OP06_REGEX_MATCH' => 159,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP23_LOGICAL_AND' => 150,
			";" => 241
		}
	},
	{#State 184
		ACTIONS => {
			'VARIABLE_SYMBOL' => 242
		}
	},
	{#State 185
		ACTIONS => {
			"}" => 243
		}
	},
	{#State 186
		ACTIONS => {
			")" => 244
		}
	},
	{#State 187
		DEFAULT => -128
	},
	{#State 188
		ACTIONS => {
			";" => 245
		}
	},
	{#State 189
		DEFAULT => -217
	},
	{#State 190
		DEFAULT => -216
	},
	{#State 191
		DEFAULT => -204
	},
	{#State 192
		DEFAULT => -205
	},
	{#State 193
		ACTIONS => {
			"{" => 247
		},
		GOTOS => {
			'CodeBlock' => 246
		}
	},
	{#State 194
		DEFAULT => -154
	},
	{#State 195
		ACTIONS => {
			";" => 248,
			'OP19_VARIABLE_ASSIGN' => 249
		}
	},
	{#State 196
		ACTIONS => {
			'VARIABLE_SYMBOL' => 250
		}
	},
	{#State 197
		ACTIONS => {
			"(" => 251
		}
	},
	{#State 198
		ACTIONS => {
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP16_LOGICAL_OR' => 147,
			'OP06_REGEX_MATCH' => 159,
			'OP18_TERNARY' => 148,
			'OP23_LOGICAL_AND' => 150,
			'OP14_BITWISE_OR_XOR' => 160,
			")" => 252,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			'OP24_LOGICAL_OR_XOR' => 162
		}
	},
	{#State 199
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -207,
			'LITERAL_STRING' => -207,
			'OP05_MATH_NEG' => -207,
			"{" => -207,
			"[" => -207,
			'WORD_SCOPED' => -207,
			'OP10_NAMED_UNARY_STRINGIFY' => -207,
			'LITERAL_NUMBER' => -207,
			"my" => 97,
			'WORD' => -207,
			'OP01_NAMED' => -207,
			'OP22_LOGICAL_NOT' => -207,
			'VARIABLE_SYMBOL' => -207,
			"(" => -207,
			'OP10_NAMED_UNARY' => -207,
			"undef" => -207,
			'OP03_MATH_INC_DEC' => -207,
			"%{" => -207,
			"\@{" => -207
		},
		GOTOS => {
			'TypeInner' => 254,
			'OPTIONAL-61' => 253
		}
	},
	{#State 200
		ACTIONS => {
			"}" => 257,
			'OP21_LIST_COMMA' => 256
		},
		GOTOS => {
			'PAREN-62' => 255
		}
	},
	{#State 201
		DEFAULT => -138
	},
	{#State 202
		ACTIONS => {
			"= sub {" => 258
		}
	},
	{#State 203
		ACTIONS => {
			";" => 259
		}
	},
	{#State 204
		DEFAULT => -132
	},
	{#State 205
		DEFAULT => -136
	},
	{#State 206
		ACTIONS => {
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'OP03_MATH_INC_DEC' => 74,
			"%{" => 54,
			"\@{" => 55,
			'OP01_NAMED' => 82,
			'WORD' => 261,
			'OP22_LOGICAL_NOT' => 81
		},
		GOTOS => {
			'Expression' => 260,
			'Literal' => 62,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'Operator' => 77
		}
	},
	{#State 207
		ACTIONS => {
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			'OP22_LOGICAL_NOT' => 81,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'HashReference' => 75,
			'ArrayReference' => 42,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77,
			'Expression' => 262,
			'Literal' => 62,
			'Variable' => 91,
			'HashDereferenced' => 49
		}
	},
	{#State 208
		DEFAULT => -181
	},
	{#State 209
		DEFAULT => -100
	},
	{#State 210
		ACTIONS => {
			")" => 263
		}
	},
	{#State 211
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			")" => -105,
			"]" => -105,
			"}" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			".." => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP08_STRING_CAT' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP18_TERNARY' => -105,
			'OP06_REGEX_MATCH' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			";" => -105,
			'OP23_LOGICAL_AND' => -105
		}
	},
	{#State 212
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => -120,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP16_LOGICAL_OR' => -120,
			'OP21_LIST_COMMA' => -120,
			'OP18_TERNARY' => -120,
			'OP06_REGEX_MATCH' => 159,
			'OP14_BITWISE_OR_XOR' => 160,
			";" => -120,
			'OP23_LOGICAL_AND' => -120,
			")" => -120,
			"]" => -120,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			".." => -120,
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			"}" => -120,
			'OP24_LOGICAL_OR_XOR' => -120
		}
	},
	{#State 213
		ACTIONS => {
			'COLON' => 264
		}
	},
	{#State 214
		ACTIONS => {
			".." => -124,
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			'OP24_LOGICAL_OR_XOR' => -124,
			"}" => -124,
			")" => -124,
			"]" => -124,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			'OP06_REGEX_MATCH' => 159,
			'OP21_LIST_COMMA' => -124,
			'OP18_TERNARY' => 148,
			'OP23_LOGICAL_AND' => -124,
			";" => -124,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP04_MATH_POW' => 146,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP16_LOGICAL_OR' => 147
		}
	},
	{#State 215
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -109,
			";" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP18_TERNARY' => -109,
			'OP06_REGEX_MATCH' => 159,
			'OP08_MATH_ADD_SUB' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP08_STRING_CAT' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP13_BITWISE_AND' => -109,
			".." => -109,
			"}" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			"]" => -109,
			")" => -109,
			'OP11_COMPARE_LT_GT' => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109
		}
	},
	{#State 216
		ACTIONS => {
			"}" => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP13_BITWISE_AND' => -117,
			".." => -117,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			"]" => -117,
			")" => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			";" => -117,
			'OP23_LOGICAL_AND' => -117,
			'OP21_LIST_COMMA' => -117,
			'OP18_TERNARY' => -117,
			'OP06_REGEX_MATCH' => 159,
			'OP16_LOGICAL_OR' => -117,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => -117,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP04_MATH_POW' => 146
		}
	},
	{#State 217
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 160,
			";" => -119,
			'OP23_LOGICAL_AND' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP18_TERNARY' => -119,
			'OP06_REGEX_MATCH' => 159,
			'OP16_LOGICAL_OR' => -119,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => -119,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP04_MATH_POW' => 146,
			"}" => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP13_BITWISE_AND' => 152,
			".." => -119,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			"]" => -119,
			")" => -119
		}
	},
	{#State 218
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -116,
			"}" => -116,
			".." => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP13_BITWISE_AND' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			")" => -116,
			"]" => -116,
			'OP06_REGEX_MATCH' => 159,
			'OP18_TERNARY' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP23_LOGICAL_AND' => -116,
			";" => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP16_LOGICAL_OR' => -116,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP04_MATH_POW' => 146,
			'OP17_LIST_RANGE' => -116,
			'OP08_MATH_ADD_SUB' => 156
		}
	},
	{#State 219
		ACTIONS => {
			"}" => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152,
			".." => -121,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			"]" => -121,
			")" => -121,
			'OP14_BITWISE_OR_XOR' => 160,
			";" => -121,
			'OP23_LOGICAL_AND' => -121,
			'OP21_LIST_COMMA' => -121,
			'OP18_TERNARY' => -121,
			'OP06_REGEX_MATCH' => 159,
			'OP16_LOGICAL_OR' => 147,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP04_MATH_POW' => 146
		}
	},
	{#State 220
		ACTIONS => {
			'OP15_LOGICAL_AND' => -110,
			'OP13_BITWISE_AND' => -110,
			".." => -110,
			"}" => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			"]" => -110,
			")" => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP23_LOGICAL_AND' => -110,
			";" => -110,
			'OP18_TERNARY' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP06_REGEX_MATCH' => 159,
			'OP08_MATH_ADD_SUB' => -110,
			'OP17_LIST_RANGE' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP04_MATH_POW' => 146,
			'OP16_LOGICAL_OR' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP08_STRING_CAT' => -110
		}
	},
	{#State 221
		ACTIONS => {
			'OP16_LOGICAL_OR' => -111,
			'OP08_STRING_CAT' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP04_MATH_POW' => 146,
			'OP17_LIST_RANGE' => -111,
			'OP08_MATH_ADD_SUB' => 156,
			'OP23_LOGICAL_AND' => -111,
			";" => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP06_REGEX_MATCH' => 159,
			'OP18_TERNARY' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			"]" => -111,
			")" => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			"}" => -111,
			'OP13_BITWISE_AND' => -111,
			'OP15_LOGICAL_AND' => -111,
			".." => -111
		}
	},
	{#State 222
		ACTIONS => {
			'OP13_BITWISE_AND' => -112,
			'OP15_LOGICAL_AND' => -112,
			".." => -112,
			"}" => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			"]" => -112,
			")" => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => -112,
			";" => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP18_TERNARY' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP06_REGEX_MATCH' => 159,
			'OP17_LIST_RANGE' => -112,
			'OP08_MATH_ADD_SUB' => 156,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP08_STRING_CAT' => 157
		}
	},
	{#State 223
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 265
		}
	},
	{#State 224
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			"]" => -118,
			")" => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			"}" => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP13_BITWISE_AND' => 152,
			".." => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP17_LIST_RANGE' => -118,
			'OP08_MATH_ADD_SUB' => 156,
			";" => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP06_REGEX_MATCH' => 159,
			'OP21_LIST_COMMA' => -118,
			'OP18_TERNARY' => -118
		}
	},
	{#State 225
		ACTIONS => {
			"}" => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			".." => -115,
			'OP13_BITWISE_AND' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => undef,
			")" => -115,
			"]" => -115,
			'OP18_TERNARY' => -115,
			'OP21_LIST_COMMA' => -115,
			'OP06_REGEX_MATCH' => 159,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP23_LOGICAL_AND' => -115,
			";" => -115,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP16_LOGICAL_OR' => -115,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => -115,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => -115
		}
	},
	{#State 226
		ACTIONS => {
			";" => -125,
			'OP23_LOGICAL_AND' => 150,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP06_REGEX_MATCH' => 159,
			'OP21_LIST_COMMA' => -125,
			'OP18_TERNARY' => 148,
			'OP16_LOGICAL_OR' => 147,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP24_LOGICAL_OR_XOR' => -125,
			"}" => -125,
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			".." => -125,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			"]" => -125,
			")" => -125
		}
	},
	{#State 227
		ACTIONS => {
			'LITERAL_NUMBER' => 63,
			'LITERAL_STRING' => 70,
			"[" => 268,
			"{" => 266
		},
		GOTOS => {
			'Literal' => 269,
			'ConstantValue' => 267
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
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 271
		}
	},
	{#State 231
		ACTIONS => {
			"1;" => 272
		}
	},
	{#State 232
		DEFAULT => -24
	},
	{#State 233
		DEFAULT => -152
	},
	{#State 234
		ACTIONS => {
			'WORD' => 273,
			")" => 274
		}
	},
	{#State 235
		DEFAULT => -195
	},
	{#State 236
		ACTIONS => {
			'WORD' => 275
		}
	},
	{#State 237
		ACTIONS => {
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			'KEYS_OR_VALUES' => 96,
			'OP22_LOGICAL_NOT' => 81,
			'WORD' => 11,
			"my" => 97,
			'OP01_NAMED' => 82,
			"{" => 67,
			'WORD_SCOPED' => 12,
			"[" => 46,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'TypeInner' => 98,
			'Literal' => 62,
			'Expression' => 100,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'ListElement' => 276,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77
		}
	},
	{#State 238
		DEFAULT => -192
	},
	{#State 239
		ACTIONS => {
			")" => -142,
			'KEYS_OR_VALUES' => 96,
			'OP22_LOGICAL_NOT' => 81,
			"my" => 97,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74,
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			"{" => 67,
			"[" => 46,
			'WORD_SCOPED' => 12,
			'OP01_NAMED_QW' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63
		},
		GOTOS => {
			'ArrayDereferenced' => 80,
			'ListElements' => 277,
			'ListElement' => 99,
			'WordScoped' => 44,
			'Operator' => 77,
			'HashReference' => 75,
			'OPTIONAL-48' => 278,
			'ArrayReference' => 42,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'Literal' => 62,
			'Expression' => 100,
			'TypeInner' => 98
		}
	},
	{#State 240
		DEFAULT => -189
	},
	{#State 241
		DEFAULT => -190
	},
	{#State 242
		DEFAULT => -221
	},
	{#State 243
		DEFAULT => -220
	},
	{#State 244
		ACTIONS => {
			";" => 279
		}
	},
	{#State 245
		DEFAULT => -134
	},
	{#State 246
		DEFAULT => -167,
		GOTOS => {
			'STAR-52' => 280
		}
	},
	{#State 247
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 74,
			'OP01_NAMED_VOID_PAREN' => 53,
			"foreach my" => -159,
			"%{" => 54,
			"\@{" => 55,
			'OP01_NAMED_VOID' => 78,
			'VARIABLE_SYMBOL' => 79,
			"if (" => 57,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'OP01_NAMED' => 82,
			"my" => 61,
			'WORD' => 84,
			'OP22_LOGICAL_NOT' => 81,
			"for my integer" => -159,
			"while (" => -159,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP19_LOOP_CONTROL' => 68,
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50
		},
		GOTOS => {
			'ArrayReference' => 42,
			'OPTIONAL-50' => 65,
			'Operation' => 281,
			'VariableDeclaration' => 45,
			'LoopLabel' => 47,
			'WordScoped' => 44,
			'HashDereferenced' => 49,
			'PAREN-49' => 73,
			'OperatorVoid' => 52,
			'VariableModification' => 72,
			'Variable' => 51,
			'Statement' => 56,
			'HashReference' => 75,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'PLUS-55' => 282,
			'Literal' => 62,
			'Conditional' => 60,
			'Expression' => 83
		}
	},
	{#State 248
		DEFAULT => -187
	},
	{#State 249
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'WORD_SCOPED' => 12,
			"[" => 46,
			"{" => 67,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			"<STDIN>" => 181,
			'OP22_LOGICAL_NOT' => 81,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'OP03_MATH_INC_DEC' => 74,
			"%{" => 54,
			"\@{" => 55
		},
		GOTOS => {
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'ExpressionOrStdin' => 283,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'Literal' => 62,
			'Expression' => 180
		}
	},
	{#State 250
		ACTIONS => {
			"(" => 284
		}
	},
	{#State 251
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 81,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			"\@{" => 55,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 74,
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			"{" => 67,
			'WORD_SCOPED' => 12,
			"[" => 46,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Variable' => 91,
			'Expression' => 285,
			'Literal' => 62,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'ArrayReference' => 42,
			'HashReference' => 75
		}
	},
	{#State 252
		ACTIONS => {
			"{" => 247
		},
		GOTOS => {
			'CodeBlock' => 286
		}
	},
	{#State 253
		ACTIONS => {
			"{" => 67,
			'WORD_SCOPED' => 12,
			"[" => 46,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'OP03_MATH_INC_DEC' => 74,
			"\@{" => 55,
			"%{" => 54,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81
		},
		GOTOS => {
			'Expression' => 287,
			'Literal' => 62,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77
		}
	},
	{#State 254
		DEFAULT => -206
	},
	{#State 255
		DEFAULT => -213
	},
	{#State 256
		ACTIONS => {
			'WORD' => 131,
			"%{" => 54
		},
		GOTOS => {
			'HashDereferenced' => 134,
			'HashEntry' => 288
		}
	},
	{#State 257
		DEFAULT => -215
	},
	{#State 258
		ACTIONS => {
			'LITERAL_NUMBER' => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			"[" => -54,
			'OP19_LOOP_CONTROL' => -54,
			"{" => -54,
			'WORD_SCOPED' => -54,
			'OP05_MATH_NEG' => -54,
			"( my" => 289,
			'LITERAL_STRING' => -54,
			'OP05_LOGICAL_NEG' => -54,
			'OP01_NAMED_VOID_PAREN' => -54,
			"foreach my" => -54,
			"%{" => -54,
			"\@{" => -54,
			'OP03_MATH_INC_DEC' => -54,
			"undef" => -54,
			"if (" => -54,
			'OP10_NAMED_UNARY' => -54,
			"(" => -54,
			'OP01_NAMED_VOID' => -54,
			'VARIABLE_SYMBOL' => -54,
			"for my integer" => -54,
			'OP22_LOGICAL_NOT' => -54,
			'OP01_NAMED' => -54,
			'WORD' => -54,
			"my" => -54,
			"while (" => -54
		},
		GOTOS => {
			'OPTIONAL-21' => 291,
			'SubroutineArguments' => 290
		}
	},
	{#State 259
		DEFAULT => -137
	},
	{#State 260
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 162,
			"}" => 292,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP23_LOGICAL_AND' => 150,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP06_REGEX_MATCH' => 159,
			'OP18_TERNARY' => 148,
			'OP16_LOGICAL_OR' => 147,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155
		}
	},
	{#State 261
		ACTIONS => {
			"}" => 293,
			"(" => -218
		}
	},
	{#State 262
		ACTIONS => {
			"]" => 294,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP04_MATH_POW' => 146,
			'OP17_LIST_RANGE' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP16_LOGICAL_OR' => 147,
			'OP06_REGEX_MATCH' => 159,
			'OP18_TERNARY' => 148,
			'OP23_LOGICAL_AND' => 150,
			'OP14_BITWISE_OR_XOR' => 160
		}
	},
	{#State 263
		DEFAULT => -102
	},
	{#State 264
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Variable' => 295
		}
	},
	{#State 265
		ACTIONS => {
			"/" => 296
		}
	},
	{#State 266
		ACTIONS => {
			'WORD' => 297
		}
	},
	{#State 267
		ACTIONS => {
			";" => 298
		}
	},
	{#State 268
		ACTIONS => {
			'LITERAL_NUMBER' => -37,
			"my" => 97,
			'LITERAL_STRING' => -37
		},
		GOTOS => {
			'OPTIONAL-13' => 300,
			'TypeInner' => 299
		}
	},
	{#State 269
		DEFAULT => -50
	},
	{#State 270
		DEFAULT => -34
	},
	{#State 271
		ACTIONS => {
			"## no critic qw(" => 22,
			"our %properties = (" => -71,
			"use" => -71,
			"use constant" => -71
		},
		GOTOS => {
			'STAR-29' => 301,
			'Critic' => 302
		}
	},
	{#State 272
		DEFAULT => -26
	},
	{#State 273
		DEFAULT => -194
	},
	{#State 274
		DEFAULT => -197
	},
	{#State 275
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 303
		}
	},
	{#State 276
		DEFAULT => -191
	},
	{#State 277
		DEFAULT => -141
	},
	{#State 278
		ACTIONS => {
			")" => 304
		}
	},
	{#State 279
		DEFAULT => -135
	},
	{#State 280
		ACTIONS => {
			"}" => -170,
			'OP03_MATH_INC_DEC' => -170,
			'OP01_NAMED_VOID_PAREN' => -170,
			"foreach my" => -170,
			"%{" => -170,
			"\@{" => -170,
			'OP01_NAMED_VOID' => -170,
			'VARIABLE_SYMBOL' => -170,
			"undef" => -170,
			"if (" => -170,
			"(" => -170,
			'OP10_NAMED_UNARY' => -170,
			'OP01_NAMED' => -170,
			'WORD' => -170,
			"my" => -170,
			'OP22_LOGICAL_NOT' => -170,
			"for my integer" => -170,
			"while (" => -170,
			'LITERAL_NUMBER' => -170,
			'OP10_NAMED_UNARY_STRINGIFY' => -170,
			"else" => 307,
			"{" => -170,
			"[" => -170,
			'OP19_LOOP_CONTROL' => -170,
			'WORD_SCOPED' => -170,
			'LITERAL_STRING' => -170,
			'' => -170,
			'OP05_MATH_NEG' => -170,
			"elsif (" => 306,
			'OP05_LOGICAL_NEG' => -170
		},
		GOTOS => {
			'PAREN-51' => 308,
			'OPTIONAL-54' => 305,
			'PAREN-53' => 309
		}
	},
	{#State 281
		DEFAULT => -179
	},
	{#State 282
		ACTIONS => {
			"%{" => 54,
			"\@{" => 55,
			"foreach my" => -159,
			'OP01_NAMED_VOID_PAREN' => 53,
			'OP03_MATH_INC_DEC' => 74,
			"}" => 311,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			"if (" => 57,
			"undef" => 76,
			'VARIABLE_SYMBOL' => 79,
			'OP01_NAMED_VOID' => 78,
			"for my integer" => -159,
			'OP22_LOGICAL_NOT' => 81,
			"my" => 61,
			'WORD' => 84,
			'OP01_NAMED' => 82,
			"while (" => -159,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			"[" => 46,
			'OP19_LOOP_CONTROL' => 68,
			"{" => 67,
			'WORD_SCOPED' => 12,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50
		},
		GOTOS => {
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'Statement' => 56,
			'HashReference' => 75,
			'Conditional' => 60,
			'Literal' => 62,
			'Expression' => 83,
			'WordScoped' => 44,
			'VariableDeclaration' => 45,
			'LoopLabel' => 47,
			'ArrayReference' => 42,
			'Operation' => 310,
			'OPTIONAL-50' => 65,
			'HashDereferenced' => 49,
			'VariableModification' => 72,
			'Variable' => 51,
			'OperatorVoid' => 52,
			'PAREN-49' => 73
		}
	},
	{#State 283
		ACTIONS => {
			";" => 312
		}
	},
	{#State 284
		ACTIONS => {
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50,
			'OP01_NAMED_QW' => 95,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD_SCOPED' => 12,
			"[" => 46,
			"{" => 67,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			"my" => 97,
			'KEYS_OR_VALUES' => 96,
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Variable' => 91,
			'TypeInner' => 98,
			'Expression' => 100,
			'Literal' => 62,
			'Operator' => 77,
			'ListElement' => 99,
			'WordScoped' => 44,
			'ListElements' => 313,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 42,
			'HashReference' => 75
		}
	},
	{#State 285
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152,
			".." => 314,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP16_LOGICAL_OR' => 147,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP23_LOGICAL_AND' => 150,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP06_REGEX_MATCH' => 159,
			'OP18_TERNARY' => 148
		}
	},
	{#State 286
		DEFAULT => -177
	},
	{#State 287
		ACTIONS => {
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			"}" => -208,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP23_LOGICAL_AND' => 150,
			'OP21_LIST_COMMA' => -208,
			'OP18_TERNARY' => 148,
			'OP06_REGEX_MATCH' => 159,
			'OP17_LIST_RANGE' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP16_LOGICAL_OR' => 147,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157
		}
	},
	{#State 288
		DEFAULT => -212
	},
	{#State 289
		ACTIONS => {
			'WORD' => 123
		},
		GOTOS => {
			'Type' => 315
		}
	},
	{#State 290
		DEFAULT => -53
	},
	{#State 291
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP19_LOOP_CONTROL' => 68,
			"[" => 46,
			"{" => 67,
			'WORD_SCOPED' => 12,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"while (" => -159,
			'OP01_NAMED' => 82,
			"my" => 61,
			'WORD' => 84,
			'OP22_LOGICAL_NOT' => 81,
			"for my integer" => -159,
			'OP01_NAMED_VOID' => 78,
			'VARIABLE_SYMBOL' => 79,
			"if (" => 57,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'OP03_MATH_INC_DEC' => 74,
			"foreach my" => -159,
			'OP01_NAMED_VOID_PAREN' => 53,
			"%{" => 54,
			"\@{" => 55
		},
		GOTOS => {
			'Literal' => 62,
			'Expression' => 83,
			'Conditional' => 60,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'HashReference' => 75,
			'Statement' => 56,
			'HashDereferenced' => 49,
			'OperatorVoid' => 52,
			'PAREN-49' => 73,
			'VariableModification' => 72,
			'Variable' => 51,
			'VariableDeclaration' => 45,
			'LoopLabel' => 47,
			'WordScoped' => 44,
			'PLUS-22' => 317,
			'ArrayReference' => 42,
			'OPTIONAL-50' => 65,
			'Operation' => 316
		}
	},
	{#State 292
		DEFAULT => -185
	},
	{#State 293
		DEFAULT => -186
	},
	{#State 294
		DEFAULT => -184
	},
	{#State 295
		DEFAULT => -122
	},
	{#State 296
		DEFAULT => -108
	},
	{#State 297
		ACTIONS => {
			'OP20_HASH_FATARROW' => 318
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
			'LITERAL_NUMBER' => 63,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'Literal' => 319
		}
	},
	{#State 301
		ACTIONS => {
			"use" => 26,
			"our %properties = (" => -73,
			"use constant" => -73
		},
		GOTOS => {
			'Include' => 321,
			'STAR-30' => 320
		}
	},
	{#State 302
		DEFAULT => -68
	},
	{#State 303
		DEFAULT => -222
	},
	{#State 304
		DEFAULT => -153
	},
	{#State 305
		DEFAULT => -171
	},
	{#State 306
		ACTIONS => {
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			'WORD_SCOPED' => 12,
			"{" => 67,
			"[" => 46,
			'WORD' => 11,
			'OP01_NAMED' => 82,
			'OP22_LOGICAL_NOT' => 81,
			'OP03_MATH_INC_DEC' => 74,
			"\@{" => 55,
			"%{" => 54,
			'VARIABLE_SYMBOL' => 79,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			"undef" => 76
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Variable' => 91,
			'Expression' => 322,
			'Literal' => 62,
			'Operator' => 77,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 42,
			'HashReference' => 75
		}
	},
	{#State 307
		ACTIONS => {
			"{" => 247
		},
		GOTOS => {
			'CodeBlock' => 323
		}
	},
	{#State 308
		DEFAULT => -166
	},
	{#State 309
		DEFAULT => -169
	},
	{#State 310
		DEFAULT => -178
	},
	{#State 311
		DEFAULT => -180
	},
	{#State 312
		DEFAULT => -188
	},
	{#State 313
		ACTIONS => {
			")" => 324
		}
	},
	{#State 314
		ACTIONS => {
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"{" => 67,
			"[" => 46,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81,
			'OP03_MATH_INC_DEC' => 74,
			"\@{" => 55,
			"%{" => 54,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58
		},
		GOTOS => {
			'Variable' => 91,
			'HashDereferenced' => 49,
			'Expression' => 325,
			'Literal' => 62,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77,
			'HashReference' => 75,
			'ArrayReference' => 42
		}
	},
	{#State 315
		ACTIONS => {
			'VARIABLE_SYMBOL' => 326
		}
	},
	{#State 316
		DEFAULT => -56
	},
	{#State 317
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 74,
			"}" => 328,
			"\@{" => 55,
			"%{" => 54,
			"foreach my" => -159,
			'OP01_NAMED_VOID_PAREN' => 53,
			'VARIABLE_SYMBOL' => 79,
			'OP01_NAMED_VOID' => 78,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			"if (" => 57,
			"undef" => 76,
			"my" => 61,
			'WORD' => 84,
			'OP01_NAMED' => 82,
			'OP22_LOGICAL_NOT' => 81,
			"for my integer" => -159,
			"while (" => -159,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'LITERAL_NUMBER' => 63,
			'OP19_LOOP_CONTROL' => 68,
			"{" => 67,
			'WORD_SCOPED' => 12,
			"[" => 46,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50
		},
		GOTOS => {
			'Expression' => 83,
			'Conditional' => 60,
			'Literal' => 62,
			'HashReference' => 75,
			'Statement' => 56,
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'HashDereferenced' => 49,
			'OperatorVoid' => 52,
			'PAREN-49' => 73,
			'VariableModification' => 72,
			'Variable' => 51,
			'ArrayReference' => 42,
			'OPTIONAL-50' => 65,
			'Operation' => 327,
			'VariableDeclaration' => 45,
			'LoopLabel' => 47,
			'WordScoped' => 44
		}
	},
	{#State 318
		ACTIONS => {
			'LITERAL_STRING' => -44,
			"my" => 97,
			'LITERAL_NUMBER' => -44
		},
		GOTOS => {
			'TypeInner' => 329,
			'OPTIONAL-17' => 330
		}
	},
	{#State 319
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 331
		}
	},
	{#State 320
		ACTIONS => {
			"our %properties = (" => 334,
			"use constant" => 34
		},
		GOTOS => {
			'Constant' => 333,
			'Properties' => 332
		}
	},
	{#State 321
		DEFAULT => -70
	},
	{#State 322
		ACTIONS => {
			")" => 335,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP16_LOGICAL_OR' => 147,
			'OP18_TERNARY' => 148,
			'OP06_REGEX_MATCH' => 159,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP23_LOGICAL_AND' => 150
		}
	},
	{#State 323
		DEFAULT => -168
	},
	{#State 324
		ACTIONS => {
			"{" => 247
		},
		GOTOS => {
			'CodeBlock' => 336
		}
	},
	{#State 325
		ACTIONS => {
			'OP18_TERNARY' => 148,
			'OP06_REGEX_MATCH' => 159,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP23_LOGICAL_AND' => 150,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP16_LOGICAL_OR' => 147,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 161,
			")" => 337
		}
	},
	{#State 326
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 338
		}
	},
	{#State 327
		DEFAULT => -55
	},
	{#State 328
		ACTIONS => {
			";" => 339
		}
	},
	{#State 329
		DEFAULT => -43
	},
	{#State 330
		ACTIONS => {
			'LITERAL_NUMBER' => 63,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'Literal' => 340
		}
	},
	{#State 331
		ACTIONS => {
			"]" => 343,
			'OP21_LIST_COMMA' => 342
		},
		GOTOS => {
			'PAREN-15' => 341
		}
	},
	{#State 332
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 344
		}
	},
	{#State 333
		DEFAULT => -72
	},
	{#State 334
		ACTIONS => {
			")" => 345,
			"%{" => 54,
			'WORD' => 347
		},
		GOTOS => {
			'HashDereferenced' => 348,
			'HashEntryTyped' => 346
		}
	},
	{#State 335
		ACTIONS => {
			"{" => 247
		},
		GOTOS => {
			'CodeBlock' => 349
		}
	},
	{#State 336
		DEFAULT => -176
	},
	{#State 337
		ACTIONS => {
			"{" => 247
		},
		GOTOS => {
			'CodeBlock' => 350
		}
	},
	{#State 338
		ACTIONS => {
			'OP21_LIST_COMMA' => 351,
			")" => 353
		},
		GOTOS => {
			'PAREN-23' => 352
		}
	},
	{#State 339
		DEFAULT => -57
	},
	{#State 340
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 354
		}
	},
	{#State 341
		DEFAULT => -41
	},
	{#State 342
		ACTIONS => {
			'LITERAL_STRING' => -39,
			"my" => 97,
			'LITERAL_NUMBER' => -39
		},
		GOTOS => {
			'OPTIONAL-14' => 356,
			'TypeInner' => 355
		}
	},
	{#State 343
		DEFAULT => -51
	},
	{#State 344
		ACTIONS => {
			"1;" => 359,
			"our" => 358
		},
		GOTOS => {
			'Method' => 357
		}
	},
	{#State 345
		ACTIONS => {
			";" => 360
		}
	},
	{#State 346
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 361
		}
	},
	{#State 347
		ACTIONS => {
			'OP20_HASH_FATARROW' => 362
		}
	},
	{#State 348
		DEFAULT => -211
	},
	{#State 349
		DEFAULT => -165
	},
	{#State 350
		DEFAULT => -175
	},
	{#State 351
		ACTIONS => {
			"my" => 363
		}
	},
	{#State 352
		DEFAULT => -59
	},
	{#State 353
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 364
		}
	},
	{#State 354
		ACTIONS => {
			'OP21_LIST_COMMA' => 365,
			"}" => 366
		},
		GOTOS => {
			'PAREN-19' => 367
		}
	},
	{#State 355
		DEFAULT => -38
	},
	{#State 356
		ACTIONS => {
			'LITERAL_NUMBER' => 63,
			'LITERAL_STRING' => 70
		},
		GOTOS => {
			'Literal' => 368
		}
	},
	{#State 357
		DEFAULT => -74
	},
	{#State 358
		ACTIONS => {
			'WORD' => 123
		},
		GOTOS => {
			'Type' => 369
		}
	},
	{#State 359
		ACTIONS => {
			"1;" => 370
		}
	},
	{#State 360
		DEFAULT => -86
	},
	{#State 361
		ACTIONS => {
			'OP21_LIST_COMMA' => 371,
			")" => 372
		},
		GOTOS => {
			'PAREN-35' => 373
		}
	},
	{#State 362
		ACTIONS => {
			"my" => 97
		},
		GOTOS => {
			'TypeInner' => 374
		}
	},
	{#State 363
		ACTIONS => {
			'WORD' => 123
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
			'WORD' => 377
		}
	},
	{#State 366
		DEFAULT => -52
	},
	{#State 367
		DEFAULT => -48
	},
	{#State 368
		DEFAULT => -40
	},
	{#State 369
		ACTIONS => {
			'VARIABLE_SYMBOL' => 378
		}
	},
	{#State 370
		ACTIONS => {
			"package" => -80,
			"our" => 71,
			'' => -80
		},
		GOTOS => {
			'OPTIONAL-34' => 380,
			'PLUS-32' => 382,
			'PAREN-33' => 379,
			'Subroutine' => 381
		}
	},
	{#State 371
		ACTIONS => {
			"%{" => 54,
			'WORD' => 347
		},
		GOTOS => {
			'HashEntryTyped' => 383,
			'HashDereferenced' => 348
		}
	},
	{#State 372
		ACTIONS => {
			";" => 384
		}
	},
	{#State 373
		DEFAULT => -83
	},
	{#State 374
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			"[" => 46,
			"{" => 67,
			'WORD_SCOPED' => 12,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'VARIABLE_SYMBOL' => 79,
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74
		},
		GOTOS => {
			'Operator' => 77,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'ArrayReference' => 42,
			'HashReference' => 75,
			'HashDereferenced' => 49,
			'Variable' => 91,
			'Expression' => 385,
			'Literal' => 62
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
			'OP20_HASH_FATARROW' => 388
		}
	},
	{#State 378
		ACTIONS => {
			"= sub {" => 389
		}
	},
	{#State 379
		DEFAULT => -79
	},
	{#State 380
		DEFAULT => -81
	},
	{#State 381
		DEFAULT => -77
	},
	{#State 382
		ACTIONS => {
			"our" => 71,
			"1;" => 391
		},
		GOTOS => {
			'Subroutine' => 390
		}
	},
	{#State 383
		DEFAULT => -82
	},
	{#State 384
		DEFAULT => -85
	},
	{#State 385
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP13_BITWISE_AND' => 152,
			'OP15_LOGICAL_AND' => 153,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => -210,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP23_LOGICAL_AND' => 150,
			'OP18_TERNARY' => 148,
			'OP21_LIST_COMMA' => -210,
			'OP06_REGEX_MATCH' => 159,
			'OP16_LOGICAL_OR' => 147,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_STRING_CAT' => 157,
			'OP17_LIST_RANGE' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP04_MATH_POW' => 146
		}
	},
	{#State 386
		DEFAULT => -58
	},
	{#State 387
		ACTIONS => {
			'OP22_LOGICAL_NOT' => -63,
			"for my integer" => -63,
			"my" => -63,
			'WORD' => -63,
			'OP01_NAMED' => -63,
			"while (" => -63,
			"%{" => -63,
			"\@{" => -63,
			"foreach my" => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			'OP03_MATH_INC_DEC' => -63,
			'OP10_NAMED_UNARY' => -63,
			"(" => -63,
			"if (" => -63,
			"undef" => -63,
			'OP01_NAMED_VOID' => -63,
			'VARIABLE_SYMBOL' => -63,
			'OP05_MATH_NEG' => -63,
			'LITERAL_STRING' => -63,
			'OP05_LOGICAL_NEG' => -63,
			'CHECK_OR_CHECKTRACE' => 393,
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			'LITERAL_NUMBER' => -63,
			"[" => -63,
			'OP19_LOOP_CONTROL' => -63,
			'WORD_SCOPED' => -63,
			"{" => -63
		},
		GOTOS => {
			'ArgumentCheck' => 392
		}
	},
	{#State 388
		ACTIONS => {
			'LITERAL_NUMBER' => -46,
			"my" => 97,
			'LITERAL_STRING' => -46
		},
		GOTOS => {
			'OPTIONAL-18' => 394,
			'TypeInner' => 395
		}
	},
	{#State 389
		ACTIONS => {
			'WORD' => -88,
			"my" => -88,
			'OP01_NAMED' => -88,
			'OP22_LOGICAL_NOT' => -88,
			"for my integer" => -88,
			"while (" => -88,
			'OP03_MATH_INC_DEC' => -88,
			"%{" => -88,
			"\@{" => -88,
			'OP01_NAMED_VOID_PAREN' => -88,
			"foreach my" => -88,
			'OP01_NAMED_VOID' => -88,
			'VARIABLE_SYMBOL' => -88,
			"(" => -88,
			'OP10_NAMED_UNARY' => -88,
			"undef" => -88,
			"if (" => -88,
			'LITERAL_STRING' => -88,
			"( my" => 397,
			'OP05_MATH_NEG' => -88,
			'OP05_LOGICAL_NEG' => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			'LITERAL_NUMBER' => -88,
			'WORD_SCOPED' => -88,
			"[" => -88,
			'OP19_LOOP_CONTROL' => -88,
			"{" => -88
		},
		GOTOS => {
			'MethodArguments' => 398,
			'OPTIONAL-37' => 396
		}
	},
	{#State 390
		DEFAULT => -76
	},
	{#State 391
		ACTIONS => {
			"1;" => 399
		}
	},
	{#State 392
		DEFAULT => -61
	},
	{#State 393
		ACTIONS => {
			"(" => 400
		}
	},
	{#State 394
		ACTIONS => {
			'LITERAL_STRING' => 70,
			'LITERAL_NUMBER' => 63
		},
		GOTOS => {
			'Literal' => 401
		}
	},
	{#State 395
		DEFAULT => -45
	},
	{#State 396
		ACTIONS => {
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP19_LOOP_CONTROL' => 68,
			'WORD_SCOPED' => 12,
			"{" => 67,
			"[" => 46,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50,
			'OP01_NAMED_VOID_PAREN' => 53,
			"foreach my" => -159,
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74,
			"undef" => 76,
			"if (" => 57,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'VARIABLE_SYMBOL' => 79,
			'OP01_NAMED_VOID' => 78,
			"for my integer" => -159,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 84,
			"my" => 61,
			"while (" => -159
		},
		GOTOS => {
			'ArrayDereferenced' => 80,
			'PLUS-38' => 403,
			'Operator' => 77,
			'HashReference' => 75,
			'Statement' => 56,
			'Conditional' => 60,
			'Literal' => 62,
			'Expression' => 83,
			'WordScoped' => 44,
			'LoopLabel' => 47,
			'VariableDeclaration' => 45,
			'Operation' => 402,
			'OPTIONAL-50' => 65,
			'ArrayReference' => 42,
			'VariableModification' => 72,
			'Variable' => 51,
			'PAREN-49' => 73,
			'OperatorVoid' => 52,
			'HashDereferenced' => 49
		}
	},
	{#State 397
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 404
		}
	},
	{#State 398
		DEFAULT => -87
	},
	{#State 399
		DEFAULT => -78
	},
	{#State 400
		ACTIONS => {
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81,
			'OP03_MATH_INC_DEC' => 74,
			"%{" => 54,
			"\@{" => 55,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"[" => 46,
			"{" => 67,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'Expression' => 405,
			'Literal' => 62,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'ArrayDereferenced' => 80,
			'WordScoped' => 44,
			'Operator' => 77
		}
	},
	{#State 401
		DEFAULT => -47
	},
	{#State 402
		DEFAULT => -90
	},
	{#State 403
		ACTIONS => {
			"for my integer" => -159,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 84,
			"my" => 61,
			"while (" => -159,
			"foreach my" => -159,
			'OP01_NAMED_VOID_PAREN' => 53,
			"\@{" => 55,
			"%{" => 54,
			"}" => 406,
			'OP03_MATH_INC_DEC' => 74,
			"undef" => 76,
			"if (" => 57,
			"(" => 58,
			'OP10_NAMED_UNARY' => 59,
			'OP01_NAMED_VOID' => 78,
			'VARIABLE_SYMBOL' => 79,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			'OP05_LOGICAL_NEG' => 50,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP19_LOOP_CONTROL' => 68,
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67
		},
		GOTOS => {
			'ArrayDereferenced' => 80,
			'Operator' => 77,
			'Statement' => 56,
			'HashReference' => 75,
			'Expression' => 83,
			'Literal' => 62,
			'Conditional' => 60,
			'WordScoped' => 44,
			'VariableDeclaration' => 45,
			'LoopLabel' => 47,
			'Operation' => 407,
			'OPTIONAL-50' => 65,
			'ArrayReference' => 42,
			'Variable' => 51,
			'VariableModification' => 72,
			'PAREN-49' => 73,
			'OperatorVoid' => 52,
			'HashDereferenced' => 49
		}
	},
	{#State 404
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 408
		}
	},
	{#State 405
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 160,
			'OP23_LOGICAL_AND' => 150,
			'OP21_LIST_COMMA' => 410,
			'OP18_TERNARY' => 148,
			'OP06_REGEX_MATCH' => 159,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP16_LOGICAL_OR' => 147,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152,
			'OP24_LOGICAL_OR_XOR' => 162,
			")" => -66,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151
		},
		GOTOS => {
			'PAREN-26' => 411,
			'OPTIONAL-27' => 409
		}
	},
	{#State 406
		ACTIONS => {
			";" => 412
		}
	},
	{#State 407
		DEFAULT => -89
	},
	{#State 408
		ACTIONS => {
			")" => 415,
			'OP21_LIST_COMMA' => 413
		},
		GOTOS => {
			'PAREN-39' => 414
		}
	},
	{#State 409
		ACTIONS => {
			")" => 416
		}
	},
	{#State 410
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 74,
			"%{" => 54,
			"\@{" => 55,
			'VARIABLE_SYMBOL' => 79,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'OP01_NAMED' => 82,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 81,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"{" => 67,
			'WORD_SCOPED' => 12,
			"[" => 46,
			'LITERAL_STRING' => 70,
			'OP05_MATH_NEG' => 48,
			'OP05_LOGICAL_NEG' => 50
		},
		GOTOS => {
			'Literal' => 62,
			'Expression' => 417,
			'Variable' => 91,
			'HashDereferenced' => 49,
			'HashReference' => 75,
			'ArrayReference' => 42,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77
		}
	},
	{#State 411
		DEFAULT => -65
	},
	{#State 412
		DEFAULT => -91
	},
	{#State 413
		ACTIONS => {
			"my" => 418
		}
	},
	{#State 414
		DEFAULT => -93
	},
	{#State 415
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 419
		}
	},
	{#State 416
		ACTIONS => {
			";" => 420
		}
	},
	{#State 417
		ACTIONS => {
			'OP16_LOGICAL_OR' => 147,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 155,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP04_MATH_POW' => 146,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP23_LOGICAL_AND' => 150,
			'OP18_TERNARY' => 148,
			'OP21_LIST_COMMA' => 421,
			'OP06_REGEX_MATCH' => 159,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152
		}
	},
	{#State 418
		ACTIONS => {
			'WORD' => 123
		},
		GOTOS => {
			'Type' => 422
		}
	},
	{#State 419
		ACTIONS => {
			"\@_;" => 423
		}
	},
	{#State 420
		DEFAULT => -67
	},
	{#State 421
		ACTIONS => {
			"[" => 46,
			'WORD_SCOPED' => 12,
			"{" => 67,
			'LITERAL_NUMBER' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP05_LOGICAL_NEG' => 50,
			'OP05_MATH_NEG' => 48,
			'LITERAL_STRING' => 70,
			"undef" => 76,
			'OP10_NAMED_UNARY' => 59,
			"(" => 58,
			'VARIABLE_SYMBOL' => 79,
			"%{" => 54,
			"\@{" => 55,
			'OP03_MATH_INC_DEC' => 74,
			'OP22_LOGICAL_NOT' => 81,
			'OP01_NAMED' => 82,
			'WORD' => 11
		},
		GOTOS => {
			'Variable' => 91,
			'HashDereferenced' => 49,
			'Literal' => 62,
			'Expression' => 424,
			'WordScoped' => 44,
			'ArrayDereferenced' => 80,
			'Operator' => 77,
			'HashReference' => 75,
			'ArrayReference' => 42
		}
	},
	{#State 422
		ACTIONS => {
			'VARIABLE_SYMBOL' => 425
		}
	},
	{#State 423
		DEFAULT => -96,
		GOTOS => {
			'STAR-41' => 426
		}
	},
	{#State 424
		ACTIONS => {
			")" => -64,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP15_LOGICAL_AND' => 153,
			'OP13_BITWISE_AND' => 152,
			'OP24_LOGICAL_OR_XOR' => 162,
			'OP17_LIST_RANGE' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NEQ' => 154,
			'OP16_LOGICAL_OR' => 147,
			'OP08_STRING_CAT' => 157,
			'OP09_BITWISE_SHIFT' => 158,
			'OP14_BITWISE_OR_XOR' => 160,
			'OP23_LOGICAL_AND' => 150,
			'OP18_TERNARY' => 148,
			'OP06_REGEX_MATCH' => 159
		}
	},
	{#State 425
		DEFAULT => -92
	},
	{#State 426
		ACTIONS => {
			"while (" => -97,
			'OP01_NAMED' => -97,
			"my" => -97,
			'WORD' => -97,
			"for my integer" => -97,
			'OP22_LOGICAL_NOT' => -97,
			'VARIABLE_SYMBOL' => -97,
			'OP01_NAMED_VOID' => -97,
			"undef" => -97,
			"if (" => -97,
			"(" => -97,
			'OP10_NAMED_UNARY' => -97,
			'OP03_MATH_INC_DEC' => -97,
			"foreach my" => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			"%{" => -97,
			"\@{" => -97,
			'OP05_LOGICAL_NEG' => -97,
			'LITERAL_STRING' => -97,
			'OP05_MATH_NEG' => -97,
			'OP19_LOOP_CONTROL' => -97,
			"[" => -97,
			"{" => -97,
			'WORD_SCOPED' => -97,
			'LITERAL_NUMBER' => -97,
			'CHECK_OR_CHECKTRACE' => 393,
			'OP10_NAMED_UNARY_STRINGIFY' => -97
		},
		GOTOS => {
			'ArgumentCheck' => 427
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
#line 5612 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5619 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5626 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5637 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5648 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5655 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5662 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5669 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5676 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5683 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5690 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5697 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5704 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5711 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5718 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5729 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5740 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5751 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5758 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5765 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5772 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5779 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5786 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5793 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5800 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5807 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 10,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5818 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5829 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5836 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5843 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5854 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5861 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5868 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5879 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5901 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5908 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5936 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5943 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5992 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6010 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6021 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6032 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6039 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6046 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6053 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6060 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6071 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6078 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6085 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6092 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6099 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6106 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6117 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6124 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6131 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6138 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6149 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6156 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6163 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6170 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6177 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6184 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6191 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6198 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6205 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6212 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6219 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 3,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6233 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6240 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 17,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6251 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6258 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6265 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6272 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6283 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6294 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6301 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6315 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6322 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6340 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6347 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6354 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6361 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6368 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6379 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6390 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6401 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6408 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6415 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6426 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6437 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6448 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6459 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6470 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6481 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6492 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6503 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6514 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6525 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6536 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6547 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6558 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6569 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6580 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6591 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6602 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6613 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6624 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6635 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6646 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6657 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6668 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6679 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6686 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6693 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6700 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6707 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6714 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6721 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6728 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6735 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6746 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6757 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6768 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6779 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6790 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6797 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6811 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6840 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6862 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6873 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6884 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6895 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6906 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6917 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6928 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6939 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6950 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_155
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6961 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_156
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6972 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6979 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6993 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7004 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7015 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7026 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_163
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7037 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_164
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7048 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7055 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7062 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7069 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7076 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7083 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7090 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_171
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7101 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7112 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_173
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7123 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_174
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7134 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_175
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7145 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_176
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7156 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_177
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7174 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7181 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_180
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7192 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7206 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_183
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7217 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7228 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_185
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7239 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_186
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7250 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_187
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7261 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_188
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7272 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_189
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7283 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_190
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7294 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7301 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7308 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7315 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_196
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7340 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_197
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_198
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7362 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_199
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7373 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_200
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7384 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7391 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7398 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_203
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7409 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_204
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7420 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_205
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7431 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7438 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7445 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_208
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7456 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_209
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7467 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_210
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7478 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_211
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7489 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-62', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7496 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7503 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7510 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_215
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_216
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_217
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7543 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_218
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7554 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_219
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7565 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_220
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7576 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_221
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7587 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_222
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7598 lib/RPerl/Grammar.pm
	],
	[#Rule Type_223
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7609 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_224
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7620 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_225
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7631 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_226
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7642 lib/RPerl/Grammar.pm
	]
],
#line 7645 lib/RPerl/Grammar.pm
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

#line 178 "lib/RPerl/Grammar.eyp"


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


#line 7920 lib/RPerl/Grammar.pm



1;
