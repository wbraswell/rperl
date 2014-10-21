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
    our $VERSION = 0.000_712;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G(\s*(\#.+)*\s*)+/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|\=\ sub\ \{|package|elsif\ \(|while\ \(|\$TYPED_|undef|\(\ my|else|if\ \(|use|our|qw\(|\@_\;|\{\*|my|\%\{|\.\.|\@\{|1\;|\)|\]|\/|\}|\(|\{|\;|\[)}gc and return ($1, $1);

      /\G(^(\#\!\/[\w\/]*\/perl)$)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ \=\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
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
			'SHEBANG' => 2,
			"package" => 1
		},
		GOTOS => {
			'PLUS-1' => 3,
			'Class' => 4,
			'Program' => 6,
			'CompileUnit' => 5,
			'Package' => 7,
			'Module' => 8
		}
	},
	{#State 1
		ACTIONS => {
			'WORD_SCOPED' => 11,
			'WORD' => 10
		},
		GOTOS => {
			'WordScoped' => 9
		}
	},
	{#State 2
		ACTIONS => {
			"use strict;" => 12
		},
		GOTOS => {
			'Header' => 13
		}
	},
	{#State 3
		ACTIONS => {
			'' => -4,
			"package" => 1
		},
		GOTOS => {
			'Module' => 14,
			'Package' => 7,
			'Class' => 4
		}
	},
	{#State 4
		DEFAULT => -17
	},
	{#State 5
		ACTIONS => {
			'' => 15
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		DEFAULT => -16
	},
	{#State 8
		DEFAULT => -2
	},
	{#State 9
		ACTIONS => {
			";" => 16
		}
	},
	{#State 10
		DEFAULT => -213
	},
	{#State 11
		DEFAULT => -214
	},
	{#State 12
		ACTIONS => {
			"use warnings;" => 17
		}
	},
	{#State 13
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 18
		}
	},
	{#State 14
		DEFAULT => -1
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		ACTIONS => {
			"use strict;" => 12
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
			"for my integer" => -8,
			"undef" => -8,
			"my" => -8,
			"[" => -8,
			"foreach my" => -8,
			"our" => -8,
			'LITERAL_STRING' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			'WORD' => -8,
			'OP22_LOGICAL_NOT' => -8,
			'OP05_LOGICAL_NEG' => -8,
			'OP19_LOOP_CONTROL' => -8,
			"use" => -8,
			"\@{" => -8,
			'WORD_SCOPED' => -8,
			"if (" => -8,
			'OP01_NAMED_VOID' => -8,
			"while (" => -8,
			'OP10_NAMED_UNARY' => -8,
			"{" => -8,
			"## no critic qw(" => 23,
			'VARIABLE_SYMBOL' => -8,
			"(" => -8,
			'OP05_MATH_NEG' => -8,
			'OP01_NAMED' => -8,
			'OP03_MATH_INC_DEC' => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"%{" => -8,
			'LITERAL_NUMBER' => -8,
			"use constant" => -8
		},
		GOTOS => {
			'Critic' => 22,
			'STAR-3' => 21
		}
	},
	{#State 19
		ACTIONS => {
			"use parent qw(" => 24,
			"## no critic qw(" => -19,
			"our" => -19,
			"use" => -19,
			"use constant" => -19
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
			"use" => 28,
			'OP19_LOOP_CONTROL' => -10,
			'OP05_LOGICAL_NEG' => -10,
			'OP22_LOGICAL_NOT' => -10,
			'WORD' => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			'LITERAL_STRING' => -10,
			"our" => -10,
			"my" => -10,
			"[" => -10,
			"foreach my" => -10,
			"undef" => -10,
			"for my integer" => -10,
			"%{" => -10,
			'LITERAL_NUMBER' => -10,
			"use constant" => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			'OP03_MATH_INC_DEC' => -10,
			'OP01_NAMED' => -10,
			'OP05_MATH_NEG' => -10,
			"(" => -10,
			'VARIABLE_SYMBOL' => -10,
			"{" => -10,
			'OP01_NAMED_VOID' => -10,
			"while (" => -10,
			"if (" => -10,
			'OP10_NAMED_UNARY' => -10,
			"\@{" => -10,
			'WORD_SCOPED' => -10
		},
		GOTOS => {
			'STAR-4' => 27,
			'Include' => 29
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
			"use" => -21,
			"use constant" => -21,
			"our" => -21,
			"## no critic qw(" => 23
		},
		GOTOS => {
			'STAR-8' => 33,
			'Critic' => 34
		}
	},
	{#State 26
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 35
		}
	},
	{#State 27
		ACTIONS => {
			"our" => -12,
			"foreach my" => -12,
			"[" => -12,
			"my" => -12,
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			'LITERAL_STRING' => -12,
			"undef" => -12,
			"for my integer" => -12,
			'OP05_LOGICAL_NEG' => -12,
			'OP22_LOGICAL_NOT' => -12,
			'OP19_LOOP_CONTROL' => -12,
			'WORD' => -12,
			"{" => -12,
			'VARIABLE_SYMBOL' => -12,
			"\@{" => -12,
			'WORD_SCOPED' => -12,
			"if (" => -12,
			'OP01_NAMED_VOID' => -12,
			"while (" => -12,
			'OP10_NAMED_UNARY' => -12,
			'OP03_MATH_INC_DEC' => -12,
			"%{" => -12,
			'LITERAL_NUMBER' => -12,
			"use constant" => 37,
			'OP01_NAMED_VOID_PAREN' => -12,
			"(" => -12,
			'OP05_MATH_NEG' => -12,
			'OP01_NAMED' => -12
		},
		GOTOS => {
			'STAR-5' => 38,
			'Constant' => 36
		}
	},
	{#State 28
		ACTIONS => {
			'WORD' => 10,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 29
		DEFAULT => -7
	},
	{#State 30
		DEFAULT => -29
	},
	{#State 31
		ACTIONS => {
			'WORD' => 41,
			")" => 40
		}
	},
	{#State 32
		ACTIONS => {
			")" => 42
		}
	},
	{#State 33
		ACTIONS => {
			"use constant" => -23,
			"use" => 28,
			"our" => -23
		},
		GOTOS => {
			'STAR-9' => 44,
			'Include' => 43
		}
	},
	{#State 34
		DEFAULT => -18
	},
	{#State 35
		DEFAULT => -27
	},
	{#State 36
		DEFAULT => -9
	},
	{#State 37
		ACTIONS => {
			'WORD' => 45
		}
	},
	{#State 38
		ACTIONS => {
			"undef" => 64,
			"for my integer" => -157,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"our" => 62,
			"my" => 61,
			"foreach my" => -157,
			"[" => 77,
			'WORD' => 87,
			'OP19_LOOP_CONTROL' => 86,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			"while (" => -157,
			'OP10_NAMED_UNARY' => 72,
			'OP01_NAMED_VOID' => 70,
			"if (" => 71,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED_VOID_PAREN' => 51,
			'OP03_MATH_INC_DEC' => 49
		},
		GOTOS => {
			'Variable' => 59,
			'WordScoped' => 60,
			'HashReference' => 56,
			'LoopLabel' => 52,
			'Subroutine' => 50,
			'ArrayDereferenced' => 74,
			'Conditional' => 53,
			'Operator' => 55,
			'PLUS-6' => 73,
			'OPTIONAL-50' => 48,
			'HashDereferenced' => 88,
			'VariableDeclaration' => 67,
			'Statement' => 66,
			'Expression' => 68,
			'PAREN-49' => 65,
			'Literal' => 81,
			'Operation' => 79,
			'OperatorVoid' => 80,
			'VariableModification' => 82,
			'ArrayReference' => 63
		}
	},
	{#State 39
		ACTIONS => {
			";" => 89,
			"qw(" => 90
		}
	},
	{#State 40
		DEFAULT => -30
	},
	{#State 41
		DEFAULT => -28
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
			"our" => 62,
			"use constant" => 37
		},
		GOTOS => {
			'Constant' => 93,
			'PLUS-10' => 94,
			'Subroutine' => 92
		}
	},
	{#State 45
		ACTIONS => {
			'OP20_HASH_FATARROW' => 95
		}
	},
	{#State 46
		ACTIONS => {
			'WORD' => 98,
			"%{" => 54,
			"}" => 99
		},
		GOTOS => {
			'HashDereferenced' => 97,
			'HashEntry' => 96
		}
	},
	{#State 47
		DEFAULT => -180,
		GOTOS => {
			'STAR-56' => 100
		}
	},
	{#State 48
		ACTIONS => {
			"while (" => 103,
			"for my integer" => 104,
			"foreach my" => 101
		},
		GOTOS => {
			'LoopWhile' => 102,
			'Loop' => 106,
			'LoopForEach' => 107,
			'LoopFor' => 105
		}
	},
	{#State 49
		ACTIONS => {
			'VARIABLE_SYMBOL' => 47
		},
		GOTOS => {
			'Variable' => 108
		}
	},
	{#State 50
		DEFAULT => -11
	},
	{#State 51
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			"{*" => 113,
			'WORD' => 10,
			"[" => 77,
			"my" => 114,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			'KEYS_OR_VALUES' => 118,
			"undef" => 64,
			'OP03_MATH_INC_DEC' => 49,
			")" => -127,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72
		},
		GOTOS => {
			'OPTIONAL-43' => 117,
			'ArrayDereferenced' => 74,
			'TypeInner' => 116,
			'Operator' => 55,
			'HashReference' => 56,
			'ListElements' => 109,
			'Expression' => 112,
			'Variable' => 111,
			'HashDereferenced' => 88,
			'FileHandle' => 110,
			'WordScoped' => 60,
			'ListElement' => 115,
			'ArrayReference' => 63,
			'Literal' => 81
		}
	},
	{#State 52
		ACTIONS => {
			'COLON' => 119
		}
	},
	{#State 53
		DEFAULT => -158
	},
	{#State 54
		ACTIONS => {
			"{" => 120,
			'VARIABLE_SYMBOL' => 47
		},
		GOTOS => {
			'HashReference' => 121,
			'Variable' => 122
		}
	},
	{#State 55
		DEFAULT => -151
	},
	{#State 56
		DEFAULT => -148
	},
	{#State 57
		ACTIONS => {
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			"undef" => 64,
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83
		},
		GOTOS => {
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111,
			'Expression' => 123,
			'HashReference' => 56,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'Literal' => 81,
			'ArrayReference' => 63
		}
	},
	{#State 58
		ACTIONS => {
			"(" => 124
		}
	},
	{#State 59
		ACTIONS => {
			'OP17_LIST_RANGE' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP18_TERNARY' => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 126,
			'OP03_MATH_INC_DEC' => 127,
			'OP08_MATH_ADD_SUB' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP02_METHOD_THINARROW' => 128,
			'OP23_LOGICAL_AND' => -145,
			'OP04_MATH_POW' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			";" => -145,
			'OP08_STRING_CAT' => -145,
			'OP19_VARIABLE_ASSIGN' => 125,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP24_LOGICAL_OR_XOR' => -145
		}
	},
	{#State 60
		ACTIONS => {
			"(" => 129
		}
	},
	{#State 61
		ACTIONS => {
			'WORD' => 131
		},
		GOTOS => {
			'Type' => 130
		}
	},
	{#State 62
		ACTIONS => {
			'WORD' => 131
		},
		GOTOS => {
			'Type' => 132
		}
	},
	{#State 63
		DEFAULT => -146
	},
	{#State 64
		DEFAULT => -143
	},
	{#State 65
		DEFAULT => -156
	},
	{#State 66
		DEFAULT => -99
	},
	{#State 67
		DEFAULT => -161
	},
	{#State 68
		ACTIONS => {
			'OP16_LOGICAL_OR' => 146,
			'OP08_MATH_ADD_SUB' => 137,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147,
			'OP13_BITWISE_AND' => 138,
			'OP12_COMPARE_EQ_NEQ' => 143,
			";" => 142,
			'OP08_STRING_CAT' => 136,
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 144
		}
	},
	{#State 69
		ACTIONS => {
			"[" => 77,
			'VARIABLE_SYMBOL' => 47
		},
		GOTOS => {
			'ArrayReference' => 150,
			'Variable' => 151
		}
	},
	{#State 70
		ACTIONS => {
			"[" => 77,
			"my" => 114,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			'KEYS_OR_VALUES' => 118,
			"undef" => 64,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			"{*" => 113,
			'WORD' => 10,
			";" => -131,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58
		},
		GOTOS => {
			'HashReference' => 56,
			'ListElements' => 152,
			'Expression' => 112,
			'Variable' => 111,
			'FileHandle' => 153,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'TypeInner' => 116,
			'OPTIONAL-45' => 154,
			'ListElement' => 115,
			'ArrayReference' => 63,
			'Literal' => 81
		}
	},
	{#State 71
		ACTIONS => {
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			"undef" => 64,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"[" => 77,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46
		},
		GOTOS => {
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111,
			'Expression' => 155,
			'HashReference' => 56,
			'Literal' => 81,
			'ArrayReference' => 63
		}
	},
	{#State 72
		ACTIONS => {
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP01_NAMED' => 58,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49,
			"undef" => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"[" => 77,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'Expression' => 156,
			'HashReference' => 56,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111,
			'Operator' => 55,
			'ArrayDereferenced' => 74
		}
	},
	{#State 73
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'OP19_LOOP_CONTROL' => 86,
			'WORD' => 87,
			"my" => 61,
			"foreach my" => -157,
			"[" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"undef" => 64,
			"for my integer" => -157,
			'' => -15,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP01_NAMED_VOID_PAREN' => 51,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			"while (" => -157,
			'OP01_NAMED_VOID' => 70,
			"if (" => 71,
			'OP10_NAMED_UNARY' => 72
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'Operation' => 157,
			'OperatorVoid' => 80,
			'VariableModification' => 82,
			'VariableDeclaration' => 67,
			'Statement' => 66,
			'Expression' => 68,
			'HashDereferenced' => 88,
			'PAREN-49' => 65,
			'OPTIONAL-50' => 48,
			'HashReference' => 56,
			'Variable' => 59,
			'WordScoped' => 60,
			'LoopLabel' => 52,
			'Operator' => 55,
			'Conditional' => 53,
			'ArrayDereferenced' => 74
		}
	},
	{#State 74
		DEFAULT => -147
	},
	{#State 75
		DEFAULT => -221
	},
	{#State 76
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'WORD' => 10,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"[" => 77,
			"undef" => 64,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 58,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP10_NAMED_UNARY' => 72,
			"\@{" => 69,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'Expression' => 158,
			'HashReference' => 56,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111,
			'ArrayDereferenced' => 74,
			'Operator' => 55
		}
	},
	{#State 77
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'WORD' => 10,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"my" => 161,
			"[" => 77,
			"undef" => 64,
			'KEYS_OR_VALUES' => 118,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'VARIABLE_SYMBOL' => 47,
			"]" => -197,
			"{" => 46,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69
		},
		GOTOS => {
			'ArrayReference' => 63,
			'ListElement' => 115,
			'Literal' => 81,
			'ListElements' => 159,
			'Expression' => 112,
			'HashReference' => 56,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'OPTIONAL-59' => 160,
			'Variable' => 111,
			'TypeInner' => 116,
			'Operator' => 55,
			'ArrayDereferenced' => 74
		}
	},
	{#State 78
		DEFAULT => -220
	},
	{#State 79
		DEFAULT => -14
	},
	{#State 80
		DEFAULT => -160
	},
	{#State 81
		DEFAULT => -144
	},
	{#State 82
		DEFAULT => -162
	},
	{#State 83
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"[" => 77,
			"undef" => 64,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 10,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'HashReference' => 56,
			'Expression' => 162,
			'Variable' => 111,
			'WordScoped' => 60,
			'HashDereferenced' => 88
		}
	},
	{#State 84
		ACTIONS => {
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			"[" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"undef" => 64,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 10
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 63,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'Variable' => 111,
			'Expression' => 163,
			'HashReference' => 56
		}
	},
	{#State 85
		ACTIONS => {
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			"undef" => 64,
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 63,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'Variable' => 111,
			'Expression' => 164,
			'HashReference' => 56,
			'Operator' => 55,
			'ArrayDereferenced' => 74
		}
	},
	{#State 86
		ACTIONS => {
			'WORD' => 165
		},
		GOTOS => {
			'LoopLabel' => 166
		}
	},
	{#State 87
		ACTIONS => {
			'COLON' => -219,
			"(" => -213
		}
	},
	{#State 88
		DEFAULT => -149
	},
	{#State 89
		DEFAULT => -33
	},
	{#State 90
		ACTIONS => {
			'WORD' => 167
		},
		GOTOS => {
			'PLUS-12' => 168
		}
	},
	{#State 91
		ACTIONS => {
			"use" => 28
		},
		GOTOS => {
			'Include' => 169
		}
	},
	{#State 92
		DEFAULT => -25
	},
	{#State 93
		DEFAULT => -22
	},
	{#State 94
		ACTIONS => {
			"1;" => 171,
			"our" => 62
		},
		GOTOS => {
			'Subroutine' => 170
		}
	},
	{#State 95
		ACTIONS => {
			"my" => 161
		},
		GOTOS => {
			'TypeInner' => 172
		}
	},
	{#State 96
		DEFAULT => -209,
		GOTOS => {
			'STAR-62' => 173
		}
	},
	{#State 97
		DEFAULT => -204
	},
	{#State 98
		ACTIONS => {
			'OP20_HASH_FATARROW' => 174
		}
	},
	{#State 99
		DEFAULT => -150
	},
	{#State 100
		ACTIONS => {
			'OP21_LIST_COMMA' => -181,
			'OP19_VARIABLE_ASSIGN_BY' => -181,
			'OP02_ARRAY_THINARROW' => 176,
			".." => -181,
			'OP16_LOGICAL_OR' => -181,
			'OP08_MATH_ADD_SUB' => -181,
			"}" => -181,
			'OP02_HASH_THINARROW' => 177,
			'OP03_MATH_INC_DEC' => -181,
			")" => -181,
			'COLON' => -181,
			'OP06_REGEX_MATCH' => -181,
			'OP17_LIST_RANGE' => -181,
			'OP18_TERNARY' => -181,
			'OP09_BITWISE_SHIFT' => -181,
			'OP13_BITWISE_AND' => -181,
			"]" => -181,
			'OP12_COMPARE_EQ_NEQ' => -181,
			'OP19_VARIABLE_ASSIGN' => -181,
			";" => -181,
			'OP08_STRING_CAT' => -181,
			'OP11_COMPARE_LT_GT' => -181,
			'OP04_MATH_POW' => -181,
			'OP24_LOGICAL_OR_XOR' => -181,
			'OP15_LOGICAL_AND' => -181,
			'OP14_BITWISE_OR_XOR' => -181,
			'OP23_LOGICAL_AND' => -181,
			'OP02_METHOD_THINARROW' => -181,
			'OP07_MATH_MULT_DIV_MOD' => -181
		},
		GOTOS => {
			'VariableRetrieval' => 175
		}
	},
	{#State 101
		ACTIONS => {
			'WORD' => 131
		},
		GOTOS => {
			'Type' => 178
		}
	},
	{#State 102
		DEFAULT => -172
	},
	{#State 103
		ACTIONS => {
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			"undef" => 64,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"[" => 77,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 49,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 63,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111,
			'Expression' => 179,
			'HashReference' => 56,
			'Operator' => 55,
			'ArrayDereferenced' => 74
		}
	},
	{#State 104
		ACTIONS => {
			'VARIABLE_SYMBOL' => 180
		}
	},
	{#State 105
		DEFAULT => -170
	},
	{#State 106
		DEFAULT => -159
	},
	{#State 107
		DEFAULT => -171
	},
	{#State 108
		DEFAULT => -103
	},
	{#State 109
		DEFAULT => -126
	},
	{#State 110
		ACTIONS => {
			'KEYS_OR_VALUES' => 118,
			"undef" => 64,
			"my" => 161,
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			")" => -129,
			'LITERAL_NUMBER' => 75,
			"%{" => 54
		},
		GOTOS => {
			'ListElement' => 115,
			'ArrayReference' => 63,
			'Literal' => 81,
			'OPTIONAL-44' => 181,
			'TypeInner' => 116,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'HashReference' => 56,
			'ListElements' => 182,
			'Expression' => 112,
			'Variable' => 111,
			'WordScoped' => 60,
			'HashDereferenced' => 88
		}
	},
	{#State 111
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			";" => -145,
			'OP08_STRING_CAT' => -145,
			'OP04_MATH_POW' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP02_METHOD_THINARROW' => 128,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			"}" => -145,
			")" => -145,
			'OP03_MATH_INC_DEC' => 127,
			'OP16_LOGICAL_OR' => -145,
			".." => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP21_LIST_COMMA' => -145,
			"]" => -145,
			'OP13_BITWISE_AND' => -145,
			'OP18_TERNARY' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP06_REGEX_MATCH' => -145
		}
	},
	{#State 112
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 145,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			";" => -193,
			'OP08_STRING_CAT' => 136,
			'OP12_COMPARE_EQ_NEQ' => 143,
			"]" => -193,
			'OP13_BITWISE_AND' => 138,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 148,
			'OP17_LIST_RANGE' => 139,
			'OP06_REGEX_MATCH' => 149,
			")" => -193,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => 146,
			'OP21_LIST_COMMA' => -193
		}
	},
	{#State 113
		ACTIONS => {
			'WORD' => 183
		}
	},
	{#State 114
		ACTIONS => {
			"filehandle_ref" => 185,
			'WORD' => 131
		},
		GOTOS => {
			'Type' => 184
		}
	},
	{#State 115
		DEFAULT => -191,
		GOTOS => {
			'STAR-58' => 186
		}
	},
	{#State 116
		ACTIONS => {
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			"undef" => 64,
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'HashReference' => 56,
			'Expression' => 187,
			'Variable' => 111,
			'WordScoped' => 60,
			'HashDereferenced' => 88
		}
	},
	{#State 117
		ACTIONS => {
			")" => 188
		}
	},
	{#State 118
		ACTIONS => {
			"%{" => 54
		},
		GOTOS => {
			'HashDereferenced' => 189
		}
	},
	{#State 119
		DEFAULT => -155
	},
	{#State 120
		ACTIONS => {
			'WORD' => 98,
			"%{" => 54
		},
		GOTOS => {
			'HashDereferenced' => 97,
			'HashEntry' => 96
		}
	},
	{#State 121
		ACTIONS => {
			"}" => 190
		}
	},
	{#State 122
		ACTIONS => {
			"}" => 191
		}
	},
	{#State 123
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 148,
			'OP13_BITWISE_AND' => 138,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => 146,
			")" => 192,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP08_STRING_CAT' => 136
		}
	},
	{#State 124
		ACTIONS => {
			"undef" => 64,
			'KEYS_OR_VALUES' => 118,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"[" => 77,
			"my" => 161,
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			")" => -101,
			'OP03_MATH_INC_DEC' => 49
		},
		GOTOS => {
			'ArrayReference' => 63,
			'OPTIONAL-42' => 193,
			'ListElement' => 115,
			'Literal' => 81,
			'ListElements' => 194,
			'Expression' => 112,
			'HashReference' => 56,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'Variable' => 111,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'TypeInner' => 116
		}
	},
	{#State 125
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'WORD' => 10,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"[" => 77,
			"undef" => 64,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 58,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP10_NAMED_UNARY' => 72,
			"\@{" => 69,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'HashReference' => 56,
			'Expression' => 195,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'Literal' => 81,
			'ArrayReference' => 63
		}
	},
	{#State 126
		ACTIONS => {
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			"undef" => 64,
			"[" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'HashReference' => 56,
			'Expression' => 196,
			'Variable' => 111,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'ArrayDereferenced' => 74,
			'Operator' => 55
		}
	},
	{#State 127
		DEFAULT => -104
	},
	{#State 128
		ACTIONS => {
			'WORD' => 197
		}
	},
	{#State 129
		ACTIONS => {
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			")" => -140,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			"[" => 77,
			"my" => 161,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'KEYS_OR_VALUES' => 118,
			"undef" => 64,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'WORD' => 10
		},
		GOTOS => {
			'ArrayDereferenced' => 74,
			'TypeInner' => 116,
			'Operator' => 55,
			'OPTIONAL-47' => 199,
			'Expression' => 112,
			'ListElements' => 198,
			'HashReference' => 56,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111,
			'ArrayReference' => 63,
			'ListElement' => 115,
			'Literal' => 81
		}
	},
	{#State 130
		ACTIONS => {
			'VARIABLE_SYMBOL' => 200
		}
	},
	{#State 131
		DEFAULT => -218
	},
	{#State 132
		ACTIONS => {
			'VARIABLE_SYMBOL' => 201
		}
	},
	{#State 133
		ACTIONS => {
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"undef" => 64,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'WORD' => 10
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'Expression' => 202,
			'HashReference' => 56,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111
		}
	},
	{#State 134
		ACTIONS => {
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			"undef" => 64,
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'Expression' => 203,
			'HashReference' => 56,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'Variable' => 111,
			'ArrayDereferenced' => 74,
			'Operator' => 55
		}
	},
	{#State 135
		ACTIONS => {
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			"undef" => 64,
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'HashReference' => 56,
			'Expression' => 204,
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'ArrayDereferenced' => 74,
			'Operator' => 55
		}
	},
	{#State 136
		ACTIONS => {
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 49,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			"undef" => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"[" => 77
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 63,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'Variable' => 111,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'HashReference' => 56,
			'Expression' => 205
		}
	},
	{#State 137
		ACTIONS => {
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"undef" => 64,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'WORD' => 10,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58
		},
		GOTOS => {
			'HashReference' => 56,
			'Expression' => 206,
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'ArrayReference' => 63,
			'Literal' => 81
		}
	},
	{#State 138
		ACTIONS => {
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 58,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP10_NAMED_UNARY' => 72,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 10,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"[" => 77,
			"undef" => 64
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'Expression' => 207,
			'HashReference' => 56,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111
		}
	},
	{#State 139
		ACTIONS => {
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			"[" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"undef" => 64,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 10
		},
		GOTOS => {
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'HashReference' => 56,
			'Expression' => 208,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'Literal' => 81,
			'ArrayReference' => 63
		}
	},
	{#State 140
		ACTIONS => {
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			"undef" => 64,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"[" => 77,
			'OP01_NAMED' => 58,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 63,
			'Variable' => 111,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'HashReference' => 56,
			'Expression' => 209,
			'Operator' => 55,
			'ArrayDereferenced' => 74
		}
	},
	{#State 141
		ACTIONS => {
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			"[" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"undef" => 64,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 10
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 63,
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'HashReference' => 56,
			'Expression' => 210,
			'Operator' => 55,
			'ArrayDereferenced' => 74
		}
	},
	{#State 142
		DEFAULT => -98
	},
	{#State 143
		ACTIONS => {
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			"undef" => 64,
			"[" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47
		},
		GOTOS => {
			'Expression' => 211,
			'HashReference' => 56,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'ArrayReference' => 63,
			'Literal' => 81
		}
	},
	{#State 144
		ACTIONS => {
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 10,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"[" => 77,
			"undef" => 64
		},
		GOTOS => {
			'Expression' => 212,
			'HashReference' => 56,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'Variable' => 111,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'ArrayReference' => 63,
			'Literal' => 81
		}
	},
	{#State 145
		ACTIONS => {
			"[" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"undef" => 64,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 10,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58
		},
		GOTOS => {
			'Expression' => 213,
			'HashReference' => 56,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'Variable' => 111,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'ArrayReference' => 63,
			'Literal' => 81
		}
	},
	{#State 146
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 10,
			"[" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"undef" => 64
		},
		GOTOS => {
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'HashReference' => 56,
			'Expression' => 214,
			'Literal' => 81,
			'ArrayReference' => 63
		}
	},
	{#State 147
		ACTIONS => {
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			"undef" => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"[" => 77,
			'OP01_NAMED' => 58,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'Expression' => 215,
			'HashReference' => 56,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111
		}
	},
	{#State 148
		ACTIONS => {
			'VARIABLE_SYMBOL' => 47
		},
		GOTOS => {
			'Variable' => 216
		}
	},
	{#State 149
		ACTIONS => {
			"/" => 217
		}
	},
	{#State 150
		ACTIONS => {
			"}" => 218
		}
	},
	{#State 151
		ACTIONS => {
			"}" => 219
		}
	},
	{#State 152
		DEFAULT => -130
	},
	{#State 153
		ACTIONS => {
			"undef" => 64,
			'KEYS_OR_VALUES' => 118,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"[" => 77,
			"my" => 161,
			";" => -133,
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 49
		},
		GOTOS => {
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'Variable' => 111,
			'ListElements' => 221,
			'Expression' => 112,
			'HashReference' => 56,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'TypeInner' => 116,
			'OPTIONAL-46' => 220,
			'Literal' => 81,
			'ArrayReference' => 63,
			'ListElement' => 115
		}
	},
	{#State 154
		ACTIONS => {
			";" => 222
		}
	},
	{#State 155
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP08_STRING_CAT' => 136,
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP16_LOGICAL_OR' => 146,
			'OP08_MATH_ADD_SUB' => 137,
			")" => 223,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147,
			'OP13_BITWISE_AND' => 138
		}
	},
	{#State 156
		ACTIONS => {
			'OP13_BITWISE_AND' => -113,
			"]" => -113,
			'OP18_TERNARY' => -113,
			'OP09_BITWISE_SHIFT' => 147,
			'OP17_LIST_RANGE' => -113,
			'OP06_REGEX_MATCH' => 149,
			"}" => -113,
			")" => -113,
			'OP16_LOGICAL_OR' => -113,
			".." => -113,
			'OP08_MATH_ADD_SUB' => 137,
			'OP21_LIST_COMMA' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP15_LOGICAL_AND' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			";" => -113,
			'OP08_STRING_CAT' => 136,
			'OP11_COMPARE_LT_GT' => -113,
			'OP04_MATH_POW' => 135,
			'OP12_COMPARE_EQ_NEQ' => -113
		}
	},
	{#State 157
		DEFAULT => -13
	},
	{#State 158
		ACTIONS => {
			'OP08_STRING_CAT' => 136,
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			")" => 224,
			'OP16_LOGICAL_OR' => 146,
			'OP08_MATH_ADD_SUB' => 137,
			'OP17_LIST_RANGE' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP13_BITWISE_AND' => 138,
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147
		}
	},
	{#State 159
		DEFAULT => -196
	},
	{#State 160
		ACTIONS => {
			"]" => 225
		}
	},
	{#State 161
		ACTIONS => {
			'WORD' => 131
		},
		GOTOS => {
			'Type' => 184
		}
	},
	{#State 162
		ACTIONS => {
			".." => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP08_MATH_ADD_SUB' => 137,
			"}" => -114,
			")" => -114,
			'OP21_LIST_COMMA' => -114,
			'OP18_TERNARY' => -114,
			'OP09_BITWISE_SHIFT' => 147,
			"]" => -114,
			'OP13_BITWISE_AND' => -114,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP12_COMPARE_EQ_NEQ' => -114,
			";" => -114,
			'OP08_STRING_CAT' => 136,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 144
		}
	},
	{#State 163
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP08_STRING_CAT' => 136,
			";" => -123,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP23_LOGICAL_AND' => -123,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			"}" => -123,
			")" => -123,
			'OP16_LOGICAL_OR' => 146,
			".." => -123,
			'OP08_MATH_ADD_SUB' => 137,
			'OP21_LIST_COMMA' => -123,
			'OP13_BITWISE_AND' => 138,
			"]" => -123,
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147,
			'OP17_LIST_RANGE' => 139,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 164
		ACTIONS => {
			'OP13_BITWISE_AND' => -106,
			"]" => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP18_TERNARY' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP06_REGEX_MATCH' => -106,
			")" => -106,
			"}" => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP16_LOGICAL_OR' => -106,
			".." => -106,
			'OP21_LIST_COMMA' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP04_MATH_POW' => 135,
			'OP08_STRING_CAT' => -106,
			";" => -106,
			'OP12_COMPARE_EQ_NEQ' => -106
		}
	},
	{#State 165
		DEFAULT => -219
	},
	{#State 166
		ACTIONS => {
			";" => 226
		}
	},
	{#State 167
		DEFAULT => -32
	},
	{#State 168
		ACTIONS => {
			")" => 227,
			'WORD' => 228
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
		ACTIONS => {
			"{" => 234,
			"[" => 232,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 78
		},
		GOTOS => {
			'ConstantValue' => 233,
			'Literal' => 231
		}
	},
	{#State 173
		ACTIONS => {
			"}" => 236,
			'OP21_LIST_COMMA' => 235
		},
		GOTOS => {
			'PAREN-61' => 237
		}
	},
	{#State 174
		ACTIONS => {
			'OP10_NAMED_UNARY' => -202,
			"\@{" => -202,
			'WORD_SCOPED' => -202,
			'VARIABLE_SYMBOL' => -202,
			"{" => -202,
			'OP01_NAMED' => -202,
			'OP05_MATH_NEG' => -202,
			"(" => -202,
			'LITERAL_NUMBER' => -202,
			"%{" => -202,
			'OP03_MATH_INC_DEC' => -202,
			"undef" => -202,
			'OP10_NAMED_UNARY_STRINGIFY' => -202,
			'LITERAL_STRING' => -202,
			"[" => -202,
			"my" => 161,
			'WORD' => -202,
			'OP05_LOGICAL_NEG' => -202,
			'OP22_LOGICAL_NOT' => -202
		},
		GOTOS => {
			'TypeInner' => 238,
			'OPTIONAL-60' => 239
		}
	},
	{#State 175
		DEFAULT => -179
	},
	{#State 176
		ACTIONS => {
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"undef" => 64,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'WORD' => 10
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'Expression' => 240,
			'HashReference' => 56,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111
		}
	},
	{#State 177
		ACTIONS => {
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			"[" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"undef" => 64,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 241
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 63,
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'HashReference' => 56,
			'Expression' => 242,
			'Operator' => 55,
			'ArrayDereferenced' => 74
		}
	},
	{#State 178
		ACTIONS => {
			'VARIABLE_SYMBOL' => 243
		}
	},
	{#State 179
		ACTIONS => {
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP08_STRING_CAT' => 136,
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP17_LIST_RANGE' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP13_BITWISE_AND' => 138,
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147,
			")" => 244,
			'OP16_LOGICAL_OR' => 146,
			'OP08_MATH_ADD_SUB' => 137
		}
	},
	{#State 180
		ACTIONS => {
			"(" => 245
		}
	},
	{#State 181
		ACTIONS => {
			")" => 246
		}
	},
	{#State 182
		DEFAULT => -128
	},
	{#State 183
		ACTIONS => {
			"}" => 247
		}
	},
	{#State 184
		ACTIONS => {
			"\$TYPED_" => 248
		}
	},
	{#State 185
		ACTIONS => {
			'VARIABLE_SYMBOL' => 249
		}
	},
	{#State 186
		ACTIONS => {
			'OP21_LIST_COMMA' => 250,
			";" => -192,
			"]" => -192,
			")" => -192
		},
		GOTOS => {
			'PAREN-57' => 251
		}
	},
	{#State 187
		ACTIONS => {
			")" => -194,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => 146,
			'OP21_LIST_COMMA' => -194,
			"]" => -194,
			'OP13_BITWISE_AND' => 138,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 148,
			'OP17_LIST_RANGE' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			";" => -194,
			'OP08_STRING_CAT' => 136,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 145
		}
	},
	{#State 188
		ACTIONS => {
			";" => 252
		}
	},
	{#State 189
		DEFAULT => -195
	},
	{#State 190
		DEFAULT => -212
	},
	{#State 191
		DEFAULT => -211
	},
	{#State 192
		DEFAULT => -154
	},
	{#State 193
		ACTIONS => {
			")" => 253
		}
	},
	{#State 194
		DEFAULT => -100
	},
	{#State 195
		ACTIONS => {
			'OP13_BITWISE_AND' => 138,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 148,
			'OP17_LIST_RANGE' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 145,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP08_STRING_CAT' => 136,
			";" => 254,
			'OP12_COMPARE_EQ_NEQ' => 143
		}
	},
	{#State 196
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 145,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			";" => 255,
			'OP08_STRING_CAT' => 136,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP13_BITWISE_AND' => 138,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 148,
			'OP17_LIST_RANGE' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => 146
		}
	},
	{#State 197
		ACTIONS => {
			"(" => 256
		}
	},
	{#State 198
		DEFAULT => -139
	},
	{#State 199
		ACTIONS => {
			")" => 257
		}
	},
	{#State 200
		ACTIONS => {
			";" => 258,
			'OP19_VARIABLE_ASSIGN' => 259
		}
	},
	{#State 201
		ACTIONS => {
			"= sub {" => 260
		}
	},
	{#State 202
		ACTIONS => {
			"]" => -118,
			'OP13_BITWISE_AND' => 138,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => -118,
			'OP17_LIST_RANGE' => -118,
			'OP06_REGEX_MATCH' => 149,
			")" => -118,
			"}" => -118,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => -118,
			".." => -118,
			'OP21_LIST_COMMA' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135,
			";" => -118,
			'OP08_STRING_CAT' => 136,
			'OP12_COMPARE_EQ_NEQ' => 143
		}
	},
	{#State 203
		ACTIONS => {
			'OP15_LOGICAL_AND' => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP11_COMPARE_LT_GT' => undef,
			'OP04_MATH_POW' => 135,
			'OP08_STRING_CAT' => 136,
			";" => -115,
			'OP12_COMPARE_EQ_NEQ' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => -115,
			")" => -115,
			"}" => -115,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => -115,
			".." => -115,
			'OP21_LIST_COMMA' => -115,
			'OP13_BITWISE_AND' => -115,
			"]" => -115,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => -115,
			'OP17_LIST_RANGE' => -115,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 204
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP04_MATH_POW' => 135,
			";" => -105,
			'OP08_STRING_CAT' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			"]" => -105,
			'OP13_BITWISE_AND' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP18_TERNARY' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP06_REGEX_MATCH' => -105,
			")" => -105,
			"}" => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP16_LOGICAL_OR' => -105,
			".." => -105,
			'OP21_LIST_COMMA' => -105
		}
	},
	{#State 205
		ACTIONS => {
			"}" => -111,
			")" => -111,
			'OP16_LOGICAL_OR' => -111,
			".." => -111,
			'OP08_MATH_ADD_SUB' => 137,
			'OP21_LIST_COMMA' => -111,
			'OP13_BITWISE_AND' => -111,
			"]" => -111,
			'OP18_TERNARY' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP06_REGEX_MATCH' => 149,
			'OP15_LOGICAL_AND' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			";" => -111,
			'OP08_STRING_CAT' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP04_MATH_POW' => 135,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 144
		}
	},
	{#State 206
		ACTIONS => {
			'OP17_LIST_RANGE' => -110,
			'OP06_REGEX_MATCH' => 149,
			"]" => -110,
			'OP13_BITWISE_AND' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP18_TERNARY' => -110,
			'OP21_LIST_COMMA' => -110,
			")" => -110,
			"}" => -110,
			'OP08_MATH_ADD_SUB' => -110,
			'OP16_LOGICAL_OR' => -110,
			".." => -110,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP04_MATH_POW' => 135,
			'OP08_STRING_CAT' => -110,
			";" => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP24_LOGICAL_OR_XOR' => -110
		}
	},
	{#State 207
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135,
			'OP08_STRING_CAT' => 136,
			";" => -117,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => -117,
			'OP21_LIST_COMMA' => -117,
			")" => -117,
			"}" => -117,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => -117,
			".." => -117,
			'OP17_LIST_RANGE' => -117,
			'OP06_REGEX_MATCH' => 149,
			"]" => -117,
			'OP13_BITWISE_AND' => -117,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => -117
		}
	},
	{#State 208
		ACTIONS => {
			")" => -121,
			"}" => -121,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => 146,
			".." => -121,
			'OP21_LIST_COMMA' => -121,
			"]" => -121,
			'OP13_BITWISE_AND' => 138,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => -121,
			'OP17_LIST_RANGE' => undef,
			'OP06_REGEX_MATCH' => 149,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			";" => -121,
			'OP08_STRING_CAT' => 136,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => -121
		}
	},
	{#State 209
		ACTIONS => {
			'OP21_LIST_COMMA' => -119,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -119,
			'OP16_LOGICAL_OR' => -119,
			")" => -119,
			"}" => -119,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => -119,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => -119,
			"]" => -119,
			'OP13_BITWISE_AND' => 138,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP08_STRING_CAT' => 136,
			";" => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => -119
		}
	},
	{#State 210
		ACTIONS => {
			'OP13_BITWISE_AND' => 138,
			"]" => -125,
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147,
			'OP17_LIST_RANGE' => 139,
			'OP06_REGEX_MATCH' => 149,
			"}" => -125,
			")" => -125,
			'OP16_LOGICAL_OR' => 146,
			".." => -125,
			'OP08_MATH_ADD_SUB' => 137,
			'OP21_LIST_COMMA' => -125,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP08_STRING_CAT' => 136,
			";" => -125,
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135,
			'OP12_COMPARE_EQ_NEQ' => 143
		}
	},
	{#State 211
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => -116,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP08_STRING_CAT' => 136,
			";" => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => -116,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => -116,
			"]" => -116,
			'OP13_BITWISE_AND' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -116,
			'OP16_LOGICAL_OR' => -116,
			")" => -116,
			"}" => -116
		}
	},
	{#State 212
		ACTIONS => {
			")" => -109,
			"}" => -109,
			'OP08_MATH_ADD_SUB' => -109,
			'OP16_LOGICAL_OR' => -109,
			".." => -109,
			'OP21_LIST_COMMA' => -109,
			"]" => -109,
			'OP13_BITWISE_AND' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP18_TERNARY' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP06_REGEX_MATCH' => 149,
			'OP15_LOGICAL_AND' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			'OP04_MATH_POW' => 135,
			'OP08_STRING_CAT' => -109,
			";" => -109,
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP23_LOGICAL_AND' => -109
		}
	},
	{#State 213
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			";" => -124,
			'OP08_STRING_CAT' => 136,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 148,
			'OP13_BITWISE_AND' => 138,
			"]" => -124,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -124,
			'OP16_LOGICAL_OR' => 146,
			")" => -124,
			"}" => -124,
			'OP21_LIST_COMMA' => -124
		}
	},
	{#State 214
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP08_STRING_CAT' => 136,
			";" => -120,
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP23_LOGICAL_AND' => -120,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			"}" => -120,
			")" => -120,
			'OP16_LOGICAL_OR' => -120,
			".." => -120,
			'OP08_MATH_ADD_SUB' => 137,
			'OP21_LIST_COMMA' => -120,
			"]" => -120,
			'OP13_BITWISE_AND' => 138,
			'OP18_TERNARY' => -120,
			'OP09_BITWISE_SHIFT' => 147,
			'OP17_LIST_RANGE' => -120,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 215
		ACTIONS => {
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP18_TERNARY' => -112,
			"]" => -112,
			'OP13_BITWISE_AND' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP08_MATH_ADD_SUB' => 137,
			".." => -112,
			'OP16_LOGICAL_OR' => -112,
			")" => -112,
			"}" => -112,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => -112,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => -112,
			";" => -112,
			'OP08_STRING_CAT' => 136,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP14_BITWISE_OR_XOR' => -112
		}
	},
	{#State 216
		ACTIONS => {
			'COLON' => 261
		}
	},
	{#State 217
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 262
		}
	},
	{#State 218
		DEFAULT => -200
	},
	{#State 219
		DEFAULT => -199
	},
	{#State 220
		ACTIONS => {
			";" => 263
		}
	},
	{#State 221
		DEFAULT => -132
	},
	{#State 222
		DEFAULT => -136
	},
	{#State 223
		ACTIONS => {
			"{" => 265
		},
		GOTOS => {
			'CodeBlock' => 264
		}
	},
	{#State 224
		DEFAULT => -107
	},
	{#State 225
		DEFAULT => -198
	},
	{#State 226
		DEFAULT => -138
	},
	{#State 227
		ACTIONS => {
			";" => 266
		}
	},
	{#State 228
		DEFAULT => -31
	},
	{#State 229
		ACTIONS => {
			"our %properties = (" => -71,
			"use constant" => -71,
			"use" => -71,
			"## no critic qw(" => 23
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
		DEFAULT => -50
	},
	{#State 232
		ACTIONS => {
			'LITERAL_STRING' => -37,
			'LITERAL_NUMBER' => -37,
			"my" => 161
		},
		GOTOS => {
			'TypeInner' => 270,
			'OPTIONAL-13' => 269
		}
	},
	{#State 233
		ACTIONS => {
			";" => 271
		}
	},
	{#State 234
		ACTIONS => {
			'WORD' => 272
		}
	},
	{#State 235
		ACTIONS => {
			'WORD' => 98,
			"%{" => 54
		},
		GOTOS => {
			'HashDereferenced' => 97,
			'HashEntry' => 273
		}
	},
	{#State 236
		DEFAULT => -210
	},
	{#State 237
		DEFAULT => -208
	},
	{#State 238
		DEFAULT => -201
	},
	{#State 239
		ACTIONS => {
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"undef" => 64,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'WORD' => 10,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58
		},
		GOTOS => {
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'HashReference' => 56,
			'Expression' => 274,
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'ArrayReference' => 63,
			'Literal' => 81
		}
	},
	{#State 240
		ACTIONS => {
			'OP16_LOGICAL_OR' => 146,
			'OP08_MATH_ADD_SUB' => 137,
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147,
			"]" => 275,
			'OP13_BITWISE_AND' => 138,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP08_STRING_CAT' => 136,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 144
		}
	},
	{#State 241
		ACTIONS => {
			"}" => 276,
			"(" => -213
		}
	},
	{#State 242
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 145,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP08_STRING_CAT' => 136,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP17_LIST_RANGE' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP13_BITWISE_AND' => 138,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 148,
			"}" => 277,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => 146
		}
	},
	{#State 243
		ACTIONS => {
			"(" => 278
		}
	},
	{#State 244
		ACTIONS => {
			"{" => 265
		},
		GOTOS => {
			'CodeBlock' => 279
		}
	},
	{#State 245
		ACTIONS => {
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 10,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"[" => 77,
			"undef" => 64
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 63,
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'HashReference' => 56,
			'Expression' => 280,
			'ArrayDereferenced' => 74,
			'Operator' => 55
		}
	},
	{#State 246
		ACTIONS => {
			";" => 281
		}
	},
	{#State 247
		DEFAULT => -215
	},
	{#State 248
		ACTIONS => {
			'WORD' => 282
		}
	},
	{#State 249
		DEFAULT => -216
	},
	{#State 250
		ACTIONS => {
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'KEYS_OR_VALUES' => 118,
			"undef" => 64,
			"my" => 161,
			"[" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84
		},
		GOTOS => {
			'ArrayReference' => 63,
			'ListElement' => 283,
			'Literal' => 81,
			'TypeInner' => 116,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'Expression' => 112,
			'HashReference' => 56,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111
		}
	},
	{#State 251
		DEFAULT => -190
	},
	{#State 252
		DEFAULT => -134
	},
	{#State 253
		DEFAULT => -102
	},
	{#State 254
		DEFAULT => -187
	},
	{#State 255
		DEFAULT => -188
	},
	{#State 256
		ACTIONS => {
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'KEYS_OR_VALUES' => 118,
			"undef" => 64,
			"[" => 77,
			"my" => 161,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			")" => -142,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47
		},
		GOTOS => {
			'ArrayDereferenced' => 74,
			'OPTIONAL-48' => 285,
			'Operator' => 55,
			'TypeInner' => 116,
			'Variable' => 111,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'HashReference' => 56,
			'ListElements' => 284,
			'Expression' => 112,
			'Literal' => 81,
			'ListElement' => 115,
			'ArrayReference' => 63
		}
	},
	{#State 257
		DEFAULT => -152
	},
	{#State 258
		DEFAULT => -185
	},
	{#State 259
		ACTIONS => {
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			"undef" => 64,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"[" => 77,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP03_MATH_INC_DEC' => 49,
			'OP10_NAMED_UNARY' => 72,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46
		},
		GOTOS => {
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111,
			'Expression' => 286,
			'HashReference' => 56,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'Literal' => 81,
			'ArrayReference' => 63
		}
	},
	{#State 260
		ACTIONS => {
			'OP01_NAMED_VOID' => -54,
			"while (" => -54,
			"if (" => -54,
			'OP10_NAMED_UNARY' => -54,
			'WORD_SCOPED' => -54,
			"\@{" => -54,
			'VARIABLE_SYMBOL' => -54,
			"{" => -54,
			'OP01_NAMED' => -54,
			"(" => -54,
			'OP05_MATH_NEG' => -54,
			"%{" => -54,
			'LITERAL_NUMBER' => -54,
			'OP01_NAMED_VOID_PAREN' => -54,
			'OP03_MATH_INC_DEC' => -54,
			"undef" => -54,
			"for my integer" => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			'LITERAL_STRING' => -54,
			"( my" => 289,
			"[" => -54,
			"my" => -54,
			"foreach my" => -54,
			'WORD' => -54,
			'OP19_LOOP_CONTROL' => -54,
			'OP05_LOGICAL_NEG' => -54,
			'OP22_LOGICAL_NOT' => -54
		},
		GOTOS => {
			'OPTIONAL-21' => 288,
			'SubroutineArguments' => 287
		}
	},
	{#State 261
		ACTIONS => {
			'VARIABLE_SYMBOL' => 47
		},
		GOTOS => {
			'Variable' => 290
		}
	},
	{#State 262
		ACTIONS => {
			"/" => 291
		}
	},
	{#State 263
		DEFAULT => -137
	},
	{#State 264
		DEFAULT => -165,
		GOTOS => {
			'STAR-52' => 292
		}
	},
	{#State 265
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED_VOID_PAREN' => 51,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			"while (" => -157,
			"if (" => 71,
			'OP10_NAMED_UNARY' => 72,
			'OP01_NAMED_VOID' => 70,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'OP19_LOOP_CONTROL' => 86,
			'WORD' => 87,
			"[" => 77,
			"foreach my" => -157,
			"my" => 61,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"undef" => 64,
			"for my integer" => -157
		},
		GOTOS => {
			'OPTIONAL-50' => 48,
			'ArrayDereferenced' => 74,
			'Conditional' => 53,
			'Operator' => 55,
			'LoopLabel' => 52,
			'HashReference' => 56,
			'WordScoped' => 60,
			'Variable' => 59,
			'ArrayReference' => 63,
			'PLUS-55' => 294,
			'VariableModification' => 82,
			'Operation' => 293,
			'OperatorVoid' => 80,
			'Literal' => 81,
			'PAREN-49' => 65,
			'Expression' => 68,
			'Statement' => 66,
			'VariableDeclaration' => 67,
			'HashDereferenced' => 88
		}
	},
	{#State 266
		DEFAULT => -34
	},
	{#State 267
		ACTIONS => {
			"use" => 28,
			"our %properties = (" => -73,
			"use constant" => -73
		},
		GOTOS => {
			'STAR-30' => 295,
			'Include' => 296
		}
	},
	{#State 268
		DEFAULT => -68
	},
	{#State 269
		ACTIONS => {
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 75
		},
		GOTOS => {
			'Literal' => 297
		}
	},
	{#State 270
		DEFAULT => -36
	},
	{#State 271
		DEFAULT => -35
	},
	{#State 272
		ACTIONS => {
			'OP20_HASH_FATARROW' => 298
		}
	},
	{#State 273
		DEFAULT => -207
	},
	{#State 274
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP08_STRING_CAT' => 136,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP16_LOGICAL_OR' => 146,
			'OP08_MATH_ADD_SUB' => 137,
			"}" => -203,
			'OP21_LIST_COMMA' => -203,
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147,
			'OP13_BITWISE_AND' => 138,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139
		}
	},
	{#State 275
		DEFAULT => -182
	},
	{#State 276
		DEFAULT => -184
	},
	{#State 277
		DEFAULT => -183
	},
	{#State 278
		ACTIONS => {
			"[" => 77,
			"my" => 161,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'KEYS_OR_VALUES' => 118,
			"undef" => 64,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'WORD' => 10,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP10_NAMED_UNARY' => 72,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58
		},
		GOTOS => {
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'HashReference' => 56,
			'Expression' => 112,
			'ListElements' => 299,
			'TypeInner' => 116,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'Literal' => 81,
			'ListElement' => 115,
			'ArrayReference' => 63
		}
	},
	{#State 279
		DEFAULT => -175
	},
	{#State 280
		ACTIONS => {
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147,
			'OP13_BITWISE_AND' => 138,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139,
			".." => 300,
			'OP16_LOGICAL_OR' => 146,
			'OP08_MATH_ADD_SUB' => 137,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP08_STRING_CAT' => 136,
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135
		}
	},
	{#State 281
		DEFAULT => -135
	},
	{#State 282
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 301
		}
	},
	{#State 283
		DEFAULT => -189
	},
	{#State 284
		DEFAULT => -141
	},
	{#State 285
		ACTIONS => {
			")" => 302
		}
	},
	{#State 286
		ACTIONS => {
			'OP16_LOGICAL_OR' => 146,
			'OP08_MATH_ADD_SUB' => 137,
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147,
			'OP13_BITWISE_AND' => 138,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP12_COMPARE_EQ_NEQ' => 143,
			";" => 303,
			'OP08_STRING_CAT' => 136,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 144
		}
	},
	{#State 287
		DEFAULT => -53
	},
	{#State 288
		ACTIONS => {
			"for my integer" => -157,
			"undef" => 64,
			"my" => 61,
			"foreach my" => -157,
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'WORD' => 87,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'OP19_LOOP_CONTROL' => 86,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'OP01_NAMED_VOID' => 70,
			"while (" => -157,
			'OP10_NAMED_UNARY' => 72,
			"if (" => 71,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED_VOID_PAREN' => 51,
			"%{" => 54,
			'LITERAL_NUMBER' => 75
		},
		GOTOS => {
			'OPTIONAL-50' => 48,
			'Variable' => 59,
			'WordScoped' => 60,
			'HashReference' => 56,
			'LoopLabel' => 52,
			'Conditional' => 53,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'OperatorVoid' => 80,
			'Literal' => 81,
			'Operation' => 304,
			'VariableModification' => 82,
			'ArrayReference' => 63,
			'HashDereferenced' => 88,
			'Statement' => 66,
			'VariableDeclaration' => 67,
			'Expression' => 68,
			'PAREN-49' => 65,
			'PLUS-22' => 305
		}
	},
	{#State 289
		ACTIONS => {
			'WORD' => 131
		},
		GOTOS => {
			'Type' => 306
		}
	},
	{#State 290
		DEFAULT => -122
	},
	{#State 291
		DEFAULT => -108
	},
	{#State 292
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -168,
			'LITERAL_STRING' => -168,
			"my" => -168,
			"[" => -168,
			"foreach my" => -168,
			"undef" => -168,
			"for my integer" => -168,
			'' => -168,
			'OP19_LOOP_CONTROL' => -168,
			'OP05_LOGICAL_NEG' => -168,
			'OP22_LOGICAL_NOT' => -168,
			'WORD' => -168,
			'VARIABLE_SYMBOL' => -168,
			"{" => -168,
			"else" => 308,
			'OP01_NAMED_VOID' => -168,
			"if (" => -168,
			"while (" => -168,
			'OP10_NAMED_UNARY' => -168,
			"\@{" => -168,
			'WORD_SCOPED' => -168,
			"%{" => -168,
			'LITERAL_NUMBER' => -168,
			'OP01_NAMED_VOID_PAREN' => -168,
			'OP03_MATH_INC_DEC' => -168,
			"}" => -168,
			'OP01_NAMED' => -168,
			"(" => -168,
			'OP05_MATH_NEG' => -168,
			"elsif (" => 311
		},
		GOTOS => {
			'OPTIONAL-54' => 307,
			'PAREN-51' => 310,
			'PAREN-53' => 309
		}
	},
	{#State 293
		DEFAULT => -177
	},
	{#State 294
		ACTIONS => {
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			"while (" => -157,
			"if (" => 71,
			'OP10_NAMED_UNARY' => 72,
			'OP01_NAMED_VOID' => 70,
			"}" => 313,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED_VOID_PAREN' => 51,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			"foreach my" => -157,
			"my" => 61,
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"for my integer" => -157,
			"undef" => 64,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'OP19_LOOP_CONTROL' => 86,
			'WORD' => 87
		},
		GOTOS => {
			'OPTIONAL-50' => 48,
			'LoopLabel' => 52,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'Conditional' => 53,
			'HashReference' => 56,
			'Variable' => 59,
			'WordScoped' => 60,
			'ArrayReference' => 63,
			'OperatorVoid' => 80,
			'Operation' => 312,
			'Literal' => 81,
			'VariableModification' => 82,
			'PAREN-49' => 65,
			'Statement' => 66,
			'VariableDeclaration' => 67,
			'Expression' => 68,
			'HashDereferenced' => 88
		}
	},
	{#State 295
		ACTIONS => {
			"our %properties = (" => 314,
			"use constant" => 37
		},
		GOTOS => {
			'Properties' => 315,
			'Constant' => 316
		}
	},
	{#State 296
		DEFAULT => -70
	},
	{#State 297
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 317
		}
	},
	{#State 298
		ACTIONS => {
			"my" => 161,
			'LITERAL_NUMBER' => -44,
			'LITERAL_STRING' => -44
		},
		GOTOS => {
			'TypeInner' => 318,
			'OPTIONAL-17' => 319
		}
	},
	{#State 299
		ACTIONS => {
			")" => 320
		}
	},
	{#State 300
		ACTIONS => {
			"undef" => 64,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"[" => 77,
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 63,
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'HashReference' => 56,
			'Expression' => 321,
			'Operator' => 55,
			'ArrayDereferenced' => 74
		}
	},
	{#State 301
		DEFAULT => -217
	},
	{#State 302
		DEFAULT => -153
	},
	{#State 303
		DEFAULT => -186
	},
	{#State 304
		DEFAULT => -56
	},
	{#State 305
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'OP19_LOOP_CONTROL' => 86,
			'WORD' => 87,
			"foreach my" => -157,
			"[" => 77,
			"my" => 61,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"for my integer" => -157,
			"undef" => 64,
			"}" => 323,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED_VOID_PAREN' => 51,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			"while (" => -157,
			'OP10_NAMED_UNARY' => 72,
			'OP01_NAMED_VOID' => 70,
			"if (" => 71
		},
		GOTOS => {
			'VariableModification' => 82,
			'Operation' => 322,
			'OperatorVoid' => 80,
			'Literal' => 81,
			'ArrayReference' => 63,
			'HashDereferenced' => 88,
			'Expression' => 68,
			'Statement' => 66,
			'VariableDeclaration' => 67,
			'PAREN-49' => 65,
			'OPTIONAL-50' => 48,
			'WordScoped' => 60,
			'Variable' => 59,
			'HashReference' => 56,
			'Conditional' => 53,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'LoopLabel' => 52
		}
	},
	{#State 306
		ACTIONS => {
			'VARIABLE_SYMBOL' => 324
		}
	},
	{#State 307
		DEFAULT => -169
	},
	{#State 308
		ACTIONS => {
			"{" => 265
		},
		GOTOS => {
			'CodeBlock' => 325
		}
	},
	{#State 309
		DEFAULT => -167
	},
	{#State 310
		DEFAULT => -164
	},
	{#State 311
		ACTIONS => {
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			"undef" => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"[" => 77,
			'OP01_NAMED' => 58,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49,
			'OP10_NAMED_UNARY' => 72,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46
		},
		GOTOS => {
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'WordScoped' => 60,
			'HashDereferenced' => 88,
			'Variable' => 111,
			'Expression' => 326,
			'HashReference' => 56,
			'Literal' => 81,
			'ArrayReference' => 63
		}
	},
	{#State 312
		DEFAULT => -176
	},
	{#State 313
		DEFAULT => -178
	},
	{#State 314
		ACTIONS => {
			"%{" => 54,
			")" => 327,
			'WORD' => 328
		},
		GOTOS => {
			'HashEntryTyped' => 330,
			'HashDereferenced' => 329
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
			'OP21_LIST_COMMA' => 332,
			"]" => 333
		},
		GOTOS => {
			'PAREN-15' => 334
		}
	},
	{#State 318
		DEFAULT => -43
	},
	{#State 319
		ACTIONS => {
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 75
		},
		GOTOS => {
			'Literal' => 335
		}
	},
	{#State 320
		ACTIONS => {
			"{" => 265
		},
		GOTOS => {
			'CodeBlock' => 336
		}
	},
	{#State 321
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => 146,
			")" => 337,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 148,
			'OP13_BITWISE_AND' => 138,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135,
			'OP08_STRING_CAT' => 136,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 145
		}
	},
	{#State 322
		DEFAULT => -55
	},
	{#State 323
		ACTIONS => {
			";" => 338
		}
	},
	{#State 324
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 339
		}
	},
	{#State 325
		DEFAULT => -166
	},
	{#State 326
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 145,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP08_STRING_CAT' => 136,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP17_LIST_RANGE' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP13_BITWISE_AND' => 138,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 148,
			")" => 340,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => 146
		}
	},
	{#State 327
		ACTIONS => {
			";" => 341
		}
	},
	{#State 328
		ACTIONS => {
			'OP20_HASH_FATARROW' => 342
		}
	},
	{#State 329
		DEFAULT => -206
	},
	{#State 330
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 343
		}
	},
	{#State 331
		ACTIONS => {
			"1;" => 345,
			"our" => 346
		},
		GOTOS => {
			'Method' => 344
		}
	},
	{#State 332
		ACTIONS => {
			'LITERAL_NUMBER' => -39,
			'LITERAL_STRING' => -39,
			"my" => 161
		},
		GOTOS => {
			'OPTIONAL-14' => 347,
			'TypeInner' => 348
		}
	},
	{#State 333
		DEFAULT => -51
	},
	{#State 334
		DEFAULT => -41
	},
	{#State 335
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 349
		}
	},
	{#State 336
		DEFAULT => -174
	},
	{#State 337
		ACTIONS => {
			"{" => 265
		},
		GOTOS => {
			'CodeBlock' => 350
		}
	},
	{#State 338
		DEFAULT => -57
	},
	{#State 339
		ACTIONS => {
			")" => 353,
			'OP21_LIST_COMMA' => 352
		},
		GOTOS => {
			'PAREN-23' => 351
		}
	},
	{#State 340
		ACTIONS => {
			"{" => 265
		},
		GOTOS => {
			'CodeBlock' => 354
		}
	},
	{#State 341
		DEFAULT => -86
	},
	{#State 342
		ACTIONS => {
			"my" => 161
		},
		GOTOS => {
			'TypeInner' => 355
		}
	},
	{#State 343
		ACTIONS => {
			'OP21_LIST_COMMA' => 356,
			")" => 357
		},
		GOTOS => {
			'PAREN-35' => 358
		}
	},
	{#State 344
		DEFAULT => -74
	},
	{#State 345
		ACTIONS => {
			"1;" => 359
		}
	},
	{#State 346
		ACTIONS => {
			'WORD' => 131
		},
		GOTOS => {
			'Type' => 360
		}
	},
	{#State 347
		ACTIONS => {
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 75
		},
		GOTOS => {
			'Literal' => 361
		}
	},
	{#State 348
		DEFAULT => -38
	},
	{#State 349
		ACTIONS => {
			'OP21_LIST_COMMA' => 364,
			"}" => 363
		},
		GOTOS => {
			'PAREN-19' => 362
		}
	},
	{#State 350
		DEFAULT => -173
	},
	{#State 351
		DEFAULT => -59
	},
	{#State 352
		ACTIONS => {
			"my" => 365
		}
	},
	{#State 353
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 366
		}
	},
	{#State 354
		DEFAULT => -163
	},
	{#State 355
		ACTIONS => {
			"undef" => 64,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"[" => 77,
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'OP10_NAMED_UNARY' => 72,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP01_NAMED' => 58,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49
		},
		GOTOS => {
			'ArrayReference' => 63,
			'Literal' => 81,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'HashReference' => 56,
			'Expression' => 367,
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60
		}
	},
	{#State 356
		ACTIONS => {
			'WORD' => 328,
			"%{" => 54
		},
		GOTOS => {
			'HashEntryTyped' => 368,
			'HashDereferenced' => 329
		}
	},
	{#State 357
		ACTIONS => {
			";" => 369
		}
	},
	{#State 358
		DEFAULT => -83
	},
	{#State 359
		ACTIONS => {
			'' => -80,
			"package" => -80,
			"our" => 62
		},
		GOTOS => {
			'Subroutine' => 372,
			'PAREN-33' => 371,
			'OPTIONAL-34' => 373,
			'PLUS-32' => 370
		}
	},
	{#State 360
		ACTIONS => {
			'VARIABLE_SYMBOL' => 374
		}
	},
	{#State 361
		DEFAULT => -40
	},
	{#State 362
		DEFAULT => -48
	},
	{#State 363
		DEFAULT => -52
	},
	{#State 364
		ACTIONS => {
			'WORD' => 375
		}
	},
	{#State 365
		ACTIONS => {
			'WORD' => 131
		},
		GOTOS => {
			'Type' => 376
		}
	},
	{#State 366
		ACTIONS => {
			"\@_;" => 377
		}
	},
	{#State 367
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 145,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP08_STRING_CAT' => 136,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 148,
			'OP13_BITWISE_AND' => 138,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => 146,
			")" => -205,
			'OP21_LIST_COMMA' => -205
		}
	},
	{#State 368
		DEFAULT => -82
	},
	{#State 369
		DEFAULT => -85
	},
	{#State 370
		ACTIONS => {
			"1;" => 379,
			"our" => 62
		},
		GOTOS => {
			'Subroutine' => 378
		}
	},
	{#State 371
		DEFAULT => -79
	},
	{#State 372
		DEFAULT => -77
	},
	{#State 373
		DEFAULT => -81
	},
	{#State 374
		ACTIONS => {
			"= sub {" => 380
		}
	},
	{#State 375
		ACTIONS => {
			'OP20_HASH_FATARROW' => 381
		}
	},
	{#State 376
		ACTIONS => {
			'VARIABLE_SYMBOL' => 382
		}
	},
	{#State 377
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 383
		}
	},
	{#State 378
		DEFAULT => -76
	},
	{#State 379
		ACTIONS => {
			"1;" => 384
		}
	},
	{#State 380
		ACTIONS => {
			'OP01_NAMED_VOID' => -88,
			'OP10_NAMED_UNARY' => -88,
			"if (" => -88,
			"while (" => -88,
			"\@{" => -88,
			'WORD_SCOPED' => -88,
			'VARIABLE_SYMBOL' => -88,
			"{" => -88,
			'OP01_NAMED' => -88,
			"(" => -88,
			'OP05_MATH_NEG' => -88,
			'LITERAL_NUMBER' => -88,
			"%{" => -88,
			'OP01_NAMED_VOID_PAREN' => -88,
			'OP03_MATH_INC_DEC' => -88,
			"undef" => -88,
			"for my integer" => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			'LITERAL_STRING' => -88,
			"( my" => 385,
			"[" => -88,
			"my" => -88,
			"foreach my" => -88,
			'WORD' => -88,
			'OP19_LOOP_CONTROL' => -88,
			'OP05_LOGICAL_NEG' => -88,
			'OP22_LOGICAL_NOT' => -88
		},
		GOTOS => {
			'OPTIONAL-37' => 387,
			'MethodArguments' => 386
		}
	},
	{#State 381
		ACTIONS => {
			'LITERAL_STRING' => -46,
			'LITERAL_NUMBER' => -46,
			"my" => 161
		},
		GOTOS => {
			'TypeInner' => 389,
			'OPTIONAL-18' => 388
		}
	},
	{#State 382
		DEFAULT => -58
	},
	{#State 383
		ACTIONS => {
			'WORD' => -63,
			'OP19_LOOP_CONTROL' => -63,
			'OP22_LOGICAL_NOT' => -63,
			'OP05_LOGICAL_NEG' => -63,
			"for my integer" => -63,
			"undef" => -63,
			'LITERAL_STRING' => -63,
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			"my" => -63,
			"[" => -63,
			"foreach my" => -63,
			'OP01_NAMED' => -63,
			'OP05_MATH_NEG' => -63,
			"(" => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			'LITERAL_NUMBER' => -63,
			"%{" => -63,
			'OP03_MATH_INC_DEC' => -63,
			'OP01_NAMED_VOID' => -63,
			"if (" => -63,
			"while (" => -63,
			'OP10_NAMED_UNARY' => -63,
			'WORD_SCOPED' => -63,
			"\@{" => -63,
			'VARIABLE_SYMBOL' => -63,
			'CHECK_OR_CHECKTRACE' => 391,
			"{" => -63
		},
		GOTOS => {
			'ArgumentCheck' => 390
		}
	},
	{#State 384
		DEFAULT => -78
	},
	{#State 385
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 392
		}
	},
	{#State 386
		DEFAULT => -87
	},
	{#State 387
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 86,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"[" => 77,
			"foreach my" => -157,
			"my" => 61,
			"undef" => 64,
			"for my integer" => -157,
			'LITERAL_NUMBER' => 75,
			"%{" => 54,
			'OP01_NAMED_VOID_PAREN' => 51,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 58,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP01_NAMED_VOID' => 70,
			"while (" => -157,
			'OP10_NAMED_UNARY' => 72,
			"if (" => 71,
			"\@{" => 69,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'Statement' => 66,
			'VariableDeclaration' => 67,
			'Expression' => 68,
			'HashDereferenced' => 88,
			'PAREN-49' => 65,
			'PLUS-38' => 394,
			'ArrayReference' => 63,
			'OperatorVoid' => 80,
			'Operation' => 393,
			'Literal' => 81,
			'VariableModification' => 82,
			'HashReference' => 56,
			'Variable' => 59,
			'WordScoped' => 60,
			'LoopLabel' => 52,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'Conditional' => 53,
			'OPTIONAL-50' => 48
		}
	},
	{#State 388
		ACTIONS => {
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 75
		},
		GOTOS => {
			'Literal' => 395
		}
	},
	{#State 389
		DEFAULT => -45
	},
	{#State 390
		DEFAULT => -61
	},
	{#State 391
		ACTIONS => {
			"(" => 396
		}
	},
	{#State 392
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 397
		}
	},
	{#State 393
		DEFAULT => -90
	},
	{#State 394
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => 51,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			"}" => 399,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP10_NAMED_UNARY' => 72,
			"while (" => -157,
			"if (" => 71,
			'OP01_NAMED_VOID' => 70,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP19_LOOP_CONTROL' => 86,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'WORD' => 87,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			"my" => 61,
			"foreach my" => -157,
			"[" => 77,
			"for my integer" => -157,
			"undef" => 64
		},
		GOTOS => {
			'ArrayReference' => 63,
			'VariableModification' => 82,
			'Literal' => 81,
			'OperatorVoid' => 80,
			'Operation' => 398,
			'PAREN-49' => 65,
			'Expression' => 68,
			'VariableDeclaration' => 67,
			'Statement' => 66,
			'HashDereferenced' => 88,
			'OPTIONAL-50' => 48,
			'Operator' => 55,
			'Conditional' => 53,
			'ArrayDereferenced' => 74,
			'LoopLabel' => 52,
			'HashReference' => 56,
			'WordScoped' => 60,
			'Variable' => 59
		}
	},
	{#State 395
		DEFAULT => -47
	},
	{#State 396
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			'WORD' => 10,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			"[" => 77,
			"undef" => 64,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 49,
			'OP01_NAMED' => 58,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'VARIABLE_SYMBOL' => 47,
			"{" => 46,
			'OP10_NAMED_UNARY' => 72,
			'WORD_SCOPED' => 11,
			"\@{" => 69
		},
		GOTOS => {
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111,
			'Expression' => 400,
			'HashReference' => 56,
			'Literal' => 81,
			'ArrayReference' => 63
		}
	},
	{#State 397
		ACTIONS => {
			")" => 403,
			'OP21_LIST_COMMA' => 402
		},
		GOTOS => {
			'PAREN-39' => 401
		}
	},
	{#State 398
		DEFAULT => -89
	},
	{#State 399
		ACTIONS => {
			";" => 404
		}
	},
	{#State 400
		ACTIONS => {
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147,
			'OP13_BITWISE_AND' => 138,
			'OP21_LIST_COMMA' => 406,
			'OP16_LOGICAL_OR' => 146,
			'OP08_MATH_ADD_SUB' => 137,
			")" => -66,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP08_STRING_CAT' => 136,
			'OP04_MATH_POW' => 135,
			'OP11_COMPARE_LT_GT' => 134,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140
		},
		GOTOS => {
			'PAREN-26' => 407,
			'OPTIONAL-27' => 405
		}
	},
	{#State 401
		DEFAULT => -93
	},
	{#State 402
		ACTIONS => {
			"my" => 408
		}
	},
	{#State 403
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 409
		}
	},
	{#State 404
		DEFAULT => -91
	},
	{#State 405
		ACTIONS => {
			")" => 410
		}
	},
	{#State 406
		ACTIONS => {
			'WORD' => 10,
			'OP05_LOGICAL_NEG' => 85,
			'OP22_LOGICAL_NOT' => 84,
			"undef" => 64,
			"[" => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL_STRING' => 78,
			'OP05_MATH_NEG' => 76,
			"(" => 57,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			"%{" => 54,
			'LITERAL_NUMBER' => 75,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 63,
			'Operator' => 55,
			'ArrayDereferenced' => 74,
			'Variable' => 111,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'HashReference' => 56,
			'Expression' => 411
		}
	},
	{#State 407
		DEFAULT => -65
	},
	{#State 408
		ACTIONS => {
			'WORD' => 131
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
			";" => 414
		}
	},
	{#State 411
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP08_STRING_CAT' => 136,
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP23_LOGICAL_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP21_LIST_COMMA' => 415,
			'OP16_LOGICAL_OR' => 146,
			'OP08_MATH_ADD_SUB' => 137,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 139,
			'OP18_TERNARY' => 148,
			'OP09_BITWISE_SHIFT' => 147,
			'OP13_BITWISE_AND' => 138
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
		DEFAULT => -67
	},
	{#State 415
		ACTIONS => {
			"undef" => 64,
			"[" => 77,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'WORD' => 10,
			'OP22_LOGICAL_NOT' => 84,
			'OP05_LOGICAL_NEG' => 85,
			"\@{" => 69,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY' => 72,
			"{" => 46,
			'VARIABLE_SYMBOL' => 47,
			"(" => 57,
			'OP05_MATH_NEG' => 76,
			'OP01_NAMED' => 58,
			'OP03_MATH_INC_DEC' => 49,
			'LITERAL_NUMBER' => 75,
			"%{" => 54
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 63,
			'ArrayDereferenced' => 74,
			'Operator' => 55,
			'HashDereferenced' => 88,
			'WordScoped' => 60,
			'Variable' => 111,
			'Expression' => 418,
			'HashReference' => 56
		}
	},
	{#State 416
		DEFAULT => -92
	},
	{#State 417
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -97,
			'OP22_LOGICAL_NOT' => -97,
			'OP05_LOGICAL_NEG' => -97,
			'WORD' => -97,
			'LITERAL_STRING' => -97,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			"foreach my" => -97,
			"[" => -97,
			"my" => -97,
			"for my integer" => -97,
			"undef" => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			'LITERAL_NUMBER' => -97,
			"%{" => -97,
			'OP03_MATH_INC_DEC' => -97,
			'OP01_NAMED' => -97,
			'OP05_MATH_NEG' => -97,
			"(" => -97,
			'VARIABLE_SYMBOL' => -97,
			'CHECK_OR_CHECKTRACE' => 391,
			"{" => -97,
			'OP01_NAMED_VOID' => -97,
			"while (" => -97,
			"if (" => -97,
			'OP10_NAMED_UNARY' => -97,
			"\@{" => -97,
			'WORD_SCOPED' => -97
		},
		GOTOS => {
			'ArgumentCheck' => 419
		}
	},
	{#State 418
		ACTIONS => {
			")" => -64,
			'OP08_MATH_ADD_SUB' => 137,
			'OP16_LOGICAL_OR' => 146,
			'OP13_BITWISE_AND' => 138,
			'OP09_BITWISE_SHIFT' => 147,
			'OP18_TERNARY' => 148,
			'OP17_LIST_RANGE' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 140,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP11_COMPARE_LT_GT' => 134,
			'OP04_MATH_POW' => 135,
			'OP08_STRING_CAT' => 136,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 145
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
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5573 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
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
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5609 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5616 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5623 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5630 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5637 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5644 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5651 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5658 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5665 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
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
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5712 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5719 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5726 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5733 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5740 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5747 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5754 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
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
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5790 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
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
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5815 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
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
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5862 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5869 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5876 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5883 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5904 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5911 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5918 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5925 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5932 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5939 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5946 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
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
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5993 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6000 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6007 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
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
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6032 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6039 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6046 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6053 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
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
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6078 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6085 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
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
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6110 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6117 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6124 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6131 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6138 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6145 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6152 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6159 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6166 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6173 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 3,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6180 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6187 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
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
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6212 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6219 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
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
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6255 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6262 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6269 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
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
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6294 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6301 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6315 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
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
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6362 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
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
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6640 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6647 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6654 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6661 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6668 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6675 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6682 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
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
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
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
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6911 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6918 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
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
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6987 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6994 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7001 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7008 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7015 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
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
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7106 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
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
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7131 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
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
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7233 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7240 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
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
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7298 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
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
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7345 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
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
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7403 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7410 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
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

#line 180 "lib/RPerl/Grammar.eyp"


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
