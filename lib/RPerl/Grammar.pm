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
    our $VERSION = 0.000_400;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G(\s*(\#.+)*\s*)+/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|use\ parent\ qw\(|our\ \$VERSION\ \=|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|use\ Carp\;|\$TYPED_|while\ \(|elsif\ \(|\=\ sub\ \{|package|undef|else|\(\ my|if\ \(|\@_\;|our|qw\(|use|\:\:|\%\{|\@\{|1\;|my|\{\*|\.\.|\}\;|\{|\;|\)|\/|\:|\]|\[|\(|\})}gc and return ($1, $1);

      /\G(^(\#\!\/[\w\/]*\/perl)$)/gc and return ('SHEBANG', $1);
      /\G(\d+\.\d{3}\_\d{3})/gc and return ('VERSION_NUMBER', $1);
      /\G((-?\d+(\.\d+)?)|('[^']*')|("[^"]*"))/gc and return ('LITERAL', $1);
      /\G(\$[a-zA-Z][\w:{2}]*\w*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(keys|values)/gc and return ('KEYS_OR_VALUES', $1);
      /\G(string\s+\$class|object\s+\$self)/gc and return ('TYPE_CLASS_OR_SELF', $1);
      /\G([a-zA-Z]\w*__CHECK(TRACE)*)/gc and return ('CHECK_OR_CHECKTRACE', $1);
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
      /\G(^.)/gc and return ('OP10_NAMED_UNARY', $1);
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
      /\G((print|croak|return|exit)\()/gc and return ('OP01_NAMED_VOID_PAREN', $1);
      /\G(print|croak|return|exit)/gc and return ('OP01_NAMED_VOID', $1);
      /\G(^.)/gc and return ('OP01_NAMED', $1);
      /\G([a-zA-Z]\w*)/gc and return ('WORD', $1);


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


#line 110 lib/RPerl/Grammar.pm

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
  [ '_STAR_LIST' => 'STAR-2', [ 'STAR-2', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-2', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-3', [ 'STAR-3', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-3', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [ 'STAR-4', 'Subroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-5', [ 'PLUS-5', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-5', [ 'Operation' ], 0 ],
  [ 'Program_13' => 'Program', [ 'SHEBANG', 'Header', 'STAR-2', 'STAR-3', 'STAR-4', 'PLUS-5' ], 0 ],
  [ 'Module_14' => 'Module', [ 'Package' ], 0 ],
  [ 'Module_15' => 'Module', [ 'Class' ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [ 'STAR-6', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-7', [ 'STAR-7', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-7', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-8', [ 'PLUS-8', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-8', [ 'Subroutine' ], 0 ],
  [ 'Package_22' => 'Package', [ 'package', 'WordScoped', ';', 'Header', 'STAR-6', 'STAR-7', 'PLUS-8', '1;' ], 0 ],
  [ 'Header_23' => 'Header', [ 'use strict;', 'use warnings;', 'our $VERSION =', 'VERSION_NUMBER', ';', 'use Carp;', 'use RPerl;' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-9', [ 'PLUS-9', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-9', [ 'WORD' ], 0 ],
  [ 'Include_26' => 'Include', [ 'use', 'WordScoped', ';' ], 0 ],
  [ 'Include_27' => 'Include', [ 'use', 'WordScoped', 'qw(', 'PLUS-9', ')', ';' ], 0 ],
  [ 'Constant_28' => 'Constant', [ 'use constant', 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'ConstantValue', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-10', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-10', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-11', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-11', [  ], 0 ],
  [ '_PAREN' => 'PAREN-12', [ 'OP21_LIST_COMMA', 'OPTIONAL-11', 'LITERAL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-13', [ 'STAR-13', 'PAREN-12' ], 0 ],
  [ '_STAR_LIST' => 'STAR-13', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-14', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-14', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-15', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-15', [  ], 0 ],
  [ '_PAREN' => 'PAREN-16', [ 'OP21_LIST_COMMA', 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-15', 'LITERAL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-17', [ 'STAR-17', 'PAREN-16' ], 0 ],
  [ '_STAR_LIST' => 'STAR-17', [  ], 0 ],
  [ 'ConstantValue_43' => 'ConstantValue', [ 'LITERAL' ], 0 ],
  [ 'ConstantValue_44' => 'ConstantValue', [ '[', 'OPTIONAL-10', 'LITERAL', 'STAR-13', ']' ], 0 ],
  [ 'ConstantValue_45' => 'ConstantValue', [ '{', 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-14', 'LITERAL', 'STAR-17', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-19', [ 'PLUS-19', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-19', [ 'Operation' ], 0 ],
  [ 'Subroutine_50' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-18', 'PLUS-19', '};' ], 0 ],
  [ '_PAREN' => 'PAREN-20', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [ 'STAR-21', 'PAREN-20' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [ 'STAR-22', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [  ], 0 ],
  [ 'SubroutineArguments_56' => 'SubroutineArguments', [ '( my', 'Type', 'VARIABLE_SYMBOL', 'STAR-21', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-22' ], 0 ],
  [ '_PAREN' => 'PAREN-23', [ 'OP21_LIST_COMMA', 'Expression', 'OP21_LIST_COMMA', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [ 'PAREN-23' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [  ], 0 ],
  [ 'ArgumentCheck_60' => 'ArgumentCheck', [ '::', 'CHECK_OR_CHECKTRACE', '(', 'Expression', 'OPTIONAL-24', ')', ';' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-25', [ 'PLUS-25', 'WordScoped' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-25', [ 'WordScoped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [ 'STAR-26', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'Method' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-29', [ 'PLUS-29', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-29', [ 'Subroutine' ], 0 ],
  [ '_PAREN' => 'PAREN-30', [ 'PLUS-29', '1;' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [ 'PAREN-30' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [  ], 0 ],
  [ 'Class_74' => 'Class', [ 'package', 'WordScoped', ';', 'Header', 'use parent qw(', 'PLUS-25', ')', ';', 'STAR-26', 'STAR-27', 'Properties', 'STAR-28', '1;', 'OPTIONAL-31' ], 0 ],
  [ '_PAREN' => 'PAREN-32', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [ 'STAR-33', 'PAREN-32' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [  ], 0 ],
  [ 'Properties_78' => 'Properties', [ 'our %properties = (', 'HashEntryTyped', 'STAR-33', ')', ';' ], 0 ],
  [ 'Properties_79' => 'Properties', [ 'our %properties = (', ')', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-35', [ 'PLUS-35', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-35', [ 'Operation' ], 0 ],
  [ 'Method_84' => 'Method', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-34', 'PLUS-35', '};' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [ 'STAR-37', 'PAREN-36' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [ 'STAR-38', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [  ], 0 ],
  [ 'MethodArguments_90' => 'MethodArguments', [ '( my', 'TYPE_CLASS_OR_SELF', 'STAR-37', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-38' ], 0 ],
  [ 'Operation_91' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_92' => 'Operation', [ 'Statement' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'OP01_NAMED', '(', 'OPTIONAL-39', ')' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'Expression', 'OP04_MATH_POW', 'Expression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'OP05_LOGICAL_NEG', 'Expression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP05_MATH_NEG', 'Expression', ')' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'Expression', 'OP06_REGEX_MATCH', '/', 'OP06_REGEX_PATTERN', '/' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'Expression', 'OP07_MATH_MULT_DIV_MOD', 'Expression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'Expression', 'OP08_MATH_ADD_SUB', 'Expression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'Expression', 'OP08_STRING_CAT', 'Expression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'Expression', 'OP09_BITWISE_SHIFT', 'Expression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'OP10_NAMED_UNARY', 'Expression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'Expression', 'OP11_COMPARE_LT_GT', 'Expression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'Expression', 'OP12_COMPARE_EQ_NEQ', 'Expression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'Expression', 'OP13_BITWISE_AND', 'Expression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'Expression', 'OP14_BITWISE_OR_XOR', 'Expression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'Expression', 'OP15_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'Expression', 'OP16_LOGICAL_OR', 'Expression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'Expression', 'OP17_LIST_RANGE', 'Expression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'Expression', 'OP18_TERNARY', 'Variable', ':', 'Variable' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'OP22_LOGICAL_NOT', 'Expression' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'Expression', 'OP23_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'Expression', 'OP24_LOGICAL_OR_XOR', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'OperatorVoid_126' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'OPTIONAL-40', ')', ';' ], 0 ],
  [ 'OperatorVoid_127' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'FileHandle', 'OPTIONAL-41', ')', ';' ], 0 ],
  [ 'OperatorVoid_128' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-42', ';' ], 0 ],
  [ 'OperatorVoid_129' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'FileHandle', 'OPTIONAL-43', ';' ], 0 ],
  [ 'OperatorVoid_130' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'Expression_140' => 'Expression', [ 'undef' ], 0 ],
  [ 'Expression_141' => 'Expression', [ 'LITERAL' ], 0 ],
  [ 'Expression_142' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_143' => 'Expression', [ '[', 'OPTIONAL-44', ']' ], 0 ],
  [ 'Expression_144' => 'Expression', [ '{', 'HashEntry', 'STAR-46', '}' ], 0 ],
  [ 'Expression_145' => 'Expression', [ '{', '}' ], 0 ],
  [ 'Expression_146' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_147' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-47', ')' ], 0 ],
  [ 'Expression_148' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-48', ')' ], 0 ],
  [ 'Expression_149' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'LoopLabel', ':' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'PAREN-49' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_154' => 'Statement', [ 'OPTIONAL-50', 'Loop' ], 0 ],
  [ 'Statement_155' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_156' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_157' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ '_PAREN' => 'PAREN-53', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [ 'PAREN-53' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-54', [  ], 0 ],
  [ 'Conditional_164' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-52', 'OPTIONAL-54' ], 0 ],
  [ 'Loop_165' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_166' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_167' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_168' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_169' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_170' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-55', [ 'PLUS-55', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-55', [ 'Operation' ], 0 ],
  [ 'CodeBlock_173' => 'CodeBlock', [ '{', 'PLUS-55', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [ 'STAR-56', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [  ], 0 ],
  [ 'Variable_176' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-56' ], 0 ],
  [ 'VariableRetrieval_177' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_178' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_179' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_180' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_181' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_182' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_183' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-57', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [ 'STAR-58', 'PAREN-57' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [  ], 0 ],
  [ 'ListElements_187' => 'ListElements', [ 'ListElement', 'STAR-58' ], 0 ],
  [ 'ListElement_188' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_189' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_190' => 'ListElement', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ListElement_191' => 'ListElement', [ 'KEYS_OR_VALUES', '%{', 'Variable', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [  ], 0 ],
  [ 'HashEntry_194' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-59', 'Expression' ], 0 ],
  [ 'HashEntry_195' => 'HashEntry', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashEntryTyped_196' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_197' => 'HashEntryTyped', [ '%{', 'Variable', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-60', [ '::', 'WORD' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [ 'STAR-61', 'PAREN-60' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [  ], 0 ],
  [ 'WordScoped_201' => 'WordScoped', [ 'WORD', 'STAR-61' ], 0 ],
  [ 'FileHandle_202' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'TypeInner_203' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Type_204' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_205' => 'LoopLabel', [ 'WORD' ], 0 ],
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
  '_PLUS_LIST' => 11,
  '_PLUS_LIST' => 12,
  'Program_13' => 13,
  'Module_14' => 14,
  'Module_15' => 15,
  '_STAR_LIST' => 16,
  '_STAR_LIST' => 17,
  '_STAR_LIST' => 18,
  '_STAR_LIST' => 19,
  '_PLUS_LIST' => 20,
  '_PLUS_LIST' => 21,
  'Package_22' => 22,
  'Header_23' => 23,
  '_PLUS_LIST' => 24,
  '_PLUS_LIST' => 25,
  'Include_26' => 26,
  'Include_27' => 27,
  'Constant_28' => 28,
  '_OPTIONAL' => 29,
  '_OPTIONAL' => 30,
  '_OPTIONAL' => 31,
  '_OPTIONAL' => 32,
  '_PAREN' => 33,
  '_STAR_LIST' => 34,
  '_STAR_LIST' => 35,
  '_OPTIONAL' => 36,
  '_OPTIONAL' => 37,
  '_OPTIONAL' => 38,
  '_OPTIONAL' => 39,
  '_PAREN' => 40,
  '_STAR_LIST' => 41,
  '_STAR_LIST' => 42,
  'ConstantValue_43' => 43,
  'ConstantValue_44' => 44,
  'ConstantValue_45' => 45,
  '_OPTIONAL' => 46,
  '_OPTIONAL' => 47,
  '_PLUS_LIST' => 48,
  '_PLUS_LIST' => 49,
  'Subroutine_50' => 50,
  '_PAREN' => 51,
  '_STAR_LIST' => 52,
  '_STAR_LIST' => 53,
  '_STAR_LIST' => 54,
  '_STAR_LIST' => 55,
  'SubroutineArguments_56' => 56,
  '_PAREN' => 57,
  '_OPTIONAL' => 58,
  '_OPTIONAL' => 59,
  'ArgumentCheck_60' => 60,
  '_PLUS_LIST' => 61,
  '_PLUS_LIST' => 62,
  '_STAR_LIST' => 63,
  '_STAR_LIST' => 64,
  '_STAR_LIST' => 65,
  '_STAR_LIST' => 66,
  '_STAR_LIST' => 67,
  '_STAR_LIST' => 68,
  '_PLUS_LIST' => 69,
  '_PLUS_LIST' => 70,
  '_PAREN' => 71,
  '_OPTIONAL' => 72,
  '_OPTIONAL' => 73,
  'Class_74' => 74,
  '_PAREN' => 75,
  '_STAR_LIST' => 76,
  '_STAR_LIST' => 77,
  'Properties_78' => 78,
  'Properties_79' => 79,
  '_OPTIONAL' => 80,
  '_OPTIONAL' => 81,
  '_PLUS_LIST' => 82,
  '_PLUS_LIST' => 83,
  'Method_84' => 84,
  '_PAREN' => 85,
  '_STAR_LIST' => 86,
  '_STAR_LIST' => 87,
  '_STAR_LIST' => 88,
  '_STAR_LIST' => 89,
  'MethodArguments_90' => 90,
  'Operation_91' => 91,
  'Operation_92' => 92,
  '_OPTIONAL' => 93,
  '_OPTIONAL' => 94,
  'Operator_95' => 95,
  'Operator_96' => 96,
  'Operator_97' => 97,
  'Operator_98' => 98,
  'Operator_99' => 99,
  'Operator_100' => 100,
  'Operator_101' => 101,
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
  '_OPTIONAL' => 118,
  '_OPTIONAL' => 119,
  '_OPTIONAL' => 120,
  '_OPTIONAL' => 121,
  '_OPTIONAL' => 122,
  '_OPTIONAL' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  'OperatorVoid_126' => 126,
  'OperatorVoid_127' => 127,
  'OperatorVoid_128' => 128,
  'OperatorVoid_129' => 129,
  'OperatorVoid_130' => 130,
  '_OPTIONAL' => 131,
  '_OPTIONAL' => 132,
  '_PAREN' => 133,
  '_STAR_LIST' => 134,
  '_STAR_LIST' => 135,
  '_OPTIONAL' => 136,
  '_OPTIONAL' => 137,
  '_OPTIONAL' => 138,
  '_OPTIONAL' => 139,
  'Expression_140' => 140,
  'Expression_141' => 141,
  'Expression_142' => 142,
  'Expression_143' => 143,
  'Expression_144' => 144,
  'Expression_145' => 145,
  'Expression_146' => 146,
  'Expression_147' => 147,
  'Expression_148' => 148,
  'Expression_149' => 149,
  '_PAREN' => 150,
  '_OPTIONAL' => 151,
  '_OPTIONAL' => 152,
  'Statement_153' => 153,
  'Statement_154' => 154,
  'Statement_155' => 155,
  'Statement_156' => 156,
  'Statement_157' => 157,
  '_PAREN' => 158,
  '_STAR_LIST' => 159,
  '_STAR_LIST' => 160,
  '_PAREN' => 161,
  '_OPTIONAL' => 162,
  '_OPTIONAL' => 163,
  'Conditional_164' => 164,
  'Loop_165' => 165,
  'Loop_166' => 166,
  'Loop_167' => 167,
  'LoopFor_168' => 168,
  'LoopForEach_169' => 169,
  'LoopWhile_170' => 170,
  '_PLUS_LIST' => 171,
  '_PLUS_LIST' => 172,
  'CodeBlock_173' => 173,
  '_STAR_LIST' => 174,
  '_STAR_LIST' => 175,
  'Variable_176' => 176,
  'VariableRetrieval_177' => 177,
  'VariableRetrieval_178' => 178,
  'VariableRetrieval_179' => 179,
  'VariableDeclaration_180' => 180,
  'VariableDeclaration_181' => 181,
  'VariableModification_182' => 182,
  'VariableModification_183' => 183,
  '_PAREN' => 184,
  '_STAR_LIST' => 185,
  '_STAR_LIST' => 186,
  'ListElements_187' => 187,
  'ListElement_188' => 188,
  'ListElement_189' => 189,
  'ListElement_190' => 190,
  'ListElement_191' => 191,
  '_OPTIONAL' => 192,
  '_OPTIONAL' => 193,
  'HashEntry_194' => 194,
  'HashEntry_195' => 195,
  'HashEntryTyped_196' => 196,
  'HashEntryTyped_197' => 197,
  '_PAREN' => 198,
  '_STAR_LIST' => 199,
  '_STAR_LIST' => 200,
  'WordScoped_201' => 201,
  'FileHandle_202' => 202,
  'TypeInner_203' => 203,
  'Type_204' => 204,
  'LoopLabel_205' => 205,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'( my' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	'..' => { ISSEMANTIC => 0 },
	'/' => { ISSEMANTIC => 0 },
	'1;' => { ISSEMANTIC => 0 },
	':' => { ISSEMANTIC => 0 },
	'::' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'= sub {' => { ISSEMANTIC => 0 },
	'@_;' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	'[' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'else' => { ISSEMANTIC => 0 },
	'elsif (' => { ISSEMANTIC => 0 },
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
	'use Carp;' => { ISSEMANTIC => 0 },
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
	'};' => { ISSEMANTIC => 0 },
	CHECK_OR_CHECKTRACE => { ISSEMANTIC => 1 },
	KEYS_OR_VALUES => { ISSEMANTIC => 1 },
	LITERAL => { ISSEMANTIC => 1 },
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
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'lib/RPerl/Grammar.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'SHEBANG' => 6,
			"package" => 8
		},
		GOTOS => {
			'Module' => 1,
			'PLUS-1' => 5,
			'Class' => 4,
			'Package' => 3,
			'Program' => 7,
			'CompileUnit' => 2
		}
	},
	{#State 1
		DEFAULT => -2
	},
	{#State 2
		ACTIONS => {
			'' => 9
		}
	},
	{#State 3
		DEFAULT => -14
	},
	{#State 4
		DEFAULT => -15
	},
	{#State 5
		ACTIONS => {
			'' => -4,
			"package" => 8
		},
		GOTOS => {
			'Package' => 3,
			'Class' => 4,
			'Module' => 10
		}
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
		DEFAULT => -3
	},
	{#State 8
		ACTIONS => {
			'WORD' => 13
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
			'STAR-2' => 15
		}
	},
	{#State 12
		ACTIONS => {
			"use warnings;" => 16
		}
	},
	{#State 13
		DEFAULT => -200,
		GOTOS => {
			'STAR-61' => 17
		}
	},
	{#State 14
		ACTIONS => {
			";" => 18
		}
	},
	{#State 15
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -8,
			'OP05_MATH_NEG' => -8,
			'VARIABLE_SYMBOL' => -8,
			"use" => 21,
			'OP05_LOGICAL_NEG' => -8,
			"for my integer" => -8,
			'OP01_NAMED_VOID' => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"if (" => -8,
			'OP03_MATH_INC_DEC' => -8,
			"undef" => -8,
			'OP22_LOGICAL_NOT' => -8,
			"(" => -8,
			'OP10_NAMED_UNARY' => -8,
			'LITERAL' => -8,
			"while (" => -8,
			"my" => -8,
			"{" => -8,
			"use constant" => -8,
			'OP01_NAMED' => -8,
			"foreach my" => -8,
			"our" => -8,
			"[" => -8,
			'WORD' => -8
		},
		GOTOS => {
			'Include' => 20,
			'STAR-3' => 19
		}
	},
	{#State 16
		ACTIONS => {
			"our \$VERSION =" => 22
		}
	},
	{#State 17
		ACTIONS => {
			"::" => 24,
			"(" => -201,
			";" => -201,
			"qw(" => -201,
			'WORD' => -201,
			")" => -201
		},
		GOTOS => {
			'PAREN-60' => 23
		}
	},
	{#State 18
		ACTIONS => {
			"use strict;" => 12
		},
		GOTOS => {
			'Header' => 25
		}
	},
	{#State 19
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -10,
			'OP05_MATH_NEG' => -10,
			'VARIABLE_SYMBOL' => -10,
			"for my integer" => -10,
			'OP05_LOGICAL_NEG' => -10,
			'OP01_NAMED_VOID' => -10,
			"if (" => -10,
			'OP03_MATH_INC_DEC' => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"my" => -10,
			"undef" => -10,
			"(" => -10,
			'LITERAL' => -10,
			'OP10_NAMED_UNARY' => -10,
			"while (" => -10,
			'OP22_LOGICAL_NOT' => -10,
			'OP01_NAMED' => -10,
			"use constant" => 27,
			"{" => -10,
			'WORD' => -10,
			"[" => -10,
			"foreach my" => -10,
			"our" => -10
		},
		GOTOS => {
			'Constant' => 28,
			'STAR-4' => 26
		}
	},
	{#State 20
		DEFAULT => -5
	},
	{#State 21
		ACTIONS => {
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 22
		ACTIONS => {
			'VERSION_NUMBER' => 30
		}
	},
	{#State 23
		DEFAULT => -199
	},
	{#State 24
		ACTIONS => {
			'WORD' => 31
		}
	},
	{#State 25
		ACTIONS => {
			"use constant" => -17,
			"use" => -17,
			"use parent qw(" => 33,
			"our" => -17
		},
		GOTOS => {
			'STAR-6' => 32
		}
	},
	{#State 26
		ACTIONS => {
			'OP01_NAMED_VOID' => 48,
			'OP05_LOGICAL_NEG' => 64,
			"for my integer" => -152,
			'VARIABLE_SYMBOL' => 51,
			'OP05_MATH_NEG' => 49,
			'OP19_LOOP_CONTROL' => 50,
			"our" => 54,
			"foreach my" => -152,
			'WORD' => 56,
			"[" => 36,
			"{" => 34,
			'OP01_NAMED' => 53,
			'LITERAL' => 60,
			"while (" => -152,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			"undef" => 62,
			"my" => 44,
			'OP01_NAMED_VOID_PAREN' => 58,
			'OP03_MATH_INC_DEC' => 39,
			"if (" => 59
		},
		GOTOS => {
			'PLUS-5' => 63,
			'Statement' => 52,
			'Subroutine' => 43,
			'OPTIONAL-50' => 42,
			'VariableModification' => 67,
			'Operator' => 38,
			'Variable' => 66,
			'Expression' => 37,
			'LoopLabel' => 65,
			'VariableDeclaration' => 57,
			'WordScoped' => 47,
			'PAREN-49' => 55,
			'Operation' => 46,
			'OperatorVoid' => 35,
			'Conditional' => 45
		}
	},
	{#State 27
		ACTIONS => {
			'WORD' => 68
		}
	},
	{#State 28
		DEFAULT => -7
	},
	{#State 29
		ACTIONS => {
			";" => 69,
			"qw(" => 70
		}
	},
	{#State 30
		ACTIONS => {
			";" => 71
		}
	},
	{#State 31
		DEFAULT => -198
	},
	{#State 32
		ACTIONS => {
			"use" => 21,
			"our" => -19,
			"use constant" => -19
		},
		GOTOS => {
			'Include' => 72,
			'STAR-7' => 73
		}
	},
	{#State 33
		ACTIONS => {
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 75,
			'PLUS-25' => 74
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => 78,
			"}" => 76,
			"%{" => 77
		},
		GOTOS => {
			'HashEntry' => 79
		}
	},
	{#State 35
		DEFAULT => -155
	},
	{#State 36
		ACTIONS => {
			'OP05_MATH_NEG' => 49,
			'VARIABLE_SYMBOL' => 51,
			'OP05_LOGICAL_NEG' => 64,
			"]" => -132,
			'KEYS_OR_VALUES' => 88,
			'OP03_MATH_INC_DEC' => 39,
			"undef" => 62,
			'OP10_NAMED_UNARY' => 41,
			'OP22_LOGICAL_NOT' => 61,
			'LITERAL' => 60,
			"\@{" => 80,
			"(" => 40,
			"my" => 86,
			"{" => 34,
			'OP01_NAMED' => 53,
			'WORD' => 13,
			"[" => 36
		},
		GOTOS => {
			'ListElements' => 82,
			'WordScoped' => 47,
			'OPTIONAL-44' => 87,
			'TypeInner' => 83,
			'ListElement' => 84,
			'Expression' => 85,
			'Variable' => 81,
			'Operator' => 38
		}
	},
	{#State 37
		ACTIONS => {
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => 94,
			'OP15_LOGICAL_AND' => 93,
			";" => 97,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => 104,
			'OP17_LIST_RANGE' => 92,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => 91,
			'OP11_COMPARE_LT_GT' => 98,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP08_MATH_ADD_SUB' => 101,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP13_BITWISE_AND' => 100
		}
	},
	{#State 38
		DEFAULT => -146
	},
	{#State 39
		ACTIONS => {
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Variable' => 106
		}
	},
	{#State 40
		ACTIONS => {
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'OP01_NAMED' => 53,
			'WORD' => 13,
			"[" => 36
		},
		GOTOS => {
			'WordScoped' => 47,
			'Operator' => 38,
			'Variable' => 81,
			'Expression' => 107
		}
	},
	{#State 41
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 61,
			'LITERAL' => 60,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39,
			'WORD' => 13,
			"[" => 36,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'OP01_NAMED' => 53
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 108,
			'Operator' => 38,
			'Variable' => 81
		}
	},
	{#State 42
		ACTIONS => {
			"for my integer" => 110,
			"foreach my" => 111,
			"while (" => 114
		},
		GOTOS => {
			'LoopForEach' => 115,
			'LoopWhile' => 113,
			'Loop' => 109,
			'LoopFor' => 112
		}
	},
	{#State 43
		DEFAULT => -9
	},
	{#State 44
		ACTIONS => {
			'WORD' => 116
		},
		GOTOS => {
			'Type' => 117
		}
	},
	{#State 45
		DEFAULT => -153
	},
	{#State 46
		DEFAULT => -12
	},
	{#State 47
		ACTIONS => {
			"(" => 118
		}
	},
	{#State 48
		ACTIONS => {
			";" => -123,
			'WORD' => 13,
			"[" => 36,
			"{" => 34,
			'OP01_NAMED' => 53,
			"undef" => 62,
			"(" => 40,
			"\@{" => 80,
			'OP10_NAMED_UNARY' => 41,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			"my" => 86,
			'OP03_MATH_INC_DEC' => 39,
			'KEYS_OR_VALUES' => 88,
			'OP05_LOGICAL_NEG' => 64,
			"{*" => 121,
			'VARIABLE_SYMBOL' => 51,
			'OP05_MATH_NEG' => 49
		},
		GOTOS => {
			'TypeInner' => 83,
			'ListElement' => 84,
			'Expression' => 85,
			'Operator' => 38,
			'Variable' => 81,
			'OPTIONAL-42' => 120,
			'ListElements' => 119,
			'WordScoped' => 47,
			'FileHandle' => 122
		}
	},
	{#State 49
		ACTIONS => {
			'OP01_NAMED' => 53,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			"[" => 36,
			'WORD' => 13,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Variable' => 81,
			'Operator' => 38,
			'Expression' => 123,
			'WordScoped' => 47
		}
	},
	{#State 50
		ACTIONS => {
			'WORD' => 124
		},
		GOTOS => {
			'LoopLabel' => 125
		}
	},
	{#State 51
		DEFAULT => -175,
		GOTOS => {
			'STAR-56' => 126
		}
	},
	{#State 52
		DEFAULT => -92
	},
	{#State 53
		ACTIONS => {
			"(" => 127
		}
	},
	{#State 54
		ACTIONS => {
			'WORD' => 116
		},
		GOTOS => {
			'Type' => 128
		}
	},
	{#State 55
		DEFAULT => -151
	},
	{#State 56
		ACTIONS => {
			":" => -205,
			"::" => -200,
			"(" => -200
		},
		GOTOS => {
			'STAR-61' => 17
		}
	},
	{#State 57
		DEFAULT => -156
	},
	{#State 58
		ACTIONS => {
			'WORD' => 13,
			"[" => 36,
			"{" => 34,
			'OP01_NAMED' => 53,
			"undef" => 62,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			"\@{" => 80,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			"my" => 86,
			")" => -119,
			'OP03_MATH_INC_DEC' => 39,
			'KEYS_OR_VALUES' => 88,
			'OP05_LOGICAL_NEG' => 64,
			"{*" => 121,
			'VARIABLE_SYMBOL' => 51,
			'OP05_MATH_NEG' => 49
		},
		GOTOS => {
			'WordScoped' => 47,
			'ListElements' => 130,
			'FileHandle' => 131,
			'TypeInner' => 83,
			'ListElement' => 84,
			'Operator' => 38,
			'Variable' => 81,
			'Expression' => 85,
			'OPTIONAL-40' => 129
		}
	},
	{#State 59
		ACTIONS => {
			"[" => 36,
			'WORD' => 13,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'OP01_NAMED' => 53,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'LITERAL' => 60,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39
		},
		GOTOS => {
			'Operator' => 38,
			'Variable' => 81,
			'Expression' => 132,
			'WordScoped' => 47
		}
	},
	{#State 60
		DEFAULT => -141
	},
	{#State 61
		ACTIONS => {
			'WORD' => 13,
			"[" => 36,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'OP01_NAMED' => 53,
			'OP10_NAMED_UNARY' => 41,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39
		},
		GOTOS => {
			'Expression' => 133,
			'Variable' => 81,
			'Operator' => 38,
			'WordScoped' => 47
		}
	},
	{#State 62
		DEFAULT => -140
	},
	{#State 63
		ACTIONS => {
			'OP01_NAMED_VOID' => 48,
			"for my integer" => -152,
			'OP05_LOGICAL_NEG' => 64,
			'VARIABLE_SYMBOL' => 51,
			'OP19_LOOP_CONTROL' => 50,
			'OP05_MATH_NEG' => 49,
			'' => -13,
			"[" => 36,
			'WORD' => 56,
			"foreach my" => -152,
			'OP01_NAMED' => 53,
			"{" => 34,
			"my" => 44,
			"undef" => 62,
			"while (" => -152,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			"if (" => 59,
			'OP03_MATH_INC_DEC' => 39,
			'OP01_NAMED_VOID_PAREN' => 58
		},
		GOTOS => {
			'VariableModification' => 67,
			'VariableDeclaration' => 57,
			'LoopLabel' => 65,
			'Expression' => 37,
			'Operator' => 38,
			'Variable' => 66,
			'Statement' => 52,
			'OPTIONAL-50' => 42,
			'OperatorVoid' => 35,
			'Conditional' => 45,
			'WordScoped' => 47,
			'Operation' => 134,
			'PAREN-49' => 55
		}
	},
	{#State 64
		ACTIONS => {
			'WORD' => 13,
			"[" => 36,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'OP01_NAMED' => 53,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39
		},
		GOTOS => {
			'WordScoped' => 47,
			'Variable' => 81,
			'Operator' => 38,
			'Expression' => 135
		}
	},
	{#State 65
		ACTIONS => {
			":" => 136
		}
	},
	{#State 66
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 137,
			'OP14_BITWISE_OR_XOR' => -142,
			'OP08_MATH_ADD_SUB' => -142,
			'OP13_BITWISE_AND' => -142,
			'OP09_BITWISE_SHIFT' => -142,
			'OP18_TERNARY' => -142,
			'OP17_LIST_RANGE' => -142,
			'OP19_VARIABLE_ASSIGN_BY' => 139,
			'OP11_COMPARE_LT_GT' => -142,
			'OP07_MATH_MULT_DIV_MOD' => -142,
			'OP24_LOGICAL_OR_XOR' => -142,
			'OP06_REGEX_MATCH' => -142,
			";" => -142,
			'OP12_COMPARE_EQ_NEQ' => -142,
			'OP16_LOGICAL_OR' => -142,
			'OP08_STRING_CAT' => -142,
			'OP19_VARIABLE_ASSIGN' => 138,
			'OP04_MATH_POW' => -142,
			'OP23_LOGICAL_AND' => -142,
			'OP03_MATH_INC_DEC' => 140,
			'OP15_LOGICAL_AND' => -142
		}
	},
	{#State 67
		DEFAULT => -157
	},
	{#State 68
		ACTIONS => {
			'OP20_HASH_FATARROW' => 141
		}
	},
	{#State 69
		DEFAULT => -26
	},
	{#State 70
		ACTIONS => {
			'WORD' => 142
		},
		GOTOS => {
			'PLUS-9' => 143
		}
	},
	{#State 71
		ACTIONS => {
			"use Carp;" => 144
		}
	},
	{#State 72
		DEFAULT => -16
	},
	{#State 73
		ACTIONS => {
			"use constant" => 27,
			"our" => 54
		},
		GOTOS => {
			'PLUS-8' => 145,
			'Subroutine' => 147,
			'Constant' => 146
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => 13,
			")" => 149
		},
		GOTOS => {
			'WordScoped' => 148
		}
	},
	{#State 75
		DEFAULT => -62
	},
	{#State 76
		DEFAULT => -145
	},
	{#State 77
		ACTIONS => {
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Variable' => 150
		}
	},
	{#State 78
		ACTIONS => {
			'OP20_HASH_FATARROW' => 151
		}
	},
	{#State 79
		DEFAULT => -135,
		GOTOS => {
			'STAR-46' => 152
		}
	},
	{#State 80
		ACTIONS => {
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Variable' => 153
		}
	},
	{#State 81
		ACTIONS => {
			'OP18_TERNARY' => -142,
			'OP09_BITWISE_SHIFT' => -142,
			'OP17_LIST_RANGE' => -142,
			'OP11_COMPARE_LT_GT' => -142,
			'OP07_MATH_MULT_DIV_MOD' => -142,
			".." => -142,
			'OP24_LOGICAL_OR_XOR' => -142,
			'OP02_METHOD_THINARROW' => 137,
			'OP08_MATH_ADD_SUB' => -142,
			'OP21_LIST_COMMA' => -142,
			'OP14_BITWISE_OR_XOR' => -142,
			"}" => -142,
			"]" => -142,
			'OP13_BITWISE_AND' => -142,
			'OP04_MATH_POW' => -142,
			'OP23_LOGICAL_AND' => -142,
			'OP03_MATH_INC_DEC' => 140,
			")" => -142,
			'OP15_LOGICAL_AND' => -142,
			'OP06_REGEX_MATCH' => -142,
			";" => -142,
			'OP12_COMPARE_EQ_NEQ' => -142,
			'OP16_LOGICAL_OR' => -142,
			'OP08_STRING_CAT' => -142
		}
	},
	{#State 82
		DEFAULT => -131
	},
	{#State 83
		ACTIONS => {
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			'OP22_LOGICAL_NOT' => 61,
			'LITERAL' => 60,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			"[" => 36,
			'WORD' => 13,
			'OP01_NAMED' => 53,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64
		},
		GOTOS => {
			'Variable' => 81,
			'Operator' => 38,
			'Expression' => 154,
			'WordScoped' => 47
		}
	},
	{#State 84
		DEFAULT => -186,
		GOTOS => {
			'STAR-58' => 155
		}
	},
	{#State 85
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP06_REGEX_MATCH' => 105,
			";" => -188,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP23_LOGICAL_AND' => 94,
			'OP04_MATH_POW' => 103,
			'OP15_LOGICAL_AND' => 93,
			")" => -188,
			'OP21_LIST_COMMA' => -188,
			'OP08_MATH_ADD_SUB' => 101,
			'OP14_BITWISE_OR_XOR' => 102,
			"]" => -188,
			'OP13_BITWISE_AND' => 100,
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP17_LIST_RANGE' => 92,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP11_COMPARE_LT_GT' => 98
		}
	},
	{#State 86
		ACTIONS => {
			'WORD' => 116
		},
		GOTOS => {
			'Type' => 156
		}
	},
	{#State 87
		ACTIONS => {
			"]" => 157
		}
	},
	{#State 88
		ACTIONS => {
			"%{" => 158
		}
	},
	{#State 89
		ACTIONS => {
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'OP01_NAMED' => 53,
			"[" => 36,
			'WORD' => 13,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			'LITERAL' => 60,
			"(" => 40
		},
		GOTOS => {
			'Operator' => 38,
			'Variable' => 81,
			'Expression' => 159,
			'WordScoped' => 47
		}
	},
	{#State 90
		ACTIONS => {
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'OP01_NAMED' => 53,
			'WORD' => 13,
			"[" => 36
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 160,
			'Variable' => 81,
			'Operator' => 38
		}
	},
	{#State 91
		ACTIONS => {
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Variable' => 161
		}
	},
	{#State 92
		ACTIONS => {
			'WORD' => 13,
			"[" => 36,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'OP01_NAMED' => 53,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 61,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 162,
			'Operator' => 38,
			'Variable' => 81
		}
	},
	{#State 93
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'OP01_NAMED' => 53,
			"[" => 36,
			'WORD' => 13,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62
		},
		GOTOS => {
			'Expression' => 163,
			'Operator' => 38,
			'Variable' => 81,
			'WordScoped' => 47
		}
	},
	{#State 94
		ACTIONS => {
			"[" => 36,
			'WORD' => 13,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'OP01_NAMED' => 53,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			'LITERAL' => 60,
			"(" => 40,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39
		},
		GOTOS => {
			'WordScoped' => 47,
			'Variable' => 81,
			'Operator' => 38,
			'Expression' => 164
		}
	},
	{#State 95
		ACTIONS => {
			"[" => 36,
			'WORD' => 13,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'OP01_NAMED' => 53,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			'OP22_LOGICAL_NOT' => 61,
			'LITERAL' => 60,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 165,
			'Variable' => 81,
			'Operator' => 38
		}
	},
	{#State 96
		ACTIONS => {
			'OP01_NAMED' => 53,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'WORD' => 13,
			"[" => 36,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			'LITERAL' => 60,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Expression' => 166,
			'Variable' => 81,
			'Operator' => 38,
			'WordScoped' => 47
		}
	},
	{#State 97
		DEFAULT => -91
	},
	{#State 98
		ACTIONS => {
			'WORD' => 13,
			"[" => 36,
			'OP01_NAMED' => 53,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49
		},
		GOTOS => {
			'WordScoped' => 47,
			'Variable' => 81,
			'Operator' => 38,
			'Expression' => 167
		}
	},
	{#State 99
		ACTIONS => {
			'WORD' => 13,
			"[" => 36,
			'OP01_NAMED' => 53,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 168,
			'Operator' => 38,
			'Variable' => 81
		}
	},
	{#State 100
		ACTIONS => {
			'OP01_NAMED' => 53,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'WORD' => 13,
			"[" => 36,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			'OP22_LOGICAL_NOT' => 61,
			'LITERAL' => 60,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Expression' => 169,
			'Variable' => 81,
			'Operator' => 38,
			'WordScoped' => 47
		}
	},
	{#State 101
		ACTIONS => {
			"[" => 36,
			'WORD' => 13,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'OP01_NAMED' => 53,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39
		},
		GOTOS => {
			'Operator' => 38,
			'Variable' => 81,
			'Expression' => 170,
			'WordScoped' => 47
		}
	},
	{#State 102
		ACTIONS => {
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 61,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39,
			"[" => 36,
			'WORD' => 13,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'OP01_NAMED' => 53
		},
		GOTOS => {
			'Operator' => 38,
			'Variable' => 81,
			'Expression' => 171,
			'WordScoped' => 47
		}
	},
	{#State 103
		ACTIONS => {
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			'WORD' => 13,
			"[" => 36,
			'OP01_NAMED' => 53,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34
		},
		GOTOS => {
			'Variable' => 81,
			'Operator' => 38,
			'Expression' => 172,
			'WordScoped' => 47
		}
	},
	{#State 104
		ACTIONS => {
			'WORD' => 13,
			"[" => 36,
			'OP01_NAMED' => 53,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49
		},
		GOTOS => {
			'Variable' => 81,
			'Operator' => 38,
			'Expression' => 173,
			'WordScoped' => 47
		}
	},
	{#State 105
		ACTIONS => {
			"/" => 174
		}
	},
	{#State 106
		DEFAULT => -96
	},
	{#State 107
		ACTIONS => {
			'OP13_BITWISE_AND' => 100,
			'OP08_MATH_ADD_SUB' => 101,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP11_COMPARE_LT_GT' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => 91,
			'OP17_LIST_RANGE' => 92,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			")" => 175,
			'OP15_LOGICAL_AND' => 93,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => 94
		}
	},
	{#State 108
		ACTIONS => {
			'OP23_LOGICAL_AND' => -106,
			'OP04_MATH_POW' => 103,
			'OP15_LOGICAL_AND' => -106,
			")" => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP06_REGEX_MATCH' => 105,
			";" => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP08_STRING_CAT' => 95,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => -106,
			'OP17_LIST_RANGE' => -106,
			".." => -106,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP08_MATH_ADD_SUB' => 101,
			"}" => -106,
			"]" => -106,
			'OP13_BITWISE_AND' => -106
		}
	},
	{#State 109
		DEFAULT => -154
	},
	{#State 110
		ACTIONS => {
			'VARIABLE_SYMBOL' => 176
		}
	},
	{#State 111
		ACTIONS => {
			'WORD' => 116
		},
		GOTOS => {
			'Type' => 177
		}
	},
	{#State 112
		DEFAULT => -165
	},
	{#State 113
		DEFAULT => -167
	},
	{#State 114
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			"(" => 40,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			'OP22_LOGICAL_NOT' => 61,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'OP01_NAMED' => 53,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			"[" => 36,
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 178,
			'Variable' => 81,
			'Operator' => 38
		}
	},
	{#State 115
		DEFAULT => -166
	},
	{#State 116
		DEFAULT => -204
	},
	{#State 117
		ACTIONS => {
			'VARIABLE_SYMBOL' => 179
		}
	},
	{#State 118
		ACTIONS => {
			'OP05_MATH_NEG' => 49,
			'VARIABLE_SYMBOL' => 51,
			'OP05_LOGICAL_NEG' => 64,
			'KEYS_OR_VALUES' => 88,
			'OP03_MATH_INC_DEC' => 39,
			")" => -137,
			"my" => 86,
			'OP22_LOGICAL_NOT' => 61,
			'LITERAL' => 60,
			"\@{" => 80,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			"undef" => 62,
			'OP01_NAMED' => 53,
			"{" => 34,
			'WORD' => 13,
			"[" => 36
		},
		GOTOS => {
			'TypeInner' => 83,
			'ListElement' => 84,
			'Operator' => 38,
			'Variable' => 81,
			'Expression' => 85,
			'ListElements' => 180,
			'WordScoped' => 47,
			'OPTIONAL-47' => 181
		}
	},
	{#State 119
		DEFAULT => -122
	},
	{#State 120
		ACTIONS => {
			";" => 182
		}
	},
	{#State 121
		ACTIONS => {
			'WORD' => 183
		}
	},
	{#State 122
		ACTIONS => {
			'KEYS_OR_VALUES' => 88,
			'OP05_LOGICAL_NEG' => 64,
			'VARIABLE_SYMBOL' => 51,
			'OP05_MATH_NEG' => 49,
			";" => -125,
			'WORD' => 13,
			"[" => 36,
			'OP01_NAMED' => 53,
			"{" => 34,
			"my" => 86,
			"undef" => 62,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 61,
			'LITERAL' => 60,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 39
		},
		GOTOS => {
			'OPTIONAL-43' => 185,
			'WordScoped' => 47,
			'ListElements' => 184,
			'Variable' => 81,
			'Operator' => 38,
			'Expression' => 85,
			'TypeInner' => 83,
			'ListElement' => 84
		}
	},
	{#State 123
		ACTIONS => {
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => 94,
			")" => 186,
			'OP15_LOGICAL_AND' => 93,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP13_BITWISE_AND' => 100,
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP17_LIST_RANGE' => 92,
			'OP11_COMPARE_LT_GT' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90
		}
	},
	{#State 124
		DEFAULT => -205
	},
	{#State 125
		ACTIONS => {
			";" => 187
		}
	},
	{#State 126
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => -176,
			'OP18_TERNARY' => -176,
			'OP09_BITWISE_SHIFT' => -176,
			'OP17_LIST_RANGE' => -176,
			".." => -176,
			'OP07_MATH_MULT_DIV_MOD' => -176,
			'OP24_LOGICAL_OR_XOR' => -176,
			'OP11_COMPARE_LT_GT' => -176,
			'OP08_MATH_ADD_SUB' => -176,
			'OP21_LIST_COMMA' => -176,
			'OP14_BITWISE_OR_XOR' => -176,
			"}" => -176,
			'OP02_METHOD_THINARROW' => -176,
			"]" => -176,
			'OP13_BITWISE_AND' => -176,
			'OP23_LOGICAL_AND' => -176,
			'OP04_MATH_POW' => -176,
			":" => -176,
			'OP15_LOGICAL_AND' => -176,
			'OP03_MATH_INC_DEC' => -176,
			")" => -176,
			'OP02_ARRAY_THINARROW' => 188,
			'OP02_HASH_THINARROW' => 189,
			'OP12_COMPARE_EQ_NEQ' => -176,
			'OP06_REGEX_MATCH' => -176,
			";" => -176,
			'OP19_VARIABLE_ASSIGN' => -176,
			'OP16_LOGICAL_OR' => -176,
			'OP08_STRING_CAT' => -176
		},
		GOTOS => {
			'VariableRetrieval' => 190
		}
	},
	{#State 127
		ACTIONS => {
			"[" => 36,
			'WORD' => 13,
			'OP01_NAMED' => 53,
			"{" => 34,
			"my" => 86,
			"undef" => 62,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 61,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 39,
			")" => -94,
			'KEYS_OR_VALUES' => 88,
			'OP05_LOGICAL_NEG' => 64,
			'VARIABLE_SYMBOL' => 51,
			'OP05_MATH_NEG' => 49
		},
		GOTOS => {
			'TypeInner' => 83,
			'ListElement' => 84,
			'Operator' => 38,
			'Variable' => 81,
			'Expression' => 85,
			'WordScoped' => 47,
			'ListElements' => 192,
			'OPTIONAL-39' => 191
		}
	},
	{#State 128
		ACTIONS => {
			'VARIABLE_SYMBOL' => 193
		}
	},
	{#State 129
		ACTIONS => {
			")" => 194
		}
	},
	{#State 130
		DEFAULT => -118
	},
	{#State 131
		ACTIONS => {
			'VARIABLE_SYMBOL' => 51,
			'OP05_MATH_NEG' => 49,
			'KEYS_OR_VALUES' => 88,
			'OP05_LOGICAL_NEG' => 64,
			"my" => 86,
			"undef" => 62,
			'LITERAL' => 60,
			"\@{" => 80,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 61,
			'OP03_MATH_INC_DEC' => 39,
			")" => -121,
			'WORD' => 13,
			"[" => 36,
			'OP01_NAMED' => 53,
			"{" => 34
		},
		GOTOS => {
			'Expression' => 85,
			'Operator' => 38,
			'Variable' => 81,
			'ListElement' => 84,
			'TypeInner' => 83,
			'ListElements' => 195,
			'WordScoped' => 47,
			'OPTIONAL-41' => 196
		}
	},
	{#State 132
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 101,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP13_BITWISE_AND' => 100,
			'OP17_LIST_RANGE' => 92,
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP11_COMPARE_LT_GT' => 98,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => 104,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => 94,
			")" => 197,
			'OP15_LOGICAL_AND' => 93
		}
	},
	{#State 133
		ACTIONS => {
			'OP17_LIST_RANGE' => 92,
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP11_COMPARE_LT_GT' => 98,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			".." => -115,
			"}" => -115,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP21_LIST_COMMA' => -115,
			'OP08_MATH_ADD_SUB' => 101,
			'OP13_BITWISE_AND' => 100,
			"]" => -115,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => -115,
			")" => -115,
			'OP15_LOGICAL_AND' => 93,
			";" => -115,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => 104
		}
	},
	{#State 134
		DEFAULT => -11
	},
	{#State 135
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -99,
			";" => -99,
			'OP06_REGEX_MATCH' => -99,
			'OP08_STRING_CAT' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP04_MATH_POW' => 103,
			'OP15_LOGICAL_AND' => -99,
			")" => -99,
			"}" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'OP13_BITWISE_AND' => -99,
			"]" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP18_TERNARY' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			".." => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP11_COMPARE_LT_GT' => -99
		}
	},
	{#State 136
		DEFAULT => -150
	},
	{#State 137
		ACTIONS => {
			'WORD' => 198
		}
	},
	{#State 138
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'OP01_NAMED' => 53,
			"[" => 36,
			'WORD' => 13,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39,
			'OP10_NAMED_UNARY' => 41,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			'LITERAL' => 60,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Operator' => 38,
			'Variable' => 81,
			'Expression' => 199,
			'WordScoped' => 47
		}
	},
	{#State 139
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			'OP01_NAMED' => 53,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'WORD' => 13,
			"[" => 36
		},
		GOTOS => {
			'Expression' => 200,
			'Operator' => 38,
			'Variable' => 81,
			'WordScoped' => 47
		}
	},
	{#State 140
		DEFAULT => -97
	},
	{#State 141
		ACTIONS => {
			"my" => 86
		},
		GOTOS => {
			'TypeInner' => 201
		}
	},
	{#State 142
		DEFAULT => -25
	},
	{#State 143
		ACTIONS => {
			'WORD' => 203,
			")" => 202
		}
	},
	{#State 144
		ACTIONS => {
			"use RPerl;" => 204
		}
	},
	{#State 145
		ACTIONS => {
			"our" => 54,
			"1;" => 206
		},
		GOTOS => {
			'Subroutine' => 205
		}
	},
	{#State 146
		DEFAULT => -18
	},
	{#State 147
		DEFAULT => -21
	},
	{#State 148
		DEFAULT => -61
	},
	{#State 149
		ACTIONS => {
			";" => 207
		}
	},
	{#State 150
		ACTIONS => {
			"}" => 208
		}
	},
	{#State 151
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -193,
			'OP05_MATH_NEG' => -193,
			"my" => 86,
			"(" => -193,
			'LITERAL' => -193,
			'OP10_NAMED_UNARY' => -193,
			'OP22_LOGICAL_NOT' => -193,
			"undef" => -193,
			'VARIABLE_SYMBOL' => -193,
			'OP01_NAMED' => -193,
			'OP05_LOGICAL_NEG' => -193,
			"{" => -193,
			'WORD' => -193,
			"[" => -193
		},
		GOTOS => {
			'TypeInner' => 210,
			'OPTIONAL-59' => 209
		}
	},
	{#State 152
		ACTIONS => {
			'OP21_LIST_COMMA' => 212,
			"}" => 211
		},
		GOTOS => {
			'PAREN-45' => 213
		}
	},
	{#State 153
		ACTIONS => {
			"}" => 214
		}
	},
	{#State 154
		ACTIONS => {
			")" => -189,
			'OP15_LOGICAL_AND' => 93,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => 94,
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => 104,
			";" => -189,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP11_COMPARE_LT_GT' => 98,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP17_LIST_RANGE' => 92,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => 91,
			'OP13_BITWISE_AND' => 100,
			"]" => -189,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP21_LIST_COMMA' => -189,
			'OP08_MATH_ADD_SUB' => 101
		}
	},
	{#State 155
		ACTIONS => {
			"]" => -187,
			")" => -187,
			";" => -187,
			'OP21_LIST_COMMA' => 216
		},
		GOTOS => {
			'PAREN-57' => 215
		}
	},
	{#State 156
		ACTIONS => {
			"\$TYPED_" => 217
		}
	},
	{#State 157
		DEFAULT => -143
	},
	{#State 158
		ACTIONS => {
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Variable' => 218
		}
	},
	{#State 159
		ACTIONS => {
			"}" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP08_MATH_ADD_SUB' => -102,
			'OP13_BITWISE_AND' => -102,
			"]" => -102,
			'OP17_LIST_RANGE' => -102,
			'OP09_BITWISE_SHIFT' => -102,
			'OP18_TERNARY' => -102,
			'OP11_COMPARE_LT_GT' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_MATH_MULT_DIV_MOD' => -102,
			".." => -102,
			";" => -102,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => -102,
			'OP08_STRING_CAT' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => -102,
			")" => -102,
			'OP15_LOGICAL_AND' => -102
		}
	},
	{#State 160
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => 91,
			'OP17_LIST_RANGE' => 92,
			".." => -117,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP11_COMPARE_LT_GT' => 98,
			'OP21_LIST_COMMA' => -117,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			"}" => -117,
			"]" => -117,
			'OP13_BITWISE_AND' => 100,
			'OP23_LOGICAL_AND' => 94,
			'OP04_MATH_POW' => 103,
			'OP15_LOGICAL_AND' => 93,
			")" => -117,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP06_REGEX_MATCH' => 105,
			";" => -117,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95
		}
	},
	{#State 161
		ACTIONS => {
			":" => 219
		}
	},
	{#State 162
		ACTIONS => {
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => 104,
			'OP12_COMPARE_EQ_NEQ' => 96,
			";" => -113,
			'OP06_REGEX_MATCH' => 105,
			'OP15_LOGICAL_AND' => 93,
			")" => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP04_MATH_POW' => 103,
			'OP13_BITWISE_AND' => 100,
			"]" => -113,
			"}" => -113,
			'OP21_LIST_COMMA' => -113,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP24_LOGICAL_OR_XOR' => -113,
			".." => -113,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP11_COMPARE_LT_GT' => 98,
			'OP17_LIST_RANGE' => undef,
			'OP18_TERNARY' => -113,
			'OP09_BITWISE_SHIFT' => 99
		}
	},
	{#State 163
		ACTIONS => {
			"}" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP13_BITWISE_AND' => 100,
			"]" => -111,
			'OP17_LIST_RANGE' => -111,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => -111,
			'OP11_COMPARE_LT_GT' => 98,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			".." => -111,
			";" => -111,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => -111,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => -111,
			")" => -111,
			'OP15_LOGICAL_AND' => -111
		}
	},
	{#State 164
		ACTIONS => {
			".." => -116,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP11_COMPARE_LT_GT' => 98,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => 91,
			'OP17_LIST_RANGE' => 92,
			"]" => -116,
			'OP13_BITWISE_AND' => 100,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP21_LIST_COMMA' => -116,
			'OP08_MATH_ADD_SUB' => 101,
			"}" => -116,
			'OP15_LOGICAL_AND' => 93,
			")" => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP04_MATH_POW' => 103,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP06_REGEX_MATCH' => 105,
			";" => -116
		}
	},
	{#State 165
		ACTIONS => {
			'OP13_BITWISE_AND' => -104,
			"]" => -104,
			"}" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP08_MATH_ADD_SUB' => 101,
			'OP11_COMPARE_LT_GT' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			".." => -104,
			'OP17_LIST_RANGE' => -104,
			'OP09_BITWISE_SHIFT' => -104,
			'OP18_TERNARY' => -104,
			'OP08_STRING_CAT' => -104,
			'OP16_LOGICAL_OR' => -104,
			";" => -104,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => -104,
			")" => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => -104
		}
	},
	{#State 166
		ACTIONS => {
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => -108,
			";" => -108,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => undef,
			")" => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => -108,
			'OP13_BITWISE_AND' => -108,
			"]" => -108,
			"}" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP08_MATH_ADD_SUB' => 101,
			'OP11_COMPARE_LT_GT' => 98,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			".." => -108,
			'OP17_LIST_RANGE' => -108,
			'OP18_TERNARY' => -108,
			'OP09_BITWISE_SHIFT' => 99
		}
	},
	{#State 167
		ACTIONS => {
			'OP23_LOGICAL_AND' => -107,
			'OP04_MATH_POW' => 103,
			'OP15_LOGICAL_AND' => -107,
			")" => -107,
			'OP12_COMPARE_EQ_NEQ' => -107,
			'OP06_REGEX_MATCH' => 105,
			";" => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP08_STRING_CAT' => 95,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => -107,
			'OP17_LIST_RANGE' => -107,
			".." => -107,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP11_COMPARE_LT_GT' => undef,
			'OP21_LIST_COMMA' => -107,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP08_MATH_ADD_SUB' => 101,
			"}" => -107,
			"]" => -107,
			'OP13_BITWISE_AND' => -107
		}
	},
	{#State 168
		ACTIONS => {
			'OP15_LOGICAL_AND' => -105,
			")" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP04_MATH_POW' => 103,
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			";" => -105,
			'OP06_REGEX_MATCH' => 105,
			'OP24_LOGICAL_OR_XOR' => -105,
			".." => -105,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP11_COMPARE_LT_GT' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP18_TERNARY' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP13_BITWISE_AND' => -105,
			"]" => -105,
			"}" => -105,
			'OP08_MATH_ADD_SUB' => 101,
			'OP21_LIST_COMMA' => -105,
			'OP14_BITWISE_OR_XOR' => -105
		}
	},
	{#State 169
		ACTIONS => {
			'OP15_LOGICAL_AND' => -109,
			")" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP04_MATH_POW' => 103,
			'OP16_LOGICAL_OR' => -109,
			'OP08_STRING_CAT' => 95,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP06_REGEX_MATCH' => 105,
			";" => -109,
			".." => -109,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP11_COMPARE_LT_GT' => 98,
			'OP18_TERNARY' => -109,
			'OP09_BITWISE_SHIFT' => 99,
			'OP17_LIST_RANGE' => -109,
			"]" => -109,
			'OP13_BITWISE_AND' => -109,
			'OP08_MATH_ADD_SUB' => 101,
			'OP21_LIST_COMMA' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			"}" => -109
		}
	},
	{#State 170
		ACTIONS => {
			";" => -103,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => -103,
			'OP08_STRING_CAT' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => -103,
			")" => -103,
			'OP15_LOGICAL_AND' => -103,
			"}" => -103,
			'OP21_LIST_COMMA' => -103,
			'OP08_MATH_ADD_SUB' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP13_BITWISE_AND' => -103,
			"]" => -103,
			'OP17_LIST_RANGE' => -103,
			'OP18_TERNARY' => -103,
			'OP09_BITWISE_SHIFT' => -103,
			'OP11_COMPARE_LT_GT' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			".." => -103
		}
	},
	{#State 171
		ACTIONS => {
			'OP06_REGEX_MATCH' => 105,
			";" => -110,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP16_LOGICAL_OR' => -110,
			'OP08_STRING_CAT' => 95,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => -110,
			")" => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP08_MATH_ADD_SUB' => 101,
			'OP14_BITWISE_OR_XOR' => -110,
			"}" => -110,
			"]" => -110,
			'OP13_BITWISE_AND' => 100,
			'OP18_TERNARY' => -110,
			'OP09_BITWISE_SHIFT' => 99,
			'OP17_LIST_RANGE' => -110,
			'OP11_COMPARE_LT_GT' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			".." => -110,
			'OP24_LOGICAL_OR_XOR' => -110
		}
	},
	{#State 172
		ACTIONS => {
			".." => -98,
			'OP07_MATH_MULT_DIV_MOD' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP18_TERNARY' => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP17_LIST_RANGE' => -98,
			"]" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP08_MATH_ADD_SUB' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			"}" => -98,
			'OP15_LOGICAL_AND' => -98,
			")" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP04_MATH_POW' => 103,
			'OP16_LOGICAL_OR' => -98,
			'OP08_STRING_CAT' => -98,
			'OP12_COMPARE_EQ_NEQ' => -98,
			'OP06_REGEX_MATCH' => -98,
			";" => -98
		}
	},
	{#State 173
		ACTIONS => {
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => -112,
			")" => -112,
			'OP15_LOGICAL_AND' => 93,
			";" => -112,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => -112,
			'OP11_COMPARE_LT_GT' => 98,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			".." => -112,
			"}" => -112,
			'OP08_MATH_ADD_SUB' => 101,
			'OP21_LIST_COMMA' => -112,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP13_BITWISE_AND' => 100,
			"]" => -112
		}
	},
	{#State 174
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 220
		}
	},
	{#State 175
		DEFAULT => -149
	},
	{#State 176
		ACTIONS => {
			"(" => 221
		}
	},
	{#State 177
		ACTIONS => {
			'VARIABLE_SYMBOL' => 222
		}
	},
	{#State 178
		ACTIONS => {
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			")" => 223,
			'OP15_LOGICAL_AND' => 93,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => 94,
			'OP13_BITWISE_AND' => 100,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP11_COMPARE_LT_GT' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => 91,
			'OP17_LIST_RANGE' => 92
		}
	},
	{#State 179
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 224,
			";" => 225
		}
	},
	{#State 180
		DEFAULT => -136
	},
	{#State 181
		ACTIONS => {
			")" => 226
		}
	},
	{#State 182
		DEFAULT => -128
	},
	{#State 183
		ACTIONS => {
			"}" => 227
		}
	},
	{#State 184
		DEFAULT => -124
	},
	{#State 185
		ACTIONS => {
			";" => 228
		}
	},
	{#State 186
		DEFAULT => -100
	},
	{#State 187
		DEFAULT => -130
	},
	{#State 188
		ACTIONS => {
			"[" => 36,
			'WORD' => 13,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'OP01_NAMED' => 53,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			'LITERAL' => 60,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 229,
			'Operator' => 38,
			'Variable' => 81
		}
	},
	{#State 189
		ACTIONS => {
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39,
			'WORD' => 231,
			"[" => 36,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'OP01_NAMED' => 53
		},
		GOTOS => {
			'Variable' => 81,
			'Operator' => 38,
			'Expression' => 230,
			'WordScoped' => 47
		}
	},
	{#State 190
		DEFAULT => -174
	},
	{#State 191
		ACTIONS => {
			")" => 232
		}
	},
	{#State 192
		DEFAULT => -93
	},
	{#State 193
		ACTIONS => {
			"= sub {" => 233
		}
	},
	{#State 194
		ACTIONS => {
			";" => 234
		}
	},
	{#State 195
		DEFAULT => -120
	},
	{#State 196
		ACTIONS => {
			")" => 235
		}
	},
	{#State 197
		ACTIONS => {
			"{" => 236
		},
		GOTOS => {
			'CodeBlock' => 237
		}
	},
	{#State 198
		ACTIONS => {
			"(" => 238
		}
	},
	{#State 199
		ACTIONS => {
			'OP06_REGEX_MATCH' => 105,
			";" => 239,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => 94,
			'OP15_LOGICAL_AND' => 93,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP13_BITWISE_AND' => 100,
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP17_LIST_RANGE' => 92,
			'OP11_COMPARE_LT_GT' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90
		}
	},
	{#State 200
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP13_BITWISE_AND' => 100,
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP17_LIST_RANGE' => 92,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP11_COMPARE_LT_GT' => 98,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP06_REGEX_MATCH' => 105,
			";" => 240,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP23_LOGICAL_AND' => 94,
			'OP04_MATH_POW' => 103,
			'OP15_LOGICAL_AND' => 93
		}
	},
	{#State 201
		ACTIONS => {
			"{" => 241,
			"[" => 242,
			'LITERAL' => 243
		},
		GOTOS => {
			'ConstantValue' => 244
		}
	},
	{#State 202
		ACTIONS => {
			";" => 245
		}
	},
	{#State 203
		DEFAULT => -24
	},
	{#State 204
		DEFAULT => -23
	},
	{#State 205
		DEFAULT => -20
	},
	{#State 206
		DEFAULT => -22
	},
	{#State 207
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 246
		}
	},
	{#State 208
		DEFAULT => -195
	},
	{#State 209
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			"(" => 40,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			'OP22_LOGICAL_NOT' => 61,
			'OP01_NAMED' => 53,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'WORD' => 13,
			"[" => 36
		},
		GOTOS => {
			'Expression' => 247,
			'Operator' => 38,
			'Variable' => 81,
			'WordScoped' => 47
		}
	},
	{#State 210
		DEFAULT => -192
	},
	{#State 211
		DEFAULT => -144
	},
	{#State 212
		ACTIONS => {
			'WORD' => 78,
			"%{" => 77
		},
		GOTOS => {
			'HashEntry' => 248
		}
	},
	{#State 213
		DEFAULT => -134
	},
	{#State 214
		DEFAULT => -190
	},
	{#State 215
		DEFAULT => -185
	},
	{#State 216
		ACTIONS => {
			'OP01_NAMED' => 53,
			"{" => 34,
			"[" => 36,
			'WORD' => 13,
			'OP03_MATH_INC_DEC' => 39,
			"my" => 86,
			"\@{" => 80,
			'OP10_NAMED_UNARY' => 41,
			'OP22_LOGICAL_NOT' => 61,
			'LITERAL' => 60,
			"(" => 40,
			"undef" => 62,
			'OP05_LOGICAL_NEG' => 64,
			'KEYS_OR_VALUES' => 88,
			'OP05_MATH_NEG' => 49,
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 85,
			'Variable' => 81,
			'Operator' => 38,
			'TypeInner' => 83,
			'ListElement' => 249
		}
	},
	{#State 217
		ACTIONS => {
			'WORD' => 250
		}
	},
	{#State 218
		ACTIONS => {
			"}" => 251
		}
	},
	{#State 219
		ACTIONS => {
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Variable' => 252
		}
	},
	{#State 220
		ACTIONS => {
			"/" => 253
		}
	},
	{#State 221
		ACTIONS => {
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'OP01_NAMED' => 53,
			'WORD' => 13,
			"[" => 36,
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			'OP10_NAMED_UNARY' => 41,
			'LITERAL' => 60,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 61
		},
		GOTOS => {
			'Expression' => 254,
			'Operator' => 38,
			'Variable' => 81,
			'WordScoped' => 47
		}
	},
	{#State 222
		ACTIONS => {
			"(" => 255
		}
	},
	{#State 223
		ACTIONS => {
			"{" => 236
		},
		GOTOS => {
			'CodeBlock' => 256
		}
	},
	{#State 224
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			"[" => 36,
			'WORD' => 13,
			'OP01_NAMED' => 53,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 257,
			'Variable' => 81,
			'Operator' => 38
		}
	},
	{#State 225
		DEFAULT => -180
	},
	{#State 226
		DEFAULT => -147
	},
	{#State 227
		DEFAULT => -202
	},
	{#State 228
		DEFAULT => -129
	},
	{#State 229
		ACTIONS => {
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => 94,
			'OP15_LOGICAL_AND' => 93,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP17_LIST_RANGE' => 92,
			'OP11_COMPARE_LT_GT' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP08_MATH_ADD_SUB' => 101,
			'OP14_BITWISE_OR_XOR' => 102,
			"]" => 258,
			'OP13_BITWISE_AND' => 100
		}
	},
	{#State 230
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP06_REGEX_MATCH' => 105,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP23_LOGICAL_AND' => 94,
			'OP04_MATH_POW' => 103,
			'OP15_LOGICAL_AND' => 93,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			"}" => 259,
			'OP13_BITWISE_AND' => 100,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => 91,
			'OP17_LIST_RANGE' => 92,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP11_COMPARE_LT_GT' => 98
		}
	},
	{#State 231
		ACTIONS => {
			"(" => -200,
			"}" => 260,
			"::" => -200
		},
		GOTOS => {
			'STAR-61' => 17
		}
	},
	{#State 232
		DEFAULT => -95
	},
	{#State 233
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => -47,
			"if (" => -47,
			'OP03_MATH_INC_DEC' => -47,
			"undef" => -47,
			"while (" => -47,
			"(" => -47,
			'OP10_NAMED_UNARY' => -47,
			'OP22_LOGICAL_NOT' => -47,
			'LITERAL' => -47,
			"my" => -47,
			"{" => -47,
			'OP01_NAMED' => -47,
			"foreach my" => -47,
			'WORD' => -47,
			"[" => -47,
			"( my" => 262,
			'OP19_LOOP_CONTROL' => -47,
			'OP05_MATH_NEG' => -47,
			'VARIABLE_SYMBOL' => -47,
			'OP05_LOGICAL_NEG' => -47,
			"for my integer" => -47,
			'OP01_NAMED_VOID' => -47
		},
		GOTOS => {
			'SubroutineArguments' => 261,
			'OPTIONAL-18' => 263
		}
	},
	{#State 234
		DEFAULT => -126
	},
	{#State 235
		ACTIONS => {
			";" => 264
		}
	},
	{#State 236
		ACTIONS => {
			"my" => 44,
			"undef" => 62,
			'OP10_NAMED_UNARY' => 41,
			"while (" => -152,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			"if (" => 59,
			'OP03_MATH_INC_DEC' => 39,
			'OP01_NAMED_VOID_PAREN' => 58,
			"[" => 36,
			'WORD' => 56,
			"foreach my" => -152,
			'OP01_NAMED' => 53,
			"{" => 34,
			'VARIABLE_SYMBOL' => 51,
			'OP19_LOOP_CONTROL' => 50,
			'OP05_MATH_NEG' => 49,
			'OP01_NAMED_VOID' => 48,
			"for my integer" => -152,
			'OP05_LOGICAL_NEG' => 64
		},
		GOTOS => {
			'Statement' => 52,
			'OPTIONAL-50' => 42,
			'VariableModification' => 67,
			'PLUS-55' => 265,
			'LoopLabel' => 65,
			'VariableDeclaration' => 57,
			'Expression' => 37,
			'Operator' => 38,
			'Variable' => 66,
			'WordScoped' => 47,
			'PAREN-49' => 55,
			'Operation' => 266,
			'OperatorVoid' => 35,
			'Conditional' => 45
		}
	},
	{#State 237
		DEFAULT => -160,
		GOTOS => {
			'STAR-52' => 267
		}
	},
	{#State 238
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 64,
			'KEYS_OR_VALUES' => 88,
			'OP05_MATH_NEG' => 49,
			'VARIABLE_SYMBOL' => 51,
			'OP01_NAMED' => 53,
			"{" => 34,
			'WORD' => 13,
			"[" => 36,
			'OP03_MATH_INC_DEC' => 39,
			")" => -139,
			"my" => 86,
			'OP22_LOGICAL_NOT' => 61,
			"\@{" => 80,
			'LITERAL' => 60,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			"undef" => 62
		},
		GOTOS => {
			'Variable' => 81,
			'Operator' => 38,
			'Expression' => 85,
			'OPTIONAL-48' => 269,
			'ListElement' => 84,
			'TypeInner' => 83,
			'WordScoped' => 47,
			'ListElements' => 268
		}
	},
	{#State 239
		DEFAULT => -182
	},
	{#State 240
		DEFAULT => -183
	},
	{#State 241
		ACTIONS => {
			'WORD' => 270
		}
	},
	{#State 242
		ACTIONS => {
			"my" => 86,
			'LITERAL' => -30
		},
		GOTOS => {
			'OPTIONAL-10' => 272,
			'TypeInner' => 271
		}
	},
	{#State 243
		DEFAULT => -43
	},
	{#State 244
		ACTIONS => {
			";" => 273
		}
	},
	{#State 245
		DEFAULT => -27
	},
	{#State 246
		ACTIONS => {
			"use" => 21,
			"our %properties = (" => -66,
			"use constant" => -66
		},
		GOTOS => {
			'Include' => 275,
			'STAR-27' => 274
		}
	},
	{#State 247
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP17_LIST_RANGE' => 92,
			'OP13_BITWISE_AND' => 100,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP21_LIST_COMMA' => -194,
			'OP08_MATH_ADD_SUB' => 101,
			"}" => -194,
			'OP15_LOGICAL_AND' => 93,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => 94,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96
		}
	},
	{#State 248
		DEFAULT => -133
	},
	{#State 249
		DEFAULT => -184
	},
	{#State 250
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 276
		}
	},
	{#State 251
		DEFAULT => -191
	},
	{#State 252
		DEFAULT => -114
	},
	{#State 253
		DEFAULT => -101
	},
	{#State 254
		ACTIONS => {
			'OP15_LOGICAL_AND' => 93,
			'OP23_LOGICAL_AND' => 94,
			'OP04_MATH_POW' => 103,
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => 104,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP06_REGEX_MATCH' => 105,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			".." => 277,
			'OP11_COMPARE_LT_GT' => 98,
			'OP17_LIST_RANGE' => 92,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => 91,
			'OP13_BITWISE_AND' => 100,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101
		}
	},
	{#State 255
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 39,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			"\@{" => 80,
			'LITERAL' => 60,
			"undef" => 62,
			"my" => 86,
			"{" => 34,
			'OP01_NAMED' => 53,
			'WORD' => 13,
			"[" => 36,
			'OP05_MATH_NEG' => 49,
			'VARIABLE_SYMBOL' => 51,
			'OP05_LOGICAL_NEG' => 64,
			'KEYS_OR_VALUES' => 88
		},
		GOTOS => {
			'WordScoped' => 47,
			'ListElements' => 278,
			'Operator' => 38,
			'Variable' => 81,
			'Expression' => 85,
			'ListElement' => 84,
			'TypeInner' => 83
		}
	},
	{#State 256
		DEFAULT => -170
	},
	{#State 257
		ACTIONS => {
			'OP23_LOGICAL_AND' => 94,
			'OP04_MATH_POW' => 103,
			'OP15_LOGICAL_AND' => 93,
			'OP12_COMPARE_EQ_NEQ' => 96,
			";" => 279,
			'OP06_REGEX_MATCH' => 105,
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => 104,
			'OP17_LIST_RANGE' => 92,
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP11_COMPARE_LT_GT' => 98,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP13_BITWISE_AND' => 100
		}
	},
	{#State 258
		DEFAULT => -177
	},
	{#State 259
		DEFAULT => -178
	},
	{#State 260
		DEFAULT => -179
	},
	{#State 261
		DEFAULT => -46
	},
	{#State 262
		ACTIONS => {
			'WORD' => 116
		},
		GOTOS => {
			'Type' => 280
		}
	},
	{#State 263
		ACTIONS => {
			'VARIABLE_SYMBOL' => 51,
			'OP19_LOOP_CONTROL' => 50,
			'OP05_MATH_NEG' => 49,
			'OP01_NAMED_VOID' => 48,
			"for my integer" => -152,
			'OP05_LOGICAL_NEG' => 64,
			"my" => 44,
			"undef" => 62,
			"while (" => -152,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			'LITERAL' => 60,
			"(" => 40,
			"if (" => 59,
			'OP03_MATH_INC_DEC' => 39,
			'OP01_NAMED_VOID_PAREN' => 58,
			"[" => 36,
			'WORD' => 56,
			"foreach my" => -152,
			'OP01_NAMED' => 53,
			"{" => 34
		},
		GOTOS => {
			'Statement' => 52,
			'OPTIONAL-50' => 42,
			'VariableModification' => 67,
			'Operator' => 38,
			'Variable' => 66,
			'Expression' => 37,
			'VariableDeclaration' => 57,
			'LoopLabel' => 65,
			'WordScoped' => 47,
			'PLUS-19' => 281,
			'PAREN-49' => 55,
			'Operation' => 282,
			'OperatorVoid' => 35,
			'Conditional' => 45
		}
	},
	{#State 264
		DEFAULT => -127
	},
	{#State 265
		ACTIONS => {
			"my" => 44,
			"undef" => 62,
			'OP22_LOGICAL_NOT' => 61,
			"while (" => -152,
			'OP10_NAMED_UNARY' => 41,
			'LITERAL' => 60,
			"(" => 40,
			"if (" => 59,
			'OP03_MATH_INC_DEC' => 39,
			'OP01_NAMED_VOID_PAREN' => 58,
			'WORD' => 56,
			"[" => 36,
			"foreach my" => -152,
			'OP01_NAMED' => 53,
			"{" => 34,
			'VARIABLE_SYMBOL' => 51,
			'OP19_LOOP_CONTROL' => 50,
			'OP05_MATH_NEG' => 49,
			'OP01_NAMED_VOID' => 48,
			"}" => 283,
			"for my integer" => -152,
			'OP05_LOGICAL_NEG' => 64
		},
		GOTOS => {
			'OPTIONAL-50' => 42,
			'Statement' => 52,
			'Operator' => 38,
			'Variable' => 66,
			'Expression' => 37,
			'LoopLabel' => 65,
			'VariableDeclaration' => 57,
			'VariableModification' => 67,
			'Operation' => 284,
			'PAREN-49' => 55,
			'WordScoped' => 47,
			'Conditional' => 45,
			'OperatorVoid' => 35
		}
	},
	{#State 266
		DEFAULT => -172
	},
	{#State 267
		ACTIONS => {
			'OP01_NAMED' => -163,
			"{" => -163,
			"[" => -163,
			'WORD' => -163,
			'' => -163,
			"foreach my" => -163,
			"elsif (" => 287,
			'OP03_MATH_INC_DEC' => -163,
			"if (" => -163,
			'OP01_NAMED_VOID_PAREN' => -163,
			"my" => -163,
			"(" => -163,
			"while (" => -163,
			'OP22_LOGICAL_NOT' => -163,
			'OP10_NAMED_UNARY' => -163,
			'LITERAL' => -163,
			"else" => 288,
			"undef" => -163,
			"for my integer" => -163,
			'OP05_LOGICAL_NEG' => -163,
			'OP01_NAMED_VOID' => -163,
			"}" => -163,
			"};" => -163,
			'OP05_MATH_NEG' => -163,
			'OP19_LOOP_CONTROL' => -163,
			'VARIABLE_SYMBOL' => -163
		},
		GOTOS => {
			'PAREN-51' => 289,
			'OPTIONAL-54' => 285,
			'PAREN-53' => 286
		}
	},
	{#State 268
		DEFAULT => -138
	},
	{#State 269
		ACTIONS => {
			")" => 290
		}
	},
	{#State 270
		ACTIONS => {
			'OP20_HASH_FATARROW' => 291
		}
	},
	{#State 271
		DEFAULT => -29
	},
	{#State 272
		ACTIONS => {
			'LITERAL' => 292
		}
	},
	{#State 273
		DEFAULT => -28
	},
	{#State 274
		ACTIONS => {
			"our %properties = (" => 293,
			"use constant" => 27
		},
		GOTOS => {
			'Constant' => 294,
			'Properties' => 295
		}
	},
	{#State 275
		DEFAULT => -63
	},
	{#State 276
		DEFAULT => -203
	},
	{#State 277
		ACTIONS => {
			'WORD' => 13,
			"[" => 36,
			'OP01_NAMED' => 53,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			'LITERAL' => 60,
			"(" => 40,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 296,
			'Variable' => 81,
			'Operator' => 38
		}
	},
	{#State 278
		ACTIONS => {
			")" => 297
		}
	},
	{#State 279
		DEFAULT => -181
	},
	{#State 280
		ACTIONS => {
			'VARIABLE_SYMBOL' => 298
		}
	},
	{#State 281
		ACTIONS => {
			'OP01_NAMED' => 53,
			"{" => 34,
			"[" => 36,
			'WORD' => 56,
			"foreach my" => -152,
			'OP03_MATH_INC_DEC' => 39,
			"if (" => 59,
			'OP01_NAMED_VOID_PAREN' => 58,
			"my" => 44,
			'LITERAL' => 60,
			"while (" => -152,
			'OP10_NAMED_UNARY' => 41,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			"undef" => 62,
			"for my integer" => -152,
			'OP05_LOGICAL_NEG' => 64,
			'OP01_NAMED_VOID' => 48,
			"};" => 299,
			'OP05_MATH_NEG' => 49,
			'OP19_LOOP_CONTROL' => 50,
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Conditional' => 45,
			'OperatorVoid' => 35,
			'Operation' => 300,
			'PAREN-49' => 55,
			'WordScoped' => 47,
			'LoopLabel' => 65,
			'Expression' => 37,
			'VariableDeclaration' => 57,
			'Operator' => 38,
			'Variable' => 66,
			'VariableModification' => 67,
			'OPTIONAL-50' => 42,
			'Statement' => 52
		}
	},
	{#State 282
		DEFAULT => -49
	},
	{#State 283
		DEFAULT => -173
	},
	{#State 284
		DEFAULT => -171
	},
	{#State 285
		DEFAULT => -164
	},
	{#State 286
		DEFAULT => -162
	},
	{#State 287
		ACTIONS => {
			'OP05_MATH_NEG' => 49,
			'OP03_MATH_INC_DEC' => 39,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'OP01_NAMED' => 53,
			"[" => 36,
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 47,
			'Variable' => 81,
			'Operator' => 38,
			'Expression' => 301
		}
	},
	{#State 288
		ACTIONS => {
			"{" => 236
		},
		GOTOS => {
			'CodeBlock' => 302
		}
	},
	{#State 289
		DEFAULT => -159
	},
	{#State 290
		DEFAULT => -148
	},
	{#State 291
		ACTIONS => {
			'LITERAL' => -37,
			"my" => 86
		},
		GOTOS => {
			'TypeInner' => 304,
			'OPTIONAL-14' => 303
		}
	},
	{#State 292
		DEFAULT => -35,
		GOTOS => {
			'STAR-13' => 305
		}
	},
	{#State 293
		ACTIONS => {
			")" => 306,
			"%{" => 308,
			'WORD' => 307
		},
		GOTOS => {
			'HashEntryTyped' => 309
		}
	},
	{#State 294
		DEFAULT => -65
	},
	{#State 295
		DEFAULT => -68,
		GOTOS => {
			'STAR-28' => 310
		}
	},
	{#State 296
		ACTIONS => {
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP06_REGEX_MATCH' => 105,
			'OP15_LOGICAL_AND' => 93,
			")" => 311,
			'OP23_LOGICAL_AND' => 94,
			'OP04_MATH_POW' => 103,
			'OP13_BITWISE_AND' => 100,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP11_COMPARE_LT_GT' => 98,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => 91,
			'OP17_LIST_RANGE' => 92
		}
	},
	{#State 297
		ACTIONS => {
			"{" => 236
		},
		GOTOS => {
			'CodeBlock' => 312
		}
	},
	{#State 298
		DEFAULT => -53,
		GOTOS => {
			'STAR-21' => 313
		}
	},
	{#State 299
		DEFAULT => -50
	},
	{#State 300
		DEFAULT => -48
	},
	{#State 301
		ACTIONS => {
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP17_LIST_RANGE' => 92,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP11_COMPARE_LT_GT' => 98,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP13_BITWISE_AND' => 100,
			'OP23_LOGICAL_AND' => 94,
			'OP04_MATH_POW' => 103,
			'OP15_LOGICAL_AND' => 93,
			")" => 314,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP06_REGEX_MATCH' => 105,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95
		}
	},
	{#State 302
		DEFAULT => -161
	},
	{#State 303
		ACTIONS => {
			'LITERAL' => 315
		}
	},
	{#State 304
		DEFAULT => -36
	},
	{#State 305
		ACTIONS => {
			'OP21_LIST_COMMA' => 316,
			"]" => 318
		},
		GOTOS => {
			'PAREN-12' => 317
		}
	},
	{#State 306
		ACTIONS => {
			";" => 319
		}
	},
	{#State 307
		ACTIONS => {
			'OP20_HASH_FATARROW' => 320
		}
	},
	{#State 308
		ACTIONS => {
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'Variable' => 321
		}
	},
	{#State 309
		DEFAULT => -77,
		GOTOS => {
			'STAR-33' => 322
		}
	},
	{#State 310
		ACTIONS => {
			"1;" => 325,
			"our" => 324
		},
		GOTOS => {
			'Method' => 323
		}
	},
	{#State 311
		ACTIONS => {
			"{" => 236
		},
		GOTOS => {
			'CodeBlock' => 326
		}
	},
	{#State 312
		DEFAULT => -169
	},
	{#State 313
		ACTIONS => {
			")" => 329,
			'OP21_LIST_COMMA' => 327
		},
		GOTOS => {
			'PAREN-20' => 328
		}
	},
	{#State 314
		ACTIONS => {
			"{" => 236
		},
		GOTOS => {
			'CodeBlock' => 330
		}
	},
	{#State 315
		DEFAULT => -42,
		GOTOS => {
			'STAR-17' => 331
		}
	},
	{#State 316
		ACTIONS => {
			'LITERAL' => -32,
			"my" => 86
		},
		GOTOS => {
			'OPTIONAL-11' => 333,
			'TypeInner' => 332
		}
	},
	{#State 317
		DEFAULT => -34
	},
	{#State 318
		DEFAULT => -44
	},
	{#State 319
		DEFAULT => -79
	},
	{#State 320
		ACTIONS => {
			"my" => 86
		},
		GOTOS => {
			'TypeInner' => 334
		}
	},
	{#State 321
		ACTIONS => {
			"}" => 335
		}
	},
	{#State 322
		ACTIONS => {
			")" => 338,
			'OP21_LIST_COMMA' => 336
		},
		GOTOS => {
			'PAREN-32' => 337
		}
	},
	{#State 323
		DEFAULT => -67
	},
	{#State 324
		ACTIONS => {
			'WORD' => 116
		},
		GOTOS => {
			'Type' => 339
		}
	},
	{#State 325
		ACTIONS => {
			"our" => 54,
			"package" => -73,
			'' => -73
		},
		GOTOS => {
			'PAREN-30' => 342,
			'Subroutine' => 343,
			'PLUS-29' => 341,
			'OPTIONAL-31' => 340
		}
	},
	{#State 326
		DEFAULT => -168
	},
	{#State 327
		ACTIONS => {
			"my" => 344
		}
	},
	{#State 328
		DEFAULT => -52
	},
	{#State 329
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 345
		}
	},
	{#State 330
		DEFAULT => -158
	},
	{#State 331
		ACTIONS => {
			'OP21_LIST_COMMA' => 347,
			"}" => 346
		},
		GOTOS => {
			'PAREN-16' => 348
		}
	},
	{#State 332
		DEFAULT => -31
	},
	{#State 333
		ACTIONS => {
			'LITERAL' => 349
		}
	},
	{#State 334
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51,
			'LITERAL' => 60,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			'OP01_NAMED' => 53,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			"[" => 36,
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 350,
			'Variable' => 81,
			'Operator' => 38
		}
	},
	{#State 335
		DEFAULT => -197
	},
	{#State 336
		ACTIONS => {
			'WORD' => 307,
			"%{" => 308
		},
		GOTOS => {
			'HashEntryTyped' => 351
		}
	},
	{#State 337
		DEFAULT => -76
	},
	{#State 338
		ACTIONS => {
			";" => 352
		}
	},
	{#State 339
		ACTIONS => {
			'VARIABLE_SYMBOL' => 353
		}
	},
	{#State 340
		DEFAULT => -74
	},
	{#State 341
		ACTIONS => {
			"our" => 54,
			"1;" => 355
		},
		GOTOS => {
			'Subroutine' => 354
		}
	},
	{#State 342
		DEFAULT => -72
	},
	{#State 343
		DEFAULT => -70
	},
	{#State 344
		ACTIONS => {
			'WORD' => 116
		},
		GOTOS => {
			'Type' => 356
		}
	},
	{#State 345
		ACTIONS => {
			"\@_;" => 357
		}
	},
	{#State 346
		DEFAULT => -45
	},
	{#State 347
		ACTIONS => {
			'WORD' => 358
		}
	},
	{#State 348
		DEFAULT => -41
	},
	{#State 349
		DEFAULT => -33
	},
	{#State 350
		ACTIONS => {
			'OP15_LOGICAL_AND' => 93,
			")" => -196,
			'OP23_LOGICAL_AND' => 94,
			'OP04_MATH_POW' => 103,
			'OP08_STRING_CAT' => 95,
			'OP16_LOGICAL_OR' => 104,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP06_REGEX_MATCH' => 105,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP11_COMPARE_LT_GT' => 98,
			'OP17_LIST_RANGE' => 92,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => 91,
			'OP13_BITWISE_AND' => 100,
			'OP21_LIST_COMMA' => -196,
			'OP08_MATH_ADD_SUB' => 101,
			'OP14_BITWISE_OR_XOR' => 102
		}
	},
	{#State 351
		DEFAULT => -75
	},
	{#State 352
		DEFAULT => -78
	},
	{#State 353
		ACTIONS => {
			"= sub {" => 359
		}
	},
	{#State 354
		DEFAULT => -69
	},
	{#State 355
		DEFAULT => -71
	},
	{#State 356
		ACTIONS => {
			'VARIABLE_SYMBOL' => 360
		}
	},
	{#State 357
		DEFAULT => -55,
		GOTOS => {
			'STAR-22' => 361
		}
	},
	{#State 358
		ACTIONS => {
			'OP20_HASH_FATARROW' => 362
		}
	},
	{#State 359
		ACTIONS => {
			'OP01_NAMED' => -81,
			"{" => -81,
			'WORD' => -81,
			"[" => -81,
			"foreach my" => -81,
			"if (" => -81,
			'OP03_MATH_INC_DEC' => -81,
			'OP01_NAMED_VOID_PAREN' => -81,
			"my" => -81,
			"undef" => -81,
			'LITERAL' => -81,
			"(" => -81,
			'OP10_NAMED_UNARY' => -81,
			"while (" => -81,
			'OP22_LOGICAL_NOT' => -81,
			"for my integer" => -81,
			'OP05_LOGICAL_NEG' => -81,
			'OP01_NAMED_VOID' => -81,
			'OP19_LOOP_CONTROL' => -81,
			"( my" => 363,
			'OP05_MATH_NEG' => -81,
			'VARIABLE_SYMBOL' => -81
		},
		GOTOS => {
			'OPTIONAL-34' => 364,
			'MethodArguments' => 365
		}
	},
	{#State 360
		DEFAULT => -51
	},
	{#State 361
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -56,
			"for my integer" => -56,
			'OP01_NAMED_VOID' => -56,
			'OP19_LOOP_CONTROL' => -56,
			'OP05_MATH_NEG' => -56,
			'VARIABLE_SYMBOL' => -56,
			"{" => -56,
			'OP01_NAMED' => -56,
			"foreach my" => -56,
			'WORD' => -56,
			"[" => -56,
			'OP01_NAMED_VOID_PAREN' => -56,
			"if (" => -56,
			'OP03_MATH_INC_DEC' => -56,
			"::" => 366,
			"undef" => -56,
			'OP10_NAMED_UNARY' => -56,
			"(" => -56,
			'OP22_LOGICAL_NOT' => -56,
			"while (" => -56,
			'LITERAL' => -56,
			"my" => -56
		},
		GOTOS => {
			'ArgumentCheck' => 367
		}
	},
	{#State 362
		ACTIONS => {
			"my" => 86,
			'LITERAL' => -39
		},
		GOTOS => {
			'OPTIONAL-15' => 368,
			'TypeInner' => 369
		}
	},
	{#State 363
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 370
		}
	},
	{#State 364
		ACTIONS => {
			"[" => 36,
			'WORD' => 56,
			"foreach my" => -152,
			'OP01_NAMED' => 53,
			"{" => 34,
			"my" => 44,
			"while (" => -152,
			'OP22_LOGICAL_NOT' => 61,
			'LITERAL' => 60,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			"undef" => 62,
			'OP03_MATH_INC_DEC' => 39,
			"if (" => 59,
			'OP01_NAMED_VOID_PAREN' => 58,
			'OP01_NAMED_VOID' => 48,
			"for my integer" => -152,
			'OP05_LOGICAL_NEG' => 64,
			'VARIABLE_SYMBOL' => 51,
			'OP05_MATH_NEG' => 49,
			'OP19_LOOP_CONTROL' => 50
		},
		GOTOS => {
			'OperatorVoid' => 35,
			'Conditional' => 45,
			'WordScoped' => 47,
			'Operation' => 371,
			'PAREN-49' => 55,
			'VariableModification' => 67,
			'PLUS-35' => 372,
			'VariableDeclaration' => 57,
			'Expression' => 37,
			'LoopLabel' => 65,
			'Operator' => 38,
			'Variable' => 66,
			'Statement' => 52,
			'OPTIONAL-50' => 42
		}
	},
	{#State 365
		DEFAULT => -80
	},
	{#State 366
		ACTIONS => {
			'CHECK_OR_CHECKTRACE' => 373
		}
	},
	{#State 367
		DEFAULT => -54
	},
	{#State 368
		ACTIONS => {
			'LITERAL' => 374
		}
	},
	{#State 369
		DEFAULT => -38
	},
	{#State 370
		DEFAULT => -87,
		GOTOS => {
			'STAR-37' => 375
		}
	},
	{#State 371
		DEFAULT => -83
	},
	{#State 372
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => 58,
			"if (" => 59,
			'OP03_MATH_INC_DEC' => 39,
			"undef" => 62,
			"(" => 40,
			"while (" => -152,
			'OP22_LOGICAL_NOT' => 61,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			"my" => 44,
			"{" => 34,
			'OP01_NAMED' => 53,
			"foreach my" => -152,
			"[" => 36,
			'WORD' => 56,
			'OP19_LOOP_CONTROL' => 50,
			'OP05_MATH_NEG' => 49,
			"};" => 376,
			'VARIABLE_SYMBOL' => 51,
			'OP05_LOGICAL_NEG' => 64,
			"for my integer" => -152,
			'OP01_NAMED_VOID' => 48
		},
		GOTOS => {
			'OPTIONAL-50' => 42,
			'Statement' => 52,
			'Variable' => 66,
			'Operator' => 38,
			'VariableDeclaration' => 57,
			'Expression' => 37,
			'LoopLabel' => 65,
			'VariableModification' => 67,
			'PAREN-49' => 55,
			'Operation' => 377,
			'WordScoped' => 47,
			'Conditional' => 45,
			'OperatorVoid' => 35
		}
	},
	{#State 373
		ACTIONS => {
			"(" => 378
		}
	},
	{#State 374
		DEFAULT => -40
	},
	{#State 375
		ACTIONS => {
			'OP21_LIST_COMMA' => 381,
			")" => 380
		},
		GOTOS => {
			'PAREN-36' => 379
		}
	},
	{#State 376
		DEFAULT => -84
	},
	{#State 377
		DEFAULT => -82
	},
	{#State 378
		ACTIONS => {
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			'LITERAL' => 60,
			'OP22_LOGICAL_NOT' => 61,
			"(" => 40,
			'OP10_NAMED_UNARY' => 41,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			'WORD' => 13,
			"[" => 36,
			'OP01_NAMED' => 53,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64
		},
		GOTOS => {
			'Operator' => 38,
			'Variable' => 81,
			'Expression' => 382,
			'WordScoped' => 47
		}
	},
	{#State 379
		DEFAULT => -86
	},
	{#State 380
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 383
		}
	},
	{#State 381
		ACTIONS => {
			"my" => 384
		}
	},
	{#State 382
		ACTIONS => {
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => 94,
			")" => -59,
			'OP15_LOGICAL_AND' => 93,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP21_LIST_COMMA' => 386,
			'OP13_BITWISE_AND' => 100,
			'OP09_BITWISE_SHIFT' => 99,
			'OP18_TERNARY' => 91,
			'OP17_LIST_RANGE' => 92,
			'OP11_COMPARE_LT_GT' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90
		},
		GOTOS => {
			'PAREN-23' => 387,
			'OPTIONAL-24' => 385
		}
	},
	{#State 383
		ACTIONS => {
			"\@_;" => 388
		}
	},
	{#State 384
		ACTIONS => {
			'WORD' => 116
		},
		GOTOS => {
			'Type' => 389
		}
	},
	{#State 385
		ACTIONS => {
			")" => 390
		}
	},
	{#State 386
		ACTIONS => {
			'WORD' => 13,
			"[" => 36,
			'OP01_NAMED' => 53,
			"{" => 34,
			'OP05_LOGICAL_NEG' => 64,
			'VARIABLE_SYMBOL' => 51,
			"undef" => 62,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 61,
			'OP10_NAMED_UNARY' => 41,
			'LITERAL' => 60,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49
		},
		GOTOS => {
			'Expression' => 391,
			'Operator' => 38,
			'Variable' => 81,
			'WordScoped' => 47
		}
	},
	{#State 387
		DEFAULT => -58
	},
	{#State 388
		DEFAULT => -89,
		GOTOS => {
			'STAR-38' => 392
		}
	},
	{#State 389
		ACTIONS => {
			'VARIABLE_SYMBOL' => 393
		}
	},
	{#State 390
		ACTIONS => {
			";" => 394
		}
	},
	{#State 391
		ACTIONS => {
			'OP04_MATH_POW' => 103,
			'OP23_LOGICAL_AND' => 94,
			'OP15_LOGICAL_AND' => 93,
			'OP06_REGEX_MATCH' => 105,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP17_LIST_RANGE' => 92,
			'OP11_COMPARE_LT_GT' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP21_LIST_COMMA' => 395,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP13_BITWISE_AND' => 100
		}
	},
	{#State 392
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -90,
			"for my integer" => -90,
			'OP01_NAMED_VOID' => -90,
			'OP19_LOOP_CONTROL' => -90,
			'OP05_MATH_NEG' => -90,
			'VARIABLE_SYMBOL' => -90,
			"{" => -90,
			'OP01_NAMED' => -90,
			"foreach my" => -90,
			'WORD' => -90,
			"[" => -90,
			'OP01_NAMED_VOID_PAREN' => -90,
			"if (" => -90,
			'OP03_MATH_INC_DEC' => -90,
			"undef" => -90,
			"::" => 366,
			"(" => -90,
			"while (" => -90,
			'OP22_LOGICAL_NOT' => -90,
			'OP10_NAMED_UNARY' => -90,
			'LITERAL' => -90,
			"my" => -90
		},
		GOTOS => {
			'ArgumentCheck' => 396
		}
	},
	{#State 393
		DEFAULT => -85
	},
	{#State 394
		DEFAULT => -60
	},
	{#State 395
		ACTIONS => {
			'OP01_NAMED' => 53,
			'OP05_LOGICAL_NEG' => 64,
			"{" => 34,
			'WORD' => 13,
			"[" => 36,
			'OP03_MATH_INC_DEC' => 39,
			'OP05_MATH_NEG' => 49,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 41,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 61,
			"undef" => 62,
			'VARIABLE_SYMBOL' => 51
		},
		GOTOS => {
			'WordScoped' => 47,
			'Expression' => 397,
			'Variable' => 81,
			'Operator' => 38
		}
	},
	{#State 396
		DEFAULT => -88
	},
	{#State 397
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 89,
			'OP24_LOGICAL_OR_XOR' => 90,
			'OP11_COMPARE_LT_GT' => 98,
			'OP18_TERNARY' => 91,
			'OP09_BITWISE_SHIFT' => 99,
			'OP17_LIST_RANGE' => 92,
			'OP13_BITWISE_AND' => 100,
			'OP14_BITWISE_OR_XOR' => 102,
			'OP08_MATH_ADD_SUB' => 101,
			'OP15_LOGICAL_AND' => 93,
			")" => -57,
			'OP23_LOGICAL_AND' => 94,
			'OP04_MATH_POW' => 103,
			'OP16_LOGICAL_OR' => 104,
			'OP08_STRING_CAT' => 95,
			'OP12_COMPARE_EQ_NEQ' => 96,
			'OP06_REGEX_MATCH' => 105
		}
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 4767 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 102 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4774 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 102 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4781 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4792 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4803 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4810 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4817 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4824 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4831 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4838 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4845 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-5', 2,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4852 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-5', 1,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4859 lib/RPerl/Grammar.pm
	],
	[#Rule Program_13
		 'Program', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4870 lib/RPerl/Grammar.pm
	],
	[#Rule Module_14
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4881 lib/RPerl/Grammar.pm
	],
	[#Rule Module_15
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4892 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 105 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4899 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 105 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4906 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 105 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4913 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 105 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4920 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 105 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4927 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 105 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4934 lib/RPerl/Grammar.pm
	],
	[#Rule Package_22
		 'Package', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4945 lib/RPerl/Grammar.pm
	],
	[#Rule Header_23
		 'Header', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4956 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-9', 2,
sub {
#line 107 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4963 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-9', 1,
sub {
#line 107 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4970 lib/RPerl/Grammar.pm
	],
	[#Rule Include_26
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4981 lib/RPerl/Grammar.pm
	],
	[#Rule Include_27
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 4992 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_28
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5003 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5010 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5017 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-11', 1,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5024 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-11', 0,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5031 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-12', 3,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5038 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5045 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5052 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5059 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5066 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5073 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5080 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-16', 5,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5087 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5094 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5101 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_43
		 'ConstantValue', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5112 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_44
		 'ConstantValue', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5123 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_45
		 'ConstantValue', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5134 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5141 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5148 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-19', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5155 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-19', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5162 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_50
		 'Subroutine', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5173 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 4,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5180 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5187 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5194 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5208 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_56
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5219 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5226 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5233 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5240 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_60
		 'ArgumentCheck', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5251 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-25', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5258 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-25', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5265 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5272 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5279 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5286 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5293 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5300 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5307 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-29', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5314 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-29', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5321 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5328 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5335 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5342 lib/RPerl/Grammar.pm
	],
	[#Rule Class_74
		 'Class', 14,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5353 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5360 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5367 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5374 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_78
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5385 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_79
		 'Properties', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5396 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5403 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5410 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-35', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5417 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-35', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5424 lib/RPerl/Grammar.pm
	],
	[#Rule Method_84
		 'Method', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5435 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 4,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5442 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5449 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5456 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5463 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5470 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_90
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5481 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_91
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5492 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_92
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5503 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5510 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5517 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5528 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5539 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5550 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5561 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5572 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5583 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5594 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5605 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5616 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5627 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5638 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5649 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5660 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5671 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5682 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5693 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5704 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5715 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5726 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5737 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5748 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5759 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5770 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5777 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5784 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5791 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5798 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5805 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5812 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5819 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5826 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_126
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5837 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_127
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_128
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5859 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_129
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_130
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5881 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5888 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5895 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5902 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5909 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5923 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5930 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5937 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5944 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_140
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5955 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_141
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5966 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_142
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5977 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5988 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6010 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6021 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6032 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6043 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6061 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6068 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6075 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6086 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6097 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6108 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_156
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6119 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_157
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6130 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6137 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6144 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6151 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6172 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_164
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6183 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6194 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_166
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6205 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_167
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6216 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_168
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6227 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_169
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6238 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6256 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6263 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_173
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6274 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6281 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6288 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_176
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6299 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6310 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6321 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6332 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6343 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6354 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6365 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6376 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6383 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6390 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6397 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_187
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6408 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6419 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_189
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6430 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6441 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6452 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6459 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6466 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_194
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6477 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_195
		 'HashEntry', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_196
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_197
		 'HashEntryTyped', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6510 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-60', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6517 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6524 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6531 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_201
		 'WordScoped', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6542 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_202
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6553 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_203
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6564 lib/RPerl/Grammar.pm
	],
	[#Rule Type_204
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6575 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_205
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6586 lib/RPerl/Grammar.pm
	]
],
#line 6589 lib/RPerl/Grammar.pm
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
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Program_13', 
         'Module_14', 
         'Module_15', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Package_22', 
         'Header_23', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Include_26', 
         'Include_27', 
         'Constant_28', 
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
         'ConstantValue_43', 
         'ConstantValue_44', 
         'ConstantValue_45', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Subroutine_50', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_56', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArgumentCheck_60', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
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
         'Class_74', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_78', 
         'Properties_79', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Method_84', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_90', 
         'Operation_91', 
         'Operation_92', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Operator_95', 
         'Operator_96', 
         'Operator_97', 
         'Operator_98', 
         'Operator_99', 
         'Operator_100', 
         'Operator_101', 
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_126', 
         'OperatorVoid_127', 
         'OperatorVoid_128', 
         'OperatorVoid_129', 
         'OperatorVoid_130', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_140', 
         'Expression_141', 
         'Expression_142', 
         'Expression_143', 
         'Expression_144', 
         'Expression_145', 
         'Expression_146', 
         'Expression_147', 
         'Expression_148', 
         'Expression_149', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_153', 
         'Statement_154', 
         'Statement_155', 
         'Statement_156', 
         'Statement_157', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_164', 
         'Loop_165', 
         'Loop_166', 
         'Loop_167', 
         'LoopFor_168', 
         'LoopForEach_169', 
         'LoopWhile_170', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_173', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_176', 
         'VariableRetrieval_177', 
         'VariableRetrieval_178', 
         'VariableRetrieval_179', 
         'VariableDeclaration_180', 
         'VariableDeclaration_181', 
         'VariableModification_182', 
         'VariableModification_183', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_187', 
         'ListElement_188', 
         'ListElement_189', 
         'ListElement_190', 
         'ListElement_191', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_194', 
         'HashEntry_195', 
         'HashEntryTyped_196', 
         'HashEntryTyped_197', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'WordScoped_201', 
         'FileHandle_202', 
         'TypeInner_203', 
         'Type_204', 
         'LoopLabel_205', );
  $self;
}

#line 158 "lib/RPerl/Grammar.eyp"


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


#line 6842 lib/RPerl/Grammar.pm



1;
