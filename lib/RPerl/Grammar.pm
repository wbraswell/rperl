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
    our $VERSION = 0.000_720;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G(\s*(\#.+)*\s*)+/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\<STDIN\>|elsif\ \(|package|while\ \(|\$TYPED_|\=\ sub\ \{|undef|else|if\ \(|\(\ my|our|qw\(|\@_\;|use|1\;|\{\*|\%\{|my|\.\.|\@\{|\/|\[|\;|\]|\)|\}|\{|\()}gc and return ($1, $1);

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
  [ 'ListElements_194' => 'ListElements', [ 'ListElement', 'STAR-58' ], 0 ],
  [ 'ListElement_195' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_196' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_197' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [  ], 0 ],
  [ 'ArrayReference_200' => 'ArrayReference', [ '[', 'OPTIONAL-59', ']' ], 0 ],
  [ 'ArrayDereferenced_201' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_202' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [  ], 0 ],
  [ 'HashEntry_205' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-60', 'Expression' ], 0 ],
  [ 'HashEntry_206' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_207' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_208' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-61', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-62', [ 'STAR-62', 'PAREN-61' ], 0 ],
  [ '_STAR_LIST' => 'STAR-62', [  ], 0 ],
  [ 'HashReference_212' => 'HashReference', [ '{', 'HashEntry', 'STAR-62', '}' ], 0 ],
  [ 'HashDereferenced_213' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_214' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_215' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_216' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'FileHandle_217' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'FileHandle_218' => 'FileHandle', [ 'my', 'filehandle_ref', 'VARIABLE_SYMBOL' ], 0 ],
  [ 'TypeInner_219' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Type_220' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_221' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Literal_222' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_223' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  'ListElements_194' => 194,
  'ListElement_195' => 195,
  'ListElement_196' => 196,
  'ListElement_197' => 197,
  '_OPTIONAL' => 198,
  '_OPTIONAL' => 199,
  'ArrayReference_200' => 200,
  'ArrayDereferenced_201' => 201,
  'ArrayDereferenced_202' => 202,
  '_OPTIONAL' => 203,
  '_OPTIONAL' => 204,
  'HashEntry_205' => 205,
  'HashEntry_206' => 206,
  'HashEntryTyped_207' => 207,
  'HashEntryTyped_208' => 208,
  '_PAREN' => 209,
  '_STAR_LIST' => 210,
  '_STAR_LIST' => 211,
  'HashReference_212' => 212,
  'HashDereferenced_213' => 213,
  'HashDereferenced_214' => 214,
  'WordScoped_215' => 215,
  'WordScoped_216' => 216,
  'FileHandle_217' => 217,
  'FileHandle_218' => 218,
  'TypeInner_219' => 219,
  'Type_220' => 220,
  'LoopLabel_221' => 221,
  'Literal_222' => 222,
  'Literal_223' => 223,
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
			'SHEBANG' => 4
		},
		GOTOS => {
			'Module' => 1,
			'Class' => 5,
			'PLUS-1' => 8,
			'Program' => 7,
			'Package' => 2,
			'CompileUnit' => 3
		}
	},
	{#State 1
		DEFAULT => -2
	},
	{#State 2
		DEFAULT => -16
	},
	{#State 3
		ACTIONS => {
			'' => 9
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
		DEFAULT => -17
	},
	{#State 6
		ACTIONS => {
			'WORD_SCOPED' => 14,
			'WORD' => 12
		},
		GOTOS => {
			'WordScoped' => 13
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		ACTIONS => {
			"package" => 6,
			'' => -4
		},
		GOTOS => {
			'Module' => 15,
			'Class' => 5,
			'Package' => 2
		}
	},
	{#State 9
		DEFAULT => 0
	},
	{#State 10
		ACTIONS => {
			"use warnings;" => 16
		}
	},
	{#State 11
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 17
		}
	},
	{#State 12
		DEFAULT => -215
	},
	{#State 13
		ACTIONS => {
			";" => 18
		}
	},
	{#State 14
		DEFAULT => -216
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
			"undef" => -8,
			"while (" => -8,
			'LITERAL_NUMBER' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			"%{" => -8,
			"my" => -8,
			'OP03_MATH_INC_DEC' => -8,
			"(" => -8,
			'OP01_NAMED' => -8,
			'OP19_LOOP_CONTROL' => -8,
			"[" => -8,
			"{" => -8,
			"for my integer" => -8,
			'OP01_NAMED_VOID' => -8,
			"use" => -8,
			'WORD_SCOPED' => -8,
			"if (" => -8,
			'OP05_LOGICAL_NEG' => -8,
			"our" => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			'OP05_MATH_NEG' => -8,
			"use constant" => -8,
			'WORD' => -8,
			'LITERAL_STRING' => -8,
			'OP22_LOGICAL_NOT' => -8,
			'OP10_NAMED_UNARY' => -8,
			"## no critic qw(" => 20,
			"\@{" => -8,
			"foreach my" => -8
		},
		GOTOS => {
			'STAR-3' => 21,
			'Critic' => 22
		}
	},
	{#State 18
		ACTIONS => {
			"use strict;" => 10
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
		ACTIONS => {
			'WORD' => 25
		},
		GOTOS => {
			'PLUS-11' => 26
		}
	},
	{#State 21
		ACTIONS => {
			'WORD_SCOPED' => -10,
			"use" => 29,
			'OP01_NAMED' => -10,
			'OP19_LOOP_CONTROL' => -10,
			"{" => -10,
			"for my integer" => -10,
			"[" => -10,
			'OP01_NAMED_VOID' => -10,
			"(" => -10,
			'OP03_MATH_INC_DEC' => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			"%{" => -10,
			"my" => -10,
			'VARIABLE_SYMBOL' => -10,
			"while (" => -10,
			"undef" => -10,
			'LITERAL_NUMBER' => -10,
			"\@{" => -10,
			"foreach my" => -10,
			'OP10_NAMED_UNARY' => -10,
			'OP22_LOGICAL_NOT' => -10,
			'LITERAL_STRING' => -10,
			'WORD' => -10,
			'OP05_LOGICAL_NEG' => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"our" => -10,
			'OP05_MATH_NEG' => -10,
			"use constant" => -10,
			"if (" => -10
		},
		GOTOS => {
			'Include' => 28,
			'STAR-4' => 27
		}
	},
	{#State 22
		DEFAULT => -5
	},
	{#State 23
		ACTIONS => {
			"## no critic qw(" => -19,
			"our" => -19,
			"use constant" => -19,
			"use" => -19,
			"use parent qw(" => 30
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
		DEFAULT => -29
	},
	{#State 26
		ACTIONS => {
			'WORD' => 34,
			")" => 33
		}
	},
	{#State 27
		ACTIONS => {
			"(" => -12,
			'OP03_MATH_INC_DEC' => -12,
			'OP01_NAMED' => -12,
			'OP19_LOOP_CONTROL' => -12,
			"{" => -12,
			'OP01_NAMED_VOID' => -12,
			"[" => -12,
			"for my integer" => -12,
			"undef" => -12,
			'VARIABLE_SYMBOL' => -12,
			'LITERAL_NUMBER' => -12,
			"while (" => -12,
			"%{" => -12,
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			"my" => -12,
			'WORD_SCOPED' => -12,
			"our" => -12,
			'OP05_LOGICAL_NEG' => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			'OP05_MATH_NEG' => -12,
			"use constant" => 35,
			'WORD' => -12,
			"if (" => -12,
			'OP10_NAMED_UNARY' => -12,
			"foreach my" => -12,
			"\@{" => -12,
			'LITERAL_STRING' => -12,
			'OP22_LOGICAL_NOT' => -12
		},
		GOTOS => {
			'STAR-5' => 36,
			'Constant' => 37
		}
	},
	{#State 28
		DEFAULT => -7
	},
	{#State 29
		ACTIONS => {
			'WORD_SCOPED' => 14,
			'WORD' => 12
		},
		GOTOS => {
			'WordScoped' => 38
		}
	},
	{#State 30
		ACTIONS => {
			'WORD_SCOPED' => 14,
			'WORD' => 12
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 31
		ACTIONS => {
			"use" => -21,
			"## no critic qw(" => 20,
			"our" => -21,
			"use constant" => -21
		},
		GOTOS => {
			'Critic' => 40,
			'STAR-8' => 41
		}
	},
	{#State 32
		DEFAULT => -27
	},
	{#State 33
		DEFAULT => -30
	},
	{#State 34
		DEFAULT => -28
	},
	{#State 35
		ACTIONS => {
			'WORD' => 42
		}
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"my" => 51,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"while (" => -159,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			"for my integer" => -159,
			'OP01_NAMED_VOID' => 43,
			"[" => 68,
			"{" => 44,
			'OP19_LOOP_CONTROL' => 47,
			'OP01_NAMED' => 69,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"foreach my" => -159,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			"if (" => 64,
			'WORD' => 58,
			'OP05_MATH_NEG' => 60,
			'OP01_NAMED_VOID_PAREN' => 62,
			"our" => 78,
			'OP05_LOGICAL_NEG' => 63
		},
		GOTOS => {
			'PAREN-49' => 79,
			'ArrayDereferenced' => 80,
			'OperatorVoid' => 81,
			'Conditional' => 59,
			'Expression' => 77,
			'Subroutine' => 61,
			'PLUS-6' => 83,
			'OPTIONAL-50' => 85,
			'HashReference' => 82,
			'VariableDeclaration' => 70,
			'ArrayReference' => 71,
			'Literal' => 55,
			'VariableModification' => 54,
			'Operation' => 45,
			'Operator' => 46,
			'HashDereferenced' => 48,
			'WordScoped' => 76,
			'LoopLabel' => 75,
			'Variable' => 56,
			'Statement' => 57
		}
	},
	{#State 37
		DEFAULT => -9
	},
	{#State 38
		ACTIONS => {
			"qw(" => 87,
			";" => 86
		}
	},
	{#State 39
		ACTIONS => {
			")" => 88
		}
	},
	{#State 40
		DEFAULT => -18
	},
	{#State 41
		ACTIONS => {
			"use" => 29,
			"our" => -23,
			"use constant" => -23
		},
		GOTOS => {
			'Include' => 90,
			'STAR-9' => 89
		}
	},
	{#State 42
		ACTIONS => {
			'OP20_HASH_FATARROW' => 91
		}
	},
	{#State 43
		ACTIONS => {
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'OP05_MATH_NEG' => 60,
			";" => -131,
			"{*" => 96,
			'OP05_LOGICAL_NEG' => 63,
			'WORD' => 12,
			'WORD_SCOPED' => 14,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			'KEYS_OR_VALUES' => 94,
			'VARIABLE_SYMBOL' => 53,
			"my" => 98,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"{" => 44,
			"[" => 68,
			'OP01_NAMED' => 69
		},
		GOTOS => {
			'TypeInner' => 92,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'ListElements' => 93,
			'Literal' => 55,
			'Operator' => 46,
			'Expression' => 95,
			'HashDereferenced' => 48,
			'WordScoped' => 76,
			'FileHandle' => 101,
			'Variable' => 99,
			'ListElement' => 97,
			'OPTIONAL-45' => 100,
			'HashReference' => 82
		}
	},
	{#State 44
		ACTIONS => {
			"}" => 103,
			"%{" => 72,
			'WORD' => 104
		},
		GOTOS => {
			'HashEntry' => 105,
			'HashDereferenced' => 102
		}
	},
	{#State 45
		DEFAULT => -14
	},
	{#State 46
		DEFAULT => -151
	},
	{#State 47
		ACTIONS => {
			'WORD' => 106
		},
		GOTOS => {
			'LoopLabel' => 107
		}
	},
	{#State 48
		DEFAULT => -149
	},
	{#State 49
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Variable' => 108
		}
	},
	{#State 50
		ACTIONS => {
			'WORD' => 12,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 82,
			'WordScoped' => 76,
			'Operator' => 46,
			'HashDereferenced' => 48,
			'Expression' => 109,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55
		}
	},
	{#State 51
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 111
		}
	},
	{#State 52
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12,
			'WORD_SCOPED' => 14,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 82,
			'WordScoped' => 76,
			'Operator' => 46,
			'HashDereferenced' => 48,
			'Expression' => 112,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'Literal' => 55
		}
	},
	{#State 53
		DEFAULT => -182,
		GOTOS => {
			'STAR-56' => 113
		}
	},
	{#State 54
		DEFAULT => -164
	},
	{#State 55
		DEFAULT => -144
	},
	{#State 56
		ACTIONS => {
			'OP08_STRING_CAT' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			";" => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 115,
			'OP15_LOGICAL_AND' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP04_MATH_POW' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP02_METHOD_THINARROW' => 117,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP03_MATH_INC_DEC' => 114,
			'OP19_VARIABLE_ASSIGN' => 116,
			'OP18_TERNARY' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP24_LOGICAL_OR_XOR' => -145
		}
	},
	{#State 57
		DEFAULT => -99
	},
	{#State 58
		ACTIONS => {
			"(" => -215,
			'COLON' => -221
		}
	},
	{#State 59
		DEFAULT => -160
	},
	{#State 60
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			'WORD_SCOPED' => 14,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65
		},
		GOTOS => {
			'WordScoped' => 76,
			'Variable' => 99,
			'HashReference' => 82,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'Literal' => 55,
			'Operator' => 46,
			'Expression' => 118,
			'HashDereferenced' => 48
		}
	},
	{#State 61
		DEFAULT => -11
	},
	{#State 62
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			")" => -127,
			'WORD' => 12,
			"{*" => 96,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD_SCOPED' => 14,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"my" => 98,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			'KEYS_OR_VALUES' => 94,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49
		},
		GOTOS => {
			'Expression' => 95,
			'HashDereferenced' => 48,
			'OPTIONAL-43' => 119,
			'Operator' => 46,
			'ListElements' => 121,
			'Literal' => 55,
			'TypeInner' => 92,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'HashReference' => 82,
			'Variable' => 99,
			'ListElement' => 97,
			'FileHandle' => 120,
			'WordScoped' => 76
		}
	},
	{#State 63
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'WordScoped' => 76,
			'Variable' => 99,
			'HashReference' => 82,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55,
			'Operator' => 46,
			'Expression' => 122,
			'HashDereferenced' => 48
		}
	},
	{#State 64
		ACTIONS => {
			'WORD' => 12,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 82,
			'WordScoped' => 76,
			'Operator' => 46,
			'Expression' => 123,
			'HashDereferenced' => 48,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55
		}
	},
	{#State 65
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			"[" => 68
		},
		GOTOS => {
			'ArrayReference' => 124,
			'Variable' => 125
		}
	},
	{#State 66
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'WordScoped' => 76,
			'HashReference' => 82,
			'Variable' => 99,
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Expression' => 126,
			'HashDereferenced' => 48,
			'Operator' => 46
		}
	},
	{#State 67
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 82,
			'WordScoped' => 76,
			'Operator' => 46,
			'HashDereferenced' => 48,
			'Expression' => 127,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55
		}
	},
	{#State 68
		ACTIONS => {
			'WORD' => 12,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			"my" => 130,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			'KEYS_OR_VALUES' => 94,
			"undef" => 74,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"]" => -199,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'HashDereferenced' => 48,
			'Expression' => 95,
			'Operator' => 46,
			'OPTIONAL-59' => 128,
			'Literal' => 55,
			'ListElements' => 129,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'TypeInner' => 92,
			'HashReference' => 82,
			'ListElement' => 97,
			'Variable' => 99,
			'WordScoped' => 76
		}
	},
	{#State 69
		ACTIONS => {
			"(" => 131
		}
	},
	{#State 70
		DEFAULT => -163
	},
	{#State 71
		DEFAULT => -146
	},
	{#State 72
		ACTIONS => {
			"{" => 134,
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'HashReference' => 132,
			'Variable' => 133
		}
	},
	{#State 73
		DEFAULT => -223
	},
	{#State 74
		DEFAULT => -143
	},
	{#State 75
		ACTIONS => {
			'COLON' => 135
		}
	},
	{#State 76
		ACTIONS => {
			"(" => 136
		}
	},
	{#State 77
		ACTIONS => {
			'OP06_REGEX_MATCH' => 153,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP15_LOGICAL_AND' => 146,
			";" => 137,
			'OP08_MATH_ADD_SUB' => 138,
			'OP16_LOGICAL_OR' => 149,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141
		}
	},
	{#State 78
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 154
		}
	},
	{#State 79
		DEFAULT => -158
	},
	{#State 80
		DEFAULT => -147
	},
	{#State 81
		DEFAULT => -162
	},
	{#State 82
		DEFAULT => -148
	},
	{#State 83
		ACTIONS => {
			"while (" => -159,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			"my" => 51,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"for my integer" => -159,
			"[" => 68,
			'OP01_NAMED_VOID' => 43,
			"{" => 44,
			'OP01_NAMED' => 69,
			'OP19_LOOP_CONTROL' => 47,
			'WORD_SCOPED' => 14,
			"if (" => 64,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'OP01_NAMED_VOID_PAREN' => 62,
			'WORD' => 58,
			'LITERAL_STRING' => 84,
			'' => -15,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"foreach my" => -159,
			"\@{" => 65
		},
		GOTOS => {
			'OPTIONAL-50' => 85,
			'HashReference' => 82,
			'PAREN-49' => 79,
			'ArrayDereferenced' => 80,
			'OperatorVoid' => 81,
			'Conditional' => 59,
			'Expression' => 77,
			'WordScoped' => 76,
			'Variable' => 56,
			'LoopLabel' => 75,
			'Statement' => 57,
			'VariableDeclaration' => 70,
			'ArrayReference' => 71,
			'VariableModification' => 54,
			'Literal' => 55,
			'Operation' => 155,
			'Operator' => 46,
			'HashDereferenced' => 48
		}
	},
	{#State 84
		DEFAULT => -222
	},
	{#State 85
		ACTIONS => {
			"while (" => 159,
			"foreach my" => 162,
			"for my integer" => 157
		},
		GOTOS => {
			'LoopWhile' => 158,
			'LoopFor' => 160,
			'Loop' => 156,
			'LoopForEach' => 161
		}
	},
	{#State 86
		DEFAULT => -33
	},
	{#State 87
		ACTIONS => {
			'WORD' => 163
		},
		GOTOS => {
			'PLUS-12' => 164
		}
	},
	{#State 88
		ACTIONS => {
			";" => 165
		}
	},
	{#State 89
		ACTIONS => {
			"use constant" => 35,
			"our" => 78
		},
		GOTOS => {
			'PLUS-10' => 167,
			'Constant' => 166,
			'Subroutine' => 168
		}
	},
	{#State 90
		DEFAULT => -20
	},
	{#State 91
		ACTIONS => {
			"my" => 130
		},
		GOTOS => {
			'TypeInner' => 169
		}
	},
	{#State 92
		ACTIONS => {
			'WORD_SCOPED' => 14,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12
		},
		GOTOS => {
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Expression' => 170,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'WordScoped' => 76,
			'HashReference' => 82,
			'Variable' => 99
		}
	},
	{#State 93
		DEFAULT => -130
	},
	{#State 94
		ACTIONS => {
			"%{" => 72
		},
		GOTOS => {
			'HashDereferenced' => 171
		}
	},
	{#State 95
		ACTIONS => {
			'OP08_STRING_CAT' => 140,
			";" => -195,
			'OP08_MATH_ADD_SUB' => 138,
			")" => -195,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP15_LOGICAL_AND' => 146,
			'OP23_LOGICAL_AND' => 147,
			'OP21_LIST_COMMA' => -195,
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP04_MATH_POW' => 148,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP06_REGEX_MATCH' => 153,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => 142,
			'OP13_BITWISE_AND' => 144,
			"]" => -195,
			'OP24_LOGICAL_OR_XOR' => 145
		}
	},
	{#State 96
		ACTIONS => {
			'WORD' => 172
		}
	},
	{#State 97
		DEFAULT => -193,
		GOTOS => {
			'STAR-58' => 173
		}
	},
	{#State 98
		ACTIONS => {
			"filehandle_ref" => 174,
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 175
		}
	},
	{#State 99
		ACTIONS => {
			'OP08_STRING_CAT' => -145,
			")" => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			";" => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP21_LIST_COMMA' => -145,
			'OP04_MATH_POW' => -145,
			'OP17_LIST_RANGE' => -145,
			".." => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP02_METHOD_THINARROW' => 117,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP18_TERNARY' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP03_MATH_INC_DEC' => 114,
			'OP13_BITWISE_AND' => -145,
			"}" => -145,
			"]" => -145,
			'OP24_LOGICAL_OR_XOR' => -145
		}
	},
	{#State 100
		ACTIONS => {
			";" => 176
		}
	},
	{#State 101
		ACTIONS => {
			'WORD' => 12,
			";" => -133,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			"my" => 130,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			"undef" => 74,
			'KEYS_OR_VALUES' => 94,
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 53,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'HashReference' => 82,
			'Variable' => 99,
			'ListElement' => 97,
			'WordScoped' => 76,
			'Expression' => 95,
			'HashDereferenced' => 48,
			'OPTIONAL-46' => 177,
			'Operator' => 46,
			'Literal' => 55,
			'ListElements' => 178,
			'TypeInner' => 92,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80
		}
	},
	{#State 102
		DEFAULT => -206
	},
	{#State 103
		DEFAULT => -150
	},
	{#State 104
		ACTIONS => {
			'OP20_HASH_FATARROW' => 179
		}
	},
	{#State 105
		DEFAULT => -211,
		GOTOS => {
			'STAR-62' => 180
		}
	},
	{#State 106
		DEFAULT => -221
	},
	{#State 107
		ACTIONS => {
			";" => 181
		}
	},
	{#State 108
		DEFAULT => -103
	},
	{#State 109
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => 142,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP06_REGEX_MATCH' => 153,
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP08_MATH_ADD_SUB' => 138,
			")" => 182,
			'OP15_LOGICAL_AND' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => 147,
			'OP08_STRING_CAT' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP04_MATH_POW' => 148,
			'OP16_LOGICAL_OR' => 149
		}
	},
	{#State 110
		DEFAULT => -220
	},
	{#State 111
		ACTIONS => {
			'VARIABLE_SYMBOL' => 183
		}
	},
	{#State 112
		ACTIONS => {
			'OP06_REGEX_MATCH' => 153,
			".." => -114,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP18_TERNARY' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP13_BITWISE_AND' => -114,
			"}" => -114,
			"]" => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP08_STRING_CAT' => 140,
			")" => -114,
			'OP12_COMPARE_EQ_NEQ' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP08_MATH_ADD_SUB' => 138,
			";" => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => -114
		}
	},
	{#State 113
		ACTIONS => {
			")" => -183,
			'OP19_VARIABLE_ASSIGN_BY' => -183,
			'OP23_LOGICAL_AND' => -183,
			'OP15_LOGICAL_AND' => -183,
			'OP12_COMPARE_EQ_NEQ' => -183,
			";" => -183,
			'OP08_MATH_ADD_SUB' => -183,
			'OP08_STRING_CAT' => -183,
			'OP04_MATH_POW' => -183,
			'OP02_ARRAY_THINARROW' => 185,
			'OP17_LIST_RANGE' => -183,
			'OP16_LOGICAL_OR' => -183,
			'OP21_LIST_COMMA' => -183,
			'OP02_HASH_THINARROW' => 186,
			'OP18_TERNARY' => -183,
			'OP14_BITWISE_OR_XOR' => -183,
			'OP03_MATH_INC_DEC' => -183,
			'OP19_VARIABLE_ASSIGN' => -183,
			'COLON' => -183,
			'OP06_REGEX_MATCH' => -183,
			".." => -183,
			'OP09_BITWISE_SHIFT' => -183,
			'OP11_COMPARE_LT_GT' => -183,
			'OP02_METHOD_THINARROW' => -183,
			'OP07_MATH_MULT_DIV_MOD' => -183,
			'OP13_BITWISE_AND' => -183,
			"}" => -183,
			"]" => -183,
			'OP24_LOGICAL_OR_XOR' => -183
		},
		GOTOS => {
			'VariableRetrieval' => 184
		}
	},
	{#State 114
		DEFAULT => -104
	},
	{#State 115
		ACTIONS => {
			'WORD_SCOPED' => 14,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12
		},
		GOTOS => {
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'Literal' => 55,
			'Operator' => 46,
			'Expression' => 187,
			'HashDereferenced' => 48,
			'WordScoped' => 76,
			'Variable' => 99,
			'HashReference' => 82
		}
	},
	{#State 116
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			'WORD_SCOPED' => 14,
			"<STDIN>" => 190
		},
		GOTOS => {
			'ExpressionOrStdin' => 189,
			'Expression' => 188,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'Literal' => 55,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'HashReference' => 82,
			'Variable' => 99,
			'WordScoped' => 76
		}
	},
	{#State 117
		ACTIONS => {
			'WORD' => 191
		}
	},
	{#State 118
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 138,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			")" => 192,
			'OP08_STRING_CAT' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP04_MATH_POW' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP06_REGEX_MATCH' => 153,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP13_BITWISE_AND' => 144
		}
	},
	{#State 119
		ACTIONS => {
			")" => 193
		}
	},
	{#State 120
		ACTIONS => {
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			"my" => 130,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			'KEYS_OR_VALUES' => 94,
			'WORD_SCOPED' => 14,
			")" => -129,
			'WORD' => 12,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84
		},
		GOTOS => {
			'Variable' => 99,
			'ListElement' => 97,
			'HashReference' => 82,
			'WordScoped' => 76,
			'Operator' => 46,
			'Expression' => 95,
			'OPTIONAL-44' => 195,
			'HashDereferenced' => 48,
			'TypeInner' => 92,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55,
			'ListElements' => 194
		}
	},
	{#State 121
		DEFAULT => -126
	},
	{#State 122
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP06_REGEX_MATCH' => -106,
			".." => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP18_TERNARY' => -106,
			'OP13_BITWISE_AND' => -106,
			"]" => -106,
			"}" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_STRING_CAT' => -106,
			";" => -106,
			'OP08_MATH_ADD_SUB' => -106,
			")" => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP04_MATH_POW' => 148
		}
	},
	{#State 123
		ACTIONS => {
			")" => 196,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 140,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP16_LOGICAL_OR' => 149,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP06_REGEX_MATCH' => 153,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 145
		}
	},
	{#State 124
		ACTIONS => {
			"}" => 197
		}
	},
	{#State 125
		ACTIONS => {
			"}" => 198
		}
	},
	{#State 126
		ACTIONS => {
			".." => -113,
			'OP06_REGEX_MATCH' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP11_COMPARE_LT_GT' => -113,
			'OP09_BITWISE_SHIFT' => 151,
			'OP18_TERNARY' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			"}" => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			"]" => -113,
			'OP13_BITWISE_AND' => -113,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP12_COMPARE_EQ_NEQ' => -113,
			")" => -113,
			";" => -113,
			'OP08_MATH_ADD_SUB' => 138,
			'OP16_LOGICAL_OR' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => -113
		}
	},
	{#State 127
		ACTIONS => {
			".." => -123,
			'OP06_REGEX_MATCH' => 153,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP13_BITWISE_AND' => 144,
			"}" => -123,
			'OP24_LOGICAL_OR_XOR' => -123,
			"]" => -123,
			'OP08_STRING_CAT' => 140,
			")" => -123,
			'OP15_LOGICAL_AND' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => -123,
			";" => -123,
			'OP08_MATH_ADD_SUB' => 138,
			'OP16_LOGICAL_OR' => 149,
			'OP21_LIST_COMMA' => -123,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141
		}
	},
	{#State 128
		ACTIONS => {
			"]" => 199
		}
	},
	{#State 129
		DEFAULT => -198
	},
	{#State 130
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 175
		}
	},
	{#State 131
		ACTIONS => {
			"{" => 44,
			"[" => 68,
			'OP01_NAMED' => 69,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"my" => 130,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'KEYS_OR_VALUES' => 94,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			'WORD_SCOPED' => 14,
			")" => -101,
			'WORD' => 12,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84
		},
		GOTOS => {
			'Operator' => 46,
			'HashDereferenced' => 48,
			'Expression' => 95,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'TypeInner' => 92,
			'OPTIONAL-42' => 200,
			'Literal' => 55,
			'ListElements' => 201,
			'ListElement' => 97,
			'Variable' => 99,
			'HashReference' => 82,
			'WordScoped' => 76
		}
	},
	{#State 132
		ACTIONS => {
			"}" => 202
		}
	},
	{#State 133
		ACTIONS => {
			"}" => 203
		}
	},
	{#State 134
		ACTIONS => {
			'WORD' => 104,
			"%{" => 72
		},
		GOTOS => {
			'HashEntry' => 105,
			'HashDereferenced' => 102
		}
	},
	{#State 135
		DEFAULT => -157
	},
	{#State 136
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"my" => 130,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'LITERAL_NUMBER' => 73,
			'KEYS_OR_VALUES' => 94,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			")" => -140,
			'WORD' => 12,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63
		},
		GOTOS => {
			'OPTIONAL-47' => 204,
			'WordScoped' => 76,
			'HashReference' => 82,
			'ListElement' => 97,
			'Variable' => 99,
			'ListElements' => 205,
			'Literal' => 55,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'TypeInner' => 92,
			'HashDereferenced' => 48,
			'Expression' => 95,
			'Operator' => 46
		}
	},
	{#State 137
		DEFAULT => -98
	},
	{#State 138
		ACTIONS => {
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'WORD' => 12,
			'WORD_SCOPED' => 14,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"{" => 44,
			"[" => 68,
			'OP01_NAMED' => 69
		},
		GOTOS => {
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'Literal' => 55,
			'Operator' => 46,
			'Expression' => 206,
			'HashDereferenced' => 48,
			'WordScoped' => 76,
			'Variable' => 99,
			'HashReference' => 82
		}
	},
	{#State 139
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'WORD_SCOPED' => 14,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'WORD' => 12,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 82,
			'WordScoped' => 76,
			'Operator' => 46,
			'HashDereferenced' => 48,
			'Expression' => 207,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55
		}
	},
	{#State 140
		ACTIONS => {
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'WORD' => 12,
			'WORD_SCOPED' => 14,
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"{" => 44,
			"[" => 68,
			'OP01_NAMED' => 69
		},
		GOTOS => {
			'HashReference' => 82,
			'Variable' => 99,
			'WordScoped' => 76,
			'Expression' => 208,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'Literal' => 55,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71
		}
	},
	{#State 141
		ACTIONS => {
			'WORD_SCOPED' => 14,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			"{" => 44,
			"[" => 68,
			'OP01_NAMED' => 69,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'WORD' => 12
		},
		GOTOS => {
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'HashDereferenced' => 48,
			'Expression' => 209,
			'Operator' => 46,
			'WordScoped' => 76,
			'HashReference' => 82,
			'Variable' => 99
		}
	},
	{#State 142
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Variable' => 210
		}
	},
	{#State 143
		ACTIONS => {
			'WORD' => 12,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'Literal' => 55,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'Expression' => 211,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'WordScoped' => 76,
			'HashReference' => 82,
			'Variable' => 99
		}
	},
	{#State 144
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12
		},
		GOTOS => {
			'Literal' => 55,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'Expression' => 212,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'WordScoped' => 76,
			'HashReference' => 82,
			'Variable' => 99
		}
	},
	{#State 145
		ACTIONS => {
			'WORD' => 12,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'HashReference' => 82,
			'Variable' => 99,
			'WordScoped' => 76,
			'Expression' => 213,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80
		}
	},
	{#State 146
		ACTIONS => {
			'WORD' => 12,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 82,
			'WordScoped' => 76,
			'Operator' => 46,
			'Expression' => 214,
			'HashDereferenced' => 48,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55
		}
	},
	{#State 147
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12
		},
		GOTOS => {
			'WordScoped' => 76,
			'Variable' => 99,
			'HashReference' => 82,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'Literal' => 55,
			'Operator' => 46,
			'Expression' => 215,
			'HashDereferenced' => 48
		}
	},
	{#State 148
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'WORD' => 12
		},
		GOTOS => {
			'Expression' => 216,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'Literal' => 55,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'HashReference' => 82,
			'Variable' => 99,
			'WordScoped' => 76
		}
	},
	{#State 149
		ACTIONS => {
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			'WORD' => 12,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD_SCOPED' => 14,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"undef" => 74
		},
		GOTOS => {
			'HashReference' => 82,
			'Variable' => 99,
			'WordScoped' => 76,
			'HashDereferenced' => 48,
			'Expression' => 217,
			'Operator' => 46,
			'Literal' => 55,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71
		}
	},
	{#State 150
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'Variable' => 99,
			'HashReference' => 82,
			'WordScoped' => 76,
			'Operator' => 46,
			'Expression' => 218,
			'HashDereferenced' => 48,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55
		}
	},
	{#State 151
		ACTIONS => {
			'WORD' => 12,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'WordScoped' => 76,
			'HashReference' => 82,
			'Variable' => 99,
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'HashDereferenced' => 48,
			'Expression' => 219,
			'Operator' => 46
		}
	},
	{#State 152
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'WordScoped' => 76,
			'HashReference' => 82,
			'Variable' => 99,
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'HashDereferenced' => 48,
			'Expression' => 220,
			'Operator' => 46
		}
	},
	{#State 153
		ACTIONS => {
			"/" => 221
		}
	},
	{#State 154
		ACTIONS => {
			'VARIABLE_SYMBOL' => 222
		}
	},
	{#State 155
		DEFAULT => -13
	},
	{#State 156
		DEFAULT => -161
	},
	{#State 157
		ACTIONS => {
			'VARIABLE_SYMBOL' => 223
		}
	},
	{#State 158
		DEFAULT => -174
	},
	{#State 159
		ACTIONS => {
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'WORD_SCOPED' => 14,
			'WORD' => 12,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'WordScoped' => 76,
			'Variable' => 99,
			'HashReference' => 82,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55,
			'Operator' => 46,
			'Expression' => 224,
			'HashDereferenced' => 48
		}
	},
	{#State 160
		DEFAULT => -172
	},
	{#State 161
		DEFAULT => -173
	},
	{#State 162
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 225
		}
	},
	{#State 163
		DEFAULT => -32
	},
	{#State 164
		ACTIONS => {
			")" => 226,
			'WORD' => 227
		}
	},
	{#State 165
		ACTIONS => {
			"use" => 29
		},
		GOTOS => {
			'Include' => 228
		}
	},
	{#State 166
		DEFAULT => -22
	},
	{#State 167
		ACTIONS => {
			"1;" => 229,
			"our" => 78
		},
		GOTOS => {
			'Subroutine' => 230
		}
	},
	{#State 168
		DEFAULT => -25
	},
	{#State 169
		ACTIONS => {
			'LITERAL_STRING' => 84,
			'LITERAL_NUMBER' => 73,
			"[" => 231,
			"{" => 232
		},
		GOTOS => {
			'ConstantValue' => 233,
			'Literal' => 234
		}
	},
	{#State 170
		ACTIONS => {
			'OP21_LIST_COMMA' => -196,
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP04_MATH_POW' => 148,
			'OP08_STRING_CAT' => 140,
			'OP08_MATH_ADD_SUB' => 138,
			";" => -196,
			")" => -196,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP15_LOGICAL_AND' => 146,
			'OP23_LOGICAL_AND' => 147,
			'OP13_BITWISE_AND' => 144,
			"]" => -196,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP06_REGEX_MATCH' => 153,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => 142
		}
	},
	{#State 171
		DEFAULT => -197
	},
	{#State 172
		ACTIONS => {
			"}" => 235
		}
	},
	{#State 173
		ACTIONS => {
			";" => -194,
			")" => -194,
			'OP21_LIST_COMMA' => 237,
			"]" => -194
		},
		GOTOS => {
			'PAREN-57' => 236
		}
	},
	{#State 174
		ACTIONS => {
			'VARIABLE_SYMBOL' => 238
		}
	},
	{#State 175
		ACTIONS => {
			"\$TYPED_" => 239
		}
	},
	{#State 176
		DEFAULT => -136
	},
	{#State 177
		ACTIONS => {
			";" => 240
		}
	},
	{#State 178
		DEFAULT => -132
	},
	{#State 179
		ACTIONS => {
			'OP01_NAMED' => -204,
			"{" => -204,
			"[" => -204,
			'OP03_MATH_INC_DEC' => -204,
			"(" => -204,
			'OP10_NAMED_UNARY_STRINGIFY' => -204,
			"%{" => -204,
			"my" => 130,
			'VARIABLE_SYMBOL' => -204,
			"undef" => -204,
			'LITERAL_NUMBER' => -204,
			'WORD_SCOPED' => -204,
			'WORD' => -204,
			'OP05_LOGICAL_NEG' => -204,
			'OP05_MATH_NEG' => -204,
			"\@{" => -204,
			'OP10_NAMED_UNARY' => -204,
			'OP22_LOGICAL_NOT' => -204,
			'LITERAL_STRING' => -204
		},
		GOTOS => {
			'TypeInner' => 241,
			'OPTIONAL-60' => 242
		}
	},
	{#State 180
		ACTIONS => {
			"}" => 245,
			'OP21_LIST_COMMA' => 243
		},
		GOTOS => {
			'PAREN-61' => 244
		}
	},
	{#State 181
		DEFAULT => -138
	},
	{#State 182
		DEFAULT => -154
	},
	{#State 183
		ACTIONS => {
			";" => 246,
			'OP19_VARIABLE_ASSIGN' => 247
		}
	},
	{#State 184
		DEFAULT => -181
	},
	{#State 185
		ACTIONS => {
			'WORD_SCOPED' => 14,
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12
		},
		GOTOS => {
			'HashReference' => 82,
			'Variable' => 99,
			'WordScoped' => 76,
			'HashDereferenced' => 48,
			'Expression' => 248,
			'Operator' => 46,
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80
		}
	},
	{#State 186
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			'OP01_NAMED' => 69,
			"[" => 68,
			"{" => 44,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'WORD' => 250,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60
		},
		GOTOS => {
			'Operator' => 46,
			'HashDereferenced' => 48,
			'Expression' => 249,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55,
			'Variable' => 99,
			'HashReference' => 82,
			'WordScoped' => 76
		}
	},
	{#State 187
		ACTIONS => {
			'OP15_LOGICAL_AND' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => 147,
			'OP08_MATH_ADD_SUB' => 138,
			";" => 251,
			'OP08_STRING_CAT' => 140,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP16_LOGICAL_OR' => 149,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP06_REGEX_MATCH' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP13_BITWISE_AND' => 144
		}
	},
	{#State 188
		ACTIONS => {
			'OP06_REGEX_MATCH' => 153,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			";" => -155,
			'OP08_MATH_ADD_SUB' => 138,
			'OP16_LOGICAL_OR' => 149,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141
		}
	},
	{#State 189
		ACTIONS => {
			";" => 252
		}
	},
	{#State 190
		DEFAULT => -156
	},
	{#State 191
		ACTIONS => {
			"(" => 253
		}
	},
	{#State 192
		DEFAULT => -107
	},
	{#State 193
		ACTIONS => {
			";" => 254
		}
	},
	{#State 194
		DEFAULT => -128
	},
	{#State 195
		ACTIONS => {
			")" => 255
		}
	},
	{#State 196
		ACTIONS => {
			"{" => 256
		},
		GOTOS => {
			'CodeBlock' => 257
		}
	},
	{#State 197
		DEFAULT => -202
	},
	{#State 198
		DEFAULT => -201
	},
	{#State 199
		DEFAULT => -200
	},
	{#State 200
		ACTIONS => {
			")" => 258
		}
	},
	{#State 201
		DEFAULT => -100
	},
	{#State 202
		DEFAULT => -214
	},
	{#State 203
		DEFAULT => -213
	},
	{#State 204
		ACTIONS => {
			")" => 259
		}
	},
	{#State 205
		DEFAULT => -139
	},
	{#State 206
		ACTIONS => {
			'OP13_BITWISE_AND' => -110,
			"]" => -110,
			"}" => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP06_REGEX_MATCH' => 153,
			".." => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP18_TERNARY' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP17_LIST_RANGE' => -110,
			'OP04_MATH_POW' => 148,
			'OP08_STRING_CAT' => -110,
			";" => -110,
			'OP08_MATH_ADD_SUB' => -110,
			")" => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP23_LOGICAL_AND' => -110
		}
	},
	{#State 207
		ACTIONS => {
			'OP13_BITWISE_AND' => -116,
			"}" => -116,
			"]" => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP18_TERNARY' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			".." => -116,
			'OP06_REGEX_MATCH' => 153,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP21_LIST_COMMA' => -116,
			")" => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP15_LOGICAL_AND' => -116,
			";" => -116,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 140
		}
	},
	{#State 208
		ACTIONS => {
			'OP08_STRING_CAT' => -111,
			";" => -111,
			'OP08_MATH_ADD_SUB' => 138,
			'OP23_LOGICAL_AND' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP15_LOGICAL_AND' => -111,
			")" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP04_MATH_POW' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP09_BITWISE_SHIFT' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP06_REGEX_MATCH' => 153,
			".." => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP18_TERNARY' => -111,
			"]" => -111,
			"}" => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP13_BITWISE_AND' => -111
		}
	},
	{#State 209
		ACTIONS => {
			'OP21_LIST_COMMA' => -121,
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => undef,
			'OP04_MATH_POW' => 148,
			'OP08_STRING_CAT' => 140,
			";" => -121,
			'OP08_MATH_ADD_SUB' => 138,
			")" => -121,
			'OP23_LOGICAL_AND' => -121,
			'OP15_LOGICAL_AND' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => -121,
			"}" => -121,
			"]" => -121,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			".." => -121,
			'OP06_REGEX_MATCH' => 153,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => -121
		}
	},
	{#State 210
		ACTIONS => {
			'COLON' => 260
		}
	},
	{#State 211
		ACTIONS => {
			";" => -109,
			'OP08_MATH_ADD_SUB' => -109,
			")" => -109,
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP08_STRING_CAT' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP18_TERNARY' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP06_REGEX_MATCH' => 153,
			".." => -109,
			'OP13_BITWISE_AND' => -109,
			"]" => -109,
			"}" => -109,
			'OP24_LOGICAL_OR_XOR' => -109
		}
	},
	{#State 212
		ACTIONS => {
			")" => -117,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => -117,
			'OP15_LOGICAL_AND' => -117,
			";" => -117,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 140,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP21_LIST_COMMA' => -117,
			'OP18_TERNARY' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP06_REGEX_MATCH' => 153,
			".." => -117,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP13_BITWISE_AND' => -117,
			"}" => -117,
			"]" => -117,
			'OP24_LOGICAL_OR_XOR' => -117
		}
	},
	{#State 213
		ACTIONS => {
			")" => -125,
			'OP15_LOGICAL_AND' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => 147,
			'OP08_MATH_ADD_SUB' => 138,
			";" => -125,
			'OP08_STRING_CAT' => 140,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP16_LOGICAL_OR' => 149,
			'OP21_LIST_COMMA' => -125,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150,
			".." => -125,
			'OP06_REGEX_MATCH' => 153,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP13_BITWISE_AND' => 144,
			"}" => -125,
			'OP24_LOGICAL_OR_XOR' => -125,
			"]" => -125
		}
	},
	{#State 214
		ACTIONS => {
			";" => -119,
			'OP08_MATH_ADD_SUB' => 138,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP15_LOGICAL_AND' => -119,
			'OP23_LOGICAL_AND' => -119,
			")" => -119,
			'OP08_STRING_CAT' => 140,
			'OP17_LIST_RANGE' => -119,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -119,
			'OP16_LOGICAL_OR' => -119,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			".." => -119,
			'OP06_REGEX_MATCH' => 153,
			"]" => -119,
			"}" => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP13_BITWISE_AND' => 144
		}
	},
	{#State 215
		ACTIONS => {
			'OP17_LIST_RANGE' => 141,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -124,
			'OP16_LOGICAL_OR' => 149,
			";" => -124,
			'OP08_MATH_ADD_SUB' => 138,
			")" => -124,
			'OP15_LOGICAL_AND' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => -124,
			'OP08_STRING_CAT' => 140,
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => -124,
			"}" => -124,
			"]" => -124,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => 142,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			".." => -124,
			'OP06_REGEX_MATCH' => 153
		}
	},
	{#State 216
		ACTIONS => {
			'OP18_TERNARY' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			".." => -105,
			'OP06_REGEX_MATCH' => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			"}" => -105,
			"]" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP23_LOGICAL_AND' => -105,
			")" => -105,
			'OP08_MATH_ADD_SUB' => -105,
			";" => -105,
			'OP08_STRING_CAT' => -105,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP21_LIST_COMMA' => -105
		}
	},
	{#State 217
		ACTIONS => {
			'OP13_BITWISE_AND' => 144,
			"]" => -120,
			"}" => -120,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => -120,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP06_REGEX_MATCH' => 153,
			".." => -120,
			'OP17_LIST_RANGE' => -120,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP08_MATH_ADD_SUB' => 138,
			";" => -120,
			")" => -120,
			'OP23_LOGICAL_AND' => -120,
			'OP15_LOGICAL_AND' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP08_STRING_CAT' => 140
		}
	},
	{#State 218
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 138,
			";" => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP12_COMPARE_EQ_NEQ' => 139,
			")" => -118,
			'OP08_STRING_CAT' => 140,
			'OP17_LIST_RANGE' => -118,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP18_TERNARY' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 151,
			'OP06_REGEX_MATCH' => 153,
			".." => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			"}" => -118,
			"]" => -118,
			'OP13_BITWISE_AND' => 144
		}
	},
	{#State 219
		ACTIONS => {
			'OP06_REGEX_MATCH' => 153,
			".." => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP18_TERNARY' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP13_BITWISE_AND' => -112,
			"}" => -112,
			"]" => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP08_STRING_CAT' => 140,
			")" => -112,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP08_MATH_ADD_SUB' => 138,
			";" => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => -112
		}
	},
	{#State 220
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 138,
			";" => -115,
			")" => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP12_COMPARE_EQ_NEQ' => -115,
			'OP08_STRING_CAT' => 140,
			'OP17_LIST_RANGE' => -115,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP18_TERNARY' => -115,
			'OP11_COMPARE_LT_GT' => undef,
			'OP09_BITWISE_SHIFT' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP06_REGEX_MATCH' => 153,
			".." => -115,
			'OP13_BITWISE_AND' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			"}" => -115,
			"]" => -115
		}
	},
	{#State 221
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 261
		}
	},
	{#State 222
		ACTIONS => {
			"= sub {" => 262
		}
	},
	{#State 223
		ACTIONS => {
			"(" => 263
		}
	},
	{#State 224
		ACTIONS => {
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => 142,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP06_REGEX_MATCH' => 153,
			'OP17_LIST_RANGE' => 141,
			'OP04_MATH_POW' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP08_MATH_ADD_SUB' => 138,
			")" => 264,
			'OP15_LOGICAL_AND' => 146,
			'OP23_LOGICAL_AND' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP08_STRING_CAT' => 140
		}
	},
	{#State 225
		ACTIONS => {
			'VARIABLE_SYMBOL' => 265
		}
	},
	{#State 226
		ACTIONS => {
			";" => 266
		}
	},
	{#State 227
		DEFAULT => -31
	},
	{#State 228
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 267
		}
	},
	{#State 229
		ACTIONS => {
			"1;" => 268
		}
	},
	{#State 230
		DEFAULT => -24
	},
	{#State 231
		ACTIONS => {
			"my" => 130,
			'LITERAL_NUMBER' => -37,
			'LITERAL_STRING' => -37
		},
		GOTOS => {
			'OPTIONAL-13' => 269,
			'TypeInner' => 270
		}
	},
	{#State 232
		ACTIONS => {
			'WORD' => 271
		}
	},
	{#State 233
		ACTIONS => {
			";" => 272
		}
	},
	{#State 234
		DEFAULT => -50
	},
	{#State 235
		DEFAULT => -217
	},
	{#State 236
		DEFAULT => -192
	},
	{#State 237
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'WORD' => 12,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'WORD_SCOPED' => 14,
			"my" => 130,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			'LITERAL_NUMBER' => 73,
			'KEYS_OR_VALUES' => 94,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50
		},
		GOTOS => {
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'TypeInner' => 92,
			'HashDereferenced' => 48,
			'Expression' => 95,
			'Operator' => 46,
			'WordScoped' => 76,
			'HashReference' => 82,
			'ListElement' => 273,
			'Variable' => 99
		}
	},
	{#State 238
		DEFAULT => -218
	},
	{#State 239
		ACTIONS => {
			'WORD' => 274
		}
	},
	{#State 240
		DEFAULT => -137
	},
	{#State 241
		DEFAULT => -203
	},
	{#State 242
		ACTIONS => {
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'WORD_SCOPED' => 14,
			'WORD' => 12,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'Operator' => 46,
			'Expression' => 275,
			'HashDereferenced' => 48,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55,
			'Variable' => 99,
			'HashReference' => 82,
			'WordScoped' => 76
		}
	},
	{#State 243
		ACTIONS => {
			"%{" => 72,
			'WORD' => 104
		},
		GOTOS => {
			'HashDereferenced' => 102,
			'HashEntry' => 276
		}
	},
	{#State 244
		DEFAULT => -210
	},
	{#State 245
		DEFAULT => -212
	},
	{#State 246
		DEFAULT => -187
	},
	{#State 247
		ACTIONS => {
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12,
			'WORD_SCOPED' => 14,
			"<STDIN>" => 190,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68
		},
		GOTOS => {
			'WordScoped' => 76,
			'Variable' => 99,
			'HashReference' => 82,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55,
			'Operator' => 46,
			'Expression' => 188,
			'ExpressionOrStdin' => 277,
			'HashDereferenced' => 48
		}
	},
	{#State 248
		ACTIONS => {
			'OP23_LOGICAL_AND' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 140,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP16_LOGICAL_OR' => 149,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP06_REGEX_MATCH' => 153,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 145,
			"]" => 278
		}
	},
	{#State 249
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP06_REGEX_MATCH' => 153,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => 142,
			'OP24_LOGICAL_OR_XOR' => 145,
			"}" => 279,
			'OP13_BITWISE_AND' => 144,
			'OP08_STRING_CAT' => 140,
			'OP08_MATH_ADD_SUB' => 138,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP04_MATH_POW' => 148
		}
	},
	{#State 250
		ACTIONS => {
			"(" => -215,
			"}" => 280
		}
	},
	{#State 251
		DEFAULT => -190
	},
	{#State 252
		DEFAULT => -189
	},
	{#State 253
		ACTIONS => {
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12,
			")" => -142,
			'WORD_SCOPED' => 14,
			'KEYS_OR_VALUES' => 94,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			"my" => 130,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68
		},
		GOTOS => {
			'Operator' => 46,
			'Expression' => 95,
			'HashDereferenced' => 48,
			'TypeInner' => 92,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55,
			'ListElements' => 282,
			'Variable' => 99,
			'ListElement' => 97,
			'OPTIONAL-48' => 281,
			'HashReference' => 82,
			'WordScoped' => 76
		}
	},
	{#State 254
		DEFAULT => -134
	},
	{#State 255
		ACTIONS => {
			";" => 283
		}
	},
	{#State 256
		ACTIONS => {
			'WORD_SCOPED' => 14,
			'OP19_LOOP_CONTROL' => 47,
			'OP01_NAMED' => 69,
			"for my integer" => -159,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED_VOID' => 43,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			"my" => 51,
			"undef" => 74,
			"while (" => -159,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"foreach my" => -159,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			'WORD' => 58,
			'OP01_NAMED_VOID_PAREN' => 62,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			"if (" => 64
		},
		GOTOS => {
			'Expression' => 77,
			'PLUS-55' => 285,
			'Conditional' => 59,
			'OperatorVoid' => 81,
			'ArrayDereferenced' => 80,
			'PAREN-49' => 79,
			'HashReference' => 82,
			'OPTIONAL-50' => 85,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'Operation' => 284,
			'Literal' => 55,
			'VariableModification' => 54,
			'ArrayReference' => 71,
			'VariableDeclaration' => 70,
			'Statement' => 57,
			'Variable' => 56,
			'LoopLabel' => 75,
			'WordScoped' => 76
		}
	},
	{#State 257
		DEFAULT => -167,
		GOTOS => {
			'STAR-52' => 286
		}
	},
	{#State 258
		DEFAULT => -102
	},
	{#State 259
		DEFAULT => -152
	},
	{#State 260
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Variable' => 287
		}
	},
	{#State 261
		ACTIONS => {
			"/" => 288
		}
	},
	{#State 262
		ACTIONS => {
			'WORD' => -54,
			'OP01_NAMED_VOID_PAREN' => -54,
			'OP05_LOGICAL_NEG' => -54,
			'OP05_MATH_NEG' => -54,
			"if (" => -54,
			"foreach my" => -54,
			"\@{" => -54,
			'OP10_NAMED_UNARY' => -54,
			'OP22_LOGICAL_NOT' => -54,
			'LITERAL_STRING' => -54,
			'OP19_LOOP_CONTROL' => -54,
			'OP01_NAMED' => -54,
			"for my integer" => -54,
			"{" => -54,
			"[" => -54,
			'OP01_NAMED_VOID' => -54,
			'OP03_MATH_INC_DEC' => -54,
			"(" => -54,
			"%{" => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			"my" => -54,
			'VARIABLE_SYMBOL' => -54,
			"while (" => -54,
			"undef" => -54,
			'LITERAL_NUMBER' => -54,
			'WORD_SCOPED' => -54,
			"( my" => 291
		},
		GOTOS => {
			'OPTIONAL-21' => 289,
			'SubroutineArguments' => 290
		}
	},
	{#State 263
		ACTIONS => {
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'WORD' => 12,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			"{" => 44,
			"[" => 68,
			'OP01_NAMED' => 69,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'Expression' => 292,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'Literal' => 55,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'HashReference' => 82,
			'Variable' => 99,
			'WordScoped' => 76
		}
	},
	{#State 264
		ACTIONS => {
			"{" => 256
		},
		GOTOS => {
			'CodeBlock' => 293
		}
	},
	{#State 265
		ACTIONS => {
			"(" => 294
		}
	},
	{#State 266
		DEFAULT => -34
	},
	{#State 267
		ACTIONS => {
			"use" => -71,
			"## no critic qw(" => 20,
			"our %properties = (" => -71,
			"use constant" => -71
		},
		GOTOS => {
			'STAR-29' => 295,
			'Critic' => 296
		}
	},
	{#State 268
		DEFAULT => -26
	},
	{#State 269
		ACTIONS => {
			'LITERAL_NUMBER' => 73,
			'LITERAL_STRING' => 84
		},
		GOTOS => {
			'Literal' => 297
		}
	},
	{#State 270
		DEFAULT => -36
	},
	{#State 271
		ACTIONS => {
			'OP20_HASH_FATARROW' => 298
		}
	},
	{#State 272
		DEFAULT => -35
	},
	{#State 273
		DEFAULT => -191
	},
	{#State 274
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 275
		ACTIONS => {
			'OP16_LOGICAL_OR' => 149,
			'OP21_LIST_COMMA' => -205,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 138,
			'OP13_BITWISE_AND' => 144,
			"}" => -205,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP06_REGEX_MATCH' => 153,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150
		}
	},
	{#State 276
		DEFAULT => -209
	},
	{#State 277
		ACTIONS => {
			";" => 300
		}
	},
	{#State 278
		DEFAULT => -184
	},
	{#State 279
		DEFAULT => -185
	},
	{#State 280
		DEFAULT => -186
	},
	{#State 281
		ACTIONS => {
			")" => 301
		}
	},
	{#State 282
		DEFAULT => -141
	},
	{#State 283
		DEFAULT => -135
	},
	{#State 284
		DEFAULT => -179
	},
	{#State 285
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"}" => 303,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'OP19_LOOP_CONTROL' => 47,
			'OP01_NAMED' => 69,
			"for my integer" => -159,
			'OP01_NAMED_VOID' => 43,
			"[" => 68,
			"{" => 44,
			"while (" => -159,
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"my" => 51,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			"foreach my" => -159,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP01_NAMED_VOID_PAREN' => 62,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 58,
			"if (" => 64
		},
		GOTOS => {
			'WordScoped' => 76,
			'LoopLabel' => 75,
			'Variable' => 56,
			'Statement' => 57,
			'VariableDeclaration' => 70,
			'ArrayReference' => 71,
			'Literal' => 55,
			'VariableModification' => 54,
			'Operation' => 302,
			'Operator' => 46,
			'HashDereferenced' => 48,
			'OPTIONAL-50' => 85,
			'HashReference' => 82,
			'PAREN-49' => 79,
			'ArrayDereferenced' => 80,
			'OperatorVoid' => 81,
			'Conditional' => 59,
			'Expression' => 77
		}
	},
	{#State 286
		ACTIONS => {
			"if (" => -170,
			'WORD' => -170,
			'OP01_NAMED_VOID_PAREN' => -170,
			'OP05_LOGICAL_NEG' => -170,
			'OP05_MATH_NEG' => -170,
			'OP22_LOGICAL_NOT' => -170,
			'LITERAL_STRING' => -170,
			'' => -170,
			"foreach my" => -170,
			"\@{" => -170,
			"elsif (" => 304,
			'OP10_NAMED_UNARY' => -170,
			"%{" => -170,
			'OP10_NAMED_UNARY_STRINGIFY' => -170,
			"my" => -170,
			"undef" => -170,
			'VARIABLE_SYMBOL' => -170,
			"while (" => -170,
			'LITERAL_NUMBER' => -170,
			'OP01_NAMED' => -170,
			'OP19_LOOP_CONTROL' => -170,
			"{" => -170,
			'OP01_NAMED_VOID' => -170,
			"[" => -170,
			"for my integer" => -170,
			"(" => -170,
			'OP03_MATH_INC_DEC' => -170,
			"}" => -170,
			"else" => 306,
			'WORD_SCOPED' => -170
		},
		GOTOS => {
			'PAREN-53' => 305,
			'PAREN-51' => 308,
			'OPTIONAL-54' => 307
		}
	},
	{#State 287
		DEFAULT => -122
	},
	{#State 288
		DEFAULT => -108
	},
	{#State 289
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"my" => 51,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"while (" => -159,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'OP01_NAMED_VOID' => 43,
			"for my integer" => -159,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			'OP19_LOOP_CONTROL' => 47,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"foreach my" => -159,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			"if (" => 64,
			'WORD' => 58,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'OP01_NAMED_VOID_PAREN' => 62
		},
		GOTOS => {
			'OperatorVoid' => 81,
			'PAREN-49' => 79,
			'ArrayDereferenced' => 80,
			'Expression' => 77,
			'Conditional' => 59,
			'OPTIONAL-50' => 85,
			'HashReference' => 82,
			'Literal' => 55,
			'VariableModification' => 54,
			'VariableDeclaration' => 70,
			'ArrayReference' => 71,
			'PLUS-22' => 310,
			'HashDereferenced' => 48,
			'Operation' => 309,
			'Operator' => 46,
			'WordScoped' => 76,
			'Statement' => 57,
			'LoopLabel' => 75,
			'Variable' => 56
		}
	},
	{#State 290
		DEFAULT => -53
	},
	{#State 291
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 311
		}
	},
	{#State 292
		ACTIONS => {
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP06_REGEX_MATCH' => 153,
			".." => 312,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => 142,
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP04_MATH_POW' => 148,
			'OP08_STRING_CAT' => 140,
			'OP08_MATH_ADD_SUB' => 138,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146
		}
	},
	{#State 293
		DEFAULT => -177
	},
	{#State 294
		ACTIONS => {
			'WORD_SCOPED' => 14,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			'KEYS_OR_VALUES' => 94,
			'VARIABLE_SYMBOL' => 53,
			"my" => 130,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'WORD' => 12
		},
		GOTOS => {
			'HashReference' => 82,
			'Variable' => 99,
			'ListElement' => 97,
			'WordScoped' => 76,
			'Expression' => 95,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'Literal' => 55,
			'ListElements' => 313,
			'TypeInner' => 92,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80
		}
	},
	{#State 295
		ACTIONS => {
			"use" => 29,
			"use constant" => -73,
			"our %properties = (" => -73
		},
		GOTOS => {
			'Include' => 314,
			'STAR-30' => 315
		}
	},
	{#State 296
		DEFAULT => -68
	},
	{#State 297
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 316
		}
	},
	{#State 298
		ACTIONS => {
			'LITERAL_STRING' => -44,
			'LITERAL_NUMBER' => -44,
			"my" => 130
		},
		GOTOS => {
			'OPTIONAL-17' => 318,
			'TypeInner' => 317
		}
	},
	{#State 299
		DEFAULT => -219
	},
	{#State 300
		DEFAULT => -188
	},
	{#State 301
		DEFAULT => -153
	},
	{#State 302
		DEFAULT => -178
	},
	{#State 303
		DEFAULT => -180
	},
	{#State 304
		ACTIONS => {
			'WORD' => 12,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			"{" => 44,
			"[" => 68,
			'OP01_NAMED' => 69,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'HashDereferenced' => 48,
			'Expression' => 319,
			'Operator' => 46,
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'HashReference' => 82,
			'Variable' => 99,
			'WordScoped' => 76
		}
	},
	{#State 305
		DEFAULT => -169
	},
	{#State 306
		ACTIONS => {
			"{" => 256
		},
		GOTOS => {
			'CodeBlock' => 320
		}
	},
	{#State 307
		DEFAULT => -171
	},
	{#State 308
		DEFAULT => -166
	},
	{#State 309
		DEFAULT => -56
	},
	{#State 310
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'OP01_NAMED' => 69,
			'OP19_LOOP_CONTROL' => 47,
			"for my integer" => -159,
			'OP01_NAMED_VOID' => 43,
			"[" => 68,
			"{" => 44,
			'LITERAL_NUMBER' => 73,
			"while (" => -159,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"my" => 51,
			'WORD_SCOPED' => 14,
			"}" => 321,
			'OP05_LOGICAL_NEG' => 63,
			'OP01_NAMED_VOID_PAREN' => 62,
			'OP05_MATH_NEG' => 60,
			'WORD' => 58,
			"if (" => 64,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			"foreach my" => -159,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67
		},
		GOTOS => {
			'WordScoped' => 76,
			'Statement' => 57,
			'Variable' => 56,
			'LoopLabel' => 75,
			'VariableModification' => 54,
			'Literal' => 55,
			'VariableDeclaration' => 70,
			'ArrayReference' => 71,
			'HashDereferenced' => 48,
			'Operation' => 322,
			'Operator' => 46,
			'OPTIONAL-50' => 85,
			'HashReference' => 82,
			'OperatorVoid' => 81,
			'PAREN-49' => 79,
			'ArrayDereferenced' => 80,
			'Expression' => 77,
			'Conditional' => 59
		}
	},
	{#State 311
		ACTIONS => {
			'VARIABLE_SYMBOL' => 323
		}
	},
	{#State 312
		ACTIONS => {
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'WORD' => 12,
			'WORD_SCOPED' => 14,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68
		},
		GOTOS => {
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'HashDereferenced' => 48,
			'Expression' => 324,
			'Operator' => 46,
			'WordScoped' => 76,
			'HashReference' => 82,
			'Variable' => 99
		}
	},
	{#State 313
		ACTIONS => {
			")" => 325
		}
	},
	{#State 314
		DEFAULT => -70
	},
	{#State 315
		ACTIONS => {
			"our %properties = (" => 328,
			"use constant" => 35
		},
		GOTOS => {
			'Properties' => 326,
			'Constant' => 327
		}
	},
	{#State 316
		ACTIONS => {
			'OP21_LIST_COMMA' => 331,
			"]" => 329
		},
		GOTOS => {
			'PAREN-15' => 330
		}
	},
	{#State 317
		DEFAULT => -43
	},
	{#State 318
		ACTIONS => {
			'LITERAL_STRING' => 84,
			'LITERAL_NUMBER' => 73
		},
		GOTOS => {
			'Literal' => 332
		}
	},
	{#State 319
		ACTIONS => {
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP04_MATH_POW' => 148,
			'OP08_STRING_CAT' => 140,
			'OP08_MATH_ADD_SUB' => 138,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP12_COMPARE_EQ_NEQ' => 139,
			")" => 333,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP13_BITWISE_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 151,
			'OP06_REGEX_MATCH' => 153,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => 142
		}
	},
	{#State 320
		DEFAULT => -168
	},
	{#State 321
		ACTIONS => {
			";" => 334
		}
	},
	{#State 322
		DEFAULT => -55
	},
	{#State 323
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 335
		}
	},
	{#State 324
		ACTIONS => {
			'OP08_STRING_CAT' => 140,
			'OP15_LOGICAL_AND' => 146,
			'OP23_LOGICAL_AND' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			")" => 336,
			'OP08_MATH_ADD_SUB' => 138,
			'OP16_LOGICAL_OR' => 149,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP06_REGEX_MATCH' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 151,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP13_BITWISE_AND' => 144
		}
	},
	{#State 325
		ACTIONS => {
			"{" => 256
		},
		GOTOS => {
			'CodeBlock' => 337
		}
	},
	{#State 326
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 338
		}
	},
	{#State 327
		DEFAULT => -72
	},
	{#State 328
		ACTIONS => {
			")" => 339,
			'WORD' => 340,
			"%{" => 72
		},
		GOTOS => {
			'HashEntryTyped' => 342,
			'HashDereferenced' => 341
		}
	},
	{#State 329
		DEFAULT => -51
	},
	{#State 330
		DEFAULT => -41
	},
	{#State 331
		ACTIONS => {
			'LITERAL_STRING' => -39,
			'LITERAL_NUMBER' => -39,
			"my" => 130
		},
		GOTOS => {
			'TypeInner' => 344,
			'OPTIONAL-14' => 343
		}
	},
	{#State 332
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 345
		}
	},
	{#State 333
		ACTIONS => {
			"{" => 256
		},
		GOTOS => {
			'CodeBlock' => 346
		}
	},
	{#State 334
		DEFAULT => -57
	},
	{#State 335
		ACTIONS => {
			'OP21_LIST_COMMA' => 349,
			")" => 347
		},
		GOTOS => {
			'PAREN-23' => 348
		}
	},
	{#State 336
		ACTIONS => {
			"{" => 256
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
			"our" => 352,
			"1;" => 351
		},
		GOTOS => {
			'Method' => 353
		}
	},
	{#State 339
		ACTIONS => {
			";" => 354
		}
	},
	{#State 340
		ACTIONS => {
			'OP20_HASH_FATARROW' => 355
		}
	},
	{#State 341
		DEFAULT => -208
	},
	{#State 342
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 356
		}
	},
	{#State 343
		ACTIONS => {
			'LITERAL_STRING' => 84,
			'LITERAL_NUMBER' => 73
		},
		GOTOS => {
			'Literal' => 357
		}
	},
	{#State 344
		DEFAULT => -38
	},
	{#State 345
		ACTIONS => {
			'OP21_LIST_COMMA' => 360,
			"}" => 359
		},
		GOTOS => {
			'PAREN-19' => 358
		}
	},
	{#State 346
		DEFAULT => -165
	},
	{#State 347
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 361
		}
	},
	{#State 348
		DEFAULT => -59
	},
	{#State 349
		ACTIONS => {
			"my" => 362
		}
	},
	{#State 350
		DEFAULT => -175
	},
	{#State 351
		ACTIONS => {
			"1;" => 363
		}
	},
	{#State 352
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 364
		}
	},
	{#State 353
		DEFAULT => -74
	},
	{#State 354
		DEFAULT => -86
	},
	{#State 355
		ACTIONS => {
			"my" => 130
		},
		GOTOS => {
			'TypeInner' => 365
		}
	},
	{#State 356
		ACTIONS => {
			")" => 367,
			'OP21_LIST_COMMA' => 368
		},
		GOTOS => {
			'PAREN-35' => 366
		}
	},
	{#State 357
		DEFAULT => -40
	},
	{#State 358
		DEFAULT => -48
	},
	{#State 359
		DEFAULT => -52
	},
	{#State 360
		ACTIONS => {
			'WORD' => 369
		}
	},
	{#State 361
		ACTIONS => {
			"\@_;" => 370
		}
	},
	{#State 362
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 371
		}
	},
	{#State 363
		ACTIONS => {
			'' => -80,
			"our" => 78,
			"package" => -80
		},
		GOTOS => {
			'PAREN-33' => 375,
			'Subroutine' => 373,
			'OPTIONAL-34' => 372,
			'PLUS-32' => 374
		}
	},
	{#State 364
		ACTIONS => {
			'VARIABLE_SYMBOL' => 376
		}
	},
	{#State 365
		ACTIONS => {
			'WORD' => 12,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 60,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			'OP01_NAMED' => 69,
			"{" => 44,
			"[" => 68,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'Expression' => 377,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'Literal' => 55,
			'ArrayDereferenced' => 80,
			'ArrayReference' => 71,
			'HashReference' => 82,
			'Variable' => 99,
			'WordScoped' => 76
		}
	},
	{#State 366
		DEFAULT => -83
	},
	{#State 367
		ACTIONS => {
			";" => 378
		}
	},
	{#State 368
		ACTIONS => {
			"%{" => 72,
			'WORD' => 340
		},
		GOTOS => {
			'HashDereferenced' => 341,
			'HashEntryTyped' => 379
		}
	},
	{#State 369
		ACTIONS => {
			'OP20_HASH_FATARROW' => 380
		}
	},
	{#State 370
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 381
		}
	},
	{#State 371
		ACTIONS => {
			'VARIABLE_SYMBOL' => 382
		}
	},
	{#State 372
		DEFAULT => -81
	},
	{#State 373
		DEFAULT => -77
	},
	{#State 374
		ACTIONS => {
			"1;" => 383,
			"our" => 78
		},
		GOTOS => {
			'Subroutine' => 384
		}
	},
	{#State 375
		DEFAULT => -79
	},
	{#State 376
		ACTIONS => {
			"= sub {" => 385
		}
	},
	{#State 377
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP13_BITWISE_AND' => 144,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP06_REGEX_MATCH' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 151,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP16_LOGICAL_OR' => 149,
			'OP21_LIST_COMMA' => -207,
			'OP23_LOGICAL_AND' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP15_LOGICAL_AND' => 146,
			")" => -207,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 140
		}
	},
	{#State 378
		DEFAULT => -85
	},
	{#State 379
		DEFAULT => -82
	},
	{#State 380
		ACTIONS => {
			'LITERAL_STRING' => -46,
			'LITERAL_NUMBER' => -46,
			"my" => 130
		},
		GOTOS => {
			'TypeInner' => 386,
			'OPTIONAL-18' => 387
		}
	},
	{#State 381
		ACTIONS => {
			'WORD' => -63,
			'OP05_MATH_NEG' => -63,
			'OP05_LOGICAL_NEG' => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			"if (" => -63,
			"foreach my" => -63,
			"\@{" => -63,
			'CHECK_OR_CHECKTRACE' => 388,
			'OP10_NAMED_UNARY' => -63,
			'OP22_LOGICAL_NOT' => -63,
			'LITERAL_STRING' => -63,
			"[" => -63,
			"{" => -63,
			"for my integer" => -63,
			'OP01_NAMED_VOID' => -63,
			'OP19_LOOP_CONTROL' => -63,
			'OP01_NAMED' => -63,
			"(" => -63,
			'OP03_MATH_INC_DEC' => -63,
			"my" => -63,
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			"%{" => -63,
			'VARIABLE_SYMBOL' => -63,
			"while (" => -63,
			"undef" => -63,
			'LITERAL_NUMBER' => -63,
			'WORD_SCOPED' => -63
		},
		GOTOS => {
			'ArgumentCheck' => 389
		}
	},
	{#State 382
		DEFAULT => -58
	},
	{#State 383
		ACTIONS => {
			"1;" => 390
		}
	},
	{#State 384
		DEFAULT => -76
	},
	{#State 385
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => -88,
			'OP05_LOGICAL_NEG' => -88,
			'OP05_MATH_NEG' => -88,
			'WORD' => -88,
			"if (" => -88,
			'OP10_NAMED_UNARY' => -88,
			"foreach my" => -88,
			"\@{" => -88,
			'LITERAL_STRING' => -88,
			'OP22_LOGICAL_NOT' => -88,
			"(" => -88,
			'OP03_MATH_INC_DEC' => -88,
			'OP01_NAMED' => -88,
			'OP19_LOOP_CONTROL' => -88,
			"[" => -88,
			"{" => -88,
			'OP01_NAMED_VOID' => -88,
			"for my integer" => -88,
			"undef" => -88,
			'VARIABLE_SYMBOL' => -88,
			"while (" => -88,
			'LITERAL_NUMBER' => -88,
			"%{" => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			"my" => -88,
			"( my" => 391,
			'WORD_SCOPED' => -88
		},
		GOTOS => {
			'OPTIONAL-37' => 393,
			'MethodArguments' => 392
		}
	},
	{#State 386
		DEFAULT => -45
	},
	{#State 387
		ACTIONS => {
			'LITERAL_NUMBER' => 73,
			'LITERAL_STRING' => 84
		},
		GOTOS => {
			'Literal' => 394
		}
	},
	{#State 388
		ACTIONS => {
			"(" => 395
		}
	},
	{#State 389
		DEFAULT => -61
	},
	{#State 390
		DEFAULT => -78
	},
	{#State 391
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 396
		}
	},
	{#State 392
		DEFAULT => -87
	},
	{#State 393
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"while (" => -159,
			'LITERAL_NUMBER' => 73,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"my" => 51,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'OP01_NAMED' => 69,
			'OP19_LOOP_CONTROL' => 47,
			"for my integer" => -159,
			"{" => 44,
			"[" => 68,
			'OP01_NAMED_VOID' => 43,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			"foreach my" => -159,
			"if (" => 64,
			'OP05_LOGICAL_NEG' => 63,
			'OP01_NAMED_VOID_PAREN' => 62,
			'OP05_MATH_NEG' => 60,
			'WORD' => 58
		},
		GOTOS => {
			'WordScoped' => 76,
			'Statement' => 57,
			'Variable' => 56,
			'LoopLabel' => 75,
			'Literal' => 55,
			'VariableModification' => 54,
			'ArrayReference' => 71,
			'VariableDeclaration' => 70,
			'HashDereferenced' => 48,
			'PLUS-38' => 397,
			'Operator' => 46,
			'Operation' => 398,
			'OPTIONAL-50' => 85,
			'HashReference' => 82,
			'OperatorVoid' => 81,
			'ArrayDereferenced' => 80,
			'PAREN-49' => 79,
			'Expression' => 77,
			'Conditional' => 59
		}
	},
	{#State 394
		DEFAULT => -47
	},
	{#State 395
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 53,
			"{" => 44,
			"[" => 68,
			'OP01_NAMED' => 69,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			'WORD_SCOPED' => 14,
			'WORD' => 12,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Expression' => 399,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'WordScoped' => 76,
			'HashReference' => 82,
			'Variable' => 99
		}
	},
	{#State 396
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 400
		}
	},
	{#State 397
		ACTIONS => {
			'LITERAL_NUMBER' => 73,
			"while (" => -159,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			"my" => 51,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"for my integer" => -159,
			'OP01_NAMED_VOID' => 43,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			'OP19_LOOP_CONTROL' => 47,
			"}" => 401,
			'WORD_SCOPED' => 14,
			"if (" => 64,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'OP01_NAMED_VOID_PAREN' => 62,
			'WORD' => 58,
			'LITERAL_STRING' => 84,
			'OP22_LOGICAL_NOT' => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 65,
			"foreach my" => -159
		},
		GOTOS => {
			'HashReference' => 82,
			'OPTIONAL-50' => 85,
			'Expression' => 77,
			'Conditional' => 59,
			'OperatorVoid' => 81,
			'ArrayDereferenced' => 80,
			'PAREN-49' => 79,
			'Statement' => 57,
			'LoopLabel' => 75,
			'Variable' => 56,
			'WordScoped' => 76,
			'HashDereferenced' => 48,
			'Operator' => 46,
			'Operation' => 402,
			'VariableModification' => 54,
			'Literal' => 55,
			'ArrayReference' => 71,
			'VariableDeclaration' => 70
		}
	},
	{#State 398
		DEFAULT => -90
	},
	{#State 399
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP13_BITWISE_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP06_REGEX_MATCH' => 153,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP18_TERNARY' => 142,
			'OP21_LIST_COMMA' => 403,
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP04_MATH_POW' => 148,
			'OP08_STRING_CAT' => 140,
			'OP08_MATH_ADD_SUB' => 138,
			'OP23_LOGICAL_AND' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP15_LOGICAL_AND' => 146,
			")" => -66
		},
		GOTOS => {
			'OPTIONAL-27' => 404,
			'PAREN-26' => 405
		}
	},
	{#State 400
		ACTIONS => {
			")" => 406,
			'OP21_LIST_COMMA' => 408
		},
		GOTOS => {
			'PAREN-39' => 407
		}
	},
	{#State 401
		ACTIONS => {
			";" => 409
		}
	},
	{#State 402
		DEFAULT => -89
	},
	{#State 403
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"{" => 44,
			"[" => 68,
			'OP01_NAMED' => 69,
			"(" => 50,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"undef" => 74,
			'VARIABLE_SYMBOL' => 53,
			'LITERAL_NUMBER' => 73,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			'WORD' => 12,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63
		},
		GOTOS => {
			'HashReference' => 82,
			'Variable' => 99,
			'WordScoped' => 76,
			'HashDereferenced' => 48,
			'Expression' => 410,
			'Operator' => 46,
			'Literal' => 55,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80
		}
	},
	{#State 404
		ACTIONS => {
			")" => 411
		}
	},
	{#State 405
		DEFAULT => -65
	},
	{#State 406
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 412
		}
	},
	{#State 407
		DEFAULT => -93
	},
	{#State 408
		ACTIONS => {
			"my" => 413
		}
	},
	{#State 409
		DEFAULT => -91
	},
	{#State 410
		ACTIONS => {
			'OP16_LOGICAL_OR' => 149,
			'OP21_LIST_COMMA' => 414,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP15_LOGICAL_AND' => 146,
			'OP23_LOGICAL_AND' => 147,
			'OP08_MATH_ADD_SUB' => 138,
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP06_REGEX_MATCH' => 153,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150
		}
	},
	{#State 411
		ACTIONS => {
			";" => 415
		}
	},
	{#State 412
		ACTIONS => {
			"\@_;" => 416
		}
	},
	{#State 413
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 417
		}
	},
	{#State 414
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 52,
			"%{" => 72,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 74,
			'LITERAL_NUMBER' => 73,
			"[" => 68,
			"{" => 44,
			'OP01_NAMED' => 69,
			'OP03_MATH_INC_DEC' => 49,
			"(" => 50,
			'WORD_SCOPED' => 14,
			'WORD' => 12,
			'OP05_MATH_NEG' => 60,
			'OP05_LOGICAL_NEG' => 63,
			'OP22_LOGICAL_NOT' => 67,
			'LITERAL_STRING' => 84,
			"\@{" => 65,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'WordScoped' => 76,
			'Variable' => 99,
			'HashReference' => 82,
			'ArrayReference' => 71,
			'ArrayDereferenced' => 80,
			'Literal' => 55,
			'Operator' => 46,
			'HashDereferenced' => 48,
			'Expression' => 418
		}
	},
	{#State 415
		DEFAULT => -67
	},
	{#State 416
		DEFAULT => -96,
		GOTOS => {
			'STAR-41' => 419
		}
	},
	{#State 417
		ACTIONS => {
			'VARIABLE_SYMBOL' => 420
		}
	},
	{#State 418
		ACTIONS => {
			'OP16_LOGICAL_OR' => 149,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP08_STRING_CAT' => 140,
			")" => -64,
			'OP23_LOGICAL_AND' => 147,
			'OP12_COMPARE_EQ_NEQ' => 139,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 138,
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 145,
			'OP06_REGEX_MATCH' => 153,
			'OP09_BITWISE_SHIFT' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 143,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 150
		}
	},
	{#State 419
		ACTIONS => {
			"[" => -97,
			"{" => -97,
			'OP01_NAMED_VOID' => -97,
			"for my integer" => -97,
			'OP19_LOOP_CONTROL' => -97,
			'OP01_NAMED' => -97,
			"(" => -97,
			'OP03_MATH_INC_DEC' => -97,
			"my" => -97,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			"%{" => -97,
			'VARIABLE_SYMBOL' => -97,
			"undef" => -97,
			'LITERAL_NUMBER' => -97,
			"while (" => -97,
			'WORD_SCOPED' => -97,
			'WORD' => -97,
			'OP05_MATH_NEG' => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			'OP05_LOGICAL_NEG' => -97,
			"if (" => -97,
			"\@{" => -97,
			"foreach my" => -97,
			'CHECK_OR_CHECKTRACE' => 388,
			'OP10_NAMED_UNARY' => -97,
			'OP22_LOGICAL_NOT' => -97,
			'LITERAL_STRING' => -97
		},
		GOTOS => {
			'ArgumentCheck' => 421
		}
	},
	{#State 420
		DEFAULT => -92
	},
	{#State 421
		DEFAULT => -95
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5567 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5574 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5581 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5592 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5603 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5610 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5617 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5624 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5631 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5638 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5645 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5652 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5659 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5666 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5673 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5684 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5695 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5706 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5713 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5720 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5727 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5734 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5741 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5748 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5755 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5762 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 10,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5773 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5784 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5791 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5798 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5809 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5816 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5823 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5845 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5856 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5863 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5877 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5884 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5891 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5898 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5905 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5912 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5919 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5926 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5933 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5940 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5947 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5954 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5965 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5976 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5987 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5994 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6001 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6008 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6015 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6026 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6033 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6040 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6047 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6061 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6086 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6093 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6104 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6111 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6118 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6125 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6132 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6139 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6146 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6153 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6160 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6167 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6174 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 3,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6181 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6188 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6195 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 17,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6206 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6213 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6220 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6227 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6238 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6256 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6263 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6270 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6277 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6288 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6295 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6302 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6309 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6316 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6323 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6334 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6345 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6356 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6363 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6370 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6381 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6392 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6403 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6414 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6425 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6436 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6447 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6458 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6469 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6480 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6491 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6502 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6524 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6535 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6546 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6557 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6568 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6579 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6590 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6601 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6612 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6623 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6634 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6641 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6648 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6655 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6662 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6669 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6676 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6683 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6690 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6701 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6712 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6734 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6745 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6752 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6759 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6766 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6773 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6784 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6795 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6806 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6817 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6828 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6905 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_155
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6916 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_156
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6927 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6934 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6941 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6948 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6970 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6981 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_163
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6992 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_164
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7003 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7010 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7017 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7031 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7038 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7045 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_171
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7056 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7067 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_173
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_174
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7089 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_175
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_176
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_177
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7129 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7136 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_180
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_183
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_185
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_186
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_187
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_188
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_189
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_190
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7249 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7256 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7270 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_194
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7281 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_195
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_196
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7303 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_197
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7314 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7321 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_200
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_201
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_202
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7368 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7375 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_205
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7386 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_206
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7397 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_207
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_208
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7419 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-61', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7426 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7433 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_212
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_213
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_214
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7473 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_215
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7484 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_216
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7495 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_217
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7506 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_218
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_219
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7528 lib/RPerl/Grammar.pm
	],
	[#Rule Type_220
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7539 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_221
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7550 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_222
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7561 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_223
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7572 lib/RPerl/Grammar.pm
	]
],
#line 7575 lib/RPerl/Grammar.pm
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
         'ListElements_194', 
         'ListElement_195', 
         'ListElement_196', 
         'ListElement_197', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_200', 
         'ArrayDereferenced_201', 
         'ArrayDereferenced_202', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_205', 
         'HashEntry_206', 
         'HashEntryTyped_207', 
         'HashEntryTyped_208', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_212', 
         'HashDereferenced_213', 
         'HashDereferenced_214', 
         'WordScoped_215', 
         'WordScoped_216', 
         'FileHandle_217', 
         'FileHandle_218', 
         'TypeInner_219', 
         'Type_220', 
         'LoopLabel_221', 
         'Literal_222', 
         'Literal_223', );
  $self;
}

#line 176 "lib/RPerl/Grammar.eyp"


{
# Rules from Grammar.output
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


#line 7846 lib/RPerl/Grammar.pm



1;
