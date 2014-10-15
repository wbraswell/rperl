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
    our $VERSION = 0.000_710;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G(\s*(\#.+)*\s*)+/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|our\ \$VERSION\ \=|for\ my\ integer|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|elsif\ \(|\=\ sub\ \{|while\ \(|\$TYPED_|package|undef|else|if\ \(|\(\ my|use|our|\@_\;|qw\(|\{\*|\.\.|my|\%\{|1\;|\@\{|\[|\{|\(|\;|\]|\)|\/|\})}gc and return ($1, $1);

      /\G(^(\#\!\/[\w\/]*\/perl)$)/gc and return ('SHEBANG', $1);
      /\G(\d\d?\.\d{3}\_\d{3})/gc and return ('VERSION_NUMBER', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G('[^']*')|("[^"]*")/gc and return ('LITERAL_STRING', $1);
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
  [ 'Header_27' => 'Header', [ 'use strict;', 'use warnings;', 'use RPerl;', 'our $VERSION =', 'VERSION_NUMBER', ';' ], 0 ],
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
  [ 'Literal_220' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_221' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
	'our $VERSION =' => { ISSEMANTIC => 0 },
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
	VERSION_NUMBER => { ISSEMANTIC => 1 },
	WORD => { ISSEMANTIC => 1 },
	WORD_SCOPED => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'lib/RPerl/Grammar.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'SHEBANG' => 5,
			"package" => 6
		},
		GOTOS => {
			'Program' => 8,
			'Module' => 7,
			'Class' => 3,
			'PLUS-1' => 2,
			'Package' => 4,
			'CompileUnit' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'' => 9
		}
	},
	{#State 2
		ACTIONS => {
			'' => -4,
			"package" => 6
		},
		GOTOS => {
			'Module' => 10,
			'Class' => 3,
			'Package' => 4
		}
	},
	{#State 3
		DEFAULT => -17
	},
	{#State 4
		DEFAULT => -16
	},
	{#State 5
		ACTIONS => {
			"use strict;" => 11
		},
		GOTOS => {
			'Header' => 12
		}
	},
	{#State 6
		ACTIONS => {
			'WORD_SCOPED' => 13,
			'WORD' => 14
		},
		GOTOS => {
			'WordScoped' => 15
		}
	},
	{#State 7
		DEFAULT => -2
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		DEFAULT => 0
	},
	{#State 10
		DEFAULT => -1
	},
	{#State 11
		ACTIONS => {
			"use warnings;" => 16
		}
	},
	{#State 12
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 17
		}
	},
	{#State 13
		DEFAULT => -214
	},
	{#State 14
		DEFAULT => -213
	},
	{#State 15
		ACTIONS => {
			";" => 18
		}
	},
	{#State 16
		ACTIONS => {
			"use RPerl;" => 19
		}
	},
	{#State 17
		ACTIONS => {
			"foreach my" => -8,
			"## no critic qw(" => 22,
			'OP01_NAMED' => -8,
			'VARIABLE_SYMBOL' => -8,
			"{" => -8,
			"(" => -8,
			'OP05_MATH_NEG' => -8,
			'OP05_LOGICAL_NEG' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			'OP19_LOOP_CONTROL' => -8,
			"our" => -8,
			'OP10_NAMED_UNARY' => -8,
			'WORD_SCOPED' => -8,
			"while (" => -8,
			'LITERAL_NUMBER' => -8,
			'OP22_LOGICAL_NOT' => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"%{" => -8,
			"[" => -8,
			"undef" => -8,
			"\@{" => -8,
			"my" => -8,
			'WORD' => -8,
			"use" => -8,
			"use constant" => -8,
			'LITERAL_STRING' => -8,
			'OP01_NAMED_VOID' => -8,
			'OP03_MATH_INC_DEC' => -8,
			"for my integer" => -8,
			"if (" => -8
		},
		GOTOS => {
			'STAR-3' => 21,
			'Critic' => 20
		}
	},
	{#State 18
		ACTIONS => {
			"use strict;" => 11
		},
		GOTOS => {
			'Header' => 23
		}
	},
	{#State 19
		ACTIONS => {
			"our \$VERSION =" => 24
		}
	},
	{#State 20
		DEFAULT => -5
	},
	{#State 21
		ACTIONS => {
			'WORD' => -10,
			"\@{" => -10,
			"undef" => -10,
			"my" => -10,
			"[" => -10,
			"%{" => -10,
			"use constant" => -10,
			"use" => 25,
			'OP01_NAMED_VOID' => -10,
			'OP03_MATH_INC_DEC' => -10,
			'LITERAL_STRING' => -10,
			"if (" => -10,
			"for my integer" => -10,
			"{" => -10,
			'VARIABLE_SYMBOL' => -10,
			'OP01_NAMED' => -10,
			"foreach my" => -10,
			'OP05_LOGICAL_NEG' => -10,
			'OP05_MATH_NEG' => -10,
			"(" => -10,
			"our" => -10,
			'OP10_NAMED_UNARY' => -10,
			'OP19_LOOP_CONTROL' => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			'LITERAL_NUMBER' => -10,
			'OP22_LOGICAL_NOT' => -10,
			'WORD_SCOPED' => -10,
			"while (" => -10
		},
		GOTOS => {
			'Include' => 27,
			'STAR-4' => 26
		}
	},
	{#State 22
		ACTIONS => {
			'WORD' => 29
		},
		GOTOS => {
			'PLUS-11' => 28
		}
	},
	{#State 23
		ACTIONS => {
			"use constant" => -19,
			"use parent qw(" => 30,
			"use" => -19,
			"our" => -19,
			"## no critic qw(" => -19
		},
		GOTOS => {
			'STAR-7' => 31
		}
	},
	{#State 24
		ACTIONS => {
			'VERSION_NUMBER' => 32
		}
	},
	{#State 25
		ACTIONS => {
			'WORD_SCOPED' => 13,
			'WORD' => 14
		},
		GOTOS => {
			'WordScoped' => 33
		}
	},
	{#State 26
		ACTIONS => {
			"use constant" => 34,
			'WORD' => -12,
			"undef" => -12,
			"my" => -12,
			"\@{" => -12,
			"[" => -12,
			"%{" => -12,
			"for my integer" => -12,
			"if (" => -12,
			'OP03_MATH_INC_DEC' => -12,
			'OP01_NAMED_VOID' => -12,
			'LITERAL_STRING' => -12,
			'OP05_LOGICAL_NEG' => -12,
			'OP05_MATH_NEG' => -12,
			"(" => -12,
			"{" => -12,
			'VARIABLE_SYMBOL' => -12,
			'OP01_NAMED' => -12,
			"foreach my" => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			'LITERAL_NUMBER' => -12,
			'OP22_LOGICAL_NOT' => -12,
			"while (" => -12,
			'WORD_SCOPED' => -12,
			'OP10_NAMED_UNARY' => -12,
			"our" => -12,
			'OP19_LOOP_CONTROL' => -12,
			'OP10_NAMED_UNARY_STRINGIFY' => -12
		},
		GOTOS => {
			'Constant' => 36,
			'STAR-5' => 35
		}
	},
	{#State 27
		DEFAULT => -7
	},
	{#State 28
		ACTIONS => {
			'WORD' => 37,
			")" => 38
		}
	},
	{#State 29
		DEFAULT => -29
	},
	{#State 30
		ACTIONS => {
			'WORD' => 14,
			'WORD_SCOPED' => 13
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 31
		ACTIONS => {
			"our" => -21,
			"## no critic qw(" => 22,
			"use constant" => -21,
			"use" => -21
		},
		GOTOS => {
			'Critic' => 40,
			'STAR-8' => 41
		}
	},
	{#State 32
		ACTIONS => {
			";" => 42
		}
	},
	{#State 33
		ACTIONS => {
			";" => 43,
			"qw(" => 44
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => 45
		}
	},
	{#State 35
		ACTIONS => {
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63,
			"foreach my" => -157,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'WORD_SCOPED' => 13,
			"while (" => -157,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED_VOID_PAREN' => 69,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP19_LOOP_CONTROL' => 82,
			"our" => 67,
			'OP10_NAMED_UNARY' => 66,
			"%{" => 50,
			"[" => 49,
			"\@{" => 72,
			"my" => 47,
			"undef" => 48,
			'WORD' => 46,
			"if (" => 76,
			"for my integer" => -157,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			'OP01_NAMED_VOID' => 74
		},
		GOTOS => {
			'PLUS-6' => 85,
			'ArrayReference' => 87,
			'PAREN-49' => 84,
			'Subroutine' => 83,
			'VariableDeclaration' => 81,
			'WordScoped' => 80,
			'Operator' => 79,
			'OPTIONAL-50' => 62,
			'Expression' => 58,
			'HashReference' => 61,
			'VariableModification' => 77,
			'LoopLabel' => 57,
			'OperatorVoid' => 56,
			'Literal' => 75,
			'Statement' => 55,
			'HashDereferenced' => 73,
			'Operation' => 52,
			'Variable' => 51,
			'Conditional' => 71,
			'ArrayDereferenced' => 70
		}
	},
	{#State 36
		DEFAULT => -9
	},
	{#State 37
		DEFAULT => -28
	},
	{#State 38
		DEFAULT => -30
	},
	{#State 39
		ACTIONS => {
			")" => 89
		}
	},
	{#State 40
		DEFAULT => -18
	},
	{#State 41
		ACTIONS => {
			"our" => -23,
			"use constant" => -23,
			"use" => 25
		},
		GOTOS => {
			'STAR-9' => 90,
			'Include' => 91
		}
	},
	{#State 42
		DEFAULT => -27
	},
	{#State 43
		DEFAULT => -33
	},
	{#State 44
		ACTIONS => {
			'WORD' => 93
		},
		GOTOS => {
			'PLUS-12' => 92
		}
	},
	{#State 45
		ACTIONS => {
			'OP20_HASH_FATARROW' => 94
		}
	},
	{#State 46
		ACTIONS => {
			'COLON' => -219,
			"(" => -213
		}
	},
	{#State 47
		ACTIONS => {
			'WORD' => 95
		},
		GOTOS => {
			'Type' => 96
		}
	},
	{#State 48
		DEFAULT => -143
	},
	{#State 49
		ACTIONS => {
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'KEYS_OR_VALUES' => 104,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"]" => -197,
			"{" => 59,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"%{" => 50,
			"[" => 49,
			"\@{" => 72,
			"undef" => 48,
			"my" => 100,
			'WORD' => 14
		},
		GOTOS => {
			'Variable' => 98,
			'Operator' => 79,
			'TypeInner' => 97,
			'WordScoped' => 80,
			'Expression' => 101,
			'ArrayDereferenced' => 70,
			'HashReference' => 61,
			'OPTIONAL-59' => 103,
			'ListElements' => 99,
			'ArrayReference' => 87,
			'Literal' => 75,
			'ListElement' => 102,
			'HashDereferenced' => 73
		}
	},
	{#State 50
		ACTIONS => {
			'VARIABLE_SYMBOL' => 60,
			"{" => 105
		},
		GOTOS => {
			'Variable' => 107,
			'HashReference' => 106
		}
	},
	{#State 51
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -145,
			'OP03_MATH_INC_DEC' => 110,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP04_MATH_POW' => -145,
			'OP08_STRING_CAT' => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 109,
			'OP02_METHOD_THINARROW' => 108,
			";" => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP19_VARIABLE_ASSIGN' => 111,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP18_TERNARY' => -145
		}
	},
	{#State 52
		DEFAULT => -14
	},
	{#State 53
		ACTIONS => {
			'VARIABLE_SYMBOL' => 60
		},
		GOTOS => {
			'Variable' => 112
		}
	},
	{#State 54
		DEFAULT => -221
	},
	{#State 55
		DEFAULT => -99
	},
	{#State 56
		DEFAULT => -160
	},
	{#State 57
		ACTIONS => {
			'COLON' => 113
		}
	},
	{#State 58
		ACTIONS => {
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => 121,
			'OP08_MATH_ADD_SUB' => 120,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			";" => 127,
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP18_TERNARY' => 118,
			'OP11_COMPARE_LT_GT' => 117,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP17_LIST_RANGE' => 125,
			'OP09_BITWISE_SHIFT' => 114,
			'OP15_LOGICAL_AND' => 116,
			'OP06_REGEX_MATCH' => 115
		}
	},
	{#State 59
		ACTIONS => {
			'WORD' => 134,
			"%{" => 50,
			"}" => 132
		},
		GOTOS => {
			'HashDereferenced' => 131,
			'HashEntry' => 133
		}
	},
	{#State 60
		DEFAULT => -180,
		GOTOS => {
			'STAR-56' => 135
		}
	},
	{#State 61
		DEFAULT => -148
	},
	{#State 62
		ACTIONS => {
			"foreach my" => 141,
			"for my integer" => 136,
			"while (" => 140
		},
		GOTOS => {
			'Loop' => 142,
			'LoopWhile' => 137,
			'LoopForEach' => 138,
			'LoopFor' => 139
		}
	},
	{#State 63
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP01_NAMED' => 78,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			"[" => 49,
			"%{" => 50,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashReference' => 61,
			'Expression' => 143,
			'ArrayDereferenced' => 70,
			'Operator' => 79,
			'Variable' => 98,
			'WordScoped' => 80
		}
	},
	{#State 64
		ACTIONS => {
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"%{" => 50,
			"[" => 49,
			"undef" => 48,
			"\@{" => 72,
			'WORD' => 14,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63
		},
		GOTOS => {
			'WordScoped' => 80,
			'Variable' => 98,
			'Operator' => 79,
			'Expression' => 144,
			'ArrayDereferenced' => 70,
			'HashReference' => 61,
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashDereferenced' => 73
		}
	},
	{#State 65
		ACTIONS => {
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78,
			'OP05_LOGICAL_NEG' => 63,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'WORD_SCOPED' => 13,
			"\@{" => 72,
			"undef" => 48,
			'WORD' => 14,
			"%{" => 50,
			"[" => 49,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54
		},
		GOTOS => {
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashDereferenced' => 73,
			'Operator' => 79,
			'Variable' => 98,
			'WordScoped' => 80,
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'Expression' => 145
		}
	},
	{#State 66
		ACTIONS => {
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63,
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			"%{" => 50,
			"[" => 49,
			"\@{" => 72,
			"undef" => 48,
			'WORD' => 14,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53
		},
		GOTOS => {
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'Expression' => 146,
			'WordScoped' => 80,
			'Variable' => 98,
			'Operator' => 79,
			'HashDereferenced' => 73,
			'ArrayReference' => 87,
			'Literal' => 75
		}
	},
	{#State 67
		ACTIONS => {
			'WORD' => 95
		},
		GOTOS => {
			'Type' => 147
		}
	},
	{#State 68
		ACTIONS => {
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"%{" => 50,
			"[" => 49,
			"\@{" => 72,
			"undef" => 48,
			'WORD' => 14,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63
		},
		GOTOS => {
			'Operator' => 79,
			'Variable' => 98,
			'WordScoped' => 80,
			'HashReference' => 61,
			'Expression' => 148,
			'ArrayDereferenced' => 70,
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashDereferenced' => 73
		}
	},
	{#State 69
		ACTIONS => {
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"%{" => 50,
			"[" => 49,
			"\@{" => 72,
			"undef" => 48,
			"my" => 150,
			'WORD' => 14,
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'KEYS_OR_VALUES' => 104,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			")" => -127,
			'OP05_LOGICAL_NEG' => 63,
			"{*" => 153,
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60
		},
		GOTOS => {
			'Variable' => 98,
			'Operator' => 79,
			'WordScoped' => 80,
			'OPTIONAL-43' => 149,
			'TypeInner' => 97,
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'Expression' => 101,
			'ListElements' => 152,
			'FileHandle' => 151,
			'ArrayReference' => 87,
			'Literal' => 75,
			'ListElement' => 102,
			'HashDereferenced' => 73
		}
	},
	{#State 70
		DEFAULT => -147
	},
	{#State 71
		DEFAULT => -158
	},
	{#State 72
		ACTIONS => {
			"[" => 49,
			'VARIABLE_SYMBOL' => 60
		},
		GOTOS => {
			'ArrayReference' => 155,
			'Variable' => 154
		}
	},
	{#State 73
		DEFAULT => -149
	},
	{#State 74
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'KEYS_OR_VALUES' => 104,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'WORD_SCOPED' => 13,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78,
			"{*" => 153,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			";" => -131,
			'WORD' => 14,
			"undef" => 48,
			"\@{" => 72,
			"my" => 150,
			"[" => 49,
			"%{" => 50
		},
		GOTOS => {
			'TypeInner' => 97,
			'WordScoped' => 80,
			'Operator' => 79,
			'Variable' => 98,
			'OPTIONAL-45' => 158,
			'ListElements' => 156,
			'FileHandle' => 157,
			'Expression' => 101,
			'ArrayDereferenced' => 70,
			'HashReference' => 61,
			'ListElement' => 102,
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashDereferenced' => 73
		}
	},
	{#State 75
		DEFAULT => -144
	},
	{#State 76
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			"\@{" => 72,
			"undef" => 48,
			'WORD' => 14,
			"%{" => 50,
			"[" => 49,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'WORD_SCOPED' => 13,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78,
			'OP05_LOGICAL_NEG' => 63,
			"(" => 65,
			'OP05_MATH_NEG' => 64
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'Literal' => 75,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 70,
			'Expression' => 159,
			'HashReference' => 61,
			'Variable' => 98,
			'Operator' => 79,
			'WordScoped' => 80
		}
	},
	{#State 77
		DEFAULT => -162
	},
	{#State 78
		ACTIONS => {
			"(" => 160
		}
	},
	{#State 79
		DEFAULT => -151
	},
	{#State 80
		ACTIONS => {
			"(" => 161
		}
	},
	{#State 81
		DEFAULT => -161
	},
	{#State 82
		ACTIONS => {
			'WORD' => 163
		},
		GOTOS => {
			'LoopLabel' => 162
		}
	},
	{#State 83
		DEFAULT => -11
	},
	{#State 84
		DEFAULT => -156
	},
	{#State 85
		ACTIONS => {
			'OP01_NAMED' => 78,
			"foreach my" => -157,
			'' => -15,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP19_LOOP_CONTROL' => 82,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			"while (" => -157,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'OP01_NAMED_VOID_PAREN' => 69,
			"%{" => 50,
			"[" => 49,
			"undef" => 48,
			"my" => 47,
			"\@{" => 72,
			'WORD' => 46,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			'OP01_NAMED_VOID' => 74,
			"if (" => 76,
			"for my integer" => -157
		},
		GOTOS => {
			'ArrayReference' => 87,
			'VariableDeclaration' => 81,
			'PAREN-49' => 84,
			'Operator' => 79,
			'WordScoped' => 80,
			'VariableModification' => 77,
			'HashReference' => 61,
			'Expression' => 58,
			'OPTIONAL-50' => 62,
			'Literal' => 75,
			'LoopLabel' => 57,
			'OperatorVoid' => 56,
			'HashDereferenced' => 73,
			'Statement' => 55,
			'Variable' => 51,
			'Operation' => 164,
			'Conditional' => 71,
			'ArrayDereferenced' => 70
		}
	},
	{#State 86
		DEFAULT => -220
	},
	{#State 87
		DEFAULT => -146
	},
	{#State 88
		ACTIONS => {
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"undef" => 48,
			"\@{" => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63
		},
		GOTOS => {
			'Expression' => 165,
			'ArrayDereferenced' => 70,
			'HashReference' => 61,
			'WordScoped' => 80,
			'Variable' => 98,
			'Operator' => 79,
			'HashDereferenced' => 73,
			'ArrayReference' => 87,
			'Literal' => 75
		}
	},
	{#State 89
		ACTIONS => {
			";" => 166
		}
	},
	{#State 90
		ACTIONS => {
			"our" => 67,
			"use constant" => 34
		},
		GOTOS => {
			'PLUS-10' => 168,
			'Constant' => 167,
			'Subroutine' => 169
		}
	},
	{#State 91
		DEFAULT => -20
	},
	{#State 92
		ACTIONS => {
			'WORD' => 170,
			")" => 171
		}
	},
	{#State 93
		DEFAULT => -32
	},
	{#State 94
		ACTIONS => {
			"my" => 100
		},
		GOTOS => {
			'TypeInner' => 172
		}
	},
	{#State 95
		DEFAULT => -218
	},
	{#State 96
		ACTIONS => {
			'VARIABLE_SYMBOL' => 173
		}
	},
	{#State 97
		ACTIONS => {
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			"%{" => 50,
			"[" => 49,
			"undef" => 48,
			"\@{" => 72,
			'WORD' => 14,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53
		},
		GOTOS => {
			'Variable' => 98,
			'Operator' => 79,
			'WordScoped' => 80,
			'HashReference' => 61,
			'Expression' => 174,
			'ArrayDereferenced' => 70,
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashDereferenced' => 73
		}
	},
	{#State 98
		ACTIONS => {
			'OP13_BITWISE_AND' => -145,
			'OP16_LOGICAL_OR' => -145,
			"}" => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP08_STRING_CAT' => -145,
			'OP04_MATH_POW' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP03_MATH_INC_DEC' => 110,
			'OP08_MATH_ADD_SUB' => -145,
			";" => -145,
			'OP02_METHOD_THINARROW' => 108,
			".." => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			"]" => -145,
			'OP18_TERNARY' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP21_LIST_COMMA' => -145,
			")" => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP09_BITWISE_SHIFT' => -145
		}
	},
	{#State 99
		DEFAULT => -196
	},
	{#State 100
		ACTIONS => {
			'WORD' => 95
		},
		GOTOS => {
			'Type' => 175
		}
	},
	{#State 101
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130,
			";" => -193,
			'OP08_MATH_ADD_SUB' => 120,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => 121,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			")" => -193,
			'OP21_LIST_COMMA' => -193,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			'OP18_TERNARY' => 118,
			"]" => -193,
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116
		}
	},
	{#State 102
		DEFAULT => -191,
		GOTOS => {
			'STAR-58' => 176
		}
	},
	{#State 103
		ACTIONS => {
			"]" => 177
		}
	},
	{#State 104
		ACTIONS => {
			"%{" => 50
		},
		GOTOS => {
			'HashDereferenced' => 178
		}
	},
	{#State 105
		ACTIONS => {
			"%{" => 50,
			'WORD' => 134
		},
		GOTOS => {
			'HashDereferenced' => 131,
			'HashEntry' => 133
		}
	},
	{#State 106
		ACTIONS => {
			"}" => 179
		}
	},
	{#State 107
		ACTIONS => {
			"}" => 180
		}
	},
	{#State 108
		ACTIONS => {
			'WORD' => 181
		}
	},
	{#State 109
		ACTIONS => {
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashReference' => 61,
			'Expression' => 182,
			'ArrayDereferenced' => 70,
			'WordScoped' => 80,
			'Variable' => 98,
			'Operator' => 79
		}
	},
	{#State 110
		DEFAULT => -104
	},
	{#State 111
		ACTIONS => {
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"undef" => 48,
			"\@{" => 72,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'Expression' => 183,
			'WordScoped' => 80,
			'Variable' => 98,
			'Operator' => 79
		}
	},
	{#State 112
		DEFAULT => -103
	},
	{#State 113
		DEFAULT => -155
	},
	{#State 114
		ACTIONS => {
			"\@{" => 72,
			"undef" => 48,
			'WORD' => 14,
			"%{" => 50,
			"[" => 49,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			'OP05_LOGICAL_NEG' => 63,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68
		},
		GOTOS => {
			'Operator' => 79,
			'Variable' => 98,
			'WordScoped' => 80,
			'ArrayDereferenced' => 70,
			'Expression' => 184,
			'HashReference' => 61,
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashDereferenced' => 73
		}
	},
	{#State 115
		ACTIONS => {
			"/" => 185
		}
	},
	{#State 116
		ACTIONS => {
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53
		},
		GOTOS => {
			'Variable' => 98,
			'Operator' => 79,
			'WordScoped' => 80,
			'ArrayDereferenced' => 70,
			'Expression' => 186,
			'HashReference' => 61,
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashDereferenced' => 73
		}
	},
	{#State 117
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"undef" => 48,
			"\@{" => 72
		},
		GOTOS => {
			'HashReference' => 61,
			'Expression' => 187,
			'ArrayDereferenced' => 70,
			'Variable' => 98,
			'Operator' => 79,
			'WordScoped' => 80,
			'HashDereferenced' => 73,
			'Literal' => 75,
			'ArrayReference' => 87
		}
	},
	{#State 118
		ACTIONS => {
			'VARIABLE_SYMBOL' => 60
		},
		GOTOS => {
			'Variable' => 188
		}
	},
	{#State 119
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			"[" => 49,
			"%{" => 50
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashDereferenced' => 73,
			'Variable' => 98,
			'Operator' => 79,
			'WordScoped' => 80,
			'Expression' => 189,
			'ArrayDereferenced' => 70,
			'HashReference' => 61
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			"[" => 49,
			"%{" => 50,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP01_NAMED' => 78,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'ArrayReference' => 87,
			'Literal' => 75,
			'ArrayDereferenced' => 70,
			'Expression' => 190,
			'HashReference' => 61,
			'WordScoped' => 80,
			'Operator' => 79,
			'Variable' => 98
		}
	},
	{#State 121
		ACTIONS => {
			"%{" => 50,
			"[" => 49,
			"\@{" => 72,
			"undef" => 48,
			'WORD' => 14,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63,
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashDereferenced' => 73,
			'Operator' => 79,
			'Variable' => 98,
			'WordScoped' => 80,
			'HashReference' => 61,
			'Expression' => 191,
			'ArrayDereferenced' => 70
		}
	},
	{#State 122
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"undef" => 48,
			"\@{" => 72
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashDereferenced' => 73,
			'WordScoped' => 80,
			'Variable' => 98,
			'Operator' => 79,
			'HashReference' => 61,
			'Expression' => 192,
			'ArrayDereferenced' => 70
		}
	},
	{#State 123
		ACTIONS => {
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'Expression' => 193,
			'Operator' => 79,
			'Variable' => 98,
			'WordScoped' => 80
		}
	},
	{#State 124
		ACTIONS => {
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			"[" => 49,
			"%{" => 50,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP01_NAMED' => 78,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'WORD_SCOPED' => 13
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashDereferenced' => 73,
			'WordScoped' => 80,
			'Operator' => 79,
			'Variable' => 98,
			'ArrayDereferenced' => 70,
			'Expression' => 194,
			'HashReference' => 61
		}
	},
	{#State 125
		ACTIONS => {
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"%{" => 50,
			"[" => 49,
			"undef" => 48,
			"\@{" => 72,
			'WORD' => 14,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63
		},
		GOTOS => {
			'Operator' => 79,
			'Variable' => 98,
			'WordScoped' => 80,
			'HashReference' => 61,
			'Expression' => 195,
			'ArrayDereferenced' => 70,
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashDereferenced' => 73
		}
	},
	{#State 126
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			"\@{" => 72,
			"undef" => 48,
			'WORD' => 14,
			"%{" => 50,
			"[" => 49,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP05_LOGICAL_NEG' => 63,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashDereferenced' => 73,
			'Operator' => 79,
			'Variable' => 98,
			'WordScoped' => 80,
			'ArrayDereferenced' => 70,
			'Expression' => 196,
			'HashReference' => 61
		}
	},
	{#State 127
		DEFAULT => -98
	},
	{#State 128
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			"undef" => 48,
			"\@{" => 72,
			'WORD' => 14,
			"%{" => 50,
			"[" => 49,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'WORD_SCOPED' => 13,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP01_NAMED' => 78,
			'OP05_LOGICAL_NEG' => 63,
			"(" => 65,
			'OP05_MATH_NEG' => 64
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashDereferenced' => 73,
			'WordScoped' => 80,
			'Variable' => 98,
			'Operator' => 79,
			'ArrayDereferenced' => 70,
			'Expression' => 197,
			'HashReference' => 61
		}
	},
	{#State 129
		ACTIONS => {
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashReference' => 61,
			'Expression' => 198,
			'ArrayDereferenced' => 70,
			'Operator' => 79,
			'Variable' => 98,
			'WordScoped' => 80
		}
	},
	{#State 130
		ACTIONS => {
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"%{" => 50,
			"[" => 49,
			"undef" => 48,
			"\@{" => 72,
			'WORD' => 14,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63
		},
		GOTOS => {
			'HashReference' => 61,
			'Expression' => 199,
			'ArrayDereferenced' => 70,
			'WordScoped' => 80,
			'Operator' => 79,
			'Variable' => 98,
			'HashDereferenced' => 73,
			'Literal' => 75,
			'ArrayReference' => 87
		}
	},
	{#State 131
		DEFAULT => -204
	},
	{#State 132
		DEFAULT => -150
	},
	{#State 133
		DEFAULT => -209,
		GOTOS => {
			'STAR-62' => 200
		}
	},
	{#State 134
		ACTIONS => {
			'OP20_HASH_FATARROW' => 201
		}
	},
	{#State 135
		ACTIONS => {
			'OP15_LOGICAL_AND' => -181,
			'OP06_REGEX_MATCH' => -181,
			'OP17_LIST_RANGE' => -181,
			'OP09_BITWISE_SHIFT' => -181,
			'OP02_ARRAY_THINARROW' => 204,
			'COLON' => -181,
			'OP19_VARIABLE_ASSIGN' => -181,
			'OP24_LOGICAL_OR_XOR' => -181,
			"]" => -181,
			'OP18_TERNARY' => -181,
			'OP11_COMPARE_LT_GT' => -181,
			'OP12_COMPARE_EQ_NEQ' => -181,
			'OP21_LIST_COMMA' => -181,
			")" => -181,
			'OP19_VARIABLE_ASSIGN_BY' => -181,
			'OP04_MATH_POW' => -181,
			'OP08_STRING_CAT' => -181,
			'OP14_BITWISE_OR_XOR' => -181,
			'OP23_LOGICAL_AND' => -181,
			'OP03_MATH_INC_DEC' => -181,
			'OP08_MATH_ADD_SUB' => -181,
			";" => -181,
			'OP02_METHOD_THINARROW' => -181,
			".." => -181,
			'OP02_HASH_THINARROW' => 203,
			'OP13_BITWISE_AND' => -181,
			'OP16_LOGICAL_OR' => -181,
			"}" => -181,
			'OP07_MATH_MULT_DIV_MOD' => -181
		},
		GOTOS => {
			'VariableRetrieval' => 202
		}
	},
	{#State 136
		ACTIONS => {
			'VARIABLE_SYMBOL' => 205
		}
	},
	{#State 137
		DEFAULT => -172
	},
	{#State 138
		DEFAULT => -171
	},
	{#State 139
		DEFAULT => -170
	},
	{#State 140
		ACTIONS => {
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'WORD_SCOPED' => 13,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			"[" => 49,
			"%{" => 50,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'Expression' => 206,
			'Variable' => 98,
			'Operator' => 79,
			'WordScoped' => 80
		}
	},
	{#State 141
		ACTIONS => {
			'WORD' => 95
		},
		GOTOS => {
			'Type' => 207
		}
	},
	{#State 142
		DEFAULT => -159
	},
	{#State 143
		ACTIONS => {
			'OP06_REGEX_MATCH' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP18_TERNARY' => -106,
			")" => -106,
			"]" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			";" => -106,
			".." => -106,
			'OP08_STRING_CAT' => -106,
			'OP04_MATH_POW' => 129,
			'OP08_MATH_ADD_SUB' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			"}" => -106,
			'OP13_BITWISE_AND' => -106,
			'OP16_LOGICAL_OR' => -106
		}
	},
	{#State 144
		ACTIONS => {
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP08_MATH_ADD_SUB' => 120,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130,
			'OP17_LIST_RANGE' => 125,
			'OP09_BITWISE_SHIFT' => 114,
			'OP15_LOGICAL_AND' => 116,
			'OP06_REGEX_MATCH' => 115,
			")" => 208,
			'OP18_TERNARY' => 118,
			'OP11_COMPARE_LT_GT' => 117,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP24_LOGICAL_OR_XOR' => 119
		}
	},
	{#State 145
		ACTIONS => {
			")" => 209,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			'OP18_TERNARY' => 118,
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130,
			'OP08_MATH_ADD_SUB' => 120,
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122
		}
	},
	{#State 146
		ACTIONS => {
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => -113,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP12_COMPARE_EQ_NEQ' => -113,
			'OP18_TERNARY' => -113,
			")" => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			"]" => -113,
			";" => -113,
			".." => -113,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			'OP08_MATH_ADD_SUB' => 120,
			'OP23_LOGICAL_AND' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => -113,
			'OP13_BITWISE_AND' => -113,
			'OP16_LOGICAL_OR' => -113
		}
	},
	{#State 147
		ACTIONS => {
			'VARIABLE_SYMBOL' => 210
		}
	},
	{#State 148
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => -114,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => -114,
			")" => -114,
			'OP21_LIST_COMMA' => -114,
			'OP12_COMPARE_EQ_NEQ' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP18_TERNARY' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			"]" => -114,
			".." => -114,
			";" => -114,
			'OP08_MATH_ADD_SUB' => 120,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP13_BITWISE_AND' => -114
		}
	},
	{#State 149
		ACTIONS => {
			")" => 211
		}
	},
	{#State 150
		ACTIONS => {
			'WORD' => 95,
			"filehandle_ref" => 212
		},
		GOTOS => {
			'Type' => 175
		}
	},
	{#State 151
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'KEYS_OR_VALUES' => 104,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			")" => -129,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			"my" => 100,
			"[" => 49,
			"%{" => 50
		},
		GOTOS => {
			'ListElements' => 213,
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'Expression' => 101,
			'WordScoped' => 80,
			'TypeInner' => 97,
			'OPTIONAL-44' => 214,
			'Operator' => 79,
			'Variable' => 98,
			'HashDereferenced' => 73,
			'ListElement' => 102,
			'Literal' => 75,
			'ArrayReference' => 87
		}
	},
	{#State 152
		DEFAULT => -126
	},
	{#State 153
		ACTIONS => {
			'WORD' => 215
		}
	},
	{#State 154
		ACTIONS => {
			"}" => 216
		}
	},
	{#State 155
		ACTIONS => {
			"}" => 217
		}
	},
	{#State 156
		DEFAULT => -130
	},
	{#State 157
		ACTIONS => {
			";" => -133,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			'WORD' => 14,
			"my" => 100,
			"\@{" => 72,
			"undef" => 48,
			"[" => 49,
			"%{" => 50,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'KEYS_OR_VALUES' => 104,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'ListElements' => 218,
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'Expression' => 101,
			'WordScoped' => 80,
			'TypeInner' => 97,
			'Operator' => 79,
			'Variable' => 98,
			'HashDereferenced' => 73,
			'ListElement' => 102,
			'Literal' => 75,
			'OPTIONAL-46' => 219,
			'ArrayReference' => 87
		}
	},
	{#State 158
		ACTIONS => {
			";" => 220
		}
	},
	{#State 159
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116,
			")" => 221,
			'OP11_COMPARE_LT_GT' => 117,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP18_TERNARY' => 118,
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP08_MATH_ADD_SUB' => 120,
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130
		}
	},
	{#State 160
		ACTIONS => {
			"%{" => 50,
			"[" => 49,
			"\@{" => 72,
			"my" => 100,
			"undef" => 48,
			'WORD' => 14,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			")" => -101,
			'OP05_LOGICAL_NEG' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'KEYS_OR_VALUES' => 104
		},
		GOTOS => {
			'Operator' => 79,
			'Variable' => 98,
			'WordScoped' => 80,
			'TypeInner' => 97,
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'OPTIONAL-42' => 223,
			'Expression' => 101,
			'ListElements' => 222,
			'ArrayReference' => 87,
			'Literal' => 75,
			'ListElement' => 102,
			'HashDereferenced' => 73
		}
	},
	{#State 161
		ACTIONS => {
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"undef" => 48,
			"\@{" => 72,
			"my" => 100,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'KEYS_OR_VALUES' => 104,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			")" => -140,
			'OP05_LOGICAL_NEG' => 63
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'ArrayReference' => 87,
			'Literal' => 75,
			'ListElement' => 102,
			'ArrayDereferenced' => 70,
			'Expression' => 101,
			'OPTIONAL-47' => 225,
			'HashReference' => 61,
			'ListElements' => 224,
			'Operator' => 79,
			'Variable' => 98,
			'TypeInner' => 97,
			'WordScoped' => 80
		}
	},
	{#State 162
		ACTIONS => {
			";" => 226
		}
	},
	{#State 163
		DEFAULT => -219
	},
	{#State 164
		DEFAULT => -13
	},
	{#State 165
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 120,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => -123,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			".." => -123,
			";" => -123,
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => -123,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116,
			'OP24_LOGICAL_OR_XOR' => -123,
			"]" => -123,
			")" => -123,
			'OP11_COMPARE_LT_GT' => 117,
			'OP21_LIST_COMMA' => -123,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP18_TERNARY' => 118
		}
	},
	{#State 166
		ACTIONS => {
			"use" => 25
		},
		GOTOS => {
			'Include' => 227
		}
	},
	{#State 167
		DEFAULT => -22
	},
	{#State 168
		ACTIONS => {
			"1;" => 229,
			"our" => 67
		},
		GOTOS => {
			'Subroutine' => 228
		}
	},
	{#State 169
		DEFAULT => -25
	},
	{#State 170
		DEFAULT => -31
	},
	{#State 171
		ACTIONS => {
			";" => 230
		}
	},
	{#State 172
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			"[" => 234,
			'LITERAL_STRING' => 54,
			"{" => 232
		},
		GOTOS => {
			'ConstantValue' => 233,
			'Literal' => 231
		}
	},
	{#State 173
		ACTIONS => {
			";" => 236,
			'OP19_VARIABLE_ASSIGN' => 235
		}
	},
	{#State 174
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116,
			")" => -194,
			'OP21_LIST_COMMA' => -194,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			'OP18_TERNARY' => 118,
			"]" => -194,
			'OP24_LOGICAL_OR_XOR' => 119,
			";" => -194,
			'OP08_MATH_ADD_SUB' => 120,
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130
		}
	},
	{#State 175
		ACTIONS => {
			"\$TYPED_" => 237
		}
	},
	{#State 176
		ACTIONS => {
			'OP21_LIST_COMMA' => 238,
			";" => -192,
			")" => -192,
			"]" => -192
		},
		GOTOS => {
			'PAREN-57' => 239
		}
	},
	{#State 177
		DEFAULT => -198
	},
	{#State 178
		DEFAULT => -195
	},
	{#State 179
		DEFAULT => -212
	},
	{#State 180
		DEFAULT => -211
	},
	{#State 181
		ACTIONS => {
			"(" => 240
		}
	},
	{#State 182
		ACTIONS => {
			'OP15_LOGICAL_AND' => 116,
			'OP06_REGEX_MATCH' => 115,
			'OP17_LIST_RANGE' => 125,
			'OP09_BITWISE_SHIFT' => 114,
			'OP18_TERNARY' => 118,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			'OP24_LOGICAL_OR_XOR' => 119,
			";" => 241,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => 121,
			'OP08_MATH_ADD_SUB' => 120,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124
		}
	},
	{#State 183
		ACTIONS => {
			'OP18_TERNARY' => 118,
			'OP11_COMPARE_LT_GT' => 117,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP15_LOGICAL_AND' => 116,
			'OP06_REGEX_MATCH' => 115,
			'OP17_LIST_RANGE' => 125,
			'OP09_BITWISE_SHIFT' => 114,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124,
			";" => 242,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP08_MATH_ADD_SUB' => 120
		}
	},
	{#State 184
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -112,
			"]" => -112,
			'OP18_TERNARY' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			")" => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP06_REGEX_MATCH' => 115,
			'OP17_LIST_RANGE' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP16_LOGICAL_OR' => -112,
			"}" => -112,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			'OP23_LOGICAL_AND' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP08_MATH_ADD_SUB' => 120,
			";" => -112,
			".." => -112
		}
	},
	{#State 185
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 243
		}
	},
	{#State 186
		ACTIONS => {
			".." => -119,
			";" => -119,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => -119,
			'OP08_MATH_ADD_SUB' => 120,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			"}" => -119,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP16_LOGICAL_OR' => -119,
			'OP13_BITWISE_AND' => 130,
			'OP17_LIST_RANGE' => -119,
			'OP09_BITWISE_SHIFT' => 114,
			'OP15_LOGICAL_AND' => -119,
			'OP06_REGEX_MATCH' => 115,
			")" => -119,
			'OP18_TERNARY' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			"]" => -119,
			'OP24_LOGICAL_OR_XOR' => -119
		}
	},
	{#State 187
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => -115,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => -115,
			")" => -115,
			'OP21_LIST_COMMA' => -115,
			'OP12_COMPARE_EQ_NEQ' => -115,
			'OP11_COMPARE_LT_GT' => undef,
			'OP18_TERNARY' => -115,
			"]" => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			".." => -115,
			";" => -115,
			'OP08_MATH_ADD_SUB' => 120,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP13_BITWISE_AND' => -115
		}
	},
	{#State 188
		ACTIONS => {
			'COLON' => 244
		}
	},
	{#State 189
		ACTIONS => {
			"]" => -125,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP18_TERNARY' => 118,
			'OP21_LIST_COMMA' => -125,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			")" => -125,
			'OP15_LOGICAL_AND' => 116,
			'OP06_REGEX_MATCH' => 115,
			'OP17_LIST_RANGE' => 125,
			'OP09_BITWISE_SHIFT' => 114,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124,
			"}" => -125,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => 121,
			'OP08_MATH_ADD_SUB' => 120,
			";" => -125,
			".." => -125
		}
	},
	{#State 190
		ACTIONS => {
			'OP16_LOGICAL_OR' => -110,
			'OP13_BITWISE_AND' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => -110,
			'OP08_MATH_ADD_SUB' => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP08_STRING_CAT' => -110,
			'OP04_MATH_POW' => 129,
			".." => -110,
			";" => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			"]" => -110,
			")" => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP18_TERNARY' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP17_LIST_RANGE' => -110,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => -110
		}
	},
	{#State 191
		ACTIONS => {
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP21_LIST_COMMA' => -124,
			'OP11_COMPARE_LT_GT' => 117,
			'OP18_TERNARY' => 118,
			")" => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			"]" => -124,
			";" => -124,
			".." => -124,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			'OP08_MATH_ADD_SUB' => 120,
			'OP23_LOGICAL_AND' => -124,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => -124,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124
		}
	},
	{#State 192
		ACTIONS => {
			'OP15_LOGICAL_AND' => -111,
			'OP06_REGEX_MATCH' => 115,
			'OP17_LIST_RANGE' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP18_TERNARY' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			")" => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			"]" => -111,
			";" => -111,
			".." => -111,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP08_MATH_ADD_SUB' => 120,
			"}" => -111,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP13_BITWISE_AND' => -111,
			'OP16_LOGICAL_OR' => -111
		}
	},
	{#State 193
		ACTIONS => {
			'OP17_LIST_RANGE' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP06_REGEX_MATCH' => 115,
			'OP24_LOGICAL_OR_XOR' => -109,
			"]" => -109,
			")" => -109,
			'OP18_TERNARY' => -109,
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP08_MATH_ADD_SUB' => -109,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => -109,
			".." => -109,
			";" => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP13_BITWISE_AND' => -109,
			"}" => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109
		}
	},
	{#State 194
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => -120,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116,
			")" => -120,
			'OP21_LIST_COMMA' => -120,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			'OP18_TERNARY' => -120,
			'OP24_LOGICAL_OR_XOR' => -120,
			"]" => -120,
			".." => -120,
			";" => -120,
			'OP08_MATH_ADD_SUB' => 120,
			'OP23_LOGICAL_AND' => -120,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP13_BITWISE_AND' => 130
		}
	},
	{#State 195
		ACTIONS => {
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => -121,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP08_MATH_ADD_SUB' => 120,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => -121,
			";" => -121,
			".." => -121,
			"]" => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP21_LIST_COMMA' => -121,
			'OP11_COMPARE_LT_GT' => 117,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP18_TERNARY' => -121,
			")" => -121,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => undef
		}
	},
	{#State 196
		ACTIONS => {
			'OP13_BITWISE_AND' => -116,
			'OP16_LOGICAL_OR' => -116,
			"}" => -116,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP23_LOGICAL_AND' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP08_MATH_ADD_SUB' => 120,
			";" => -116,
			".." => -116,
			"]" => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP18_TERNARY' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP11_COMPARE_LT_GT' => 117,
			")" => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP06_REGEX_MATCH' => 115,
			'OP17_LIST_RANGE' => -116,
			'OP09_BITWISE_SHIFT' => 114
		}
	},
	{#State 197
		ACTIONS => {
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => -118,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => -118,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP21_LIST_COMMA' => -118,
			'OP11_COMPARE_LT_GT' => 117,
			'OP18_TERNARY' => -118,
			")" => -118,
			"]" => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			";" => -118,
			".." => -118,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			'OP08_MATH_ADD_SUB' => 120,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => -118,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => -118
		}
	},
	{#State 198
		ACTIONS => {
			'OP16_LOGICAL_OR' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			"}" => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => -105,
			".." => -105,
			";" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			"]" => -105,
			")" => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP18_TERNARY' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP06_REGEX_MATCH' => -105,
			'OP15_LOGICAL_AND' => -105
		}
	},
	{#State 199
		ACTIONS => {
			'OP16_LOGICAL_OR' => -117,
			'OP13_BITWISE_AND' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => -117,
			'OP08_MATH_ADD_SUB' => 120,
			'OP23_LOGICAL_AND' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			".." => -117,
			";" => -117,
			"]" => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			")" => -117,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP21_LIST_COMMA' => -117,
			'OP11_COMPARE_LT_GT' => 117,
			'OP18_TERNARY' => -117,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => -117,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => -117
		}
	},
	{#State 200
		ACTIONS => {
			"}" => 247,
			'OP21_LIST_COMMA' => 245
		},
		GOTOS => {
			'PAREN-61' => 246
		}
	},
	{#State 201
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -202,
			'LITERAL_STRING' => -202,
			'WORD' => -202,
			"undef" => -202,
			"\@{" => -202,
			"my" => 100,
			"[" => -202,
			"%{" => -202,
			'LITERAL_NUMBER' => -202,
			'OP22_LOGICAL_NOT' => -202,
			'WORD_SCOPED' => -202,
			'OP10_NAMED_UNARY' => -202,
			'OP10_NAMED_UNARY_STRINGIFY' => -202,
			'OP05_LOGICAL_NEG' => -202,
			'OP05_MATH_NEG' => -202,
			"(" => -202,
			"{" => -202,
			'VARIABLE_SYMBOL' => -202,
			'OP01_NAMED' => -202
		},
		GOTOS => {
			'TypeInner' => 249,
			'OPTIONAL-60' => 248
		}
	},
	{#State 202
		DEFAULT => -179
	},
	{#State 203
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"[" => 49,
			"%{" => 50,
			'WORD' => 250,
			"\@{" => 72,
			"undef" => 48
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashDereferenced' => 73,
			'Operator' => 79,
			'Variable' => 98,
			'WordScoped' => 80,
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'Expression' => 251
		}
	},
	{#State 204
		ACTIONS => {
			"%{" => 50,
			"[" => 49,
			"\@{" => 72,
			"undef" => 48,
			'WORD' => 14,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashDereferenced' => 73,
			'Variable' => 98,
			'Operator' => 79,
			'WordScoped' => 80,
			'Expression' => 252,
			'ArrayDereferenced' => 70,
			'HashReference' => 61
		}
	},
	{#State 205
		ACTIONS => {
			"(" => 253
		}
	},
	{#State 206
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			'OP18_TERNARY' => 118,
			")" => 254,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			'OP08_MATH_ADD_SUB' => 120,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => 121
		}
	},
	{#State 207
		ACTIONS => {
			'VARIABLE_SYMBOL' => 255
		}
	},
	{#State 208
		DEFAULT => -107
	},
	{#State 209
		DEFAULT => -154
	},
	{#State 210
		ACTIONS => {
			"= sub {" => 256
		}
	},
	{#State 211
		ACTIONS => {
			";" => 257
		}
	},
	{#State 212
		ACTIONS => {
			'VARIABLE_SYMBOL' => 258
		}
	},
	{#State 213
		DEFAULT => -128
	},
	{#State 214
		ACTIONS => {
			")" => 259
		}
	},
	{#State 215
		ACTIONS => {
			"}" => 260
		}
	},
	{#State 216
		DEFAULT => -199
	},
	{#State 217
		DEFAULT => -200
	},
	{#State 218
		DEFAULT => -132
	},
	{#State 219
		ACTIONS => {
			";" => 261
		}
	},
	{#State 220
		DEFAULT => -136
	},
	{#State 221
		ACTIONS => {
			"{" => 262
		},
		GOTOS => {
			'CodeBlock' => 263
		}
	},
	{#State 222
		DEFAULT => -100
	},
	{#State 223
		ACTIONS => {
			")" => 264
		}
	},
	{#State 224
		DEFAULT => -139
	},
	{#State 225
		ACTIONS => {
			")" => 265
		}
	},
	{#State 226
		DEFAULT => -138
	},
	{#State 227
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 266
		}
	},
	{#State 228
		DEFAULT => -24
	},
	{#State 229
		ACTIONS => {
			"1;" => 267
		}
	},
	{#State 230
		DEFAULT => -34
	},
	{#State 231
		DEFAULT => -50
	},
	{#State 232
		ACTIONS => {
			'WORD' => 268
		}
	},
	{#State 233
		ACTIONS => {
			";" => 269
		}
	},
	{#State 234
		ACTIONS => {
			'LITERAL_STRING' => -37,
			"my" => 100,
			'LITERAL_NUMBER' => -37
		},
		GOTOS => {
			'OPTIONAL-13' => 270,
			'TypeInner' => 271
		}
	},
	{#State 235
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			"[" => 49,
			"%{" => 50,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54
		},
		GOTOS => {
			'WordScoped' => 80,
			'Operator' => 79,
			'Variable' => 98,
			'Expression' => 272,
			'ArrayDereferenced' => 70,
			'HashReference' => 61,
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashDereferenced' => 73
		}
	},
	{#State 236
		DEFAULT => -185
	},
	{#State 237
		ACTIONS => {
			'WORD' => 273
		}
	},
	{#State 238
		ACTIONS => {
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'KEYS_OR_VALUES' => 104,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"%{" => 50,
			"[" => 49,
			"my" => 100,
			"undef" => 48,
			"\@{" => 72,
			'WORD' => 14
		},
		GOTOS => {
			'Expression' => 101,
			'ArrayDereferenced' => 70,
			'HashReference' => 61,
			'TypeInner' => 97,
			'WordScoped' => 80,
			'Operator' => 79,
			'Variable' => 98,
			'HashDereferenced' => 73,
			'ListElement' => 274,
			'ArrayReference' => 87,
			'Literal' => 75
		}
	},
	{#State 239
		DEFAULT => -190
	},
	{#State 240
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			"undef" => 48,
			"my" => 100,
			"\@{" => 72,
			'WORD' => 14,
			"%{" => 50,
			"[" => 49,
			'OP22_LOGICAL_NOT' => 88,
			'KEYS_OR_VALUES' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			")" => -142,
			'OP05_LOGICAL_NEG' => 63,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'Literal' => 75,
			'ArrayReference' => 87,
			'ListElement' => 102,
			'HashDereferenced' => 73,
			'OPTIONAL-48' => 275,
			'Variable' => 98,
			'Operator' => 79,
			'TypeInner' => 97,
			'WordScoped' => 80,
			'ArrayDereferenced' => 70,
			'Expression' => 101,
			'HashReference' => 61,
			'ListElements' => 276
		}
	},
	{#State 241
		DEFAULT => -188
	},
	{#State 242
		DEFAULT => -187
	},
	{#State 243
		ACTIONS => {
			"/" => 277
		}
	},
	{#State 244
		ACTIONS => {
			'VARIABLE_SYMBOL' => 60
		},
		GOTOS => {
			'Variable' => 278
		}
	},
	{#State 245
		ACTIONS => {
			'WORD' => 134,
			"%{" => 50
		},
		GOTOS => {
			'HashEntry' => 279,
			'HashDereferenced' => 131
		}
	},
	{#State 246
		DEFAULT => -208
	},
	{#State 247
		DEFAULT => -210
	},
	{#State 248
		ACTIONS => {
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"undef" => 48,
			"\@{" => 72,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53
		},
		GOTOS => {
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashDereferenced' => 73,
			'WordScoped' => 80,
			'Operator' => 79,
			'Variable' => 98,
			'HashReference' => 61,
			'Expression' => 280,
			'ArrayDereferenced' => 70
		}
	},
	{#State 249
		DEFAULT => -201
	},
	{#State 250
		ACTIONS => {
			"(" => -213,
			"}" => 281
		}
	},
	{#State 251
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP11_COMPARE_LT_GT' => 117,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP18_TERNARY' => 118,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116,
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			"}" => 282,
			'OP08_MATH_ADD_SUB' => 120,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => 121,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129
		}
	},
	{#State 252
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP08_MATH_ADD_SUB' => 120,
			'OP18_TERNARY' => 118,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			'OP24_LOGICAL_OR_XOR' => 119,
			"]" => 283,
			'OP15_LOGICAL_AND' => 116,
			'OP06_REGEX_MATCH' => 115,
			'OP17_LIST_RANGE' => 125,
			'OP09_BITWISE_SHIFT' => 114
		}
	},
	{#State 253
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			'WORD' => 14,
			"undef" => 48,
			"\@{" => 72,
			"[" => 49,
			"%{" => 50,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashDereferenced' => 73,
			'WordScoped' => 80,
			'Variable' => 98,
			'Operator' => 79,
			'HashReference' => 61,
			'Expression' => 284,
			'ArrayDereferenced' => 70
		}
	},
	{#State 254
		ACTIONS => {
			"{" => 262
		},
		GOTOS => {
			'CodeBlock' => 285
		}
	},
	{#State 255
		ACTIONS => {
			"(" => 286
		}
	},
	{#State 256
		ACTIONS => {
			'WORD_SCOPED' => -54,
			"while (" => -54,
			'OP01_NAMED_VOID_PAREN' => -54,
			'LITERAL_NUMBER' => -54,
			'OP22_LOGICAL_NOT' => -54,
			'OP19_LOOP_CONTROL' => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			'OP10_NAMED_UNARY' => -54,
			'OP05_MATH_NEG' => -54,
			"(" => -54,
			'OP05_LOGICAL_NEG' => -54,
			'OP01_NAMED' => -54,
			"foreach my" => -54,
			"{" => -54,
			"( my" => 289,
			'VARIABLE_SYMBOL' => -54,
			"for my integer" => -54,
			"if (" => -54,
			'LITERAL_STRING' => -54,
			'OP01_NAMED_VOID' => -54,
			'OP03_MATH_INC_DEC' => -54,
			"[" => -54,
			"%{" => -54,
			'WORD' => -54,
			"my" => -54,
			"undef" => -54,
			"\@{" => -54
		},
		GOTOS => {
			'SubroutineArguments' => 288,
			'OPTIONAL-21' => 287
		}
	},
	{#State 257
		DEFAULT => -134
	},
	{#State 258
		DEFAULT => -216
	},
	{#State 259
		ACTIONS => {
			";" => 290
		}
	},
	{#State 260
		DEFAULT => -215
	},
	{#State 261
		DEFAULT => -137
	},
	{#State 262
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED_VOID_PAREN' => 69,
			'WORD_SCOPED' => 13,
			"while (" => -157,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP19_LOOP_CONTROL' => 82,
			'OP05_LOGICAL_NEG' => 63,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			"foreach my" => -157,
			'OP01_NAMED' => 78,
			"for my integer" => -157,
			"if (" => 76,
			'OP03_MATH_INC_DEC' => 53,
			'OP01_NAMED_VOID' => 74,
			'LITERAL_STRING' => 54,
			"my" => 47,
			"undef" => 48,
			"\@{" => 72,
			'WORD' => 46,
			"%{" => 50,
			"[" => 49
		},
		GOTOS => {
			'Conditional' => 71,
			'ArrayDereferenced' => 70,
			'Operation' => 292,
			'Variable' => 51,
			'Statement' => 55,
			'HashDereferenced' => 73,
			'OperatorVoid' => 56,
			'LoopLabel' => 57,
			'Literal' => 75,
			'OPTIONAL-50' => 62,
			'VariableModification' => 77,
			'HashReference' => 61,
			'Expression' => 58,
			'WordScoped' => 80,
			'PLUS-55' => 291,
			'Operator' => 79,
			'PAREN-49' => 84,
			'VariableDeclaration' => 81,
			'ArrayReference' => 87
		}
	},
	{#State 263
		DEFAULT => -165,
		GOTOS => {
			'STAR-52' => 293
		}
	},
	{#State 264
		DEFAULT => -102
	},
	{#State 265
		DEFAULT => -152
	},
	{#State 266
		ACTIONS => {
			"use" => -71,
			"use constant" => -71,
			"## no critic qw(" => 22,
			"our %properties = (" => -71
		},
		GOTOS => {
			'Critic' => 295,
			'STAR-29' => 294
		}
	},
	{#State 267
		DEFAULT => -26
	},
	{#State 268
		ACTIONS => {
			'OP20_HASH_FATARROW' => 296
		}
	},
	{#State 269
		DEFAULT => -35
	},
	{#State 270
		ACTIONS => {
			'LITERAL_STRING' => 54,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 297
		}
	},
	{#State 271
		DEFAULT => -36
	},
	{#State 272
		ACTIONS => {
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP08_MATH_ADD_SUB' => 120,
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128,
			";" => 298,
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			'OP18_TERNARY' => 118,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125
		}
	},
	{#State 273
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 274
		DEFAULT => -189
	},
	{#State 275
		ACTIONS => {
			")" => 300
		}
	},
	{#State 276
		DEFAULT => -141
	},
	{#State 277
		DEFAULT => -108
	},
	{#State 278
		DEFAULT => -122
	},
	{#State 279
		DEFAULT => -207
	},
	{#State 280
		ACTIONS => {
			'OP18_TERNARY' => 118,
			'OP11_COMPARE_LT_GT' => 117,
			'OP21_LIST_COMMA' => -203,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP15_LOGICAL_AND' => 116,
			'OP06_REGEX_MATCH' => 115,
			'OP17_LIST_RANGE' => 125,
			'OP09_BITWISE_SHIFT' => 114,
			"}" => -203,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => 121,
			'OP08_MATH_ADD_SUB' => 120
		}
	},
	{#State 281
		DEFAULT => -184
	},
	{#State 282
		DEFAULT => -183
	},
	{#State 283
		DEFAULT => -182
	},
	{#State 284
		ACTIONS => {
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_MATH_ADD_SUB' => 120,
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			".." => 301,
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			'OP18_TERNARY' => 118,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116
		}
	},
	{#State 285
		DEFAULT => -175
	},
	{#State 286
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			"\@{" => 72,
			"my" => 100,
			"undef" => 48,
			'WORD' => 14,
			"%{" => 50,
			"[" => 49,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'KEYS_OR_VALUES' => 104,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP05_LOGICAL_NEG' => 63,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'ArrayReference' => 87,
			'Literal' => 75,
			'ListElement' => 102,
			'Expression' => 101,
			'ArrayDereferenced' => 70,
			'HashReference' => 61,
			'ListElements' => 302,
			'Operator' => 79,
			'Variable' => 98,
			'TypeInner' => 97,
			'WordScoped' => 80
		}
	},
	{#State 287
		ACTIONS => {
			"[" => 49,
			"%{" => 50,
			'WORD' => 46,
			"undef" => 48,
			"\@{" => 72,
			"my" => 47,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			'OP01_NAMED_VOID' => 74,
			"if (" => 76,
			"for my integer" => -157,
			"foreach my" => -157,
			'OP01_NAMED' => 78,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP19_LOOP_CONTROL' => 82,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			"while (" => -157,
			'OP01_NAMED_VOID_PAREN' => 69,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 75,
			'LoopLabel' => 57,
			'OperatorVoid' => 56,
			'HashDereferenced' => 73,
			'Statement' => 55,
			'Variable' => 51,
			'Operation' => 304,
			'ArrayDereferenced' => 70,
			'Conditional' => 71,
			'ArrayReference' => 87,
			'VariableDeclaration' => 81,
			'PAREN-49' => 84,
			'Operator' => 79,
			'PLUS-22' => 303,
			'WordScoped' => 80,
			'VariableModification' => 77,
			'HashReference' => 61,
			'Expression' => 58,
			'OPTIONAL-50' => 62
		}
	},
	{#State 288
		DEFAULT => -53
	},
	{#State 289
		ACTIONS => {
			'WORD' => 95
		},
		GOTOS => {
			'Type' => 305
		}
	},
	{#State 290
		DEFAULT => -135
	},
	{#State 291
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			'OP19_LOOP_CONTROL' => 82,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP01_NAMED_VOID_PAREN' => 69,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			"while (" => -157,
			'WORD_SCOPED' => 13,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP01_NAMED' => 78,
			"foreach my" => -157,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP01_NAMED_VOID' => 74,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			"for my integer" => -157,
			"if (" => 76,
			'WORD' => 46,
			"my" => 47,
			"\@{" => 72,
			"undef" => 48,
			"[" => 49,
			"%{" => 50,
			"}" => 307
		},
		GOTOS => {
			'Operation' => 306,
			'Variable' => 51,
			'Conditional' => 71,
			'ArrayDereferenced' => 70,
			'LoopLabel' => 57,
			'OperatorVoid' => 56,
			'Literal' => 75,
			'Statement' => 55,
			'HashDereferenced' => 73,
			'WordScoped' => 80,
			'Operator' => 79,
			'OPTIONAL-50' => 62,
			'Expression' => 58,
			'HashReference' => 61,
			'VariableModification' => 77,
			'ArrayReference' => 87,
			'PAREN-49' => 84,
			'VariableDeclaration' => 81
		}
	},
	{#State 292
		DEFAULT => -177
	},
	{#State 293
		ACTIONS => {
			'VARIABLE_SYMBOL' => -168,
			"{" => -168,
			'' => -168,
			'OP01_NAMED' => -168,
			"foreach my" => -168,
			'OP05_LOGICAL_NEG' => -168,
			'OP05_MATH_NEG' => -168,
			"(" => -168,
			'OP10_NAMED_UNARY' => -168,
			'OP19_LOOP_CONTROL' => -168,
			'OP10_NAMED_UNARY_STRINGIFY' => -168,
			'OP01_NAMED_VOID_PAREN' => -168,
			'LITERAL_NUMBER' => -168,
			'OP22_LOGICAL_NOT' => -168,
			"elsif (" => 309,
			"while (" => -168,
			'WORD_SCOPED' => -168,
			'WORD' => -168,
			"\@{" => -168,
			"undef" => -168,
			"my" => -168,
			"else" => 312,
			"[" => -168,
			"%{" => -168,
			"}" => -168,
			'OP03_MATH_INC_DEC' => -168,
			'OP01_NAMED_VOID' => -168,
			'LITERAL_STRING' => -168,
			"if (" => -168,
			"for my integer" => -168
		},
		GOTOS => {
			'OPTIONAL-54' => 311,
			'PAREN-53' => 308,
			'PAREN-51' => 310
		}
	},
	{#State 294
		ACTIONS => {
			"our %properties = (" => -73,
			"use constant" => -73,
			"use" => 25
		},
		GOTOS => {
			'STAR-30' => 314,
			'Include' => 313
		}
	},
	{#State 295
		DEFAULT => -68
	},
	{#State 296
		ACTIONS => {
			'LITERAL_NUMBER' => -44,
			'LITERAL_STRING' => -44,
			"my" => 100
		},
		GOTOS => {
			'TypeInner' => 316,
			'OPTIONAL-17' => 315
		}
	},
	{#State 297
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 317
		}
	},
	{#State 298
		DEFAULT => -186
	},
	{#State 299
		DEFAULT => -217
	},
	{#State 300
		DEFAULT => -153
	},
	{#State 301
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			'OP01_NAMED' => 78,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			"[" => 49,
			"%{" => 50
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashReference' => 61,
			'Expression' => 318,
			'ArrayDereferenced' => 70,
			'WordScoped' => 80,
			'Operator' => 79,
			'Variable' => 98
		}
	},
	{#State 302
		ACTIONS => {
			")" => 319
		}
	},
	{#State 303
		ACTIONS => {
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			'OP05_LOGICAL_NEG' => 63,
			"foreach my" => -157,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'WORD_SCOPED' => 13,
			"while (" => -157,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'OP01_NAMED_VOID_PAREN' => 69,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP19_LOOP_CONTROL' => 82,
			'OP10_NAMED_UNARY' => 66,
			"}" => 321,
			"%{" => 50,
			"[" => 49,
			"\@{" => 72,
			"my" => 47,
			"undef" => 48,
			'WORD' => 46,
			"if (" => 76,
			"for my integer" => -157,
			'LITERAL_STRING' => 54,
			'OP01_NAMED_VOID' => 74,
			'OP03_MATH_INC_DEC' => 53
		},
		GOTOS => {
			'Operator' => 79,
			'WordScoped' => 80,
			'HashReference' => 61,
			'VariableModification' => 77,
			'Expression' => 58,
			'OPTIONAL-50' => 62,
			'ArrayReference' => 87,
			'VariableDeclaration' => 81,
			'PAREN-49' => 84,
			'Variable' => 51,
			'Operation' => 320,
			'Conditional' => 71,
			'ArrayDereferenced' => 70,
			'Literal' => 75,
			'LoopLabel' => 57,
			'OperatorVoid' => 56,
			'HashDereferenced' => 73,
			'Statement' => 55
		}
	},
	{#State 304
		DEFAULT => -56
	},
	{#State 305
		ACTIONS => {
			'VARIABLE_SYMBOL' => 322
		}
	},
	{#State 306
		DEFAULT => -176
	},
	{#State 307
		DEFAULT => -178
	},
	{#State 308
		DEFAULT => -167
	},
	{#State 309
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			"[" => 49,
			"%{" => 50,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 13,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Literal' => 75,
			'HashDereferenced' => 73,
			'WordScoped' => 80,
			'Variable' => 98,
			'Operator' => 79,
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'Expression' => 323
		}
	},
	{#State 310
		DEFAULT => -164
	},
	{#State 311
		DEFAULT => -169
	},
	{#State 312
		ACTIONS => {
			"{" => 262
		},
		GOTOS => {
			'CodeBlock' => 324
		}
	},
	{#State 313
		DEFAULT => -70
	},
	{#State 314
		ACTIONS => {
			"use constant" => 34,
			"our %properties = (" => 327
		},
		GOTOS => {
			'Constant' => 325,
			'Properties' => 326
		}
	},
	{#State 315
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 54
		},
		GOTOS => {
			'Literal' => 328
		}
	},
	{#State 316
		DEFAULT => -43
	},
	{#State 317
		ACTIONS => {
			"]" => 331,
			'OP21_LIST_COMMA' => 330
		},
		GOTOS => {
			'PAREN-15' => 329
		}
	},
	{#State 318
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130,
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP08_MATH_ADD_SUB' => 120,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			")" => 332,
			'OP18_TERNARY' => 118,
			'OP11_COMPARE_LT_GT' => 117,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP17_LIST_RANGE' => 125,
			'OP09_BITWISE_SHIFT' => 114,
			'OP15_LOGICAL_AND' => 116,
			'OP06_REGEX_MATCH' => 115
		}
	},
	{#State 319
		ACTIONS => {
			"{" => 262
		},
		GOTOS => {
			'CodeBlock' => 333
		}
	},
	{#State 320
		DEFAULT => -55
	},
	{#State 321
		ACTIONS => {
			";" => 334
		}
	},
	{#State 322
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 335
		}
	},
	{#State 323
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP18_TERNARY' => 118,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			")" => 336,
			'OP15_LOGICAL_AND' => 116,
			'OP06_REGEX_MATCH' => 115,
			'OP17_LIST_RANGE' => 125,
			'OP09_BITWISE_SHIFT' => 114,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP08_MATH_ADD_SUB' => 120
		}
	},
	{#State 324
		DEFAULT => -166
	},
	{#State 325
		DEFAULT => -72
	},
	{#State 326
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 337
		}
	},
	{#State 327
		ACTIONS => {
			"%{" => 50,
			'WORD' => 338,
			")" => 339
		},
		GOTOS => {
			'HashDereferenced' => 341,
			'HashEntryTyped' => 340
		}
	},
	{#State 328
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 342
		}
	},
	{#State 329
		DEFAULT => -41
	},
	{#State 330
		ACTIONS => {
			'LITERAL_NUMBER' => -39,
			"my" => 100,
			'LITERAL_STRING' => -39
		},
		GOTOS => {
			'TypeInner' => 343,
			'OPTIONAL-14' => 344
		}
	},
	{#State 331
		DEFAULT => -51
	},
	{#State 332
		ACTIONS => {
			"{" => 262
		},
		GOTOS => {
			'CodeBlock' => 345
		}
	},
	{#State 333
		DEFAULT => -174
	},
	{#State 334
		DEFAULT => -57
	},
	{#State 335
		ACTIONS => {
			'OP21_LIST_COMMA' => 348,
			")" => 346
		},
		GOTOS => {
			'PAREN-23' => 347
		}
	},
	{#State 336
		ACTIONS => {
			"{" => 262
		},
		GOTOS => {
			'CodeBlock' => 349
		}
	},
	{#State 337
		ACTIONS => {
			"1;" => 350,
			"our" => 351
		},
		GOTOS => {
			'Method' => 352
		}
	},
	{#State 338
		ACTIONS => {
			'OP20_HASH_FATARROW' => 353
		}
	},
	{#State 339
		ACTIONS => {
			";" => 354
		}
	},
	{#State 340
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 355
		}
	},
	{#State 341
		DEFAULT => -206
	},
	{#State 342
		ACTIONS => {
			"}" => 356,
			'OP21_LIST_COMMA' => 357
		},
		GOTOS => {
			'PAREN-19' => 358
		}
	},
	{#State 343
		DEFAULT => -38
	},
	{#State 344
		ACTIONS => {
			'LITERAL_STRING' => 54,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 359
		}
	},
	{#State 345
		DEFAULT => -173
	},
	{#State 346
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 360
		}
	},
	{#State 347
		DEFAULT => -59
	},
	{#State 348
		ACTIONS => {
			"my" => 361
		}
	},
	{#State 349
		DEFAULT => -163
	},
	{#State 350
		ACTIONS => {
			"1;" => 362
		}
	},
	{#State 351
		ACTIONS => {
			'WORD' => 95
		},
		GOTOS => {
			'Type' => 363
		}
	},
	{#State 352
		DEFAULT => -74
	},
	{#State 353
		ACTIONS => {
			"my" => 100
		},
		GOTOS => {
			'TypeInner' => 364
		}
	},
	{#State 354
		DEFAULT => -86
	},
	{#State 355
		ACTIONS => {
			")" => 367,
			'OP21_LIST_COMMA' => 365
		},
		GOTOS => {
			'PAREN-35' => 366
		}
	},
	{#State 356
		DEFAULT => -52
	},
	{#State 357
		ACTIONS => {
			'WORD' => 368
		}
	},
	{#State 358
		DEFAULT => -48
	},
	{#State 359
		DEFAULT => -40
	},
	{#State 360
		ACTIONS => {
			"\@_;" => 369
		}
	},
	{#State 361
		ACTIONS => {
			'WORD' => 95
		},
		GOTOS => {
			'Type' => 370
		}
	},
	{#State 362
		ACTIONS => {
			"package" => -80,
			'' => -80,
			"our" => 67
		},
		GOTOS => {
			'OPTIONAL-34' => 374,
			'Subroutine' => 372,
			'PAREN-33' => 371,
			'PLUS-32' => 373
		}
	},
	{#State 363
		ACTIONS => {
			'VARIABLE_SYMBOL' => 375
		}
	},
	{#State 364
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashReference' => 61,
			'Expression' => 376,
			'ArrayDereferenced' => 70,
			'Variable' => 98,
			'Operator' => 79,
			'WordScoped' => 80
		}
	},
	{#State 365
		ACTIONS => {
			"%{" => 50,
			'WORD' => 338
		},
		GOTOS => {
			'HashDereferenced' => 341,
			'HashEntryTyped' => 377
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
			'OP20_HASH_FATARROW' => 379
		}
	},
	{#State 369
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 380
		}
	},
	{#State 370
		ACTIONS => {
			'VARIABLE_SYMBOL' => 381
		}
	},
	{#State 371
		DEFAULT => -79
	},
	{#State 372
		DEFAULT => -77
	},
	{#State 373
		ACTIONS => {
			"1;" => 383,
			"our" => 67
		},
		GOTOS => {
			'Subroutine' => 382
		}
	},
	{#State 374
		DEFAULT => -81
	},
	{#State 375
		ACTIONS => {
			"= sub {" => 384
		}
	},
	{#State 376
		ACTIONS => {
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP08_MATH_ADD_SUB' => 120,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => 121,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			'OP24_LOGICAL_OR_XOR' => 119,
			")" => -205,
			'OP21_LIST_COMMA' => -205,
			'OP11_COMPARE_LT_GT' => 117,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP18_TERNARY' => 118,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116
		}
	},
	{#State 377
		DEFAULT => -82
	},
	{#State 378
		DEFAULT => -85
	},
	{#State 379
		ACTIONS => {
			'LITERAL_NUMBER' => -46,
			'LITERAL_STRING' => -46,
			"my" => 100
		},
		GOTOS => {
			'OPTIONAL-18' => 385,
			'TypeInner' => 386
		}
	},
	{#State 380
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			'OP19_LOOP_CONTROL' => -63,
			'OP10_NAMED_UNARY' => -63,
			"while (" => -63,
			'WORD_SCOPED' => -63,
			'LITERAL_NUMBER' => -63,
			'CHECK_OR_CHECKTRACE' => 387,
			'OP22_LOGICAL_NOT' => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			'OP01_NAMED' => -63,
			"foreach my" => -63,
			"{" => -63,
			'VARIABLE_SYMBOL' => -63,
			"(" => -63,
			'OP05_MATH_NEG' => -63,
			'OP05_LOGICAL_NEG' => -63,
			'LITERAL_STRING' => -63,
			'OP03_MATH_INC_DEC' => -63,
			'OP01_NAMED_VOID' => -63,
			"if (" => -63,
			"for my integer" => -63,
			"%{" => -63,
			"[" => -63,
			"undef" => -63,
			"my" => -63,
			"\@{" => -63,
			'WORD' => -63
		},
		GOTOS => {
			'ArgumentCheck' => 388
		}
	},
	{#State 381
		DEFAULT => -58
	},
	{#State 382
		DEFAULT => -76
	},
	{#State 383
		ACTIONS => {
			"1;" => 389
		}
	},
	{#State 384
		ACTIONS => {
			"{" => -88,
			"( my" => 392,
			'VARIABLE_SYMBOL' => -88,
			"foreach my" => -88,
			'OP01_NAMED' => -88,
			'OP05_LOGICAL_NEG' => -88,
			"(" => -88,
			'OP05_MATH_NEG' => -88,
			'OP10_NAMED_UNARY' => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			'OP19_LOOP_CONTROL' => -88,
			'OP22_LOGICAL_NOT' => -88,
			'LITERAL_NUMBER' => -88,
			'OP01_NAMED_VOID_PAREN' => -88,
			'WORD_SCOPED' => -88,
			"while (" => -88,
			"\@{" => -88,
			"undef" => -88,
			"my" => -88,
			'WORD' => -88,
			"%{" => -88,
			"[" => -88,
			'OP01_NAMED_VOID' => -88,
			'OP03_MATH_INC_DEC' => -88,
			'LITERAL_STRING' => -88,
			"if (" => -88,
			"for my integer" => -88
		},
		GOTOS => {
			'OPTIONAL-37' => 390,
			'MethodArguments' => 391
		}
	},
	{#State 385
		ACTIONS => {
			'LITERAL_STRING' => 54,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 393
		}
	},
	{#State 386
		DEFAULT => -45
	},
	{#State 387
		ACTIONS => {
			"(" => 394
		}
	},
	{#State 388
		DEFAULT => -61
	},
	{#State 389
		DEFAULT => -78
	},
	{#State 390
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED_VOID_PAREN' => 69,
			'WORD_SCOPED' => 13,
			"while (" => -157,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP19_LOOP_CONTROL' => 82,
			'OP05_LOGICAL_NEG' => 63,
			"(" => 65,
			'OP05_MATH_NEG' => 64,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			"foreach my" => -157,
			'OP01_NAMED' => 78,
			"for my integer" => -157,
			"if (" => 76,
			'OP03_MATH_INC_DEC' => 53,
			'OP01_NAMED_VOID' => 74,
			'LITERAL_STRING' => 54,
			"undef" => 48,
			"\@{" => 72,
			"my" => 47,
			'WORD' => 46,
			"%{" => 50,
			"[" => 49
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'Statement' => 55,
			'Literal' => 75,
			'LoopLabel' => 57,
			'OperatorVoid' => 56,
			'PLUS-38' => 395,
			'Conditional' => 71,
			'ArrayDereferenced' => 70,
			'Variable' => 51,
			'Operation' => 396,
			'VariableDeclaration' => 81,
			'PAREN-49' => 84,
			'ArrayReference' => 87,
			'Expression' => 58,
			'HashReference' => 61,
			'VariableModification' => 77,
			'OPTIONAL-50' => 62,
			'Operator' => 79,
			'WordScoped' => 80
		}
	},
	{#State 391
		DEFAULT => -87
	},
	{#State 392
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 397
		}
	},
	{#State 393
		DEFAULT => -47
	},
	{#State 394
		ACTIONS => {
			"[" => 49,
			"%{" => 50,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			'OP01_NAMED' => 78,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'WORD_SCOPED' => 13,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashDereferenced' => 73,
			'WordScoped' => 80,
			'Variable' => 98,
			'Operator' => 79,
			'HashReference' => 61,
			'Expression' => 398,
			'ArrayDereferenced' => 70
		}
	},
	{#State 395
		ACTIONS => {
			"while (" => -157,
			'WORD_SCOPED' => 13,
			'OP01_NAMED_VOID_PAREN' => 69,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'OP19_LOOP_CONTROL' => 82,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP10_NAMED_UNARY' => 66,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP05_LOGICAL_NEG' => 63,
			'OP01_NAMED' => 78,
			"foreach my" => -157,
			"{" => 59,
			'VARIABLE_SYMBOL' => 60,
			"if (" => 76,
			"for my integer" => -157,
			'LITERAL_STRING' => 54,
			'OP03_MATH_INC_DEC' => 53,
			'OP01_NAMED_VOID' => 74,
			"}" => 399,
			"[" => 49,
			"%{" => 50,
			'WORD' => 46,
			"\@{" => 72,
			"my" => 47,
			"undef" => 48
		},
		GOTOS => {
			'Literal' => 75,
			'OperatorVoid' => 56,
			'LoopLabel' => 57,
			'HashDereferenced' => 73,
			'Statement' => 55,
			'Variable' => 51,
			'Operation' => 400,
			'ArrayDereferenced' => 70,
			'Conditional' => 71,
			'ArrayReference' => 87,
			'VariableDeclaration' => 81,
			'PAREN-49' => 84,
			'Operator' => 79,
			'WordScoped' => 80,
			'Expression' => 58,
			'VariableModification' => 77,
			'HashReference' => 61,
			'OPTIONAL-50' => 62
		}
	},
	{#State 396
		DEFAULT => -90
	},
	{#State 397
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 401
		}
	},
	{#State 398
		ACTIONS => {
			'OP15_LOGICAL_AND' => 116,
			'OP06_REGEX_MATCH' => 115,
			'OP17_LIST_RANGE' => 125,
			'OP09_BITWISE_SHIFT' => 114,
			'OP18_TERNARY' => 118,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP11_COMPARE_LT_GT' => 117,
			'OP21_LIST_COMMA' => 403,
			")" => -66,
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP04_MATH_POW' => 129,
			'OP08_STRING_CAT' => 122,
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP08_MATH_ADD_SUB' => 120,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124
		},
		GOTOS => {
			'PAREN-26' => 402,
			'OPTIONAL-27' => 404
		}
	},
	{#State 399
		ACTIONS => {
			";" => 405
		}
	},
	{#State 400
		DEFAULT => -89
	},
	{#State 401
		ACTIONS => {
			")" => 407,
			'OP21_LIST_COMMA' => 408
		},
		GOTOS => {
			'PAREN-39' => 406
		}
	},
	{#State 402
		DEFAULT => -65
	},
	{#State 403
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			'WORD' => 14,
			"\@{" => 72,
			"undef" => 48,
			"[" => 49,
			"%{" => 50,
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'LITERAL_NUMBER' => 86,
			'OP22_LOGICAL_NOT' => 88,
			'WORD_SCOPED' => 13,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65
		},
		GOTOS => {
			'HashDereferenced' => 73,
			'Literal' => 75,
			'ArrayReference' => 87,
			'HashReference' => 61,
			'ArrayDereferenced' => 70,
			'Expression' => 409,
			'Variable' => 98,
			'Operator' => 79,
			'WordScoped' => 80
		}
	},
	{#State 404
		ACTIONS => {
			")" => 410
		}
	},
	{#State 405
		DEFAULT => -91
	},
	{#State 406
		DEFAULT => -93
	},
	{#State 407
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 411
		}
	},
	{#State 408
		ACTIONS => {
			"my" => 412
		}
	},
	{#State 409
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP18_TERNARY' => 118,
			'OP21_LIST_COMMA' => 413,
			'OP11_COMPARE_LT_GT' => 117,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP17_LIST_RANGE' => 125,
			'OP09_BITWISE_SHIFT' => 114,
			'OP15_LOGICAL_AND' => 116,
			'OP06_REGEX_MATCH' => 115,
			'OP16_LOGICAL_OR' => 124,
			'OP13_BITWISE_AND' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP14_BITWISE_OR_XOR' => 128,
			'OP23_LOGICAL_AND' => 121,
			'OP08_MATH_ADD_SUB' => 120,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129
		}
	},
	{#State 410
		ACTIONS => {
			";" => 414
		}
	},
	{#State 411
		ACTIONS => {
			"\@_;" => 415
		}
	},
	{#State 412
		ACTIONS => {
			'WORD' => 95
		},
		GOTOS => {
			'Type' => 416
		}
	},
	{#State 413
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 68,
			'OP22_LOGICAL_NOT' => 88,
			'LITERAL_NUMBER' => 86,
			'WORD_SCOPED' => 13,
			'VARIABLE_SYMBOL' => 60,
			"{" => 59,
			'OP01_NAMED' => 78,
			'OP05_LOGICAL_NEG' => 63,
			'OP05_MATH_NEG' => 64,
			"(" => 65,
			'OP03_MATH_INC_DEC' => 53,
			'LITERAL_STRING' => 54,
			'WORD' => 14,
			"undef" => 48,
			"\@{" => 72,
			"[" => 49,
			"%{" => 50
		},
		GOTOS => {
			'ArrayDereferenced' => 70,
			'Expression' => 417,
			'HashReference' => 61,
			'WordScoped' => 80,
			'Variable' => 98,
			'Operator' => 79,
			'HashDereferenced' => 73,
			'ArrayReference' => 87,
			'Literal' => 75
		}
	},
	{#State 414
		DEFAULT => -67
	},
	{#State 415
		DEFAULT => -96,
		GOTOS => {
			'STAR-41' => 418
		}
	},
	{#State 416
		ACTIONS => {
			'VARIABLE_SYMBOL' => 419
		}
	},
	{#State 417
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 117,
			'OP12_COMPARE_EQ_NEQ' => 126,
			'OP18_TERNARY' => 118,
			")" => -64,
			'OP24_LOGICAL_OR_XOR' => 119,
			'OP06_REGEX_MATCH' => 115,
			'OP15_LOGICAL_AND' => 116,
			'OP09_BITWISE_SHIFT' => 114,
			'OP17_LIST_RANGE' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 123,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 124,
			'OP08_STRING_CAT' => 122,
			'OP04_MATH_POW' => 129,
			'OP08_MATH_ADD_SUB' => 120,
			'OP23_LOGICAL_AND' => 121,
			'OP14_BITWISE_OR_XOR' => 128
		}
	},
	{#State 418
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -97,
			"(" => -97,
			'OP05_MATH_NEG' => -97,
			'VARIABLE_SYMBOL' => -97,
			"{" => -97,
			"foreach my" => -97,
			'OP01_NAMED' => -97,
			'CHECK_OR_CHECKTRACE' => 387,
			'LITERAL_NUMBER' => -97,
			'OP22_LOGICAL_NOT' => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			"while (" => -97,
			'WORD_SCOPED' => -97,
			'OP10_NAMED_UNARY' => -97,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			'OP19_LOOP_CONTROL' => -97,
			"undef" => -97,
			"my" => -97,
			"\@{" => -97,
			'WORD' => -97,
			"%{" => -97,
			"[" => -97,
			"if (" => -97,
			"for my integer" => -97,
			'OP03_MATH_INC_DEC' => -97,
			'OP01_NAMED_VOID' => -97,
			'LITERAL_STRING' => -97
		},
		GOTOS => {
			'ArgumentCheck' => 420
		}
	},
	{#State 419
		DEFAULT => -92
	},
	{#State 420
		DEFAULT => -95
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5572 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5579 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5586 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5597 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5608 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5615 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5622 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5629 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5636 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5643 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5650 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5657 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5664 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5671 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5678 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5689 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5700 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5711 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5718 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5725 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5732 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5739 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5746 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5753 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5760 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5767 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 10,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5778 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5789 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5796 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5803 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5814 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5821 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5828 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5839 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5850 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5861 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5868 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5875 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5882 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5889 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5896 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5903 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5910 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5917 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5924 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5931 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5938 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5945 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5952 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5959 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5970 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5981 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5992 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6006 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6013 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6031 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6038 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6045 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6052 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6059 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6066 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6077 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6084 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6091 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6098 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6109 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6116 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6123 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6130 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6137 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6144 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6151 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6172 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6179 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 3,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6186 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6193 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6200 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 17,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6211 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6218 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6225 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6243 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6254 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6261 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6268 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6275 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6282 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6293 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6307 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6321 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6328 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6339 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6350 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6361 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6368 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6375 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6386 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6397 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6408 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6419 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6430 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6441 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6452 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6463 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6474 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6485 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6496 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6507 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6518 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6529 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6540 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6551 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6562 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6573 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6584 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6595 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6606 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6617 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6628 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6639 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6646 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6653 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6660 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6667 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6674 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6681 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6688 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6695 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6706 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6717 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6728 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6739 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6750 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6757 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6764 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6771 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6778 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6789 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6800 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6811 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6822 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6833 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6844 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6855 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6866 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6877 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6888 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6899 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6910 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6917 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6924 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6931 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_158
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6942 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_159
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6953 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6964 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6975 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6993 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7000 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7007 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7014 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7021 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7028 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_169
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7039 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_170
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7050 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_171
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7061 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7072 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_173
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7083 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_174
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7094 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_175
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7105 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7112 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7119 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_178
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7130 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7137 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7144 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_181
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7155 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_182
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_183
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7177 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_185
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_186
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7210 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_187
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7221 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_188
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7232 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7239 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7246 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7253 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_192
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7275 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_194
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7286 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_195
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7297 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 1,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7304 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7311 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_198
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_199
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7333 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_200
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7344 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7358 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7369 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7380 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_205
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7391 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_206
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7402 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-61', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7409 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 2,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7416 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7423 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_210
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7434 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_211
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7445 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_212
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7456 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_213
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7467 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_214
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7478 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_215
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7489 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_216
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7500 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_217
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7511 lib/RPerl/Grammar.pm
	],
	[#Rule Type_218
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7522 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_219
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7533 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_220
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7544 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_221
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7555 lib/RPerl/Grammar.pm
	]
],
#line 7558 lib/RPerl/Grammar.pm
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

#line 179 "lib/RPerl/Grammar.eyp"


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


#line 7827 lib/RPerl/Grammar.pm



1;
