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
    our $VERSION = 0.000_714;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G(\s*(\#.+)*\s*)+/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|while\ \(|elsif\ \(|\$TYPED_|package|\=\ sub\ \{|undef|else|\(\ my|if\ \(|our|use|qw\(|\@_\;|\{\*|\.\.|1\;|\@\{|\%\{|my|\)|\(|\{|\}|\;|\]|\[|\/)}gc and return ($1, $1);

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
  [ '_PAREN' => 'PAREN-49', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'PAREN-49' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'Statement_158' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_159' => 'Statement', [ 'OPTIONAL-50', 'Loop' ], 0 ],
  [ 'Statement_160' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_161' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_162' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ '_PAREN' => 'PAREN-53', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [ 'PAREN-53' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [  ], 0 ],
  [ 'Conditional_169' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-52', 'OPTIONAL-54' ], 0 ],
  [ 'Loop_170' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_171' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_172' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_173' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_174' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_175' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-55', [ 'PLUS-55', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-55', [ 'Operation' ], 0 ],
  [ 'CodeBlock_178' => 'CodeBlock', [ '{', 'PLUS-55', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [ 'STAR-56', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [  ], 0 ],
  [ 'Variable_181' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-56' ], 0 ],
  [ 'VariableRetrieval_182' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_183' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_184' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_185' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_186' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_187' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_188' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-57', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [ 'STAR-58', 'PAREN-57' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [  ], 0 ],
  [ 'ListElements_192' => 'ListElements', [ 'ListElement', 'STAR-58' ], 0 ],
  [ 'ListElement_193' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_194' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_195' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [  ], 0 ],
  [ 'ArrayReference_198' => 'ArrayReference', [ '[', 'OPTIONAL-59', ']' ], 0 ],
  [ 'ArrayDereferenced_199' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_200' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [  ], 0 ],
  [ 'HashEntry_203' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-60', 'Expression' ], 0 ],
  [ 'HashEntry_204' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_205' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_206' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-61', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-62', [ 'STAR-62', 'PAREN-61' ], 0 ],
  [ '_STAR_LIST' => 'STAR-62', [  ], 0 ],
  [ 'HashReference_210' => 'HashReference', [ '{', 'HashEntry', 'STAR-62', '}' ], 0 ],
  [ 'HashDereferenced_211' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_212' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_213' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_214' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'FileHandle_215' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'FileHandle_216' => 'FileHandle', [ 'my', 'filehandle_ref', 'VARIABLE_SYMBOL' ], 0 ],
  [ 'TypeInner_217' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Type_218' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_219' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Literal_220' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_221' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_PAREN' => 155,
  '_OPTIONAL' => 156,
  '_OPTIONAL' => 157,
  'Statement_158' => 158,
  'Statement_159' => 159,
  'Statement_160' => 160,
  'Statement_161' => 161,
  'Statement_162' => 162,
  '_PAREN' => 163,
  '_STAR_LIST' => 164,
  '_STAR_LIST' => 165,
  '_PAREN' => 166,
  '_OPTIONAL' => 167,
  '_OPTIONAL' => 168,
  'Conditional_169' => 169,
  'Loop_170' => 170,
  'Loop_171' => 171,
  'Loop_172' => 172,
  'LoopFor_173' => 173,
  'LoopForEach_174' => 174,
  'LoopWhile_175' => 175,
  '_PLUS_LIST' => 176,
  '_PLUS_LIST' => 177,
  'CodeBlock_178' => 178,
  '_STAR_LIST' => 179,
  '_STAR_LIST' => 180,
  'Variable_181' => 181,
  'VariableRetrieval_182' => 182,
  'VariableRetrieval_183' => 183,
  'VariableRetrieval_184' => 184,
  'VariableDeclaration_185' => 185,
  'VariableDeclaration_186' => 186,
  'VariableModification_187' => 187,
  'VariableModification_188' => 188,
  '_PAREN' => 189,
  '_STAR_LIST' => 190,
  '_STAR_LIST' => 191,
  'ListElements_192' => 192,
  'ListElement_193' => 193,
  'ListElement_194' => 194,
  'ListElement_195' => 195,
  '_OPTIONAL' => 196,
  '_OPTIONAL' => 197,
  'ArrayReference_198' => 198,
  'ArrayDereferenced_199' => 199,
  'ArrayDereferenced_200' => 200,
  '_OPTIONAL' => 201,
  '_OPTIONAL' => 202,
  'HashEntry_203' => 203,
  'HashEntry_204' => 204,
  'HashEntryTyped_205' => 205,
  'HashEntryTyped_206' => 206,
  '_PAREN' => 207,
  '_STAR_LIST' => 208,
  '_STAR_LIST' => 209,
  'HashReference_210' => 210,
  'HashDereferenced_211' => 211,
  'HashDereferenced_212' => 212,
  'WordScoped_213' => 213,
  'WordScoped_214' => 214,
  'FileHandle_215' => 215,
  'FileHandle_216' => 216,
  'TypeInner_217' => 217,
  'Type_218' => 218,
  'LoopLabel_219' => 219,
  'Literal_220' => 220,
  'Literal_221' => 221,
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
			'SHEBANG' => 7,
			"package" => 4
		},
		GOTOS => {
			'Program' => 2,
			'Package' => 1,
			'Module' => 8,
			'CompileUnit' => 6,
			'PLUS-1' => 5,
			'Class' => 3
		}
	},
	{#State 1
		DEFAULT => -16
	},
	{#State 2
		DEFAULT => -3
	},
	{#State 3
		DEFAULT => -17
	},
	{#State 4
		ACTIONS => {
			'WORD_SCOPED' => 11,
			'WORD' => 9
		},
		GOTOS => {
			'WordScoped' => 10
		}
	},
	{#State 5
		ACTIONS => {
			'' => -4,
			"package" => 4
		},
		GOTOS => {
			'Class' => 3,
			'Module' => 12,
			'Package' => 1
		}
	},
	{#State 6
		ACTIONS => {
			'' => 13
		}
	},
	{#State 7
		ACTIONS => {
			"use strict;" => 15
		},
		GOTOS => {
			'Header' => 14
		}
	},
	{#State 8
		DEFAULT => -2
	},
	{#State 9
		DEFAULT => -213
	},
	{#State 10
		ACTIONS => {
			";" => 16
		}
	},
	{#State 11
		DEFAULT => -214
	},
	{#State 12
		DEFAULT => -1
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 17
		}
	},
	{#State 15
		ACTIONS => {
			"use warnings;" => 18
		}
	},
	{#State 16
		ACTIONS => {
			"use strict;" => 15
		},
		GOTOS => {
			'Header' => 19
		}
	},
	{#State 17
		ACTIONS => {
			"undef" => -8,
			'OP01_NAMED_VOID' => -8,
			'LITERAL_STRING' => -8,
			"%{" => -8,
			'WORD_SCOPED' => -8,
			'LITERAL_NUMBER' => -8,
			"if (" => -8,
			"use" => -8,
			'OP01_NAMED' => -8,
			"## no critic qw(" => 20,
			"use constant" => -8,
			'OP22_LOGICAL_NOT' => -8,
			'OP05_LOGICAL_NEG' => -8,
			"{" => -8,
			'VARIABLE_SYMBOL' => -8,
			'OP10_NAMED_UNARY' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			'OP03_MATH_INC_DEC' => -8,
			"(" => -8,
			"\@{" => -8,
			"[" => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"foreach my" => -8,
			'OP05_MATH_NEG' => -8,
			"while (" => -8,
			"our" => -8,
			'OP19_LOOP_CONTROL' => -8,
			'WORD' => -8,
			"my" => -8,
			"for my integer" => -8
		},
		GOTOS => {
			'Critic' => 22,
			'STAR-3' => 21
		}
	},
	{#State 18
		ACTIONS => {
			"use RPerl;" => 23
		}
	},
	{#State 19
		ACTIONS => {
			"## no critic qw(" => -19,
			"use" => -19,
			"use parent qw(" => 24,
			"our" => -19,
			"use constant" => -19
		},
		GOTOS => {
			'STAR-7' => 25
		}
	},
	{#State 20
		ACTIONS => {
			'WORD' => 27
		},
		GOTOS => {
			'PLUS-11' => 26
		}
	},
	{#State 21
		ACTIONS => {
			'LITERAL_NUMBER' => -10,
			'WORD_SCOPED' => -10,
			"%{" => -10,
			'LITERAL_STRING' => -10,
			'OP01_NAMED_VOID' => -10,
			"undef" => -10,
			'VARIABLE_SYMBOL' => -10,
			"{" => -10,
			'OP05_LOGICAL_NEG' => -10,
			'OP22_LOGICAL_NOT' => -10,
			"use constant" => -10,
			'OP01_NAMED' => -10,
			"use" => 29,
			"if (" => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"[" => -10,
			"\@{" => -10,
			"(" => -10,
			'OP03_MATH_INC_DEC' => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			'OP10_NAMED_UNARY' => -10,
			"for my integer" => -10,
			"my" => -10,
			'WORD' => -10,
			'OP19_LOOP_CONTROL' => -10,
			"our" => -10,
			"while (" => -10,
			'OP05_MATH_NEG' => -10,
			"foreach my" => -10
		},
		GOTOS => {
			'Include' => 28,
			'STAR-4' => 30
		}
	},
	{#State 22
		DEFAULT => -5
	},
	{#State 23
		ACTIONS => {
			"our" => 31
		}
	},
	{#State 24
		ACTIONS => {
			'WORD_SCOPED' => 11,
			'WORD' => 9
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 25
		ACTIONS => {
			"## no critic qw(" => 20,
			"use" => -21,
			"our" => -21,
			"use constant" => -21
		},
		GOTOS => {
			'STAR-8' => 33,
			'Critic' => 34
		}
	},
	{#State 26
		ACTIONS => {
			")" => 35,
			'WORD' => 36
		}
	},
	{#State 27
		DEFAULT => -29
	},
	{#State 28
		DEFAULT => -7
	},
	{#State 29
		ACTIONS => {
			'WORD_SCOPED' => 11,
			'WORD' => 9
		},
		GOTOS => {
			'WordScoped' => 37
		}
	},
	{#State 30
		ACTIONS => {
			"(" => -12,
			"\@{" => -12,
			'OP10_NAMED_UNARY' => -12,
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			'OP03_MATH_INC_DEC' => -12,
			"[" => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			"while (" => -12,
			"our" => -12,
			"foreach my" => -12,
			'OP05_MATH_NEG' => -12,
			"my" => -12,
			"for my integer" => -12,
			'WORD' => -12,
			'OP19_LOOP_CONTROL' => -12,
			"undef" => -12,
			'OP01_NAMED_VOID' => -12,
			'LITERAL_STRING' => -12,
			'WORD_SCOPED' => -12,
			"%{" => -12,
			'LITERAL_NUMBER' => -12,
			"use constant" => 40,
			'OP22_LOGICAL_NOT' => -12,
			"if (" => -12,
			'OP01_NAMED' => -12,
			"{" => -12,
			'VARIABLE_SYMBOL' => -12,
			'OP05_LOGICAL_NEG' => -12
		},
		GOTOS => {
			'STAR-5' => 39,
			'Constant' => 38
		}
	},
	{#State 31
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 41
		}
	},
	{#State 32
		ACTIONS => {
			")" => 42
		}
	},
	{#State 33
		ACTIONS => {
			"use" => 29,
			"use constant" => -23,
			"our" => -23
		},
		GOTOS => {
			'Include' => 44,
			'STAR-9' => 43
		}
	},
	{#State 34
		DEFAULT => -18
	},
	{#State 35
		DEFAULT => -30
	},
	{#State 36
		DEFAULT => -28
	},
	{#State 37
		ACTIONS => {
			"qw(" => 45,
			";" => 46
		}
	},
	{#State 38
		DEFAULT => -9
	},
	{#State 39
		ACTIONS => {
			"while (" => -157,
			"our" => 87,
			"foreach my" => -157,
			'OP05_MATH_NEG' => 88,
			"my" => 82,
			"for my integer" => -157,
			'WORD' => 84,
			'OP19_LOOP_CONTROL' => 85,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"[" => 74,
			'OP01_NAMED_VOID_PAREN' => 76,
			'OP22_LOGICAL_NOT' => 70,
			"if (" => 72,
			'OP01_NAMED' => 73,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			"undef" => 66,
			'OP01_NAMED_VOID' => 65,
			'LITERAL_STRING' => 50,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62
		},
		GOTOS => {
			'VariableDeclaration' => 89,
			'LoopLabel' => 86,
			'Conditional' => 61,
			'OperatorVoid' => 60,
			'Operation' => 83,
			'ArrayDereferenced' => 57,
			'PLUS-6' => 79,
			'VariableModification' => 77,
			'WordScoped' => 78,
			'Statement' => 55,
			'Subroutine' => 75,
			'Variable' => 54,
			'Expression' => 71,
			'PAREN-49' => 53,
			'HashReference' => 69,
			'Operator' => 51,
			'ArrayReference' => 63,
			'OPTIONAL-50' => 64,
			'HashDereferenced' => 47,
			'Literal' => 48
		}
	},
	{#State 40
		ACTIONS => {
			'WORD' => 90
		}
	},
	{#State 41
		DEFAULT => -27
	},
	{#State 42
		ACTIONS => {
			";" => 91
		}
	},
	{#State 43
		ACTIONS => {
			"our" => 87,
			"use constant" => 40
		},
		GOTOS => {
			'Constant' => 94,
			'Subroutine' => 93,
			'PLUS-10' => 92
		}
	},
	{#State 44
		DEFAULT => -20
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
		DEFAULT => -149
	},
	{#State 48
		DEFAULT => -144
	},
	{#State 49
		ACTIONS => {
			"{" => 97,
			'VARIABLE_SYMBOL' => 67
		},
		GOTOS => {
			'Variable' => 98,
			'HashReference' => 99
		}
	},
	{#State 50
		DEFAULT => -220
	},
	{#State 51
		DEFAULT => -151
	},
	{#State 52
		ACTIONS => {
			"}" => 101,
			'WORD' => 103,
			"%{" => 49
		},
		GOTOS => {
			'HashDereferenced' => 102,
			'HashEntry' => 100
		}
	},
	{#State 53
		DEFAULT => -156
	},
	{#State 54
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP03_MATH_INC_DEC' => 104,
			'OP08_STRING_CAT' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP18_TERNARY' => -145,
			";" => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP19_VARIABLE_ASSIGN' => 106,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 105,
			'OP02_METHOD_THINARROW' => 107,
			'OP11_COMPARE_LT_GT' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP04_MATH_POW' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145
		}
	},
	{#State 55
		DEFAULT => -99
	},
	{#State 56
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			"[" => 74
		},
		GOTOS => {
			'HashReference' => 69,
			'Expression' => 108,
			'Variable' => 109,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'ArrayDereferenced' => 57,
			'Operator' => 51
		}
	},
	{#State 57
		DEFAULT => -147
	},
	{#State 58
		ACTIONS => {
			"[" => 74,
			'VARIABLE_SYMBOL' => 67
		},
		GOTOS => {
			'Variable' => 110,
			'ArrayReference' => 111
		}
	},
	{#State 59
		ACTIONS => {
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9
		},
		GOTOS => {
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'Expression' => 112,
			'Variable' => 109,
			'HashReference' => 69
		}
	},
	{#State 60
		DEFAULT => -160
	},
	{#State 61
		DEFAULT => -158
	},
	{#State 62
		DEFAULT => -221
	},
	{#State 63
		DEFAULT => -146
	},
	{#State 64
		ACTIONS => {
			"for my integer" => 118,
			"while (" => 119,
			"foreach my" => 113
		},
		GOTOS => {
			'LoopForEach' => 114,
			'Loop' => 115,
			'LoopFor' => 117,
			'LoopWhile' => 116
		}
	},
	{#State 65
		ACTIONS => {
			'OP05_MATH_NEG' => 88,
			";" => -131,
			"{*" => 123,
			'WORD' => 9,
			"my" => 120,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"\@{" => 58,
			"(" => 56,
			"[" => 74,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			'VARIABLE_SYMBOL' => 67,
			'KEYS_OR_VALUES' => 128,
			"{" => 52,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'WordScoped' => 78,
			'FileHandle' => 127,
			'ArrayReference' => 63,
			'TypeInner' => 124,
			'Expression' => 125,
			'ListElements' => 122,
			'OPTIONAL-45' => 121,
			'Variable' => 109,
			'ListElement' => 126,
			'HashReference' => 69
		}
	},
	{#State 66
		DEFAULT => -143
	},
	{#State 67
		DEFAULT => -180,
		GOTOS => {
			'STAR-56' => 129
		}
	},
	{#State 68
		ACTIONS => {
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			"\@{" => 58,
			"(" => 56,
			"[" => 74
		},
		GOTOS => {
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'Expression' => 130,
			'Variable' => 109,
			'HashReference' => 69
		}
	},
	{#State 69
		DEFAULT => -148
	},
	{#State 70
		ACTIONS => {
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88,
			"[" => 74,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81
		},
		GOTOS => {
			'HashReference' => 69,
			'Variable' => 109,
			'Expression' => 131,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'Operator' => 51,
			'ArrayDereferenced' => 57
		}
	},
	{#State 71
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP17_LIST_RANGE' => 146,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 139,
			'OP15_LOGICAL_AND' => 135,
			'OP23_LOGICAL_AND' => 137,
			'OP06_REGEX_MATCH' => 142,
			";" => 136
		}
	},
	{#State 72
		ACTIONS => {
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58,
			"[" => 74
		},
		GOTOS => {
			'HashReference' => 69,
			'Variable' => 109,
			'Expression' => 149,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'Operator' => 51,
			'ArrayDereferenced' => 57
		}
	},
	{#State 73
		ACTIONS => {
			"(" => 150
		}
	},
	{#State 74
		ACTIONS => {
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'VARIABLE_SYMBOL' => 67,
			'KEYS_OR_VALUES' => 128,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"[" => 74,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"my" => 152,
			'WORD' => 9,
			"]" => -197,
			'OP05_MATH_NEG' => 88
		},
		GOTOS => {
			'HashReference' => 69,
			'Expression' => 125,
			'TypeInner' => 124,
			'Variable' => 109,
			'ListElement' => 126,
			'ListElements' => 153,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'OPTIONAL-59' => 151,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'ArrayDereferenced' => 57,
			'Operator' => 51
		}
	},
	{#State 75
		DEFAULT => -11
	},
	{#State 76
		ACTIONS => {
			'WORD' => 9,
			"my" => 120,
			'OP05_MATH_NEG' => 88,
			"{*" => 123,
			"[" => 74,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			"\@{" => 58,
			"(" => 56,
			")" => -127,
			'OP05_LOGICAL_NEG' => 68,
			'VARIABLE_SYMBOL' => 67,
			'KEYS_OR_VALUES' => 128,
			"{" => 52,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_STRING' => 50,
			"undef" => 66
		},
		GOTOS => {
			'OPTIONAL-43' => 155,
			'Expression' => 125,
			'TypeInner' => 124,
			'Variable' => 109,
			'ListElement' => 126,
			'ListElements' => 154,
			'HashReference' => 69,
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'ArrayReference' => 63,
			'FileHandle' => 156,
			'WordScoped' => 78
		}
	},
	{#State 77
		DEFAULT => -162
	},
	{#State 78
		ACTIONS => {
			"(" => 157
		}
	},
	{#State 79
		ACTIONS => {
			"while (" => -157,
			'OP05_MATH_NEG' => 88,
			"foreach my" => -157,
			"for my integer" => -157,
			"my" => 82,
			'' => -15,
			'WORD' => 84,
			'OP19_LOOP_CONTROL' => 85,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP01_NAMED_VOID_PAREN' => 76,
			"[" => 74,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"if (" => 72,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'OP01_NAMED_VOID' => 65,
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'Variable' => 54,
			'PAREN-49' => 53,
			'Expression' => 71,
			'HashReference' => 69,
			'Operator' => 51,
			'ArrayReference' => 63,
			'OPTIONAL-50' => 64,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'VariableDeclaration' => 89,
			'LoopLabel' => 86,
			'Conditional' => 61,
			'Operation' => 158,
			'OperatorVoid' => 60,
			'ArrayDereferenced' => 57,
			'WordScoped' => 78,
			'VariableModification' => 77,
			'Statement' => 55
		}
	},
	{#State 80
		ACTIONS => {
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"\@{" => 58,
			"(" => 56,
			"[" => 74,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'HashDereferenced' => 47,
			'Literal' => 48,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'HashReference' => 69,
			'Expression' => 159,
			'Variable' => 109
		}
	},
	{#State 81
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67
		},
		GOTOS => {
			'Variable' => 160
		}
	},
	{#State 82
		ACTIONS => {
			'WORD' => 161
		},
		GOTOS => {
			'Type' => 162
		}
	},
	{#State 83
		DEFAULT => -14
	},
	{#State 84
		ACTIONS => {
			"(" => -213,
			'COLON' => -219
		}
	},
	{#State 85
		ACTIONS => {
			'WORD' => 163
		},
		GOTOS => {
			'LoopLabel' => 164
		}
	},
	{#State 86
		ACTIONS => {
			'COLON' => 165
		}
	},
	{#State 87
		ACTIONS => {
			'WORD' => 161
		},
		GOTOS => {
			'Type' => 166
		}
	},
	{#State 88
		ACTIONS => {
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58,
			"[" => 74
		},
		GOTOS => {
			'Variable' => 109,
			'Expression' => 167,
			'HashReference' => 69,
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'HashDereferenced' => 47,
			'Literal' => 48
		}
	},
	{#State 89
		DEFAULT => -161
	},
	{#State 90
		ACTIONS => {
			'OP20_HASH_FATARROW' => 168
		}
	},
	{#State 91
		ACTIONS => {
			"use" => 29
		},
		GOTOS => {
			'Include' => 169
		}
	},
	{#State 92
		ACTIONS => {
			"1;" => 171,
			"our" => 87
		},
		GOTOS => {
			'Subroutine' => 170
		}
	},
	{#State 93
		DEFAULT => -25
	},
	{#State 94
		DEFAULT => -22
	},
	{#State 95
		ACTIONS => {
			'WORD' => 172,
			")" => 173
		}
	},
	{#State 96
		DEFAULT => -32
	},
	{#State 97
		ACTIONS => {
			'WORD' => 103,
			"%{" => 49
		},
		GOTOS => {
			'HashEntry' => 100,
			'HashDereferenced' => 102
		}
	},
	{#State 98
		ACTIONS => {
			"}" => 174
		}
	},
	{#State 99
		ACTIONS => {
			"}" => 175
		}
	},
	{#State 100
		DEFAULT => -209,
		GOTOS => {
			'STAR-62' => 176
		}
	},
	{#State 101
		DEFAULT => -150
	},
	{#State 102
		DEFAULT => -204
	},
	{#State 103
		ACTIONS => {
			'OP20_HASH_FATARROW' => 177
		}
	},
	{#State 104
		DEFAULT => -104
	},
	{#State 105
		ACTIONS => {
			'WORD' => 9,
			'OP05_MATH_NEG' => 88,
			"[" => 74,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_NUMBER' => 62,
			"undef" => 66,
			'LITERAL_STRING' => 50
		},
		GOTOS => {
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'Expression' => 178,
			'Variable' => 109,
			'HashReference' => 69
		}
	},
	{#State 106
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88,
			"[" => 74,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59
		},
		GOTOS => {
			'HashReference' => 69,
			'Variable' => 109,
			'Expression' => 179,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'Operator' => 51,
			'ArrayDereferenced' => 57
		}
	},
	{#State 107
		ACTIONS => {
			'WORD' => 180
		}
	},
	{#State 108
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			")" => 181,
			'OP17_LIST_RANGE' => 146,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP13_BITWISE_AND' => 132,
			'OP18_TERNARY' => 141,
			'OP15_LOGICAL_AND' => 135,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP23_LOGICAL_AND' => 137,
			'OP06_REGEX_MATCH' => 142
		}
	},
	{#State 109
		ACTIONS => {
			'OP18_TERNARY' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP21_LIST_COMMA' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP23_LOGICAL_AND' => -145,
			"]" => -145,
			";" => -145,
			'OP08_STRING_CAT' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP03_MATH_INC_DEC' => 104,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP17_LIST_RANGE' => -145,
			")" => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP04_MATH_POW' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP02_METHOD_THINARROW' => 107,
			'OP24_LOGICAL_OR_XOR' => -145,
			".." => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			"}" => -145
		}
	},
	{#State 110
		ACTIONS => {
			"}" => 182
		}
	},
	{#State 111
		ACTIONS => {
			"}" => 183
		}
	},
	{#State 112
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -114,
			'OP13_BITWISE_AND' => -114,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP15_LOGICAL_AND' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP09_BITWISE_SHIFT' => 140,
			'OP18_TERNARY' => -114,
			"]" => -114,
			";" => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP06_REGEX_MATCH' => 142,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			"}" => -114,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			".." => -114,
			")" => -114,
			'OP17_LIST_RANGE' => -114,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => -114
		}
	},
	{#State 113
		ACTIONS => {
			'WORD' => 161
		},
		GOTOS => {
			'Type' => 184
		}
	},
	{#State 114
		DEFAULT => -171
	},
	{#State 115
		DEFAULT => -159
	},
	{#State 116
		DEFAULT => -172
	},
	{#State 117
		DEFAULT => -170
	},
	{#State 118
		ACTIONS => {
			'VARIABLE_SYMBOL' => 185
		}
	},
	{#State 119
		ACTIONS => {
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"\@{" => 58,
			"(" => 56,
			"[" => 74,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49
		},
		GOTOS => {
			'Variable' => 109,
			'Expression' => 186,
			'HashReference' => 69,
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'Literal' => 48,
			'HashDereferenced' => 47
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 161,
			"filehandle_ref" => 187
		},
		GOTOS => {
			'Type' => 188
		}
	},
	{#State 121
		ACTIONS => {
			";" => 189
		}
	},
	{#State 122
		DEFAULT => -130
	},
	{#State 123
		ACTIONS => {
			'WORD' => 190
		}
	},
	{#State 124
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88,
			"[" => 74,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59
		},
		GOTOS => {
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'Variable' => 109,
			'Expression' => 191,
			'HashReference' => 69
		}
	},
	{#State 125
		ACTIONS => {
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			";" => -193,
			"]" => -193,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 139,
			'OP15_LOGICAL_AND' => 135,
			'OP21_LIST_COMMA' => -193,
			'OP18_TERNARY' => 141,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 146,
			")" => -193
		}
	},
	{#State 126
		DEFAULT => -191,
		GOTOS => {
			'STAR-58' => 192
		}
	},
	{#State 127
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"\@{" => 58,
			"(" => 56,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			";" => -133,
			'WORD' => 9,
			"my" => 152,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			'KEYS_OR_VALUES' => 128,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52
		},
		GOTOS => {
			'TypeInner' => 124,
			'Expression' => 125,
			'ListElements' => 193,
			'Variable' => 109,
			'ListElement' => 126,
			'HashReference' => 69,
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'OPTIONAL-46' => 194
		}
	},
	{#State 128
		ACTIONS => {
			"%{" => 49
		},
		GOTOS => {
			'HashDereferenced' => 195
		}
	},
	{#State 129
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 196,
			'OP17_LIST_RANGE' => -181,
			")" => -181,
			'OP12_COMPARE_EQ_NEQ' => -181,
			'OP04_MATH_POW' => -181,
			'OP11_COMPARE_LT_GT' => -181,
			'OP02_METHOD_THINARROW' => -181,
			'OP24_LOGICAL_OR_XOR' => -181,
			'OP19_VARIABLE_ASSIGN_BY' => -181,
			".." => -181,
			'OP07_MATH_MULT_DIV_MOD' => -181,
			'OP02_HASH_THINARROW' => 197,
			"}" => -181,
			'OP18_TERNARY' => -181,
			'OP16_LOGICAL_OR' => -181,
			'OP09_BITWISE_SHIFT' => -181,
			'OP15_LOGICAL_AND' => -181,
			'OP21_LIST_COMMA' => -181,
			'OP23_LOGICAL_AND' => -181,
			'OP06_REGEX_MATCH' => -181,
			'OP19_VARIABLE_ASSIGN' => -181,
			'COLON' => -181,
			";" => -181,
			"]" => -181,
			'OP08_MATH_ADD_SUB' => -181,
			'OP08_STRING_CAT' => -181,
			'OP13_BITWISE_AND' => -181,
			'OP03_MATH_INC_DEC' => -181,
			'OP14_BITWISE_OR_XOR' => -181
		},
		GOTOS => {
			'VariableRetrieval' => 198
		}
	},
	{#State 130
		ACTIONS => {
			"]" => -106,
			";" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP06_REGEX_MATCH' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP18_TERNARY' => -106,
			'OP13_BITWISE_AND' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP08_STRING_CAT' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP04_MATH_POW' => 148,
			")" => -106,
			'OP17_LIST_RANGE' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			"}" => -106,
			".." => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP11_COMPARE_LT_GT' => -106
		}
	},
	{#State 131
		ACTIONS => {
			".." => -123,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			"}" => -123,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			")" => -123,
			'OP17_LIST_RANGE' => 146,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP23_LOGICAL_AND' => -123,
			'OP06_REGEX_MATCH' => 142,
			"]" => -123,
			";" => -123,
			'OP18_TERNARY' => 141,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP21_LIST_COMMA' => -123,
			'OP15_LOGICAL_AND' => 135
		}
	},
	{#State 132
		ACTIONS => {
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"[" => 74,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62
		},
		GOTOS => {
			'HashReference' => 69,
			'Expression' => 199,
			'Variable' => 109,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'ArrayDereferenced' => 57,
			'Operator' => 51
		}
	},
	{#State 133
		ACTIONS => {
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58,
			"[" => 74
		},
		GOTOS => {
			'Expression' => 200,
			'Variable' => 109,
			'HashReference' => 69,
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'WordScoped' => 78,
			'ArrayReference' => 63
		}
	},
	{#State 134
		ACTIONS => {
			"[" => 74,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73
		},
		GOTOS => {
			'HashReference' => 69,
			'Expression' => 201,
			'Variable' => 109,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'ArrayDereferenced' => 57,
			'Operator' => 51
		}
	},
	{#State 135
		ACTIONS => {
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9
		},
		GOTOS => {
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'HashReference' => 69,
			'Variable' => 109,
			'Expression' => 202
		}
	},
	{#State 136
		DEFAULT => -98
	},
	{#State 137
		ACTIONS => {
			"undef" => 66,
			'LITERAL_STRING' => 50,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_NUMBER' => 62,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9
		},
		GOTOS => {
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'Variable' => 109,
			'Expression' => 203,
			'HashReference' => 69
		}
	},
	{#State 138
		ACTIONS => {
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"[" => 74,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88
		},
		GOTOS => {
			'HashReference' => 69,
			'Variable' => 109,
			'Expression' => 204,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'Operator' => 51,
			'ArrayDereferenced' => 57
		}
	},
	{#State 139
		ACTIONS => {
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9
		},
		GOTOS => {
			'Expression' => 205,
			'Variable' => 109,
			'HashReference' => 69,
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'ArrayReference' => 63,
			'WordScoped' => 78
		}
	},
	{#State 140
		ACTIONS => {
			'WORD' => 9,
			'OP05_MATH_NEG' => 88,
			"[" => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58,
			'OP05_LOGICAL_NEG' => 68,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			"undef" => 66,
			'LITERAL_STRING' => 50
		},
		GOTOS => {
			'HashReference' => 69,
			'Expression' => 206,
			'Variable' => 109,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'ArrayDereferenced' => 57,
			'Operator' => 51
		}
	},
	{#State 141
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67
		},
		GOTOS => {
			'Variable' => 207
		}
	},
	{#State 142
		ACTIONS => {
			"/" => 208
		}
	},
	{#State 143
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 68,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88,
			"[" => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58
		},
		GOTOS => {
			'HashReference' => 69,
			'Variable' => 109,
			'Expression' => 209,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'Operator' => 51,
			'ArrayDereferenced' => 57
		}
	},
	{#State 144
		ACTIONS => {
			"[" => 74,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'OP05_LOGICAL_NEG' => 68,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70
		},
		GOTOS => {
			'HashReference' => 69,
			'Variable' => 109,
			'Expression' => 210,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'Operator' => 51,
			'ArrayDereferenced' => 57
		}
	},
	{#State 145
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_NUMBER' => 62,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"[" => 74
		},
		GOTOS => {
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'HashReference' => 69,
			'Variable' => 109,
			'Expression' => 211
		}
	},
	{#State 146
		ACTIONS => {
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'OP05_LOGICAL_NEG' => 68,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			"[" => 74,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			"\@{" => 58,
			"(" => 56,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88
		},
		GOTOS => {
			'HashReference' => 69,
			'Expression' => 212,
			'Variable' => 109,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'ArrayDereferenced' => 57,
			'Operator' => 51
		}
	},
	{#State 147
		ACTIONS => {
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68
		},
		GOTOS => {
			'HashReference' => 69,
			'Expression' => 213,
			'Variable' => 109,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'ArrayDereferenced' => 57,
			'Operator' => 51
		}
	},
	{#State 148
		ACTIONS => {
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"[" => 74,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88
		},
		GOTOS => {
			'HashReference' => 69,
			'Expression' => 214,
			'Variable' => 109,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'ArrayDereferenced' => 57,
			'Operator' => 51
		}
	},
	{#State 149
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 133,
			'OP13_BITWISE_AND' => 132,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP23_LOGICAL_AND' => 137,
			'OP06_REGEX_MATCH' => 142,
			'OP15_LOGICAL_AND' => 135,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP18_TERNARY' => 141,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			")" => 215,
			'OP17_LIST_RANGE' => 146
		}
	},
	{#State 150
		ACTIONS => {
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			"my" => 152,
			'WORD' => 9,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"{" => 52,
			'KEYS_OR_VALUES' => 128,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			")" => -101
		},
		GOTOS => {
			'HashReference' => 69,
			'TypeInner' => 124,
			'Expression' => 125,
			'ListElements' => 216,
			'Variable' => 109,
			'ListElement' => 126,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'OPTIONAL-42' => 217,
			'ArrayDereferenced' => 57,
			'Operator' => 51
		}
	},
	{#State 151
		ACTIONS => {
			"]" => 218
		}
	},
	{#State 152
		ACTIONS => {
			'WORD' => 161
		},
		GOTOS => {
			'Type' => 188
		}
	},
	{#State 153
		DEFAULT => -196
	},
	{#State 154
		DEFAULT => -126
	},
	{#State 155
		ACTIONS => {
			")" => 219
		}
	},
	{#State 156
		ACTIONS => {
			'OP05_MATH_NEG' => 88,
			"my" => 152,
			'WORD' => 9,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"[" => 74,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			'VARIABLE_SYMBOL' => 67,
			'KEYS_OR_VALUES' => 128,
			"{" => 52,
			")" => -129,
			'OP05_LOGICAL_NEG' => 68,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'TypeInner' => 124,
			'Expression' => 125,
			'ListElements' => 220,
			'ListElement' => 126,
			'Variable' => 109,
			'HashReference' => 69,
			'OPTIONAL-44' => 221,
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'WordScoped' => 78,
			'ArrayReference' => 63
		}
	},
	{#State 157
		ACTIONS => {
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			")" => -140,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'KEYS_OR_VALUES' => 128,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			"my" => 152
		},
		GOTOS => {
			'OPTIONAL-47' => 223,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'HashReference' => 69,
			'Expression' => 125,
			'TypeInner' => 124,
			'Variable' => 109,
			'ListElement' => 126,
			'ListElements' => 222
		}
	},
	{#State 158
		DEFAULT => -13
	},
	{#State 159
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => -113,
			'OP17_LIST_RANGE' => -113,
			")" => -113,
			".." => -113,
			"}" => -113,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP11_COMPARE_LT_GT' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP06_REGEX_MATCH' => 142,
			"]" => -113,
			";" => -113,
			'OP18_TERNARY' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP13_BITWISE_AND' => -113
		}
	},
	{#State 160
		DEFAULT => -103
	},
	{#State 161
		DEFAULT => -218
	},
	{#State 162
		ACTIONS => {
			'VARIABLE_SYMBOL' => 224
		}
	},
	{#State 163
		DEFAULT => -219
	},
	{#State 164
		ACTIONS => {
			";" => 225
		}
	},
	{#State 165
		DEFAULT => -155
	},
	{#State 166
		ACTIONS => {
			'VARIABLE_SYMBOL' => 226
		}
	},
	{#State 167
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			")" => 227,
			'OP17_LIST_RANGE' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 139,
			'OP15_LOGICAL_AND' => 135,
			'OP18_TERNARY' => 141,
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134
		}
	},
	{#State 168
		ACTIONS => {
			"my" => 152
		},
		GOTOS => {
			'TypeInner' => 228
		}
	},
	{#State 169
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 229
		}
	},
	{#State 170
		DEFAULT => -24
	},
	{#State 171
		ACTIONS => {
			"1;" => 230
		}
	},
	{#State 172
		DEFAULT => -31
	},
	{#State 173
		ACTIONS => {
			";" => 231
		}
	},
	{#State 174
		DEFAULT => -211
	},
	{#State 175
		DEFAULT => -212
	},
	{#State 176
		ACTIONS => {
			"}" => 234,
			'OP21_LIST_COMMA' => 232
		},
		GOTOS => {
			'PAREN-61' => 233
		}
	},
	{#State 177
		ACTIONS => {
			"[" => -202,
			"(" => -202,
			"\@{" => -202,
			'OP10_NAMED_UNARY_STRINGIFY' => -202,
			'OP10_NAMED_UNARY' => -202,
			'OP03_MATH_INC_DEC' => -202,
			"my" => 152,
			'WORD' => -202,
			'OP05_MATH_NEG' => -202,
			'WORD_SCOPED' => -202,
			"%{" => -202,
			'LITERAL_NUMBER' => -202,
			"undef" => -202,
			'LITERAL_STRING' => -202,
			"{" => -202,
			'VARIABLE_SYMBOL' => -202,
			'OP05_LOGICAL_NEG' => -202,
			'OP22_LOGICAL_NOT' => -202,
			'OP01_NAMED' => -202
		},
		GOTOS => {
			'TypeInner' => 235,
			'OPTIONAL-60' => 236
		}
	},
	{#State 178
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 141,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP15_LOGICAL_AND' => 135,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137,
			";" => 237,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP17_LIST_RANGE' => 146,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148
		}
	},
	{#State 179
		ACTIONS => {
			'OP17_LIST_RANGE' => 146,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP18_TERNARY' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 139,
			'OP15_LOGICAL_AND' => 135,
			'OP23_LOGICAL_AND' => 137,
			'OP06_REGEX_MATCH' => 142,
			";" => 238,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133
		}
	},
	{#State 180
		ACTIONS => {
			"(" => 239
		}
	},
	{#State 181
		DEFAULT => -154
	},
	{#State 182
		DEFAULT => -199
	},
	{#State 183
		DEFAULT => -200
	},
	{#State 184
		ACTIONS => {
			'VARIABLE_SYMBOL' => 240
		}
	},
	{#State 185
		ACTIONS => {
			"(" => 241
		}
	},
	{#State 186
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP17_LIST_RANGE' => 146,
			")" => 242,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 138,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP13_BITWISE_AND' => 132,
			'OP18_TERNARY' => 141,
			'OP15_LOGICAL_AND' => 135,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 139,
			'OP23_LOGICAL_AND' => 137,
			'OP06_REGEX_MATCH' => 142
		}
	},
	{#State 187
		ACTIONS => {
			'VARIABLE_SYMBOL' => 243
		}
	},
	{#State 188
		ACTIONS => {
			"\$TYPED_" => 244
		}
	},
	{#State 189
		DEFAULT => -136
	},
	{#State 190
		ACTIONS => {
			"}" => 245
		}
	},
	{#State 191
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP13_BITWISE_AND' => 132,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137,
			";" => -194,
			"]" => -194,
			'OP18_TERNARY' => 141,
			'OP21_LIST_COMMA' => -194,
			'OP15_LOGICAL_AND' => 135,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP17_LIST_RANGE' => 146,
			")" => -194
		}
	},
	{#State 192
		ACTIONS => {
			'OP21_LIST_COMMA' => 246,
			")" => -192,
			";" => -192,
			"]" => -192
		},
		GOTOS => {
			'PAREN-57' => 247
		}
	},
	{#State 193
		DEFAULT => -132
	},
	{#State 194
		ACTIONS => {
			";" => 248
		}
	},
	{#State 195
		DEFAULT => -195
	},
	{#State 196
		ACTIONS => {
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9
		},
		GOTOS => {
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'Variable' => 109,
			'Expression' => 249,
			'HashReference' => 69
		}
	},
	{#State 197
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			'OP05_MATH_NEG' => 88,
			'WORD' => 250,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"[" => 74
		},
		GOTOS => {
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'Expression' => 251,
			'Variable' => 109,
			'HashReference' => 69
		}
	},
	{#State 198
		DEFAULT => -179
	},
	{#State 199
		ACTIONS => {
			")" => -117,
			'OP17_LIST_RANGE' => -117,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => -117,
			".." => -117,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			"}" => -117,
			'OP18_TERNARY' => -117,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => -117,
			'OP21_LIST_COMMA' => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP23_LOGICAL_AND' => -117,
			'OP06_REGEX_MATCH' => 142,
			";" => -117,
			"]" => -117,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP13_BITWISE_AND' => -117,
			'OP14_BITWISE_OR_XOR' => -117
		}
	},
	{#State 200
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -118,
			'OP13_BITWISE_AND' => 132,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			";" => -118,
			"]" => -118,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP21_LIST_COMMA' => -118,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => -118,
			'OP18_TERNARY' => -118,
			"}" => -118,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			".." => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			")" => -118,
			'OP17_LIST_RANGE' => -118
		}
	},
	{#State 201
		ACTIONS => {
			")" => -111,
			'OP17_LIST_RANGE' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP04_MATH_POW' => 148,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			"}" => -111,
			".." => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP18_TERNARY' => -111,
			"]" => -111,
			";" => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP06_REGEX_MATCH' => 142,
			'OP13_BITWISE_AND' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP08_STRING_CAT' => -111,
			'OP08_MATH_ADD_SUB' => 138
		}
	},
	{#State 202
		ACTIONS => {
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP18_TERNARY' => -119,
			"]" => -119,
			";" => -119,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP11_COMPARE_LT_GT' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			"}" => -119,
			".." => -119,
			'OP17_LIST_RANGE' => -119,
			")" => -119,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148
		}
	},
	{#State 203
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 146,
			")" => -124,
			".." => -124,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			"}" => -124,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP23_LOGICAL_AND' => -124,
			'OP06_REGEX_MATCH' => 142,
			";" => -124,
			"]" => -124,
			'OP18_TERNARY' => 141,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP21_LIST_COMMA' => -124,
			'OP15_LOGICAL_AND' => 135,
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 138,
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133
		}
	},
	{#State 204
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -110,
			'OP13_BITWISE_AND' => -110,
			'OP08_MATH_ADD_SUB' => -110,
			'OP08_STRING_CAT' => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP18_TERNARY' => -110,
			"]" => -110,
			";" => -110,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			"}" => -110,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			".." => -110,
			'OP17_LIST_RANGE' => -110,
			")" => -110,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => -110
		}
	},
	{#State 205
		ACTIONS => {
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => -120,
			"]" => -120,
			";" => -120,
			'OP18_TERNARY' => -120,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => -120,
			'OP21_LIST_COMMA' => -120,
			'OP15_LOGICAL_AND' => 135,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			")" => -120,
			'OP17_LIST_RANGE' => -120,
			".." => -120,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			"}" => -120,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => -120
		}
	},
	{#State 206
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			".." => -112,
			"}" => -112,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP17_LIST_RANGE' => -112,
			")" => -112,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 138,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP18_TERNARY' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => -112,
			";" => -112,
			"]" => -112
		}
	},
	{#State 207
		ACTIONS => {
			'COLON' => 252
		}
	},
	{#State 208
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 253
		}
	},
	{#State 209
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => -125,
			".." => -125,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			"}" => -125,
			'OP17_LIST_RANGE' => 146,
			")" => -125,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 141,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP21_LIST_COMMA' => -125,
			'OP15_LOGICAL_AND' => 135,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137,
			";" => -125,
			"]" => -125
		}
	},
	{#State 210
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -115,
			'OP13_BITWISE_AND' => -115,
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 138,
			'OP15_LOGICAL_AND' => -115,
			'OP21_LIST_COMMA' => -115,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => -115,
			'OP18_TERNARY' => -115,
			";" => -115,
			"]" => -115,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP11_COMPARE_LT_GT' => undef,
			"}" => -115,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			".." => -115,
			")" => -115,
			'OP17_LIST_RANGE' => -115,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => -115
		}
	},
	{#State 211
		ACTIONS => {
			'OP18_TERNARY' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => -109,
			"]" => -109,
			";" => -109,
			'OP08_STRING_CAT' => -109,
			'OP08_MATH_ADD_SUB' => -109,
			'OP13_BITWISE_AND' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			")" => -109,
			'OP17_LIST_RANGE' => -109,
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP04_MATH_POW' => 148,
			'OP11_COMPARE_LT_GT' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			".." => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109,
			"}" => -109
		}
	},
	{#State 212
		ACTIONS => {
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 138,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 139,
			'OP15_LOGICAL_AND' => 135,
			'OP21_LIST_COMMA' => -121,
			'OP18_TERNARY' => -121,
			"]" => -121,
			";" => -121,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP11_COMPARE_LT_GT' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			"}" => -121,
			".." => -121,
			'OP17_LIST_RANGE' => undef,
			")" => -121,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148
		}
	},
	{#State 213
		ACTIONS => {
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 138,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP13_BITWISE_AND' => -116,
			'OP18_TERNARY' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP06_REGEX_MATCH' => 142,
			"]" => -116,
			";" => -116,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => -116,
			".." => -116,
			"}" => -116,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP17_LIST_RANGE' => -116,
			")" => -116,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => undef
		}
	},
	{#State 214
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			".." => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			"}" => -105,
			")" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => -105,
			'OP08_STRING_CAT' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP18_TERNARY' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP06_REGEX_MATCH' => -105,
			";" => -105,
			"]" => -105
		}
	},
	{#State 215
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 255
		}
	},
	{#State 216
		DEFAULT => -100
	},
	{#State 217
		ACTIONS => {
			")" => 256
		}
	},
	{#State 218
		DEFAULT => -198
	},
	{#State 219
		ACTIONS => {
			";" => 257
		}
	},
	{#State 220
		DEFAULT => -128
	},
	{#State 221
		ACTIONS => {
			")" => 258
		}
	},
	{#State 222
		DEFAULT => -139
	},
	{#State 223
		ACTIONS => {
			")" => 259
		}
	},
	{#State 224
		ACTIONS => {
			";" => 261,
			'OP19_VARIABLE_ASSIGN' => 260
		}
	},
	{#State 225
		DEFAULT => -138
	},
	{#State 226
		ACTIONS => {
			"= sub {" => 262
		}
	},
	{#State 227
		DEFAULT => -107
	},
	{#State 228
		ACTIONS => {
			'LITERAL_NUMBER' => 62,
			"{" => 264,
			"[" => 263,
			'LITERAL_STRING' => 50
		},
		GOTOS => {
			'Literal' => 265,
			'ConstantValue' => 266
		}
	},
	{#State 229
		ACTIONS => {
			"our %properties = (" => -71,
			"use" => -71,
			"## no critic qw(" => 20,
			"use constant" => -71
		},
		GOTOS => {
			'Critic' => 268,
			'STAR-29' => 267
		}
	},
	{#State 230
		DEFAULT => -26
	},
	{#State 231
		DEFAULT => -34
	},
	{#State 232
		ACTIONS => {
			"%{" => 49,
			'WORD' => 103
		},
		GOTOS => {
			'HashDereferenced' => 102,
			'HashEntry' => 269
		}
	},
	{#State 233
		DEFAULT => -208
	},
	{#State 234
		DEFAULT => -210
	},
	{#State 235
		DEFAULT => -201
	},
	{#State 236
		ACTIONS => {
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'OP05_LOGICAL_NEG' => 68,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			"[" => 74,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			"\@{" => 58,
			"(" => 56,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88
		},
		GOTOS => {
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'Variable' => 109,
			'Expression' => 270,
			'HashReference' => 69
		}
	},
	{#State 237
		DEFAULT => -188
	},
	{#State 238
		DEFAULT => -187
	},
	{#State 239
		ACTIONS => {
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			"my" => 152,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_NUMBER' => 62,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			")" => -142,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'KEYS_OR_VALUES' => 128
		},
		GOTOS => {
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'Variable' => 109,
			'ListElement' => 126,
			'ListElements' => 272,
			'Expression' => 125,
			'TypeInner' => 124,
			'HashReference' => 69,
			'OPTIONAL-48' => 271
		}
	},
	{#State 240
		ACTIONS => {
			"(" => 273
		}
	},
	{#State 241
		ACTIONS => {
			"undef" => 66,
			'LITERAL_STRING' => 50,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_NUMBER' => 62,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9
		},
		GOTOS => {
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'Expression' => 274,
			'Variable' => 109,
			'HashReference' => 69
		}
	},
	{#State 242
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 275
		}
	},
	{#State 243
		DEFAULT => -216
	},
	{#State 244
		ACTIONS => {
			'WORD' => 276
		}
	},
	{#State 245
		DEFAULT => -215
	},
	{#State 246
		ACTIONS => {
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'VARIABLE_SYMBOL' => 67,
			'KEYS_OR_VALUES' => 128,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"[" => 74,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"my" => 152,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88
		},
		GOTOS => {
			'Expression' => 125,
			'TypeInner' => 124,
			'ListElement' => 277,
			'Variable' => 109,
			'HashReference' => 69,
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'ArrayReference' => 63,
			'WordScoped' => 78
		}
	},
	{#State 247
		DEFAULT => -190
	},
	{#State 248
		DEFAULT => -137
	},
	{#State 249
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP17_LIST_RANGE' => 146,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP13_BITWISE_AND' => 132,
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 138,
			"]" => 278,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137,
			'OP15_LOGICAL_AND' => 135,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP18_TERNARY' => 141
		}
	},
	{#State 250
		ACTIONS => {
			"(" => -213,
			"}" => 279
		}
	},
	{#State 251
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP17_LIST_RANGE' => 146,
			"}" => 280,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137,
			'OP15_LOGICAL_AND' => 135,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP13_BITWISE_AND' => 132,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134
		}
	},
	{#State 252
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67
		},
		GOTOS => {
			'Variable' => 281
		}
	},
	{#State 253
		ACTIONS => {
			"/" => 282
		}
	},
	{#State 254
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 70,
			"if (" => 72,
			'OP01_NAMED' => 73,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			"undef" => 66,
			'OP01_NAMED_VOID' => 65,
			'LITERAL_STRING' => 50,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_NUMBER' => 62,
			"while (" => -157,
			"foreach my" => -157,
			'OP05_MATH_NEG' => 88,
			"my" => 82,
			"for my integer" => -157,
			'WORD' => 84,
			'OP19_LOOP_CONTROL' => 85,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"[" => 74,
			'OP01_NAMED_VOID_PAREN' => 76
		},
		GOTOS => {
			'Conditional' => 61,
			'PLUS-55' => 284,
			'Operation' => 283,
			'OperatorVoid' => 60,
			'VariableDeclaration' => 89,
			'LoopLabel' => 86,
			'VariableModification' => 77,
			'WordScoped' => 78,
			'Statement' => 55,
			'ArrayDereferenced' => 57,
			'HashReference' => 69,
			'Variable' => 54,
			'PAREN-49' => 53,
			'Expression' => 71,
			'ArrayReference' => 63,
			'OPTIONAL-50' => 64,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'Operator' => 51
		}
	},
	{#State 255
		DEFAULT => -165,
		GOTOS => {
			'STAR-52' => 285
		}
	},
	{#State 256
		DEFAULT => -102
	},
	{#State 257
		DEFAULT => -134
	},
	{#State 258
		ACTIONS => {
			";" => 286
		}
	},
	{#State 259
		DEFAULT => -152
	},
	{#State 260
		ACTIONS => {
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9
		},
		GOTOS => {
			'Expression' => 287,
			'Variable' => 109,
			'HashReference' => 69,
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'WordScoped' => 78,
			'ArrayReference' => 63
		}
	},
	{#State 261
		DEFAULT => -185
	},
	{#State 262
		ACTIONS => {
			"foreach my" => -54,
			'OP05_MATH_NEG' => -54,
			"while (" => -54,
			"( my" => 288,
			'OP19_LOOP_CONTROL' => -54,
			'WORD' => -54,
			"my" => -54,
			"for my integer" => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			'OP10_NAMED_UNARY' => -54,
			'OP03_MATH_INC_DEC' => -54,
			"(" => -54,
			"\@{" => -54,
			"[" => -54,
			'OP01_NAMED_VOID_PAREN' => -54,
			"if (" => -54,
			'OP01_NAMED' => -54,
			'OP22_LOGICAL_NOT' => -54,
			'OP05_LOGICAL_NEG' => -54,
			"{" => -54,
			'VARIABLE_SYMBOL' => -54,
			'OP01_NAMED_VOID' => -54,
			"undef" => -54,
			'LITERAL_STRING' => -54,
			"%{" => -54,
			'WORD_SCOPED' => -54,
			'LITERAL_NUMBER' => -54
		},
		GOTOS => {
			'SubroutineArguments' => 290,
			'OPTIONAL-21' => 289
		}
	},
	{#State 263
		ACTIONS => {
			'LITERAL_NUMBER' => -37,
			"my" => 152,
			'LITERAL_STRING' => -37
		},
		GOTOS => {
			'OPTIONAL-13' => 291,
			'TypeInner' => 292
		}
	},
	{#State 264
		ACTIONS => {
			'WORD' => 293
		}
	},
	{#State 265
		DEFAULT => -50
	},
	{#State 266
		ACTIONS => {
			";" => 294
		}
	},
	{#State 267
		ACTIONS => {
			"use constant" => -73,
			"use" => 29,
			"our %properties = (" => -73
		},
		GOTOS => {
			'Include' => 296,
			'STAR-30' => 295
		}
	},
	{#State 268
		DEFAULT => -68
	},
	{#State 269
		DEFAULT => -207
	},
	{#State 270
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 145,
			"}" => -203,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 146,
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 138,
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP23_LOGICAL_AND' => 137,
			'OP06_REGEX_MATCH' => 142,
			'OP18_TERNARY' => 141,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP21_LIST_COMMA' => -203,
			'OP15_LOGICAL_AND' => 135
		}
	},
	{#State 271
		ACTIONS => {
			")" => 297
		}
	},
	{#State 272
		DEFAULT => -141
	},
	{#State 273
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 68,
			'KEYS_OR_VALUES' => 128,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'WORD' => 9,
			"my" => 152,
			'OP05_MATH_NEG' => 88,
			"[" => 74,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			"\@{" => 58,
			"(" => 56
		},
		GOTOS => {
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'ListElements' => 298,
			'Variable' => 109,
			'ListElement' => 126,
			'TypeInner' => 124,
			'Expression' => 125,
			'HashReference' => 69
		}
	},
	{#State 274
		ACTIONS => {
			'OP15_LOGICAL_AND' => 135,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP18_TERNARY' => 141,
			'OP23_LOGICAL_AND' => 137,
			'OP06_REGEX_MATCH' => 142,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP13_BITWISE_AND' => 132,
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 138,
			'OP17_LIST_RANGE' => 146,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			".." => 299
		}
	},
	{#State 275
		DEFAULT => -175
	},
	{#State 276
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 300
		}
	},
	{#State 277
		DEFAULT => -189
	},
	{#State 278
		DEFAULT => -182
	},
	{#State 279
		DEFAULT => -184
	},
	{#State 280
		DEFAULT => -183
	},
	{#State 281
		DEFAULT => -122
	},
	{#State 282
		DEFAULT => -108
	},
	{#State 283
		DEFAULT => -177
	},
	{#State 284
		ACTIONS => {
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"[" => 74,
			'OP01_NAMED_VOID_PAREN' => 76,
			"while (" => -157,
			"foreach my" => -157,
			'OP05_MATH_NEG' => 88,
			"my" => 82,
			"for my integer" => -157,
			'WORD' => 84,
			'OP19_LOOP_CONTROL' => 85,
			'OP01_NAMED_VOID' => 65,
			"}" => 302,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			'OP22_LOGICAL_NOT' => 70,
			"if (" => 72,
			'OP01_NAMED' => 73,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68
		},
		GOTOS => {
			'HashReference' => 69,
			'PAREN-49' => 53,
			'Expression' => 71,
			'Variable' => 54,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'ArrayReference' => 63,
			'OPTIONAL-50' => 64,
			'Operator' => 51,
			'Operation' => 301,
			'OperatorVoid' => 60,
			'Conditional' => 61,
			'LoopLabel' => 86,
			'VariableDeclaration' => 89,
			'Statement' => 55,
			'WordScoped' => 78,
			'VariableModification' => 77,
			'ArrayDereferenced' => 57
		}
	},
	{#State 285
		ACTIONS => {
			"elsif (" => 307,
			'OP01_NAMED_VOID_PAREN' => -168,
			"[" => -168,
			'OP03_MATH_INC_DEC' => -168,
			'OP10_NAMED_UNARY_STRINGIFY' => -168,
			'OP10_NAMED_UNARY' => -168,
			"\@{" => -168,
			"(" => -168,
			'' => -168,
			'OP19_LOOP_CONTROL' => -168,
			'WORD' => -168,
			"for my integer" => -168,
			"my" => -168,
			'OP05_MATH_NEG' => -168,
			"else" => 304,
			"foreach my" => -168,
			"while (" => -168,
			'LITERAL_NUMBER' => -168,
			"%{" => -168,
			'WORD_SCOPED' => -168,
			'LITERAL_STRING' => -168,
			'OP01_NAMED_VOID' => -168,
			"undef" => -168,
			"}" => -168,
			'OP05_LOGICAL_NEG' => -168,
			'VARIABLE_SYMBOL' => -168,
			"{" => -168,
			'OP01_NAMED' => -168,
			"if (" => -168,
			'OP22_LOGICAL_NOT' => -168
		},
		GOTOS => {
			'PAREN-51' => 305,
			'OPTIONAL-54' => 306,
			'PAREN-53' => 303
		}
	},
	{#State 286
		DEFAULT => -135
	},
	{#State 287
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP17_LIST_RANGE' => 146,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP13_BITWISE_AND' => 132,
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 138,
			'OP15_LOGICAL_AND' => 135,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 139,
			'OP18_TERNARY' => 141,
			";" => 308,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137
		}
	},
	{#State 288
		ACTIONS => {
			'WORD' => 161
		},
		GOTOS => {
			'Type' => 309
		}
	},
	{#State 289
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"if (" => 72,
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'OP01_NAMED_VOID' => 65,
			"for my integer" => -157,
			"my" => 82,
			'OP19_LOOP_CONTROL' => 85,
			'WORD' => 84,
			"while (" => -157,
			'OP05_MATH_NEG' => 88,
			"foreach my" => -157,
			'OP01_NAMED_VOID_PAREN' => 76,
			"[" => 74,
			"\@{" => 58,
			"(" => 56,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59
		},
		GOTOS => {
			'ArrayDereferenced' => 57,
			'WordScoped' => 78,
			'VariableModification' => 77,
			'Statement' => 55,
			'VariableDeclaration' => 89,
			'PLUS-22' => 310,
			'LoopLabel' => 86,
			'Conditional' => 61,
			'Operation' => 311,
			'OperatorVoid' => 60,
			'Operator' => 51,
			'OPTIONAL-50' => 64,
			'ArrayReference' => 63,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'Variable' => 54,
			'PAREN-49' => 53,
			'Expression' => 71,
			'HashReference' => 69
		}
	},
	{#State 290
		DEFAULT => -53
	},
	{#State 291
		ACTIONS => {
			'LITERAL_STRING' => 50,
			'LITERAL_NUMBER' => 62
		},
		GOTOS => {
			'Literal' => 312
		}
	},
	{#State 292
		DEFAULT => -36
	},
	{#State 293
		ACTIONS => {
			'OP20_HASH_FATARROW' => 313
		}
	},
	{#State 294
		DEFAULT => -35
	},
	{#State 295
		ACTIONS => {
			"our %properties = (" => 314,
			"use constant" => 40
		},
		GOTOS => {
			'Constant' => 316,
			'Properties' => 315
		}
	},
	{#State 296
		DEFAULT => -70
	},
	{#State 297
		DEFAULT => -153
	},
	{#State 298
		ACTIONS => {
			")" => 317
		}
	},
	{#State 299
		ACTIONS => {
			'OP05_MATH_NEG' => 88,
			'WORD' => 9,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"[" => 74,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_NUMBER' => 62
		},
		GOTOS => {
			'HashDereferenced' => 47,
			'Literal' => 48,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'HashReference' => 69,
			'Expression' => 318,
			'Variable' => 109
		}
	},
	{#State 300
		DEFAULT => -217
	},
	{#State 301
		DEFAULT => -176
	},
	{#State 302
		DEFAULT => -178
	},
	{#State 303
		DEFAULT => -167
	},
	{#State 304
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 319
		}
	},
	{#State 305
		DEFAULT => -164
	},
	{#State 306
		DEFAULT => -169
	},
	{#State 307
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 68,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_NUMBER' => 62,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88,
			"[" => 74,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"(" => 56,
			"\@{" => 58
		},
		GOTOS => {
			'Variable' => 109,
			'Expression' => 320,
			'HashReference' => 69,
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'Literal' => 48,
			'HashDereferenced' => 47
		}
	},
	{#State 308
		DEFAULT => -186
	},
	{#State 309
		ACTIONS => {
			'VARIABLE_SYMBOL' => 321
		}
	},
	{#State 310
		ACTIONS => {
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			'OP01_NAMED_VOID' => 65,
			"}" => 323,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			"if (" => 72,
			'OP01_NAMED' => 73,
			"[" => 74,
			'OP01_NAMED_VOID_PAREN' => 76,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"my" => 82,
			"for my integer" => -157,
			'WORD' => 84,
			'OP19_LOOP_CONTROL' => 85,
			"while (" => -157,
			"foreach my" => -157,
			'OP05_MATH_NEG' => 88
		},
		GOTOS => {
			'Operator' => 51,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'OPTIONAL-50' => 64,
			'ArrayReference' => 63,
			'PAREN-49' => 53,
			'Expression' => 71,
			'Variable' => 54,
			'HashReference' => 69,
			'ArrayDereferenced' => 57,
			'Statement' => 55,
			'WordScoped' => 78,
			'VariableModification' => 77,
			'LoopLabel' => 86,
			'VariableDeclaration' => 89,
			'Operation' => 322,
			'OperatorVoid' => 60,
			'Conditional' => 61
		}
	},
	{#State 311
		DEFAULT => -56
	},
	{#State 312
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 324
		}
	},
	{#State 313
		ACTIONS => {
			'LITERAL_NUMBER' => -44,
			"my" => 152,
			'LITERAL_STRING' => -44
		},
		GOTOS => {
			'OPTIONAL-17' => 325,
			'TypeInner' => 326
		}
	},
	{#State 314
		ACTIONS => {
			'WORD' => 328,
			")" => 329,
			"%{" => 49
		},
		GOTOS => {
			'HashDereferenced' => 330,
			'HashEntryTyped' => 327
		}
	},
	{#State 315
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 331
		}
	},
	{#State 316
		DEFAULT => -72
	},
	{#State 317
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 332
		}
	},
	{#State 318
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			")" => 333,
			'OP17_LIST_RANGE' => 146,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137,
			'OP18_TERNARY' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 139,
			'OP15_LOGICAL_AND' => 135
		}
	},
	{#State 319
		DEFAULT => -166
	},
	{#State 320
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			")" => 334,
			'OP17_LIST_RANGE' => 146,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP13_BITWISE_AND' => 132,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137,
			'OP15_LOGICAL_AND' => 135,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 139,
			'OP18_TERNARY' => 141
		}
	},
	{#State 321
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 335
		}
	},
	{#State 322
		DEFAULT => -55
	},
	{#State 323
		ACTIONS => {
			";" => 336
		}
	},
	{#State 324
		ACTIONS => {
			"]" => 337,
			'OP21_LIST_COMMA' => 339
		},
		GOTOS => {
			'PAREN-15' => 338
		}
	},
	{#State 325
		ACTIONS => {
			'LITERAL_STRING' => 50,
			'LITERAL_NUMBER' => 62
		},
		GOTOS => {
			'Literal' => 340
		}
	},
	{#State 326
		DEFAULT => -43
	},
	{#State 327
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 341
		}
	},
	{#State 328
		ACTIONS => {
			'OP20_HASH_FATARROW' => 342
		}
	},
	{#State 329
		ACTIONS => {
			";" => 343
		}
	},
	{#State 330
		DEFAULT => -206
	},
	{#State 331
		ACTIONS => {
			"our" => 346,
			"1;" => 344
		},
		GOTOS => {
			'Method' => 345
		}
	},
	{#State 332
		DEFAULT => -174
	},
	{#State 333
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 347
		}
	},
	{#State 334
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 348
		}
	},
	{#State 335
		ACTIONS => {
			")" => 351,
			'OP21_LIST_COMMA' => 349
		},
		GOTOS => {
			'PAREN-23' => 350
		}
	},
	{#State 336
		DEFAULT => -57
	},
	{#State 337
		DEFAULT => -51
	},
	{#State 338
		DEFAULT => -41
	},
	{#State 339
		ACTIONS => {
			'LITERAL_STRING' => -39,
			"my" => 152,
			'LITERAL_NUMBER' => -39
		},
		GOTOS => {
			'OPTIONAL-14' => 353,
			'TypeInner' => 352
		}
	},
	{#State 340
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 354
		}
	},
	{#State 341
		ACTIONS => {
			")" => 357,
			'OP21_LIST_COMMA' => 355
		},
		GOTOS => {
			'PAREN-35' => 356
		}
	},
	{#State 342
		ACTIONS => {
			"my" => 152
		},
		GOTOS => {
			'TypeInner' => 358
		}
	},
	{#State 343
		DEFAULT => -86
	},
	{#State 344
		ACTIONS => {
			"1;" => 359
		}
	},
	{#State 345
		DEFAULT => -74
	},
	{#State 346
		ACTIONS => {
			'WORD' => 161
		},
		GOTOS => {
			'Type' => 360
		}
	},
	{#State 347
		DEFAULT => -173
	},
	{#State 348
		DEFAULT => -163
	},
	{#State 349
		ACTIONS => {
			"my" => 361
		}
	},
	{#State 350
		DEFAULT => -59
	},
	{#State 351
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 362
		}
	},
	{#State 352
		DEFAULT => -38
	},
	{#State 353
		ACTIONS => {
			'LITERAL_NUMBER' => 62,
			'LITERAL_STRING' => 50
		},
		GOTOS => {
			'Literal' => 363
		}
	},
	{#State 354
		ACTIONS => {
			"}" => 366,
			'OP21_LIST_COMMA' => 365
		},
		GOTOS => {
			'PAREN-19' => 364
		}
	},
	{#State 355
		ACTIONS => {
			"%{" => 49,
			'WORD' => 328
		},
		GOTOS => {
			'HashDereferenced' => 330,
			'HashEntryTyped' => 367
		}
	},
	{#State 356
		DEFAULT => -83
	},
	{#State 357
		ACTIONS => {
			";" => 368
		}
	},
	{#State 358
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 68,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'WORD' => 9,
			'OP05_MATH_NEG' => 88,
			"[" => 74,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"\@{" => 58,
			"(" => 56
		},
		GOTOS => {
			'WordScoped' => 78,
			'ArrayReference' => 63,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'Operator' => 51,
			'ArrayDereferenced' => 57,
			'HashReference' => 69,
			'Variable' => 109,
			'Expression' => 369
		}
	},
	{#State 359
		ACTIONS => {
			'' => -80,
			"package" => -80,
			"our" => 87
		},
		GOTOS => {
			'Subroutine' => 370,
			'PLUS-32' => 373,
			'OPTIONAL-34' => 372,
			'PAREN-33' => 371
		}
	},
	{#State 360
		ACTIONS => {
			'VARIABLE_SYMBOL' => 374
		}
	},
	{#State 361
		ACTIONS => {
			'WORD' => 161
		},
		GOTOS => {
			'Type' => 375
		}
	},
	{#State 362
		ACTIONS => {
			"\@_;" => 376
		}
	},
	{#State 363
		DEFAULT => -40
	},
	{#State 364
		DEFAULT => -48
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
		DEFAULT => -82
	},
	{#State 368
		DEFAULT => -85
	},
	{#State 369
		ACTIONS => {
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP15_LOGICAL_AND' => 135,
			'OP21_LIST_COMMA' => -205,
			'OP18_TERNARY' => 141,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 146,
			")" => -205
		}
	},
	{#State 370
		DEFAULT => -77
	},
	{#State 371
		DEFAULT => -79
	},
	{#State 372
		DEFAULT => -81
	},
	{#State 373
		ACTIONS => {
			"our" => 87,
			"1;" => 378
		},
		GOTOS => {
			'Subroutine' => 379
		}
	},
	{#State 374
		ACTIONS => {
			"= sub {" => 380
		}
	},
	{#State 375
		ACTIONS => {
			'VARIABLE_SYMBOL' => 381
		}
	},
	{#State 376
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 382
		}
	},
	{#State 377
		ACTIONS => {
			'OP20_HASH_FATARROW' => 383
		}
	},
	{#State 378
		ACTIONS => {
			"1;" => 384
		}
	},
	{#State 379
		DEFAULT => -76
	},
	{#State 380
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => -88,
			"[" => -88,
			"\@{" => -88,
			"(" => -88,
			'OP03_MATH_INC_DEC' => -88,
			'OP10_NAMED_UNARY' => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			"for my integer" => -88,
			"my" => -88,
			'WORD' => -88,
			'OP19_LOOP_CONTROL' => -88,
			"( my" => 387,
			"while (" => -88,
			'OP05_MATH_NEG' => -88,
			"foreach my" => -88,
			'LITERAL_NUMBER' => -88,
			'WORD_SCOPED' => -88,
			"%{" => -88,
			'LITERAL_STRING' => -88,
			"undef" => -88,
			'OP01_NAMED_VOID' => -88,
			'VARIABLE_SYMBOL' => -88,
			"{" => -88,
			'OP05_LOGICAL_NEG' => -88,
			'OP22_LOGICAL_NOT' => -88,
			'OP01_NAMED' => -88,
			"if (" => -88
		},
		GOTOS => {
			'MethodArguments' => 386,
			'OPTIONAL-37' => 385
		}
	},
	{#State 381
		DEFAULT => -58
	},
	{#State 382
		ACTIONS => {
			"[" => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			"(" => -63,
			"\@{" => -63,
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			'OP10_NAMED_UNARY' => -63,
			'OP03_MATH_INC_DEC' => -63,
			"my" => -63,
			"for my integer" => -63,
			'OP19_LOOP_CONTROL' => -63,
			'WORD' => -63,
			"while (" => -63,
			"foreach my" => -63,
			'OP05_MATH_NEG' => -63,
			'WORD_SCOPED' => -63,
			"%{" => -63,
			'LITERAL_NUMBER' => -63,
			"undef" => -63,
			'OP01_NAMED_VOID' => -63,
			'LITERAL_STRING' => -63,
			"{" => -63,
			'VARIABLE_SYMBOL' => -63,
			'OP05_LOGICAL_NEG' => -63,
			'OP22_LOGICAL_NOT' => -63,
			'CHECK_OR_CHECKTRACE' => 389,
			"if (" => -63,
			'OP01_NAMED' => -63
		},
		GOTOS => {
			'ArgumentCheck' => 388
		}
	},
	{#State 383
		ACTIONS => {
			"my" => 152,
			'LITERAL_NUMBER' => -46,
			'LITERAL_STRING' => -46
		},
		GOTOS => {
			'OPTIONAL-18' => 390,
			'TypeInner' => 391
		}
	},
	{#State 384
		DEFAULT => -78
	},
	{#State 385
		ACTIONS => {
			"[" => 74,
			'OP01_NAMED_VOID_PAREN' => 76,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP03_MATH_INC_DEC' => 81,
			"my" => 82,
			"for my integer" => -157,
			'OP19_LOOP_CONTROL' => 85,
			'WORD' => 84,
			"while (" => -157,
			"foreach my" => -157,
			'OP05_MATH_NEG' => 88,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'LITERAL_NUMBER' => 62,
			'OP01_NAMED_VOID' => 65,
			"undef" => 66,
			'LITERAL_STRING' => 50,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			"if (" => 72,
			'OP01_NAMED' => 73
		},
		GOTOS => {
			'OperatorVoid' => 60,
			'Operation' => 393,
			'Conditional' => 61,
			'LoopLabel' => 86,
			'VariableDeclaration' => 89,
			'Statement' => 55,
			'VariableModification' => 77,
			'WordScoped' => 78,
			'ArrayDereferenced' => 57,
			'HashReference' => 69,
			'Expression' => 71,
			'PAREN-49' => 53,
			'Variable' => 54,
			'PLUS-38' => 392,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'OPTIONAL-50' => 64,
			'ArrayReference' => 63,
			'Operator' => 51
		}
	},
	{#State 386
		DEFAULT => -87
	},
	{#State 387
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 394
		}
	},
	{#State 388
		DEFAULT => -61
	},
	{#State 389
		ACTIONS => {
			"(" => 395
		}
	},
	{#State 390
		ACTIONS => {
			'LITERAL_STRING' => 50,
			'LITERAL_NUMBER' => 62
		},
		GOTOS => {
			'Literal' => 396
		}
	},
	{#State 391
		DEFAULT => -45
	},
	{#State 392
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			"\@{" => 58,
			"(" => 56,
			'OP01_NAMED_VOID_PAREN' => 76,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			"foreach my" => -157,
			"while (" => -157,
			'WORD' => 84,
			'OP19_LOOP_CONTROL' => 85,
			"for my integer" => -157,
			"my" => 82,
			'LITERAL_STRING' => 50,
			'OP01_NAMED_VOID' => 65,
			"}" => 397,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'OP01_NAMED' => 73,
			"if (" => 72,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52
		},
		GOTOS => {
			'ArrayDereferenced' => 57,
			'Statement' => 55,
			'VariableModification' => 77,
			'WordScoped' => 78,
			'LoopLabel' => 86,
			'VariableDeclaration' => 89,
			'OperatorVoid' => 60,
			'Operation' => 398,
			'Conditional' => 61,
			'Operator' => 51,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'ArrayReference' => 63,
			'OPTIONAL-50' => 64,
			'Expression' => 71,
			'PAREN-49' => 53,
			'Variable' => 54,
			'HashReference' => 69
		}
	},
	{#State 393
		DEFAULT => -90
	},
	{#State 394
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 399
		}
	},
	{#State 395
		ACTIONS => {
			'WORD' => 9,
			'OP05_MATH_NEG' => 88,
			"[" => 74,
			"(" => 56,
			"\@{" => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			'OP03_MATH_INC_DEC' => 81,
			"{" => 52,
			'VARIABLE_SYMBOL' => 67,
			'OP05_LOGICAL_NEG' => 68,
			'OP22_LOGICAL_NOT' => 70,
			'OP01_NAMED' => 73,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'LITERAL_NUMBER' => 62,
			"undef" => 66,
			'LITERAL_STRING' => 50
		},
		GOTOS => {
			'Expression' => 400,
			'Variable' => 109,
			'HashReference' => 69,
			'ArrayDereferenced' => 57,
			'Operator' => 51,
			'Literal' => 48,
			'HashDereferenced' => 47,
			'WordScoped' => 78,
			'ArrayReference' => 63
		}
	},
	{#State 396
		DEFAULT => -47
	},
	{#State 397
		ACTIONS => {
			";" => 401
		}
	},
	{#State 398
		DEFAULT => -89
	},
	{#State 399
		ACTIONS => {
			")" => 404,
			'OP21_LIST_COMMA' => 402
		},
		GOTOS => {
			'PAREN-39' => 403
		}
	},
	{#State 400
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP13_BITWISE_AND' => 132,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 139,
			'OP21_LIST_COMMA' => 405,
			'OP15_LOGICAL_AND' => 135,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			")" => -66,
			'OP17_LIST_RANGE' => 146,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP04_MATH_POW' => 148
		},
		GOTOS => {
			'PAREN-26' => 406,
			'OPTIONAL-27' => 407
		}
	},
	{#State 401
		DEFAULT => -91
	},
	{#State 402
		ACTIONS => {
			"my" => 408
		}
	},
	{#State 403
		DEFAULT => -93
	},
	{#State 404
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 409
		}
	},
	{#State 405
		ACTIONS => {
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			"%{" => 49,
			'WORD_SCOPED' => 11,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY' => 80,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"\@{" => 58,
			"(" => 56,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9
		},
		GOTOS => {
			'HashReference' => 69,
			'Expression' => 410,
			'Variable' => 109,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'ArrayDereferenced' => 57,
			'Operator' => 51
		}
	},
	{#State 406
		DEFAULT => -65
	},
	{#State 407
		ACTIONS => {
			")" => 411
		}
	},
	{#State 408
		ACTIONS => {
			'WORD' => 161
		},
		GOTOS => {
			'Type' => 412
		}
	},
	{#State 409
		ACTIONS => {
			"\@_;" => 413
		}
	},
	{#State 410
		ACTIONS => {
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 138,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP13_BITWISE_AND' => 132,
			'OP23_LOGICAL_AND' => 137,
			'OP06_REGEX_MATCH' => 142,
			'OP18_TERNARY' => 141,
			'OP15_LOGICAL_AND' => 135,
			'OP21_LIST_COMMA' => 414,
			'OP16_LOGICAL_OR' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP17_LIST_RANGE' => 146
		}
	},
	{#State 411
		ACTIONS => {
			";" => 415
		}
	},
	{#State 412
		ACTIONS => {
			'VARIABLE_SYMBOL' => 416
		}
	},
	{#State 413
		DEFAULT => -96,
		GOTOS => {
			'STAR-41' => 417
		}
	},
	{#State 414
		ACTIONS => {
			'LITERAL_STRING' => 50,
			"undef" => 66,
			'LITERAL_NUMBER' => 62,
			'WORD_SCOPED' => 11,
			"%{" => 49,
			'OP01_NAMED' => 73,
			'OP22_LOGICAL_NOT' => 70,
			'OP05_LOGICAL_NEG' => 68,
			'VARIABLE_SYMBOL' => 67,
			"{" => 52,
			'OP03_MATH_INC_DEC' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP10_NAMED_UNARY' => 80,
			"\@{" => 58,
			"(" => 56,
			"[" => 74,
			'OP05_MATH_NEG' => 88,
			'WORD' => 9
		},
		GOTOS => {
			'HashReference' => 69,
			'Variable' => 109,
			'Expression' => 418,
			'ArrayReference' => 63,
			'WordScoped' => 78,
			'HashDereferenced' => 47,
			'Literal' => 48,
			'Operator' => 51,
			'ArrayDereferenced' => 57
		}
	},
	{#State 415
		DEFAULT => -67
	},
	{#State 416
		DEFAULT => -92
	},
	{#State 417
		ACTIONS => {
			"[" => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			"(" => -97,
			"\@{" => -97,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			'OP10_NAMED_UNARY' => -97,
			'OP03_MATH_INC_DEC' => -97,
			"my" => -97,
			"for my integer" => -97,
			'WORD' => -97,
			'OP19_LOOP_CONTROL' => -97,
			"while (" => -97,
			"foreach my" => -97,
			'OP05_MATH_NEG' => -97,
			'WORD_SCOPED' => -97,
			"%{" => -97,
			'LITERAL_NUMBER' => -97,
			"undef" => -97,
			'OP01_NAMED_VOID' => -97,
			'LITERAL_STRING' => -97,
			"{" => -97,
			'VARIABLE_SYMBOL' => -97,
			'OP05_LOGICAL_NEG' => -97,
			'OP22_LOGICAL_NOT' => -97,
			'CHECK_OR_CHECKTRACE' => 389,
			"if (" => -97,
			'OP01_NAMED' => -97
		},
		GOTOS => {
			'ArgumentCheck' => 419
		}
	},
	{#State 418
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 144,
			'OP24_LOGICAL_OR_XOR' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 145,
			")" => -64,
			'OP17_LIST_RANGE' => 146,
			'OP04_MATH_POW' => 148,
			'OP12_COMPARE_EQ_NEQ' => 147,
			'OP08_MATH_ADD_SUB' => 138,
			'OP08_STRING_CAT' => 134,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP13_BITWISE_AND' => 132,
			'OP18_TERNARY' => 141,
			'OP15_LOGICAL_AND' => 135,
			'OP09_BITWISE_SHIFT' => 140,
			'OP16_LOGICAL_OR' => 139,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 137
		}
	},
	{#State 419
		DEFAULT => -95
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5566 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5573 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5580 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5591 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5602 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5609 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5616 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5623 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5630 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5637 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5644 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5651 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5658 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5665 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5672 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5683 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5694 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5705 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5712 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5719 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5726 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5733 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5740 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5747 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5754 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5761 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 10,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5772 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5783 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5790 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5797 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5808 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5815 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5822 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5833 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5844 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5862 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5869 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5876 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5883 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5904 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5911 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5918 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5925 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5932 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5939 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5946 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5953 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5975 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5986 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5993 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6000 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6007 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6014 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6025 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6032 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6039 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6046 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6053 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6060 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6071 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6078 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6085 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6092 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6103 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6110 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6117 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6124 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6131 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6138 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6145 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6152 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6159 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6166 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6173 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 3,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6180 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6187 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6194 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 17,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6205 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6212 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6219 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6237 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6248 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6255 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6262 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6269 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6276 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6287 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6294 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6301 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6315 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6322 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6344 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6355 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6362 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6369 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6380 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6391 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6413 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6446 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6457 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6468 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6479 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6490 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6501 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6512 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6523 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6534 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6556 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6600 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6611 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6622 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6633 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6640 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6647 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6654 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6661 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6668 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6675 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6682 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6689 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6700 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6711 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6722 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6733 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6772 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6794 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6816 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6827 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6838 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6849 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6860 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6871 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6904 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6911 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6918 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6925 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_158
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6936 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_159
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6947 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6987 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6994 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7001 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7008 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7015 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7022 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_169
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7033 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_170
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7044 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_171
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7055 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7066 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_173
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7077 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_174
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7088 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_175
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7099 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7106 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7113 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_178
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7124 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7131 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7138 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_181
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7149 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_182
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7160 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_183
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7171 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7182 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_185
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7193 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_186
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7204 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_187
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7215 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_188
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7226 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7233 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7240 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7247 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_192
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7258 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7269 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_194
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_195
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7291 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7298 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_198
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7316 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_199
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_200
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7345 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7363 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7374 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_205
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7385 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_206
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7396 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-61', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7403 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7410 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7417 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_210
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7428 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_211
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7439 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_212
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7450 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_213
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7461 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_214
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7472 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_215
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7483 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_216
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7494 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_217
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule Type_218
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7516 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_219
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7527 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_220
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7538 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_221
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7549 lib/RPerl/Grammar.pm
	]
],
#line 7552 lib/RPerl/Grammar.pm
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
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_158', 
         'Statement_159', 
         'Statement_160', 
         'Statement_161', 
         'Statement_162', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_169', 
         'Loop_170', 
         'Loop_171', 
         'Loop_172', 
         'LoopFor_173', 
         'LoopForEach_174', 
         'LoopWhile_175', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_178', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_181', 
         'VariableRetrieval_182', 
         'VariableRetrieval_183', 
         'VariableRetrieval_184', 
         'VariableDeclaration_185', 
         'VariableDeclaration_186', 
         'VariableModification_187', 
         'VariableModification_188', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_192', 
         'ListElement_193', 
         'ListElement_194', 
         'ListElement_195', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_198', 
         'ArrayDereferenced_199', 
         'ArrayDereferenced_200', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_203', 
         'HashEntry_204', 
         'HashEntryTyped_205', 
         'HashEntryTyped_206', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_210', 
         'HashDereferenced_211', 
         'HashDereferenced_212', 
         'WordScoped_213', 
         'WordScoped_214', 
         'FileHandle_215', 
         'FileHandle_216', 
         'TypeInner_217', 
         'Type_218', 
         'LoopLabel_219', 
         'Literal_220', 
         'Literal_221', );
  $self;
}

#line 175 "lib/RPerl/Grammar.eyp"


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


#line 7821 lib/RPerl/Grammar.pm



1;
