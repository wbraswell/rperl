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
    our $VERSION = 0.000_732;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G\s+|(\s*\#[^\#].+\s*)+/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|elsif\ \(|\=\ sub\ \{|package|\$TYPED_|\<STDIN\>|while\ \(|undef|\(\ my|else|if\ \(|qw\(|\@_\;|our|use|\@\{|1\;|\{\*|\%\{|\.\.|my|\{|\;|\]|\}|\[|\)|\(|\/)}gc and return ($1, $1);

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
			"package" => 6,
			'SHEBANG' => 5
		},
		GOTOS => {
			'CompileUnit' => 4,
			'Package' => 8,
			'Program' => 7,
			'Module' => 3,
			'Class' => 2,
			'PLUS-1' => 1
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 6,
			'' => -4
		},
		GOTOS => {
			'Module' => 9,
			'Package' => 8,
			'Class' => 2
		}
	},
	{#State 2
		DEFAULT => -17
	},
	{#State 3
		DEFAULT => -2
	},
	{#State 4
		ACTIONS => {
			'' => 10
		}
	},
	{#State 5
		ACTIONS => {
			"use strict;" => 12
		},
		GOTOS => {
			'Header' => 11
		}
	},
	{#State 6
		ACTIONS => {
			'WORD_SCOPED' => 15,
			'WORD' => 14
		},
		GOTOS => {
			'WordScoped' => 13
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		DEFAULT => -16
	},
	{#State 9
		DEFAULT => -1
	},
	{#State 10
		DEFAULT => 0
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
		ACTIONS => {
			";" => 18
		}
	},
	{#State 14
		DEFAULT => -218
	},
	{#State 15
		DEFAULT => -219
	},
	{#State 16
		ACTIONS => {
			"%{" => -8,
			'LITERAL_NUMBER' => -8,
			"undef" => -8,
			"while (" => -8,
			'OP05_LOGICAL_NEG' => -8,
			'LITERAL_STRING' => -8,
			'WORD_SCOPED' => -8,
			'OP10_NAMED_UNARY' => -8,
			"my" => -8,
			"use constant" => -8,
			'OP03_MATH_INC_DEC' => -8,
			"{" => -8,
			"for my integer" => -8,
			'OP01_NAMED_VOID' => -8,
			"[" => -8,
			"\@{" => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"(" => -8,
			'OP01_NAMED' => -8,
			"foreach my" => -8,
			'VARIABLE_SYMBOL' => -8,
			'OP05_MATH_NEG' => -8,
			'OP19_LOOP_CONTROL' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			"if (" => -8,
			"our" => -8,
			"## no critic qw(" => 20,
			'OP22_LOGICAL_NOT' => -8,
			'WORD' => -8,
			"use" => -8
		},
		GOTOS => {
			'Critic' => 21,
			'STAR-3' => 19
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
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			"if (" => -10,
			"our" => -10,
			"use" => 26,
			'WORD' => -10,
			'OP22_LOGICAL_NOT' => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"\@{" => -10,
			"(" => -10,
			"foreach my" => -10,
			'VARIABLE_SYMBOL' => -10,
			'OP05_MATH_NEG' => -10,
			'OP01_NAMED' => -10,
			'OP19_LOOP_CONTROL' => -10,
			'LITERAL_STRING' => -10,
			'OP05_LOGICAL_NEG' => -10,
			"use constant" => -10,
			'OP10_NAMED_UNARY' => -10,
			'WORD_SCOPED' => -10,
			"my" => -10,
			"{" => -10,
			'OP03_MATH_INC_DEC' => -10,
			"for my integer" => -10,
			'OP01_NAMED_VOID' => -10,
			"[" => -10,
			'LITERAL_NUMBER' => -10,
			"%{" => -10,
			"while (" => -10,
			"undef" => -10
		},
		GOTOS => {
			'STAR-4' => 24,
			'Include' => 25
		}
	},
	{#State 20
		ACTIONS => {
			'WORD' => 27
		},
		GOTOS => {
			'PLUS-11' => 28
		}
	},
	{#State 21
		DEFAULT => -5
	},
	{#State 22
		ACTIONS => {
			"our" => 29
		}
	},
	{#State 23
		ACTIONS => {
			"use constant" => -19,
			"## no critic qw(" => -19,
			"use parent qw(" => 30,
			"use" => -19,
			"our" => -19
		},
		GOTOS => {
			'STAR-7' => 31
		}
	},
	{#State 24
		ACTIONS => {
			'LITERAL_NUMBER' => -12,
			"%{" => -12,
			"while (" => -12,
			"undef" => -12,
			"use constant" => 34,
			'OP10_NAMED_UNARY' => -12,
			"my" => -12,
			'WORD_SCOPED' => -12,
			'LITERAL_STRING' => -12,
			'OP05_LOGICAL_NEG' => -12,
			"[" => -12,
			'OP01_NAMED_VOID' => -12,
			"{" => -12,
			"for my integer" => -12,
			'OP03_MATH_INC_DEC' => -12,
			"(" => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			"\@{" => -12,
			'OP19_LOOP_CONTROL' => -12,
			"foreach my" => -12,
			'VARIABLE_SYMBOL' => -12,
			'OP05_MATH_NEG' => -12,
			'OP01_NAMED' => -12,
			"if (" => -12,
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			'WORD' => -12,
			'OP22_LOGICAL_NOT' => -12,
			"our" => -12
		},
		GOTOS => {
			'Constant' => 32,
			'STAR-5' => 33
		}
	},
	{#State 25
		DEFAULT => -7
	},
	{#State 26
		ACTIONS => {
			'WORD' => 14,
			'WORD_SCOPED' => 15
		},
		GOTOS => {
			'WordScoped' => 35
		}
	},
	{#State 27
		DEFAULT => -29
	},
	{#State 28
		ACTIONS => {
			")" => 36,
			'WORD' => 37
		}
	},
	{#State 29
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 38
		}
	},
	{#State 30
		ACTIONS => {
			'WORD_SCOPED' => 15,
			'WORD' => 14
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 31
		ACTIONS => {
			"use constant" => -21,
			"use" => -21,
			"## no critic qw(" => 20,
			"our" => -21
		},
		GOTOS => {
			'STAR-8' => 40,
			'Critic' => 41
		}
	},
	{#State 32
		DEFAULT => -9
	},
	{#State 33
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => 43,
			"\@{" => 42,
			"(" => 65,
			'OP05_MATH_NEG' => 46,
			"foreach my" => -159,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED' => 68,
			'OP19_LOOP_CONTROL' => 44,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			"if (" => 48,
			"our" => 74,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 71,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"while (" => -159,
			"undef" => 77,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"my" => 78,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			"for my integer" => -159,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			'OP01_NAMED_VOID' => 84,
			"[" => 81
		},
		GOTOS => {
			'LoopLabel' => 73,
			'WordScoped' => 50,
			'HashDereferenced' => 70,
			'VariableDeclaration' => 45,
			'Subroutine' => 47,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Conditional' => 82,
			'PLUS-6' => 83,
			'Operator' => 79,
			'Expression' => 59,
			'OPTIONAL-50' => 60,
			'OperatorVoid' => 58,
			'Statement' => 57,
			'Literal' => 75,
			'Variable' => 56,
			'Operation' => 52,
			'VariableModification' => 51,
			'PAREN-49' => 54,
			'ArrayDereferenced' => 53
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => 85
		}
	},
	{#State 35
		ACTIONS => {
			";" => 86,
			"qw(" => 87
		}
	},
	{#State 36
		DEFAULT => -30
	},
	{#State 37
		DEFAULT => -28
	},
	{#State 38
		DEFAULT => -27
	},
	{#State 39
		ACTIONS => {
			")" => 88
		}
	},
	{#State 40
		ACTIONS => {
			"our" => -23,
			"use" => 26,
			"use constant" => -23
		},
		GOTOS => {
			'STAR-9' => 90,
			'Include' => 89
		}
	},
	{#State 41
		DEFAULT => -18
	},
	{#State 42
		ACTIONS => {
			'VARIABLE_SYMBOL' => 69,
			"[" => 81
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Variable' => 92
		}
	},
	{#State 43
		ACTIONS => {
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'KEYS_OR_VALUES' => 98,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED_QW' => 100,
			'OP05_MATH_NEG' => 46,
			")" => -127,
			"\@{" => 42,
			"(" => 65,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 80,
			"my" => 101,
			'WORD_SCOPED' => 15,
			"undef" => 77,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"{*" => 95
		},
		GOTOS => {
			'ArrayDereferenced' => 53,
			'Variable' => 97,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Literal' => 75,
			'OPTIONAL-43' => 96,
			'TypeInner' => 103,
			'ListElement' => 102,
			'Expression' => 93,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'FileHandle' => 99,
			'WordScoped' => 50,
			'ListElements' => 94
		}
	},
	{#State 44
		ACTIONS => {
			'WORD' => 104
		},
		GOTOS => {
			'LoopLabel' => 105
		}
	},
	{#State 45
		DEFAULT => -163
	},
	{#State 46
		ACTIONS => {
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED' => 68,
			"\@{" => 42,
			"(" => 65,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"[" => 81,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			"undef" => 77,
			'LITERAL_NUMBER' => 55,
			"%{" => 76
		},
		GOTOS => {
			'WordScoped' => 50,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 106,
			'Variable' => 97,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Literal' => 75,
			'ArrayDereferenced' => 53
		}
	},
	{#State 47
		DEFAULT => -11
	},
	{#State 48
		ACTIONS => {
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81,
			"\@{" => 42,
			"(" => 65,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14
		},
		GOTOS => {
			'HashDereferenced' => 70,
			'Expression' => 107,
			'Operator' => 79,
			'WordScoped' => 50,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Literal' => 75,
			'Variable' => 97,
			'ArrayDereferenced' => 53
		}
	},
	{#State 49
		ACTIONS => {
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"undef" => 77,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED' => 68,
			"(" => 65,
			"\@{" => 42
		},
		GOTOS => {
			'Operator' => 79,
			'HashDereferenced' => 70,
			'Expression' => 108,
			'WordScoped' => 50,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Literal' => 75,
			'Variable' => 97,
			'ArrayDereferenced' => 53
		}
	},
	{#State 50
		ACTIONS => {
			"(" => 109
		}
	},
	{#State 51
		DEFAULT => -164
	},
	{#State 52
		DEFAULT => -14
	},
	{#State 53
		DEFAULT => -147
	},
	{#State 54
		DEFAULT => -158
	},
	{#State 55
		DEFAULT => -226
	},
	{#State 56
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP18_TERNARY' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP02_METHOD_THINARROW' => 110,
			'OP11_COMPARE_LT_GT' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP08_STRING_CAT' => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 111,
			'OP06_REGEX_MATCH' => -145,
			'OP03_MATH_INC_DEC' => 113,
			";" => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP19_VARIABLE_ASSIGN' => 112,
			'OP04_MATH_POW' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP08_MATH_ADD_SUB' => -145
		}
	},
	{#State 57
		DEFAULT => -99
	},
	{#State 58
		DEFAULT => -162
	},
	{#State 59
		ACTIONS => {
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => 114,
			'OP04_MATH_POW' => 126,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP16_LOGICAL_OR' => 127,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 128,
			";" => 119,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP09_BITWISE_SHIFT' => 121,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP13_BITWISE_AND' => 129,
			'OP11_COMPARE_LT_GT' => 122,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => 125
		}
	},
	{#State 60
		ACTIONS => {
			"while (" => 137,
			"foreach my" => 131,
			"for my integer" => 134
		},
		GOTOS => {
			'LoopFor' => 132,
			'LoopWhile' => 136,
			'LoopForEach' => 133,
			'Loop' => 135
		}
	},
	{#State 61
		ACTIONS => {
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14,
			"(" => 65,
			"\@{" => 42,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46
		},
		GOTOS => {
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Literal' => 75,
			'Variable' => 97,
			'ArrayDereferenced' => 53,
			'WordScoped' => 50,
			'Operator' => 79,
			'HashDereferenced' => 70,
			'Expression' => 138
		}
	},
	{#State 62
		DEFAULT => -225
	},
	{#State 63
		ACTIONS => {
			'WORD' => 139,
			"%{" => 76,
			"}" => 141
		},
		GOTOS => {
			'HashEntry' => 142,
			'HashDereferenced' => 140
		}
	},
	{#State 64
		ACTIONS => {
			'VARIABLE_SYMBOL' => 69
		},
		GOTOS => {
			'Variable' => 143
		}
	},
	{#State 65
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14,
			"(" => 65,
			"\@{" => 42,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77
		},
		GOTOS => {
			'ArrayDereferenced' => 53,
			'Variable' => 97,
			'HashReference' => 66,
			'Literal' => 75,
			'ArrayReference' => 67,
			'HashDereferenced' => 70,
			'Expression' => 144,
			'Operator' => 79,
			'WordScoped' => 50
		}
	},
	{#State 66
		DEFAULT => -148
	},
	{#State 67
		DEFAULT => -146
	},
	{#State 68
		ACTIONS => {
			"(" => 145
		}
	},
	{#State 69
		DEFAULT => -182,
		GOTOS => {
			'STAR-56' => 146
		}
	},
	{#State 70
		DEFAULT => -149
	},
	{#State 71
		ACTIONS => {
			"(" => -218,
			'COLON' => -224
		}
	},
	{#State 72
		ACTIONS => {
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP01_NAMED' => 68,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			"\@{" => 42,
			"(" => 65,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			"undef" => 77,
			"%{" => 76,
			'LITERAL_NUMBER' => 55
		},
		GOTOS => {
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Literal' => 75,
			'Variable' => 97,
			'ArrayDereferenced' => 53,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 147,
			'WordScoped' => 50
		}
	},
	{#State 73
		ACTIONS => {
			'COLON' => 148
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => 150
		},
		GOTOS => {
			'Type' => 149
		}
	},
	{#State 75
		DEFAULT => -144
	},
	{#State 76
		ACTIONS => {
			"{" => 151,
			'VARIABLE_SYMBOL' => 69
		},
		GOTOS => {
			'HashReference' => 153,
			'Variable' => 152
		}
	},
	{#State 77
		DEFAULT => -143
	},
	{#State 78
		ACTIONS => {
			'WORD' => 150
		},
		GOTOS => {
			'Type' => 154
		}
	},
	{#State 79
		DEFAULT => -151
	},
	{#State 80
		ACTIONS => {
			'OP01_NAMED' => 68,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			"(" => 65,
			"\@{" => 42,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			"undef" => 77,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'Variable' => 97,
			'Literal' => 75,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'ArrayDereferenced' => 53,
			'Expression' => 155,
			'Operator' => 79,
			'HashDereferenced' => 70,
			'WordScoped' => 50
		}
	},
	{#State 81
		ACTIONS => {
			'KEYS_OR_VALUES' => 98,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			"(" => 65,
			"\@{" => 42,
			"]" => -202,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED_QW' => 100,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			'OP10_NAMED_UNARY' => 80,
			"my" => 157,
			'WORD_SCOPED' => 15,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77
		},
		GOTOS => {
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Literal' => 75,
			'Variable' => 97,
			'ArrayDereferenced' => 53,
			'OPTIONAL-60' => 158,
			'ListElement' => 102,
			'TypeInner' => 103,
			'Expression' => 93,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'ListElements' => 156,
			'WordScoped' => 50
		}
	},
	{#State 82
		DEFAULT => -160
	},
	{#State 83
		ACTIONS => {
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			"while (" => -159,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			"my" => 78,
			'' => -15,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'OP01_NAMED_VOID' => 84,
			"[" => 81,
			"for my integer" => -159,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"(" => 65,
			"\@{" => 42,
			'OP01_NAMED_VOID_PAREN' => 43,
			'OP19_LOOP_CONTROL' => 44,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			"foreach my" => -159,
			'OP05_MATH_NEG' => 46,
			"if (" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 71
		},
		GOTOS => {
			'VariableDeclaration' => 45,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'WordScoped' => 50,
			'LoopLabel' => 73,
			'HashDereferenced' => 70,
			'Statement' => 57,
			'OperatorVoid' => 58,
			'ArrayDereferenced' => 53,
			'PAREN-49' => 54,
			'VariableModification' => 51,
			'Operation' => 159,
			'Variable' => 56,
			'Literal' => 75,
			'Conditional' => 82,
			'OPTIONAL-50' => 60,
			'Expression' => 59,
			'Operator' => 79
		}
	},
	{#State 84
		ACTIONS => {
			'KEYS_OR_VALUES' => 98,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			"(" => 65,
			"\@{" => 42,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED_QW' => 100,
			'OP01_NAMED' => 68,
			"my" => 101,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			";" => -131,
			"{*" => 95,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77
		},
		GOTOS => {
			'TypeInner' => 103,
			'ListElement' => 102,
			'Variable' => 97,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Literal' => 75,
			'ArrayDereferenced' => 53,
			'WordScoped' => 50,
			'OPTIONAL-45' => 162,
			'ListElements' => 160,
			'FileHandle' => 161,
			'Expression' => 93,
			'HashDereferenced' => 70,
			'Operator' => 79
		}
	},
	{#State 85
		ACTIONS => {
			'OP20_HASH_FATARROW' => 163
		}
	},
	{#State 86
		DEFAULT => -33
	},
	{#State 87
		ACTIONS => {
			'WORD' => 165
		},
		GOTOS => {
			'PLUS-12' => 164
		}
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
			"our" => 74,
			"use constant" => 34
		},
		GOTOS => {
			'Constant' => 168,
			'PLUS-10' => 167,
			'Subroutine' => 169
		}
	},
	{#State 91
		ACTIONS => {
			"}" => 170
		}
	},
	{#State 92
		ACTIONS => {
			"}" => 171
		}
	},
	{#State 93
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP13_BITWISE_AND' => 129,
			'OP11_COMPARE_LT_GT' => 122,
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			"]" => -198,
			")" => -198,
			'OP16_LOGICAL_OR' => 127,
			'OP04_MATH_POW' => 126,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP06_REGEX_MATCH' => 128,
			";" => -198,
			'OP15_LOGICAL_AND' => 118,
			'OP21_LIST_COMMA' => -198,
			'OP23_LOGICAL_AND' => 114,
			'OP08_STRING_CAT' => 115
		}
	},
	{#State 94
		DEFAULT => -126
	},
	{#State 95
		ACTIONS => {
			'WORD' => 172
		}
	},
	{#State 96
		ACTIONS => {
			")" => 173
		}
	},
	{#State 97
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			")" => -145,
			"]" => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP02_METHOD_THINARROW' => 110,
			'OP11_COMPARE_LT_GT' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP18_TERNARY' => -145,
			".." => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			"}" => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP08_STRING_CAT' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP04_MATH_POW' => -145,
			";" => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP03_MATH_INC_DEC' => 113,
			'OP15_LOGICAL_AND' => -145,
			'OP21_LIST_COMMA' => -145
		}
	},
	{#State 98
		ACTIONS => {
			"%{" => 76
		},
		GOTOS => {
			'HashDereferenced' => 174
		}
	},
	{#State 99
		ACTIONS => {
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'KEYS_OR_VALUES' => 98,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			")" => -129,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED_QW' => 100,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			"(" => 65,
			"\@{" => 42,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			"my" => 157,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"undef" => 77,
			'LITERAL_NUMBER' => 55,
			"%{" => 76
		},
		GOTOS => {
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Literal' => 75,
			'Variable' => 97,
			'ArrayDereferenced' => 53,
			'ListElement' => 102,
			'TypeInner' => 103,
			'OPTIONAL-44' => 176,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 93,
			'ListElements' => 175,
			'WordScoped' => 50
		}
	},
	{#State 100
		ACTIONS => {
			"(" => 177
		}
	},
	{#State 101
		ACTIONS => {
			"filehandle_ref" => 178,
			'WORD' => 150
		},
		GOTOS => {
			'Type' => 179
		}
	},
	{#State 102
		DEFAULT => -193,
		GOTOS => {
			'STAR-58' => 180
		}
	},
	{#State 103
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			"(" => 65,
			"\@{" => 42,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77
		},
		GOTOS => {
			'Variable' => 97,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Literal' => 75,
			'ArrayDereferenced' => 53,
			'WordScoped' => 50,
			'Operator' => 79,
			'HashDereferenced' => 70,
			'Expression' => 181
		}
	},
	{#State 104
		DEFAULT => -224
	},
	{#State 105
		ACTIONS => {
			";" => 182
		}
	},
	{#State 106
		ACTIONS => {
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => 114,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 128,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP04_MATH_POW' => 126,
			'OP16_LOGICAL_OR' => 127,
			")" => 183,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP09_BITWISE_SHIFT' => 121,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => 125,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP13_BITWISE_AND' => 129,
			'OP11_COMPARE_LT_GT' => 122,
			'OP24_LOGICAL_OR_XOR' => 123
		}
	},
	{#State 107
		ACTIONS => {
			'OP06_REGEX_MATCH' => 128,
			'OP15_LOGICAL_AND' => 118,
			'OP16_LOGICAL_OR' => 127,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP04_MATH_POW' => 126,
			'OP23_LOGICAL_AND' => 114,
			'OP08_STRING_CAT' => 115,
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP13_BITWISE_AND' => 129,
			'OP11_COMPARE_LT_GT' => 122,
			")" => 184,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120
		}
	},
	{#State 108
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => -114,
			'OP04_MATH_POW' => 126,
			'OP16_LOGICAL_OR' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP21_LIST_COMMA' => -114,
			";" => -114,
			'OP06_REGEX_MATCH' => 128,
			"}" => -114,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => -114,
			'OP12_COMPARE_EQ_NEQ' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP13_BITWISE_AND' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			".." => -114,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP09_BITWISE_SHIFT' => 121,
			")" => -114,
			"]" => -114
		}
	},
	{#State 109
		ACTIONS => {
			"(" => 65,
			"\@{" => 42,
			")" => -140,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED_QW' => 100,
			'OP01_NAMED' => 68,
			'KEYS_OR_VALUES' => 98,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			"my" => 157,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63
		},
		GOTOS => {
			'ListElement' => 102,
			'TypeInner' => 103,
			'HashReference' => 66,
			'Literal' => 75,
			'ArrayReference' => 67,
			'Variable' => 97,
			'ArrayDereferenced' => 53,
			'ListElements' => 185,
			'WordScoped' => 50,
			'OPTIONAL-47' => 186,
			'Operator' => 79,
			'HashDereferenced' => 70,
			'Expression' => 93
		}
	},
	{#State 110
		ACTIONS => {
			'WORD' => 187
		}
	},
	{#State 111
		ACTIONS => {
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"(" => 65,
			"\@{" => 42,
			'OP01_NAMED' => 68,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14
		},
		GOTOS => {
			'ArrayDereferenced' => 53,
			'Variable' => 97,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Literal' => 75,
			'Expression' => 188,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'WordScoped' => 50
		}
	},
	{#State 112
		ACTIONS => {
			"(" => 65,
			"<STDIN>" => 191,
			"\@{" => 42,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64
		},
		GOTOS => {
			'WordScoped' => 50,
			'Expression' => 189,
			'Operator' => 79,
			'HashDereferenced' => 70,
			'ExpressionOrStdin' => 190,
			'ArrayDereferenced' => 53,
			'Literal' => 75,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Variable' => 97
		}
	},
	{#State 113
		DEFAULT => -104
	},
	{#State 114
		ACTIONS => {
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			"(" => 65,
			"\@{" => 42,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46
		},
		GOTOS => {
			'ArrayDereferenced' => 53,
			'Variable' => 97,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Literal' => 75,
			'HashDereferenced' => 70,
			'Expression' => 192,
			'Operator' => 79,
			'WordScoped' => 50
		}
	},
	{#State 115
		ACTIONS => {
			"undef" => 77,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			"\@{" => 42,
			"(" => 65,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14,
			'OP10_NAMED_UNARY_STRINGIFY' => 49
		},
		GOTOS => {
			'ArrayDereferenced' => 53,
			'ArrayReference' => 67,
			'Literal' => 75,
			'HashReference' => 66,
			'Variable' => 97,
			'WordScoped' => 50,
			'Expression' => 193,
			'HashDereferenced' => 70,
			'Operator' => 79
		}
	},
	{#State 116
		ACTIONS => {
			"undef" => 77,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			"(" => 65,
			"\@{" => 42,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49
		},
		GOTOS => {
			'Variable' => 97,
			'ArrayReference' => 67,
			'Literal' => 75,
			'HashReference' => 66,
			'ArrayDereferenced' => 53,
			'WordScoped' => 50,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 194
		}
	},
	{#State 117
		ACTIONS => {
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"(" => 65,
			"\@{" => 42,
			'OP01_NAMED' => 68,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14
		},
		GOTOS => {
			'WordScoped' => 50,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 195,
			'ArrayDereferenced' => 53,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Literal' => 75,
			'Variable' => 97
		}
	},
	{#State 118
		ACTIONS => {
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			"(" => 65,
			"\@{" => 42,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			"undef" => 77,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61
		},
		GOTOS => {
			'WordScoped' => 50,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 196,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Literal' => 75,
			'Variable' => 97,
			'ArrayDereferenced' => 53
		}
	},
	{#State 119
		DEFAULT => -98
	},
	{#State 120
		ACTIONS => {
			"undef" => 77,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			"\@{" => 42,
			"(" => 65,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49
		},
		GOTOS => {
			'WordScoped' => 50,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 197,
			'ArrayDereferenced' => 53,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Literal' => 75,
			'Variable' => 97
		}
	},
	{#State 121
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			"\@{" => 42,
			"(" => 65,
			'OP01_NAMED' => 68,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69
		},
		GOTOS => {
			'WordScoped' => 50,
			'HashDereferenced' => 70,
			'Expression' => 198,
			'Operator' => 79,
			'Variable' => 97,
			'ArrayReference' => 67,
			'Literal' => 75,
			'HashReference' => 66,
			'ArrayDereferenced' => 53
		}
	},
	{#State 122
		ACTIONS => {
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"(" => 65,
			"\@{" => 42,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14
		},
		GOTOS => {
			'ArrayDereferenced' => 53,
			'Variable' => 97,
			'Literal' => 75,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 199,
			'WordScoped' => 50
		}
	},
	{#State 123
		ACTIONS => {
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81,
			"\@{" => 42,
			"(" => 65,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72
		},
		GOTOS => {
			'Literal' => 75,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Variable' => 97,
			'ArrayDereferenced' => 53,
			'WordScoped' => 50,
			'Operator' => 79,
			'Expression' => 200,
			'HashDereferenced' => 70
		}
	},
	{#State 124
		ACTIONS => {
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			"(" => 65,
			"\@{" => 42,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			"undef" => 77,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'HashDereferenced' => 70,
			'Expression' => 201,
			'Operator' => 79,
			'WordScoped' => 50,
			'ArrayDereferenced' => 53,
			'Variable' => 97,
			'Literal' => 75,
			'HashReference' => 66,
			'ArrayReference' => 67
		}
	},
	{#State 125
		ACTIONS => {
			'VARIABLE_SYMBOL' => 69
		},
		GOTOS => {
			'Variable' => 202
		}
	},
	{#State 126
		ACTIONS => {
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81,
			"\@{" => 42,
			"(" => 65,
			'OP01_NAMED' => 68,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72
		},
		GOTOS => {
			'Operator' => 79,
			'Expression' => 203,
			'HashDereferenced' => 70,
			'WordScoped' => 50,
			'ArrayDereferenced' => 53,
			'ArrayReference' => 67,
			'Literal' => 75,
			'HashReference' => 66,
			'Variable' => 97
		}
	},
	{#State 127
		ACTIONS => {
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED' => 68,
			"(" => 65,
			"\@{" => 42,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"undef" => 77,
			'LITERAL_NUMBER' => 55,
			"%{" => 76
		},
		GOTOS => {
			'WordScoped' => 50,
			'Operator' => 79,
			'HashDereferenced' => 70,
			'Expression' => 204,
			'Literal' => 75,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Variable' => 97,
			'ArrayDereferenced' => 53
		}
	},
	{#State 128
		ACTIONS => {
			"/" => 205
		}
	},
	{#State 129
		ACTIONS => {
			"undef" => 77,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			"\@{" => 42,
			"(" => 65,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49
		},
		GOTOS => {
			'WordScoped' => 50,
			'Expression' => 206,
			'Operator' => 79,
			'HashDereferenced' => 70,
			'ArrayDereferenced' => 53,
			'Literal' => 75,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Variable' => 97
		}
	},
	{#State 130
		ACTIONS => {
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			"\@{" => 42,
			"(" => 65,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68
		},
		GOTOS => {
			'HashReference' => 66,
			'Literal' => 75,
			'ArrayReference' => 67,
			'Variable' => 97,
			'ArrayDereferenced' => 53,
			'HashDereferenced' => 70,
			'Expression' => 207,
			'Operator' => 79,
			'WordScoped' => 50
		}
	},
	{#State 131
		ACTIONS => {
			'WORD' => 150
		},
		GOTOS => {
			'Type' => 208
		}
	},
	{#State 132
		DEFAULT => -172
	},
	{#State 133
		DEFAULT => -173
	},
	{#State 134
		ACTIONS => {
			'VARIABLE_SYMBOL' => 209
		}
	},
	{#State 135
		DEFAULT => -161
	},
	{#State 136
		DEFAULT => -174
	},
	{#State 137
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			"(" => 65,
			"\@{" => 42,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED' => 68,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77
		},
		GOTOS => {
			'Literal' => 75,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Variable' => 97,
			'ArrayDereferenced' => 53,
			'Operator' => 79,
			'HashDereferenced' => 70,
			'Expression' => 210,
			'WordScoped' => 50
		}
	},
	{#State 138
		ACTIONS => {
			";" => -106,
			'OP06_REGEX_MATCH' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP04_MATH_POW' => 126,
			'OP23_LOGICAL_AND' => -106,
			'OP08_STRING_CAT' => -106,
			"}" => -106,
			'OP18_TERNARY' => -106,
			".." => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP13_BITWISE_AND' => -106,
			")" => -106,
			"]" => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP14_BITWISE_OR_XOR' => -106
		}
	},
	{#State 139
		ACTIONS => {
			'OP20_HASH_FATARROW' => 211
		}
	},
	{#State 140
		DEFAULT => -209
	},
	{#State 141
		DEFAULT => -150
	},
	{#State 142
		DEFAULT => -214,
		GOTOS => {
			'STAR-63' => 212
		}
	},
	{#State 143
		DEFAULT => -103
	},
	{#State 144
		ACTIONS => {
			'OP23_LOGICAL_AND' => 114,
			'OP08_STRING_CAT' => 115,
			'OP16_LOGICAL_OR' => 127,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP04_MATH_POW' => 126,
			'OP06_REGEX_MATCH' => 128,
			'OP15_LOGICAL_AND' => 118,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			")" => 213,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP13_BITWISE_AND' => 129,
			'OP11_COMPARE_LT_GT' => 122,
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124
		}
	},
	{#State 145
		ACTIONS => {
			'OP01_NAMED' => 68,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED_QW' => 100,
			'VARIABLE_SYMBOL' => 69,
			")" => -101,
			"\@{" => 42,
			"(" => 65,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'KEYS_OR_VALUES' => 98,
			"undef" => 77,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 80,
			"my" => 157,
			'WORD_SCOPED' => 15
		},
		GOTOS => {
			'ArrayDereferenced' => 53,
			'Literal' => 75,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'OPTIONAL-42' => 214,
			'Variable' => 97,
			'ListElement' => 102,
			'TypeInner' => 103,
			'Expression' => 93,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'ListElements' => 215,
			'WordScoped' => 50
		}
	},
	{#State 146
		ACTIONS => {
			'OP13_BITWISE_AND' => -183,
			'OP11_COMPARE_LT_GT' => -183,
			'OP02_METHOD_THINARROW' => -183,
			'OP12_COMPARE_EQ_NEQ' => -183,
			'OP24_LOGICAL_OR_XOR' => -183,
			".." => -183,
			'OP07_MATH_MULT_DIV_MOD' => -183,
			'OP18_TERNARY' => -183,
			'OP14_BITWISE_OR_XOR' => -183,
			'OP09_BITWISE_SHIFT' => -183,
			'OP02_ARRAY_THINARROW' => 216,
			")" => -183,
			"]" => -183,
			'OP08_MATH_ADD_SUB' => -183,
			'OP17_LIST_RANGE' => -183,
			'OP04_MATH_POW' => -183,
			'OP19_VARIABLE_ASSIGN' => -183,
			'OP16_LOGICAL_OR' => -183,
			'COLON' => -183,
			'OP15_LOGICAL_AND' => -183,
			'OP21_LIST_COMMA' => -183,
			";" => -183,
			'OP06_REGEX_MATCH' => -183,
			'OP03_MATH_INC_DEC' => -183,
			'OP02_HASH_THINARROW' => 218,
			"}" => -183,
			'OP19_VARIABLE_ASSIGN_BY' => -183,
			'OP23_LOGICAL_AND' => -183,
			'OP08_STRING_CAT' => -183
		},
		GOTOS => {
			'VariableRetrieval' => 217
		}
	},
	{#State 147
		ACTIONS => {
			'OP18_TERNARY' => 125,
			".." => -123,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP13_BITWISE_AND' => 129,
			'OP11_COMPARE_LT_GT' => 122,
			'OP12_COMPARE_EQ_NEQ' => 130,
			")" => -123,
			"]" => -123,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			";" => -123,
			'OP06_REGEX_MATCH' => 128,
			'OP21_LIST_COMMA' => -123,
			'OP15_LOGICAL_AND' => 118,
			'OP16_LOGICAL_OR' => 127,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP04_MATH_POW' => 126,
			'OP23_LOGICAL_AND' => -123,
			'OP08_STRING_CAT' => 115,
			"}" => -123
		}
	},
	{#State 148
		DEFAULT => -157
	},
	{#State 149
		ACTIONS => {
			'VARIABLE_SYMBOL' => 219
		}
	},
	{#State 150
		DEFAULT => -223
	},
	{#State 151
		ACTIONS => {
			'WORD' => 139,
			"%{" => 76
		},
		GOTOS => {
			'HashEntry' => 142,
			'HashDereferenced' => 140
		}
	},
	{#State 152
		ACTIONS => {
			"}" => 220
		}
	},
	{#State 153
		ACTIONS => {
			"}" => 221
		}
	},
	{#State 154
		ACTIONS => {
			'VARIABLE_SYMBOL' => 222
		}
	},
	{#State 155
		ACTIONS => {
			'OP06_REGEX_MATCH' => 128,
			";" => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP04_MATH_POW' => 126,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP08_STRING_CAT' => 115,
			"}" => -113,
			'OP18_TERNARY' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			".." => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP12_COMPARE_EQ_NEQ' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			"]" => -113,
			")" => -113,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => -113
		}
	},
	{#State 156
		DEFAULT => -201
	},
	{#State 157
		ACTIONS => {
			'WORD' => 150
		},
		GOTOS => {
			'Type' => 179
		}
	},
	{#State 158
		ACTIONS => {
			"]" => 223
		}
	},
	{#State 159
		DEFAULT => -13
	},
	{#State 160
		DEFAULT => -130
	},
	{#State 161
		ACTIONS => {
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'KEYS_OR_VALUES' => 98,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED_QW' => 100,
			'OP05_MATH_NEG' => 46,
			"\@{" => 42,
			"(" => 65,
			";" => -133,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"[" => 81,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 80,
			"my" => 157,
			'WORD_SCOPED' => 15,
			"undef" => 77,
			"%{" => 76,
			'LITERAL_NUMBER' => 55
		},
		GOTOS => {
			'ListElement' => 102,
			'TypeInner' => 103,
			'Literal' => 75,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Variable' => 97,
			'OPTIONAL-46' => 224,
			'ArrayDereferenced' => 53,
			'ListElements' => 225,
			'WordScoped' => 50,
			'Operator' => 79,
			'Expression' => 93,
			'HashDereferenced' => 70
		}
	},
	{#State 162
		ACTIONS => {
			";" => 226
		}
	},
	{#State 163
		ACTIONS => {
			"my" => 157
		},
		GOTOS => {
			'TypeInner' => 227
		}
	},
	{#State 164
		ACTIONS => {
			")" => 228,
			'WORD' => 229
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
		ACTIONS => {
			"our" => 74,
			"1;" => 231
		},
		GOTOS => {
			'Subroutine' => 232
		}
	},
	{#State 168
		DEFAULT => -22
	},
	{#State 169
		DEFAULT => -25
	},
	{#State 170
		DEFAULT => -205
	},
	{#State 171
		DEFAULT => -204
	},
	{#State 172
		ACTIONS => {
			"}" => 233
		}
	},
	{#State 173
		ACTIONS => {
			";" => 234
		}
	},
	{#State 174
		DEFAULT => -200
	},
	{#State 175
		DEFAULT => -128
	},
	{#State 176
		ACTIONS => {
			")" => 235
		}
	},
	{#State 177
		ACTIONS => {
			'WORD' => 236
		},
		GOTOS => {
			'PLUS-59' => 237
		}
	},
	{#State 178
		ACTIONS => {
			'VARIABLE_SYMBOL' => 238
		}
	},
	{#State 179
		ACTIONS => {
			"\$TYPED_" => 239
		}
	},
	{#State 180
		ACTIONS => {
			")" => -196,
			'OP21_LIST_COMMA' => 241,
			"]" => -196,
			";" => -196
		},
		GOTOS => {
			'PAREN-57' => 240
		}
	},
	{#State 181
		ACTIONS => {
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => 114,
			";" => -199,
			'OP06_REGEX_MATCH' => 128,
			'OP21_LIST_COMMA' => -199,
			'OP15_LOGICAL_AND' => 118,
			'OP16_LOGICAL_OR' => 127,
			'OP17_LIST_RANGE' => 117,
			'OP08_MATH_ADD_SUB' => 116,
			'OP04_MATH_POW' => 126,
			")" => -199,
			"]" => -199,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP11_COMPARE_LT_GT' => 122,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP13_BITWISE_AND' => 129
		}
	},
	{#State 182
		DEFAULT => -138
	},
	{#State 183
		DEFAULT => -107
	},
	{#State 184
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 242
		}
	},
	{#State 185
		DEFAULT => -139
	},
	{#State 186
		ACTIONS => {
			")" => 244
		}
	},
	{#State 187
		ACTIONS => {
			"(" => 245
		}
	},
	{#State 188
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP13_BITWISE_AND' => 129,
			'OP11_COMPARE_LT_GT' => 122,
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => 114,
			'OP16_LOGICAL_OR' => 127,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP04_MATH_POW' => 126,
			";" => 246,
			'OP06_REGEX_MATCH' => 128,
			'OP15_LOGICAL_AND' => 118
		}
	},
	{#State 189
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP11_COMPARE_LT_GT' => 122,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP13_BITWISE_AND' => 129,
			'OP23_LOGICAL_AND' => 114,
			'OP08_STRING_CAT' => 115,
			'OP06_REGEX_MATCH' => 128,
			";" => -155,
			'OP15_LOGICAL_AND' => 118,
			'OP16_LOGICAL_OR' => 127,
			'OP04_MATH_POW' => 126,
			'OP17_LIST_RANGE' => 117,
			'OP08_MATH_ADD_SUB' => 116
		}
	},
	{#State 190
		ACTIONS => {
			";" => 247
		}
	},
	{#State 191
		DEFAULT => -156
	},
	{#State 192
		ACTIONS => {
			'OP17_LIST_RANGE' => 117,
			'OP08_MATH_ADD_SUB' => 116,
			'OP04_MATH_POW' => 126,
			'OP16_LOGICAL_OR' => 127,
			'OP21_LIST_COMMA' => -124,
			'OP15_LOGICAL_AND' => 118,
			";" => -124,
			'OP06_REGEX_MATCH' => 128,
			"}" => -124,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => -124,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			'OP13_BITWISE_AND' => 129,
			'OP24_LOGICAL_OR_XOR' => -124,
			".." => -124,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => 125,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP09_BITWISE_SHIFT' => 121,
			")" => -124,
			"]" => -124
		}
	},
	{#State 193
		ACTIONS => {
			")" => -111,
			"]" => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			".." => -111,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP13_BITWISE_AND' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP08_STRING_CAT' => -111,
			"}" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP15_LOGICAL_AND' => -111,
			";" => -111,
			'OP06_REGEX_MATCH' => 128,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => -111,
			'OP04_MATH_POW' => 126,
			'OP16_LOGICAL_OR' => -111
		}
	},
	{#State 194
		ACTIONS => {
			'OP18_TERNARY' => -110,
			".." => -110,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP13_BITWISE_AND' => -110,
			")" => -110,
			"]" => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			";" => -110,
			'OP06_REGEX_MATCH' => 128,
			'OP15_LOGICAL_AND' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP08_MATH_ADD_SUB' => -110,
			'OP17_LIST_RANGE' => -110,
			'OP04_MATH_POW' => 126,
			'OP08_STRING_CAT' => -110,
			'OP23_LOGICAL_AND' => -110,
			"}" => -110
		}
	},
	{#State 195
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 124,
			".." => -121,
			'OP18_TERNARY' => -121,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			'OP13_BITWISE_AND' => 129,
			'OP24_LOGICAL_OR_XOR' => -121,
			"]" => -121,
			")" => -121,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP09_BITWISE_SHIFT' => 121,
			'OP15_LOGICAL_AND' => 118,
			'OP21_LIST_COMMA' => -121,
			'OP06_REGEX_MATCH' => 128,
			";" => -121,
			'OP04_MATH_POW' => 126,
			'OP17_LIST_RANGE' => undef,
			'OP08_MATH_ADD_SUB' => 116,
			'OP16_LOGICAL_OR' => 127,
			'OP23_LOGICAL_AND' => -121,
			'OP08_STRING_CAT' => 115,
			"}" => -121
		}
	},
	{#State 196
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 122,
			'OP13_BITWISE_AND' => 129,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			".." => -119,
			'OP18_TERNARY' => -119,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP09_BITWISE_SHIFT' => 121,
			"]" => -119,
			")" => -119,
			'OP04_MATH_POW' => 126,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => -119,
			'OP16_LOGICAL_OR' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP06_REGEX_MATCH' => 128,
			";" => -119,
			"}" => -119,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => -119
		}
	},
	{#State 197
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			'OP13_BITWISE_AND' => 129,
			'OP18_TERNARY' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			".." => -118,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => -118,
			"]" => -118,
			")" => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP04_MATH_POW' => 126,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => -118,
			'OP06_REGEX_MATCH' => 128,
			";" => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP21_LIST_COMMA' => -118,
			"}" => -118,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => -118
		}
	},
	{#State 198
		ACTIONS => {
			'OP18_TERNARY' => -112,
			".." => -112,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP12_COMPARE_EQ_NEQ' => -112,
			")" => -112,
			"]" => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			";" => -112,
			'OP06_REGEX_MATCH' => 128,
			'OP21_LIST_COMMA' => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => -112,
			'OP04_MATH_POW' => 126,
			'OP23_LOGICAL_AND' => -112,
			'OP08_STRING_CAT' => 115,
			"}" => -112
		}
	},
	{#State 199
		ACTIONS => {
			"}" => -115,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => -115,
			'OP04_MATH_POW' => 126,
			";" => -115,
			'OP06_REGEX_MATCH' => 128,
			'OP21_LIST_COMMA' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => -115,
			")" => -115,
			"]" => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP12_COMPARE_EQ_NEQ' => -115,
			'OP13_BITWISE_AND' => -115,
			'OP11_COMPARE_LT_GT' => undef,
			'OP18_TERNARY' => -115,
			".." => -115,
			'OP07_MATH_MULT_DIV_MOD' => 124
		}
	},
	{#State 200
		ACTIONS => {
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			".." => -125,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP13_BITWISE_AND' => 129,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			"]" => -125,
			")" => -125,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP06_REGEX_MATCH' => 128,
			";" => -125,
			'OP21_LIST_COMMA' => -125,
			'OP15_LOGICAL_AND' => 118,
			'OP16_LOGICAL_OR' => 127,
			'OP04_MATH_POW' => 126,
			'OP17_LIST_RANGE' => 117,
			'OP08_MATH_ADD_SUB' => 116,
			'OP23_LOGICAL_AND' => 114,
			'OP08_STRING_CAT' => 115,
			"}" => -125
		}
	},
	{#State 201
		ACTIONS => {
			";" => -109,
			'OP06_REGEX_MATCH' => 128,
			'OP15_LOGICAL_AND' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP08_MATH_ADD_SUB' => -109,
			'OP04_MATH_POW' => 126,
			'OP08_STRING_CAT' => -109,
			'OP23_LOGICAL_AND' => -109,
			"}" => -109,
			'OP18_TERNARY' => -109,
			".." => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP13_BITWISE_AND' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			")" => -109,
			"]" => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP14_BITWISE_OR_XOR' => -109
		}
	},
	{#State 202
		ACTIONS => {
			'COLON' => 248
		}
	},
	{#State 203
		ACTIONS => {
			'OP23_LOGICAL_AND' => -105,
			'OP08_STRING_CAT' => -105,
			"}" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP06_REGEX_MATCH' => -105,
			";" => -105,
			'OP04_MATH_POW' => 126,
			'OP17_LIST_RANGE' => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP16_LOGICAL_OR' => -105,
			"]" => -105,
			")" => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			".." => -105,
			'OP18_TERNARY' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP24_LOGICAL_OR_XOR' => -105
		}
	},
	{#State 204
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => -120,
			'OP04_MATH_POW' => 126,
			'OP16_LOGICAL_OR' => -120,
			'OP15_LOGICAL_AND' => 118,
			'OP21_LIST_COMMA' => -120,
			";" => -120,
			'OP06_REGEX_MATCH' => 128,
			"}" => -120,
			'OP23_LOGICAL_AND' => -120,
			'OP08_STRING_CAT' => 115,
			'OP13_BITWISE_AND' => 129,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			'OP24_LOGICAL_OR_XOR' => -120,
			".." => -120,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => -120,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP09_BITWISE_SHIFT' => 121,
			")" => -120,
			"]" => -120
		}
	},
	{#State 205
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 249
		}
	},
	{#State 206
		ACTIONS => {
			'OP04_MATH_POW' => 126,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP21_LIST_COMMA' => -117,
			'OP06_REGEX_MATCH' => 128,
			";" => -117,
			"}" => -117,
			'OP23_LOGICAL_AND' => -117,
			'OP08_STRING_CAT' => 115,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP13_BITWISE_AND' => -117,
			'OP11_COMPARE_LT_GT' => 122,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			".." => -117,
			'OP18_TERNARY' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP09_BITWISE_SHIFT' => 121,
			"]" => -117,
			")" => -117
		}
	},
	{#State 207
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => -116,
			'OP04_MATH_POW' => 126,
			'OP16_LOGICAL_OR' => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP21_LIST_COMMA' => -116,
			";" => -116,
			'OP06_REGEX_MATCH' => 128,
			"}" => -116,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => -116,
			'OP13_BITWISE_AND' => -116,
			'OP11_COMPARE_LT_GT' => 122,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP24_LOGICAL_OR_XOR' => -116,
			".." => -116,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP09_BITWISE_SHIFT' => 121,
			")" => -116,
			"]" => -116
		}
	},
	{#State 208
		ACTIONS => {
			'VARIABLE_SYMBOL' => 250
		}
	},
	{#State 209
		ACTIONS => {
			"(" => 251
		}
	},
	{#State 210
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 120,
			'OP09_BITWISE_SHIFT' => 121,
			")" => 252,
			'OP13_BITWISE_AND' => 129,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => 125,
			'OP23_LOGICAL_AND' => 114,
			'OP08_STRING_CAT' => 115,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP04_MATH_POW' => 126,
			'OP16_LOGICAL_OR' => 127,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 128
		}
	},
	{#State 211
		ACTIONS => {
			"{" => -207,
			'OP03_MATH_INC_DEC' => -207,
			"[" => -207,
			'LITERAL_STRING' => -207,
			'OP05_LOGICAL_NEG' => -207,
			'OP10_NAMED_UNARY' => -207,
			"my" => 157,
			'WORD_SCOPED' => -207,
			"undef" => -207,
			'LITERAL_NUMBER' => -207,
			"%{" => -207,
			'OP22_LOGICAL_NOT' => -207,
			'WORD' => -207,
			'OP10_NAMED_UNARY_STRINGIFY' => -207,
			'VARIABLE_SYMBOL' => -207,
			'OP05_MATH_NEG' => -207,
			'OP01_NAMED' => -207,
			"\@{" => -207,
			"(" => -207
		},
		GOTOS => {
			'TypeInner' => 253,
			'OPTIONAL-61' => 254
		}
	},
	{#State 212
		ACTIONS => {
			"}" => 257,
			'OP21_LIST_COMMA' => 256
		},
		GOTOS => {
			'PAREN-62' => 255
		}
	},
	{#State 213
		DEFAULT => -154
	},
	{#State 214
		ACTIONS => {
			")" => 258
		}
	},
	{#State 215
		DEFAULT => -100
	},
	{#State 216
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			"(" => 65,
			"\@{" => 42,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77
		},
		GOTOS => {
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 259,
			'WordScoped' => 50,
			'Variable' => 97,
			'Literal' => 75,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'ArrayDereferenced' => 53
		}
	},
	{#State 217
		DEFAULT => -181
	},
	{#State 218
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 260,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			"(" => 65,
			"\@{" => 42,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"undef" => 77,
			'LITERAL_NUMBER' => 55,
			"%{" => 76
		},
		GOTOS => {
			'Operator' => 79,
			'Expression' => 261,
			'HashDereferenced' => 70,
			'WordScoped' => 50,
			'Literal' => 75,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Variable' => 97,
			'ArrayDereferenced' => 53
		}
	},
	{#State 219
		ACTIONS => {
			"= sub {" => 262
		}
	},
	{#State 220
		DEFAULT => -216
	},
	{#State 221
		DEFAULT => -217
	},
	{#State 222
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 264,
			";" => 263
		}
	},
	{#State 223
		DEFAULT => -203
	},
	{#State 224
		ACTIONS => {
			";" => 265
		}
	},
	{#State 225
		DEFAULT => -132
	},
	{#State 226
		DEFAULT => -136
	},
	{#State 227
		ACTIONS => {
			"[" => 267,
			"{" => 269,
			'LITERAL_NUMBER' => 55,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'ConstantValue' => 268,
			'Literal' => 266
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
		DEFAULT => -220
	},
	{#State 234
		DEFAULT => -134
	},
	{#State 235
		ACTIONS => {
			";" => 273
		}
	},
	{#State 236
		DEFAULT => -195
	},
	{#State 237
		ACTIONS => {
			")" => 274,
			'WORD' => 275
		}
	},
	{#State 238
		DEFAULT => -221
	},
	{#State 239
		ACTIONS => {
			'WORD' => 276
		}
	},
	{#State 240
		DEFAULT => -192
	},
	{#State 241
		ACTIONS => {
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			"my" => 157,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81,
			"\@{" => 42,
			"(" => 65,
			'OP01_NAMED' => 68,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'KEYS_OR_VALUES' => 98,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72
		},
		GOTOS => {
			'TypeInner' => 103,
			'ListElement' => 277,
			'ArrayDereferenced' => 53,
			'Variable' => 97,
			'ArrayReference' => 67,
			'Literal' => 75,
			'HashReference' => 66,
			'WordScoped' => 50,
			'HashDereferenced' => 70,
			'Expression' => 93,
			'Operator' => 79
		}
	},
	{#State 242
		DEFAULT => -167,
		GOTOS => {
			'STAR-52' => 278
		}
	},
	{#State 243
		ACTIONS => {
			'OP01_NAMED_VOID' => 84,
			"[" => 81,
			"{" => 63,
			"for my integer" => -159,
			'OP03_MATH_INC_DEC' => 64,
			"my" => 78,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"while (" => -159,
			"undef" => 77,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 71,
			"if (" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP19_LOOP_CONTROL' => 44,
			"foreach my" => -159,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			"(" => 65,
			'OP01_NAMED_VOID_PAREN' => 43,
			"\@{" => 42
		},
		GOTOS => {
			'Conditional' => 82,
			'OPTIONAL-50' => 60,
			'Operator' => 79,
			'Expression' => 59,
			'OperatorVoid' => 58,
			'Statement' => 57,
			'PLUS-55' => 279,
			'Variable' => 56,
			'Literal' => 75,
			'PAREN-49' => 54,
			'ArrayDereferenced' => 53,
			'Operation' => 280,
			'VariableModification' => 51,
			'WordScoped' => 50,
			'LoopLabel' => 73,
			'HashDereferenced' => 70,
			'VariableDeclaration' => 45,
			'ArrayReference' => 67,
			'HashReference' => 66
		}
	},
	{#State 244
		DEFAULT => -152
	},
	{#State 245
		ACTIONS => {
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'KEYS_OR_VALUES' => 98,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED_QW' => 100,
			'OP01_NAMED' => 68,
			")" => -142,
			"\@{" => 42,
			"(" => 65,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"[" => 81,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			"my" => 157,
			"undef" => 77,
			'LITERAL_NUMBER' => 55,
			"%{" => 76
		},
		GOTOS => {
			'TypeInner' => 103,
			'ListElement' => 102,
			'ArrayDereferenced' => 53,
			'Variable' => 97,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Literal' => 75,
			'WordScoped' => 50,
			'ListElements' => 282,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 93,
			'OPTIONAL-48' => 281
		}
	},
	{#State 246
		DEFAULT => -190
	},
	{#State 247
		DEFAULT => -189
	},
	{#State 248
		ACTIONS => {
			'VARIABLE_SYMBOL' => 69
		},
		GOTOS => {
			'Variable' => 283
		}
	},
	{#State 249
		ACTIONS => {
			"/" => 284
		}
	},
	{#State 250
		ACTIONS => {
			"(" => 285
		}
	},
	{#State 251
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14,
			"\@{" => 42,
			"(" => 65,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77
		},
		GOTOS => {
			'Expression' => 286,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'WordScoped' => 50,
			'ArrayDereferenced' => 53,
			'Literal' => 75,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Variable' => 97
		}
	},
	{#State 252
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 287
		}
	},
	{#State 253
		DEFAULT => -206
	},
	{#State 254
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			"\@{" => 42,
			"(" => 65,
			'OP01_NAMED' => 68,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69
		},
		GOTOS => {
			'WordScoped' => 50,
			'Operator' => 79,
			'HashDereferenced' => 70,
			'Expression' => 288,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Literal' => 75,
			'Variable' => 97,
			'ArrayDereferenced' => 53
		}
	},
	{#State 255
		DEFAULT => -213
	},
	{#State 256
		ACTIONS => {
			'WORD' => 139,
			"%{" => 76
		},
		GOTOS => {
			'HashEntry' => 289,
			'HashDereferenced' => 140
		}
	},
	{#State 257
		DEFAULT => -215
	},
	{#State 258
		DEFAULT => -102
	},
	{#State 259
		ACTIONS => {
			'OP23_LOGICAL_AND' => 114,
			'OP08_STRING_CAT' => 115,
			'OP16_LOGICAL_OR' => 127,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP04_MATH_POW' => 126,
			'OP06_REGEX_MATCH' => 128,
			'OP15_LOGICAL_AND' => 118,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			"]" => 290,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			'OP13_BITWISE_AND' => 129,
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124
		}
	},
	{#State 260
		ACTIONS => {
			"}" => 291,
			"(" => -218
		}
	},
	{#State 261
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP13_BITWISE_AND' => 129,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			"}" => 292,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => 114,
			'OP16_LOGICAL_OR' => 127,
			'OP04_MATH_POW' => 126,
			'OP17_LIST_RANGE' => 117,
			'OP08_MATH_ADD_SUB' => 116,
			'OP06_REGEX_MATCH' => 128,
			'OP15_LOGICAL_AND' => 118
		}
	},
	{#State 262
		ACTIONS => {
			'OP01_NAMED_VOID' => -54,
			"[" => -54,
			"{" => -54,
			"for my integer" => -54,
			'OP03_MATH_INC_DEC' => -54,
			'WORD_SCOPED' => -54,
			'OP10_NAMED_UNARY' => -54,
			"my" => -54,
			'OP05_LOGICAL_NEG' => -54,
			'LITERAL_STRING' => -54,
			"undef" => -54,
			"while (" => -54,
			"%{" => -54,
			'LITERAL_NUMBER' => -54,
			'WORD' => -54,
			'OP22_LOGICAL_NOT' => -54,
			"( my" => 293,
			"if (" => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			'OP19_LOOP_CONTROL' => -54,
			'OP01_NAMED' => -54,
			"foreach my" => -54,
			'OP05_MATH_NEG' => -54,
			'VARIABLE_SYMBOL' => -54,
			"(" => -54,
			"\@{" => -54,
			'OP01_NAMED_VOID_PAREN' => -54
		},
		GOTOS => {
			'SubroutineArguments' => 294,
			'OPTIONAL-21' => 295
		}
	},
	{#State 263
		DEFAULT => -187
	},
	{#State 264
		ACTIONS => {
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"(" => 65,
			"<STDIN>" => 191,
			"\@{" => 42,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72
		},
		GOTOS => {
			'Variable' => 97,
			'Literal' => 75,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'ArrayDereferenced' => 53,
			'ExpressionOrStdin' => 296,
			'Expression' => 189,
			'Operator' => 79,
			'HashDereferenced' => 70,
			'WordScoped' => 50
		}
	},
	{#State 265
		DEFAULT => -137
	},
	{#State 266
		DEFAULT => -50
	},
	{#State 267
		ACTIONS => {
			'LITERAL_NUMBER' => -37,
			'LITERAL_STRING' => -37,
			"my" => 157
		},
		GOTOS => {
			'OPTIONAL-13' => 298,
			'TypeInner' => 297
		}
	},
	{#State 268
		ACTIONS => {
			";" => 299
		}
	},
	{#State 269
		ACTIONS => {
			'WORD' => 300
		}
	},
	{#State 270
		DEFAULT => -34
	},
	{#State 271
		ACTIONS => {
			"our %properties = (" => -71,
			"use constant" => -71,
			"## no critic qw(" => 20,
			"use" => -71
		},
		GOTOS => {
			'Critic' => 302,
			'STAR-29' => 301
		}
	},
	{#State 272
		DEFAULT => -26
	},
	{#State 273
		DEFAULT => -135
	},
	{#State 274
		DEFAULT => -197
	},
	{#State 275
		DEFAULT => -194
	},
	{#State 276
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 303
		}
	},
	{#State 277
		DEFAULT => -191
	},
	{#State 278
		ACTIONS => {
			'' => -170,
			'OP10_NAMED_UNARY' => -170,
			'WORD_SCOPED' => -170,
			"my" => -170,
			'LITERAL_STRING' => -170,
			'OP05_LOGICAL_NEG' => -170,
			"[" => -170,
			'OP01_NAMED_VOID' => -170,
			'OP03_MATH_INC_DEC' => -170,
			"for my integer" => -170,
			"{" => -170,
			"}" => -170,
			'LITERAL_NUMBER' => -170,
			"elsif (" => 304,
			"%{" => -170,
			"else" => 306,
			"while (" => -170,
			"undef" => -170,
			"if (" => -170,
			'OP10_NAMED_UNARY_STRINGIFY' => -170,
			'OP22_LOGICAL_NOT' => -170,
			'WORD' => -170,
			"(" => -170,
			'OP01_NAMED_VOID_PAREN' => -170,
			"\@{" => -170,
			'OP19_LOOP_CONTROL' => -170,
			"foreach my" => -170,
			'VARIABLE_SYMBOL' => -170,
			'OP05_MATH_NEG' => -170,
			'OP01_NAMED' => -170
		},
		GOTOS => {
			'OPTIONAL-54' => 305,
			'PAREN-51' => 307,
			'PAREN-53' => 308
		}
	},
	{#State 279
		ACTIONS => {
			"if (" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 71,
			'OP22_LOGICAL_NOT' => 72,
			"(" => 65,
			"\@{" => 42,
			'OP01_NAMED_VOID_PAREN' => 43,
			'OP19_LOOP_CONTROL' => 44,
			'OP01_NAMED' => 68,
			"foreach my" => -159,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'WORD_SCOPED' => 15,
			"my" => 78,
			'OP10_NAMED_UNARY' => 80,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'OP01_NAMED_VOID' => 84,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"for my integer" => -159,
			"{" => 63,
			"}" => 310,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			"while (" => -159
		},
		GOTOS => {
			'OperatorVoid' => 58,
			'Statement' => 57,
			'Literal' => 75,
			'Variable' => 56,
			'Operation' => 309,
			'VariableModification' => 51,
			'PAREN-49' => 54,
			'ArrayDereferenced' => 53,
			'Conditional' => 82,
			'Operator' => 79,
			'Expression' => 59,
			'OPTIONAL-50' => 60,
			'VariableDeclaration' => 45,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'LoopLabel' => 73,
			'WordScoped' => 50,
			'HashDereferenced' => 70
		}
	},
	{#State 280
		DEFAULT => -179
	},
	{#State 281
		ACTIONS => {
			")" => 311
		}
	},
	{#State 282
		DEFAULT => -141
	},
	{#State 283
		DEFAULT => -122
	},
	{#State 284
		DEFAULT => -108
	},
	{#State 285
		ACTIONS => {
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			"my" => 157,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"[" => 81,
			"\@{" => 42,
			"(" => 65,
			'OP01_NAMED' => 68,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED_QW' => 100,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'KEYS_OR_VALUES' => 98,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72
		},
		GOTOS => {
			'ListElement' => 102,
			'TypeInner' => 103,
			'Literal' => 75,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Variable' => 97,
			'ArrayDereferenced' => 53,
			'ListElements' => 312,
			'WordScoped' => 50,
			'Operator' => 79,
			'HashDereferenced' => 70,
			'Expression' => 93
		}
	},
	{#State 286
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 120,
			'OP09_BITWISE_SHIFT' => 121,
			'OP13_BITWISE_AND' => 129,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			'OP24_LOGICAL_OR_XOR' => 123,
			".." => 313,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => 125,
			'OP23_LOGICAL_AND' => 114,
			'OP08_STRING_CAT' => 115,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP04_MATH_POW' => 126,
			'OP16_LOGICAL_OR' => 127,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 128
		}
	},
	{#State 287
		DEFAULT => -177
	},
	{#State 288
		ACTIONS => {
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP13_BITWISE_AND' => 129,
			'OP11_COMPARE_LT_GT' => 122,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP06_REGEX_MATCH' => 128,
			'OP15_LOGICAL_AND' => 118,
			'OP21_LIST_COMMA' => -208,
			'OP16_LOGICAL_OR' => 127,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP04_MATH_POW' => 126,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => 114,
			"}" => -208
		}
	},
	{#State 289
		DEFAULT => -212
	},
	{#State 290
		DEFAULT => -184
	},
	{#State 291
		DEFAULT => -186
	},
	{#State 292
		DEFAULT => -185
	},
	{#State 293
		ACTIONS => {
			'WORD' => 150
		},
		GOTOS => {
			'Type' => 314
		}
	},
	{#State 294
		DEFAULT => -53
	},
	{#State 295
		ACTIONS => {
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"while (" => -159,
			"undef" => 77,
			"my" => 78,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			'OP01_NAMED_VOID' => 84,
			"[" => 81,
			"{" => 63,
			"for my integer" => -159,
			'OP03_MATH_INC_DEC' => 64,
			"(" => 65,
			'OP01_NAMED_VOID_PAREN' => 43,
			"\@{" => 42,
			'OP19_LOOP_CONTROL' => 44,
			"foreach my" => -159,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED' => 68,
			"if (" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 71,
			'OP22_LOGICAL_NOT' => 72
		},
		GOTOS => {
			'Variable' => 56,
			'Literal' => 75,
			'ArrayDereferenced' => 53,
			'PAREN-49' => 54,
			'VariableModification' => 51,
			'Operation' => 315,
			'OperatorVoid' => 58,
			'Statement' => 57,
			'PLUS-22' => 316,
			'OPTIONAL-50' => 60,
			'Operator' => 79,
			'Expression' => 59,
			'Conditional' => 82,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'VariableDeclaration' => 45,
			'HashDereferenced' => 70,
			'WordScoped' => 50,
			'LoopLabel' => 73
		}
	},
	{#State 296
		ACTIONS => {
			";" => 317
		}
	},
	{#State 297
		DEFAULT => -36
	},
	{#State 298
		ACTIONS => {
			'LITERAL_NUMBER' => 55,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'Literal' => 318
		}
	},
	{#State 299
		DEFAULT => -35
	},
	{#State 300
		ACTIONS => {
			'OP20_HASH_FATARROW' => 319
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
		ACTIONS => {
			"(" => 65,
			"\@{" => 42,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64
		},
		GOTOS => {
			'ArrayDereferenced' => 53,
			'Variable' => 97,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Literal' => 75,
			'WordScoped' => 50,
			'Operator' => 79,
			'Expression' => 322,
			'HashDereferenced' => 70
		}
	},
	{#State 305
		DEFAULT => -171
	},
	{#State 306
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 323
		}
	},
	{#State 307
		DEFAULT => -166
	},
	{#State 308
		DEFAULT => -169
	},
	{#State 309
		DEFAULT => -178
	},
	{#State 310
		DEFAULT => -180
	},
	{#State 311
		DEFAULT => -153
	},
	{#State 312
		ACTIONS => {
			")" => 324
		}
	},
	{#State 313
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			"(" => 65,
			"\@{" => 42,
			'OP01_NAMED' => 68,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			"[" => 81,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77
		},
		GOTOS => {
			'ArrayDereferenced' => 53,
			'Literal' => 75,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Variable' => 97,
			'WordScoped' => 50,
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 325
		}
	},
	{#State 314
		ACTIONS => {
			'VARIABLE_SYMBOL' => 326
		}
	},
	{#State 315
		DEFAULT => -56
	},
	{#State 316
		ACTIONS => {
			"}" => 327,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"undef" => 77,
			"while (" => -159,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			"my" => 78,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			"[" => 81,
			'OP01_NAMED_VOID' => 84,
			"{" => 63,
			"for my integer" => -159,
			'OP03_MATH_INC_DEC' => 64,
			"(" => 65,
			"\@{" => 42,
			'OP01_NAMED_VOID_PAREN' => 43,
			'OP19_LOOP_CONTROL' => 44,
			'OP01_NAMED' => 68,
			"foreach my" => -159,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			"if (" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 71
		},
		GOTOS => {
			'Operator' => 79,
			'Expression' => 59,
			'OPTIONAL-50' => 60,
			'Conditional' => 82,
			'Operation' => 328,
			'VariableModification' => 51,
			'ArrayDereferenced' => 53,
			'PAREN-49' => 54,
			'Literal' => 75,
			'Variable' => 56,
			'Statement' => 57,
			'OperatorVoid' => 58,
			'HashDereferenced' => 70,
			'LoopLabel' => 73,
			'WordScoped' => 50,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'VariableDeclaration' => 45
		}
	},
	{#State 317
		DEFAULT => -188
	},
	{#State 318
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 329
		}
	},
	{#State 319
		ACTIONS => {
			'LITERAL_NUMBER' => -44,
			'LITERAL_STRING' => -44,
			"my" => 157
		},
		GOTOS => {
			'OPTIONAL-17' => 331,
			'TypeInner' => 330
		}
	},
	{#State 320
		ACTIONS => {
			"use constant" => 34,
			"our %properties = (" => 332
		},
		GOTOS => {
			'Constant' => 334,
			'Properties' => 333
		}
	},
	{#State 321
		DEFAULT => -70
	},
	{#State 322
		ACTIONS => {
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP11_COMPARE_LT_GT' => 122,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP13_BITWISE_AND' => 129,
			")" => 335,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP06_REGEX_MATCH' => 128,
			'OP15_LOGICAL_AND' => 118,
			'OP16_LOGICAL_OR' => 127,
			'OP04_MATH_POW' => 126,
			'OP17_LIST_RANGE' => 117,
			'OP08_MATH_ADD_SUB' => 116,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => 114
		}
	},
	{#State 323
		DEFAULT => -168
	},
	{#State 324
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 336
		}
	},
	{#State 325
		ACTIONS => {
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => 114,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 128,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP04_MATH_POW' => 126,
			'OP16_LOGICAL_OR' => 127,
			")" => 337,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP09_BITWISE_SHIFT' => 121,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => 125,
			'OP13_BITWISE_AND' => 129,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			'OP24_LOGICAL_OR_XOR' => 123
		}
	},
	{#State 326
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 338
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
		ACTIONS => {
			"]" => 341,
			'OP21_LIST_COMMA' => 340
		},
		GOTOS => {
			'PAREN-15' => 342
		}
	},
	{#State 330
		DEFAULT => -43
	},
	{#State 331
		ACTIONS => {
			'LITERAL_STRING' => 62,
			'LITERAL_NUMBER' => 55
		},
		GOTOS => {
			'Literal' => 343
		}
	},
	{#State 332
		ACTIONS => {
			")" => 347,
			'WORD' => 344,
			"%{" => 76
		},
		GOTOS => {
			'HashEntryTyped' => 345,
			'HashDereferenced' => 346
		}
	},
	{#State 333
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 348
		}
	},
	{#State 334
		DEFAULT => -72
	},
	{#State 335
		ACTIONS => {
			"{" => 243
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
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 350
		}
	},
	{#State 338
		ACTIONS => {
			")" => 352,
			'OP21_LIST_COMMA' => 351
		},
		GOTOS => {
			'PAREN-23' => 353
		}
	},
	{#State 339
		DEFAULT => -57
	},
	{#State 340
		ACTIONS => {
			'LITERAL_NUMBER' => -39,
			'LITERAL_STRING' => -39,
			"my" => 157
		},
		GOTOS => {
			'OPTIONAL-14' => 354,
			'TypeInner' => 355
		}
	},
	{#State 341
		DEFAULT => -51
	},
	{#State 342
		DEFAULT => -41
	},
	{#State 343
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 356
		}
	},
	{#State 344
		ACTIONS => {
			'OP20_HASH_FATARROW' => 357
		}
	},
	{#State 345
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 358
		}
	},
	{#State 346
		DEFAULT => -211
	},
	{#State 347
		ACTIONS => {
			";" => 359
		}
	},
	{#State 348
		ACTIONS => {
			"our" => 361,
			"1;" => 360
		},
		GOTOS => {
			'Method' => 362
		}
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
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 364
		}
	},
	{#State 353
		DEFAULT => -59
	},
	{#State 354
		ACTIONS => {
			'LITERAL_NUMBER' => 55,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'Literal' => 365
		}
	},
	{#State 355
		DEFAULT => -38
	},
	{#State 356
		ACTIONS => {
			"}" => 366,
			'OP21_LIST_COMMA' => 367
		},
		GOTOS => {
			'PAREN-19' => 368
		}
	},
	{#State 357
		ACTIONS => {
			"my" => 157
		},
		GOTOS => {
			'TypeInner' => 369
		}
	},
	{#State 358
		ACTIONS => {
			'OP21_LIST_COMMA' => 371,
			")" => 370
		},
		GOTOS => {
			'PAREN-35' => 372
		}
	},
	{#State 359
		DEFAULT => -86
	},
	{#State 360
		ACTIONS => {
			"1;" => 373
		}
	},
	{#State 361
		ACTIONS => {
			'WORD' => 150
		},
		GOTOS => {
			'Type' => 374
		}
	},
	{#State 362
		DEFAULT => -74
	},
	{#State 363
		ACTIONS => {
			'WORD' => 150
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
		DEFAULT => -40
	},
	{#State 366
		DEFAULT => -52
	},
	{#State 367
		ACTIONS => {
			'WORD' => 377
		}
	},
	{#State 368
		DEFAULT => -48
	},
	{#State 369
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 14,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'OP05_MATH_NEG' => 46,
			'VARIABLE_SYMBOL' => 69,
			'OP01_NAMED' => 68,
			"(" => 65,
			"\@{" => 42,
			"[" => 81,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			"undef" => 77,
			'LITERAL_NUMBER' => 55,
			"%{" => 76
		},
		GOTOS => {
			'HashDereferenced' => 70,
			'Operator' => 79,
			'Expression' => 378,
			'WordScoped' => 50,
			'ArrayDereferenced' => 53,
			'Variable' => 97,
			'HashReference' => 66,
			'Literal' => 75,
			'ArrayReference' => 67
		}
	},
	{#State 370
		ACTIONS => {
			";" => 379
		}
	},
	{#State 371
		ACTIONS => {
			'WORD' => 344,
			"%{" => 76
		},
		GOTOS => {
			'HashDereferenced' => 346,
			'HashEntryTyped' => 380
		}
	},
	{#State 372
		DEFAULT => -83
	},
	{#State 373
		ACTIONS => {
			'' => -80,
			"our" => 74,
			"package" => -80
		},
		GOTOS => {
			'Subroutine' => 382,
			'PLUS-32' => 381,
			'OPTIONAL-34' => 384,
			'PAREN-33' => 383
		}
	},
	{#State 374
		ACTIONS => {
			'VARIABLE_SYMBOL' => 385
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
			'OP15_LOGICAL_AND' => 118,
			'OP21_LIST_COMMA' => -210,
			'OP06_REGEX_MATCH' => 128,
			'OP04_MATH_POW' => 126,
			'OP17_LIST_RANGE' => 117,
			'OP08_MATH_ADD_SUB' => 116,
			'OP16_LOGICAL_OR' => 127,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => 114,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => 125,
			'OP13_BITWISE_AND' => 129,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			'OP24_LOGICAL_OR_XOR' => 123,
			")" => -210,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP09_BITWISE_SHIFT' => 121
		}
	},
	{#State 379
		DEFAULT => -85
	},
	{#State 380
		DEFAULT => -82
	},
	{#State 381
		ACTIONS => {
			"1;" => 389,
			"our" => 74
		},
		GOTOS => {
			'Subroutine' => 390
		}
	},
	{#State 382
		DEFAULT => -77
	},
	{#State 383
		DEFAULT => -79
	},
	{#State 384
		DEFAULT => -81
	},
	{#State 385
		ACTIONS => {
			"= sub {" => 391
		}
	},
	{#State 386
		DEFAULT => -58
	},
	{#State 387
		ACTIONS => {
			"(" => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			"\@{" => -63,
			'OP19_LOOP_CONTROL' => -63,
			"foreach my" => -63,
			'VARIABLE_SYMBOL' => -63,
			'OP05_MATH_NEG' => -63,
			'OP01_NAMED' => -63,
			"if (" => -63,
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			'CHECK_OR_CHECKTRACE' => 393,
			'OP22_LOGICAL_NOT' => -63,
			'WORD' => -63,
			'LITERAL_NUMBER' => -63,
			"%{" => -63,
			"while (" => -63,
			"undef" => -63,
			"my" => -63,
			'OP10_NAMED_UNARY' => -63,
			'WORD_SCOPED' => -63,
			'LITERAL_STRING' => -63,
			'OP05_LOGICAL_NEG' => -63,
			'OP01_NAMED_VOID' => -63,
			"[" => -63,
			"for my integer" => -63,
			"{" => -63,
			'OP03_MATH_INC_DEC' => -63
		},
		GOTOS => {
			'ArgumentCheck' => 392
		}
	},
	{#State 388
		ACTIONS => {
			"my" => 157,
			'LITERAL_STRING' => -46,
			'LITERAL_NUMBER' => -46
		},
		GOTOS => {
			'TypeInner' => 395,
			'OPTIONAL-18' => 394
		}
	},
	{#State 389
		ACTIONS => {
			"1;" => 396
		}
	},
	{#State 390
		DEFAULT => -76
	},
	{#State 391
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -88,
			"foreach my" => -88,
			'OP05_MATH_NEG' => -88,
			'VARIABLE_SYMBOL' => -88,
			'OP01_NAMED' => -88,
			"(" => -88,
			'OP01_NAMED_VOID_PAREN' => -88,
			"\@{" => -88,
			"( my" => 399,
			'OP22_LOGICAL_NOT' => -88,
			'WORD' => -88,
			"if (" => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			"while (" => -88,
			"undef" => -88,
			'LITERAL_NUMBER' => -88,
			"%{" => -88,
			'OP01_NAMED_VOID' => -88,
			"[" => -88,
			'OP03_MATH_INC_DEC' => -88,
			"{" => -88,
			"for my integer" => -88,
			"my" => -88,
			'OP10_NAMED_UNARY' => -88,
			'WORD_SCOPED' => -88,
			'LITERAL_STRING' => -88,
			'OP05_LOGICAL_NEG' => -88
		},
		GOTOS => {
			'MethodArguments' => 398,
			'OPTIONAL-37' => 397
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
			'LITERAL_NUMBER' => 55,
			'LITERAL_STRING' => 62
		},
		GOTOS => {
			'Literal' => 401
		}
	},
	{#State 395
		DEFAULT => -45
	},
	{#State 396
		DEFAULT => -78
	},
	{#State 397
		ACTIONS => {
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"while (" => -159,
			"undef" => 77,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			"my" => 78,
			"for my integer" => -159,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			'OP01_NAMED_VOID' => 84,
			"[" => 81,
			'OP01_NAMED_VOID_PAREN' => 43,
			"\@{" => 42,
			"(" => 65,
			'VARIABLE_SYMBOL' => 69,
			"foreach my" => -159,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			'OP19_LOOP_CONTROL' => 44,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			"if (" => 48,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 71
		},
		GOTOS => {
			'ArrayReference' => 67,
			'HashReference' => 66,
			'VariableDeclaration' => 45,
			'HashDereferenced' => 70,
			'WordScoped' => 50,
			'LoopLabel' => 73,
			'ArrayDereferenced' => 53,
			'PAREN-49' => 54,
			'VariableModification' => 51,
			'Operation' => 402,
			'PLUS-38' => 403,
			'Variable' => 56,
			'Literal' => 75,
			'Statement' => 57,
			'OperatorVoid' => 58,
			'OPTIONAL-50' => 60,
			'Operator' => 79,
			'Expression' => 59,
			'Conditional' => 82
		}
	},
	{#State 398
		DEFAULT => -87
	},
	{#State 399
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 404
		}
	},
	{#State 400
		ACTIONS => {
			"\@{" => 42,
			"(" => 65,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"undef" => 77,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			'OP03_MATH_INC_DEC' => 64,
			"{" => 63,
			"[" => 81
		},
		GOTOS => {
			'ArrayDereferenced' => 53,
			'Literal' => 75,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Variable' => 97,
			'HashDereferenced' => 70,
			'Expression' => 405,
			'Operator' => 79,
			'WordScoped' => 50
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
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			"if (" => 48,
			'OP22_LOGICAL_NOT' => 72,
			'WORD' => 71,
			"\@{" => 42,
			'OP01_NAMED_VOID_PAREN' => 43,
			"(" => 65,
			'OP01_NAMED' => 68,
			'OP05_MATH_NEG' => 46,
			"foreach my" => -159,
			'VARIABLE_SYMBOL' => 69,
			'OP19_LOOP_CONTROL' => 44,
			'OP05_LOGICAL_NEG' => 61,
			'LITERAL_STRING' => 62,
			'WORD_SCOPED' => 15,
			"my" => 78,
			'OP10_NAMED_UNARY' => 80,
			"{" => 63,
			"for my integer" => -159,
			'OP03_MATH_INC_DEC' => 64,
			"[" => 81,
			'OP01_NAMED_VOID' => 84,
			"%{" => 76,
			'LITERAL_NUMBER' => 55,
			"}" => 406,
			"undef" => 77,
			"while (" => -159
		},
		GOTOS => {
			'Conditional' => 82,
			'OPTIONAL-50' => 60,
			'Operator' => 79,
			'Expression' => 59,
			'OperatorVoid' => 58,
			'Statement' => 57,
			'Variable' => 56,
			'Literal' => 75,
			'PAREN-49' => 54,
			'ArrayDereferenced' => 53,
			'VariableModification' => 51,
			'Operation' => 407,
			'WordScoped' => 50,
			'LoopLabel' => 73,
			'HashDereferenced' => 70,
			'VariableDeclaration' => 45,
			'HashReference' => 66,
			'ArrayReference' => 67
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
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			")" => -66,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP13_BITWISE_AND' => 129,
			'OP11_COMPARE_LT_GT' => 122,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => 114,
			'OP16_LOGICAL_OR' => 127,
			'OP17_LIST_RANGE' => 117,
			'OP08_MATH_ADD_SUB' => 116,
			'OP04_MATH_POW' => 126,
			'OP06_REGEX_MATCH' => 128,
			'OP21_LIST_COMMA' => 409,
			'OP15_LOGICAL_AND' => 118
		},
		GOTOS => {
			'OPTIONAL-27' => 411,
			'PAREN-26' => 410
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
			'OP21_LIST_COMMA' => 413,
			")" => 414
		},
		GOTOS => {
			'PAREN-39' => 415
		}
	},
	{#State 409
		ACTIONS => {
			"undef" => 77,
			'LITERAL_NUMBER' => 55,
			"%{" => 76,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"[" => 81,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			'WORD_SCOPED' => 15,
			'OP10_NAMED_UNARY' => 80,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			"\@{" => 42,
			"(" => 65,
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49
		},
		GOTOS => {
			'WordScoped' => 50,
			'HashDereferenced' => 70,
			'Expression' => 416,
			'Operator' => 79,
			'Variable' => 97,
			'ArrayReference' => 67,
			'HashReference' => 66,
			'Literal' => 75,
			'ArrayDereferenced' => 53
		}
	},
	{#State 410
		DEFAULT => -65
	},
	{#State 411
		ACTIONS => {
			")" => 417
		}
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
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 419
		}
	},
	{#State 415
		DEFAULT => -93
	},
	{#State 416
		ACTIONS => {
			'OP15_LOGICAL_AND' => 118,
			'OP21_LIST_COMMA' => 420,
			'OP06_REGEX_MATCH' => 128,
			'OP04_MATH_POW' => 126,
			'OP17_LIST_RANGE' => 117,
			'OP08_MATH_ADD_SUB' => 116,
			'OP16_LOGICAL_OR' => 127,
			'OP23_LOGICAL_AND' => 114,
			'OP08_STRING_CAT' => 115,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP18_TERNARY' => 125,
			'OP13_BITWISE_AND' => 129,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP09_BITWISE_SHIFT' => 121
		}
	},
	{#State 417
		ACTIONS => {
			";" => 421
		}
	},
	{#State 418
		ACTIONS => {
			'WORD' => 150
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
		ACTIONS => {
			'WORD' => 14,
			'OP22_LOGICAL_NOT' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 49,
			'VARIABLE_SYMBOL' => 69,
			'OP05_MATH_NEG' => 46,
			'OP01_NAMED' => 68,
			"\@{" => 42,
			"(" => 65,
			"{" => 63,
			'OP03_MATH_INC_DEC' => 64,
			"[" => 81,
			'LITERAL_STRING' => 62,
			'OP05_LOGICAL_NEG' => 61,
			'OP10_NAMED_UNARY' => 80,
			'WORD_SCOPED' => 15,
			"undef" => 77,
			'LITERAL_NUMBER' => 55,
			"%{" => 76
		},
		GOTOS => {
			'Variable' => 97,
			'HashReference' => 66,
			'ArrayReference' => 67,
			'Literal' => 75,
			'ArrayDereferenced' => 53,
			'WordScoped' => 50,
			'HashDereferenced' => 70,
			'Expression' => 424,
			'Operator' => 79
		}
	},
	{#State 421
		DEFAULT => -67
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
			'OP18_TERNARY' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 124,
			'OP24_LOGICAL_OR_XOR' => 123,
			'OP13_BITWISE_AND' => 129,
			'OP12_COMPARE_EQ_NEQ' => 130,
			'OP11_COMPARE_LT_GT' => 122,
			")" => -64,
			'OP09_BITWISE_SHIFT' => 121,
			'OP14_BITWISE_OR_XOR' => 120,
			'OP06_REGEX_MATCH' => 128,
			'OP15_LOGICAL_AND' => 118,
			'OP16_LOGICAL_OR' => 127,
			'OP08_MATH_ADD_SUB' => 116,
			'OP17_LIST_RANGE' => 117,
			'OP04_MATH_POW' => 126,
			'OP08_STRING_CAT' => 115,
			'OP23_LOGICAL_AND' => 114
		}
	},
	{#State 425
		DEFAULT => -92
	},
	{#State 426
		ACTIONS => {
			"undef" => -97,
			"while (" => -97,
			"%{" => -97,
			'LITERAL_NUMBER' => -97,
			"{" => -97,
			'OP03_MATH_INC_DEC' => -97,
			"for my integer" => -97,
			'OP01_NAMED_VOID' => -97,
			"[" => -97,
			'OP05_LOGICAL_NEG' => -97,
			'LITERAL_STRING' => -97,
			'OP10_NAMED_UNARY' => -97,
			'WORD_SCOPED' => -97,
			"my" => -97,
			'OP01_NAMED' => -97,
			'VARIABLE_SYMBOL' => -97,
			"foreach my" => -97,
			'OP05_MATH_NEG' => -97,
			'OP19_LOOP_CONTROL' => -97,
			"\@{" => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			"(" => -97,
			'OP22_LOGICAL_NOT' => -97,
			'WORD' => -97,
			'CHECK_OR_CHECKTRACE' => 393,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			"if (" => -97
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
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5619 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5626 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5637 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5648 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5655 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5662 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5669 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5676 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5683 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5690 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5697 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5704 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5711 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5718 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5729 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5740 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5751 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5758 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5765 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5772 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5779 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5786 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5793 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5800 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5807 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 10,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5818 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 5,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5829 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5836 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5843 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5854 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5861 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5868 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5879 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5901 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5908 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5936 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5943 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5992 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6010 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6021 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6032 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6039 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6046 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6053 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6060 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6071 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6078 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6085 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6092 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6099 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6106 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6117 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6124 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6131 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6138 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6149 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6156 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6163 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6170 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6177 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6184 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6191 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6198 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6205 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6212 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6219 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 3,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6233 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6240 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 17,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6251 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6258 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6265 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6272 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 5,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6283 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6294 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6301 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6315 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6322 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6340 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6347 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6354 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6361 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6368 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6379 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6390 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6401 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6408 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6415 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6426 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6437 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6448 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6459 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6470 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6481 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6492 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6503 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6514 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6525 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6536 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6547 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6558 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6569 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6580 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6591 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6602 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6613 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6624 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6635 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6646 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6657 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6668 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6679 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6686 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6693 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6700 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6707 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6714 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6721 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6728 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6735 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6746 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6757 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6768 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6779 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6790 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6797 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6811 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6840 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6862 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6873 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6884 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6895 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6906 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6917 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6928 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6939 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6950 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_155
		 'ExpressionOrStdin', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6961 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_156
		 'ExpressionOrStdin', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6972 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6979 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6993 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7004 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7015 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7026 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_163
		 'Statement', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7037 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_164
		 'Statement', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7048 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7055 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7062 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7069 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7076 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7083 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7090 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_171
		 'Conditional', 6,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7101 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7112 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_173
		 'Loop', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7123 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_174
		 'Loop', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7134 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_175
		 'LoopFor', 8,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7145 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_176
		 'LoopForEach', 7,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7156 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_177
		 'LoopWhile', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7174 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7181 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_180
		 'CodeBlock', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7192 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7206 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_183
		 'Variable', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7217 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7228 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_185
		 'VariableRetrieval', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7239 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_186
		 'VariableRetrieval', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7250 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_187
		 'VariableDeclaration', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7261 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_188
		 'VariableDeclaration', 6,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7272 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_189
		 'VariableModification', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7283 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_190
		 'VariableModification', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7294 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7301 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7308 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7315 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 2,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-59', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_196
		 'ListElements', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7340 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_197
		 'ListElements', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_198
		 'ListElement', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7362 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_199
		 'ListElement', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7373 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_200
		 'ListElement', 2,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7384 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7391 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7398 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_203
		 'ArrayReference', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7409 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_204
		 'ArrayDereferenced', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7420 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_205
		 'ArrayDereferenced', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7431 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7438 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7445 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_208
		 'HashEntry', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7456 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_209
		 'HashEntry', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7467 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_210
		 'HashEntryTyped', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7478 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_211
		 'HashEntryTyped', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7489 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-62', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7496 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7503 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7510 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_215
		 'HashReference', 4,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_216
		 'HashDereferenced', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_217
		 'HashDereferenced', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7543 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_218
		 'WordScoped', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7554 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_219
		 'WordScoped', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7565 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_220
		 'FileHandle', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7576 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_221
		 'FileHandle', 3,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7587 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_222
		 'TypeInner', 5,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7598 lib/RPerl/Grammar.pm
	],
	[#Rule Type_223
		 'Type', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7609 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_224
		 'LoopLabel', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7620 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_225
		 'Literal', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7631 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_226
		 'Literal', 1,
sub {
#line 19 "lib/RPerl/Grammar.eyp"

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

#line 183 "lib/RPerl/Grammar.eyp"


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
