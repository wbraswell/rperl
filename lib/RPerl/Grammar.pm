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
    our $VERSION = 0.000_600;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G(\s*(\#.+)*\s*)+/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|for\ my\ integer|use\ parent\ qw\(|our\ \$VERSION\ \=|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|use\ Carp\;|\$TYPED_|\=\ sub\ \{|while\ \(|package|elsif\ \(|undef|\(\ my|1\;1\;|if\ \(|else|use|qw\(|\@_\;|our|my|\@\{|\%\{|\{\*|\.\.|\:\:|\/|\(|\]|\)|\{|\:|\;|\[|\})}gc and return ($1, $1);

      /\G(^(\#\!\/[\w\/]*\/perl)$)/gc and return ('SHEBANG', $1);
      /\G(\d+\.\d{3}\_\d{3})/gc and return ('VERSION_NUMBER', $1);
      /\G((-?\d+(\.\d+)?)|('[^']*')|("[^"]*"))/gc and return ('LITERAL', $1);
      /\G(\$[a-zA-Z]\w*(::)*\w*)/gc and return ('VARIABLE_SYMBOL', $1);
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
      /\G(scalar)/gc and return ('OP10_NAMED_UNARY', $1);
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
  [ 'Package_22' => 'Package', [ 'package', 'WordScoped', ';', 'Header', 'STAR-6', 'STAR-7', 'PLUS-8', '1;1;' ], 0 ],
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
  [ 'Subroutine_50' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-18', 'PLUS-19', '}', ';' ], 0 ],
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
  [ '_PAREN' => 'PAREN-30', [ 'PLUS-29', '1;1;' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [ 'PAREN-30' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [  ], 0 ],
  [ 'Class_74' => 'Class', [ 'package', 'WordScoped', ';', 'Header', 'use parent qw(', 'PLUS-25', ')', ';', 'STAR-26', 'STAR-27', 'Properties', 'STAR-28', '1;1;', 'OPTIONAL-31' ], 0 ],
  [ '_PAREN' => 'PAREN-32', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [ 'STAR-33', 'PAREN-32' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [  ], 0 ],
  [ 'Properties_78' => 'Properties', [ 'our %properties = (', 'HashEntryTyped', 'STAR-33', ')', ';' ], 0 ],
  [ 'Properties_79' => 'Properties', [ 'our %properties = (', ')', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-35', [ 'PLUS-35', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-35', [ 'Operation' ], 0 ],
  [ 'Method_84' => 'Method', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-34', 'PLUS-35', '}', ';' ], 0 ],
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
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'Expression_135' => 'Expression', [ 'undef' ], 0 ],
  [ 'Expression_136' => 'Expression', [ 'LITERAL' ], 0 ],
  [ 'Expression_137' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_138' => 'Expression', [ 'ArrayReference' ], 0 ],
  [ 'Expression_139' => 'Expression', [ 'ArrayDereferenced' ], 0 ],
  [ 'Expression_140' => 'Expression', [ 'HashReference' ], 0 ],
  [ 'Expression_141' => 'Expression', [ 'HashDereferenced' ], 0 ],
  [ 'Expression_142' => 'Expression', [ '{', '}' ], 0 ],
  [ 'Expression_143' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_144' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-44', ')' ], 0 ],
  [ 'Expression_145' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-45', ')' ], 0 ],
  [ 'Expression_146' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'LoopLabel', ':' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'PAREN-46' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'Statement_150' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'OPTIONAL-47', 'Loop' ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_154' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-48', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [ 'STAR-49', 'PAREN-48' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [  ], 0 ],
  [ '_PAREN' => 'PAREN-50', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'PAREN-50' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'Conditional_161' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-49', 'OPTIONAL-51' ], 0 ],
  [ 'Loop_162' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_163' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_164' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_165' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_166' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_167' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'PLUS-52', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'Operation' ], 0 ],
  [ 'CodeBlock_170' => 'CodeBlock', [ '{', 'PLUS-52', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [ 'STAR-53', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [  ], 0 ],
  [ 'Variable_173' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-53' ], 0 ],
  [ 'VariableRetrieval_174' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_175' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_176' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_177' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_178' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_179' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_180' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-54', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-55', [ 'STAR-55', 'PAREN-54' ], 0 ],
  [ '_STAR_LIST' => 'STAR-55', [  ], 0 ],
  [ 'ListElements_184' => 'ListElements', [ 'ListElement', 'STAR-55' ], 0 ],
  [ 'ListElement_185' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_186' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_187' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [  ], 0 ],
  [ 'ArrayReference_190' => 'ArrayReference', [ '[', 'OPTIONAL-56', ']' ], 0 ],
  [ 'ArrayDereferenced_191' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_192' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [  ], 0 ],
  [ 'HashEntry_195' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-57', 'Expression' ], 0 ],
  [ 'HashEntry_196' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_197' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_198' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-58', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [ 'STAR-59', 'PAREN-58' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [  ], 0 ],
  [ 'HashReference_202' => 'HashReference', [ '{', 'HashEntry', 'STAR-59', '}' ], 0 ],
  [ 'HashDereferenced_203' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_204' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-60', [ '::', 'WORD' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [ 'STAR-61', 'PAREN-60' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [  ], 0 ],
  [ 'WordScoped_208' => 'WordScoped', [ 'WORD', 'STAR-61' ], 0 ],
  [ 'FileHandle_209' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'TypeInner_210' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Type_211' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_212' => 'LoopLabel', [ 'WORD' ], 0 ],
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
  '_OPTIONAL' => 133,
  '_OPTIONAL' => 134,
  'Expression_135' => 135,
  'Expression_136' => 136,
  'Expression_137' => 137,
  'Expression_138' => 138,
  'Expression_139' => 139,
  'Expression_140' => 140,
  'Expression_141' => 141,
  'Expression_142' => 142,
  'Expression_143' => 143,
  'Expression_144' => 144,
  'Expression_145' => 145,
  'Expression_146' => 146,
  '_PAREN' => 147,
  '_OPTIONAL' => 148,
  '_OPTIONAL' => 149,
  'Statement_150' => 150,
  'Statement_151' => 151,
  'Statement_152' => 152,
  'Statement_153' => 153,
  'Statement_154' => 154,
  '_PAREN' => 155,
  '_STAR_LIST' => 156,
  '_STAR_LIST' => 157,
  '_PAREN' => 158,
  '_OPTIONAL' => 159,
  '_OPTIONAL' => 160,
  'Conditional_161' => 161,
  'Loop_162' => 162,
  'Loop_163' => 163,
  'Loop_164' => 164,
  'LoopFor_165' => 165,
  'LoopForEach_166' => 166,
  'LoopWhile_167' => 167,
  '_PLUS_LIST' => 168,
  '_PLUS_LIST' => 169,
  'CodeBlock_170' => 170,
  '_STAR_LIST' => 171,
  '_STAR_LIST' => 172,
  'Variable_173' => 173,
  'VariableRetrieval_174' => 174,
  'VariableRetrieval_175' => 175,
  'VariableRetrieval_176' => 176,
  'VariableDeclaration_177' => 177,
  'VariableDeclaration_178' => 178,
  'VariableModification_179' => 179,
  'VariableModification_180' => 180,
  '_PAREN' => 181,
  '_STAR_LIST' => 182,
  '_STAR_LIST' => 183,
  'ListElements_184' => 184,
  'ListElement_185' => 185,
  'ListElement_186' => 186,
  'ListElement_187' => 187,
  '_OPTIONAL' => 188,
  '_OPTIONAL' => 189,
  'ArrayReference_190' => 190,
  'ArrayDereferenced_191' => 191,
  'ArrayDereferenced_192' => 192,
  '_OPTIONAL' => 193,
  '_OPTIONAL' => 194,
  'HashEntry_195' => 195,
  'HashEntry_196' => 196,
  'HashEntryTyped_197' => 197,
  'HashEntryTyped_198' => 198,
  '_PAREN' => 199,
  '_STAR_LIST' => 200,
  '_STAR_LIST' => 201,
  'HashReference_202' => 202,
  'HashDereferenced_203' => 203,
  'HashDereferenced_204' => 204,
  '_PAREN' => 205,
  '_STAR_LIST' => 206,
  '_STAR_LIST' => 207,
  'WordScoped_208' => 208,
  'FileHandle_209' => 209,
  'TypeInner_210' => 210,
  'Type_211' => 211,
  'LoopLabel_212' => 212,
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
	'1;1;' => { ISSEMANTIC => 0 },
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
			'SHEBANG' => 2,
			"package" => 3
		},
		GOTOS => {
			'PLUS-1' => 7,
			'Class' => 8,
			'CompileUnit' => 4,
			'Module' => 6,
			'Package' => 5,
			'Program' => 1
		}
	},
	{#State 1
		DEFAULT => -3
	},
	{#State 2
		ACTIONS => {
			"use strict;" => 9
		},
		GOTOS => {
			'Header' => 10
		}
	},
	{#State 3
		ACTIONS => {
			'WORD' => 12
		},
		GOTOS => {
			'WordScoped' => 11
		}
	},
	{#State 4
		ACTIONS => {
			'' => 13
		}
	},
	{#State 5
		DEFAULT => -14
	},
	{#State 6
		DEFAULT => -2
	},
	{#State 7
		ACTIONS => {
			"package" => 3,
			'' => -4
		},
		GOTOS => {
			'Class' => 8,
			'Package' => 5,
			'Module' => 14
		}
	},
	{#State 8
		DEFAULT => -15
	},
	{#State 9
		ACTIONS => {
			"use warnings;" => 15
		}
	},
	{#State 10
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 16
		}
	},
	{#State 11
		ACTIONS => {
			";" => 17
		}
	},
	{#State 12
		DEFAULT => -207,
		GOTOS => {
			'STAR-61' => 18
		}
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		DEFAULT => -1
	},
	{#State 15
		ACTIONS => {
			"our \$VERSION =" => 19
		}
	},
	{#State 16
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -8,
			"(" => -8,
			'WORD' => -8,
			"[" => -8,
			"our" => -8,
			'VARIABLE_SYMBOL' => -8,
			'OP01_NAMED_VOID' => -8,
			'OP03_MATH_INC_DEC' => -8,
			"while (" => -8,
			"if (" => -8,
			"undef" => -8,
			'OP22_LOGICAL_NOT' => -8,
			'OP01_NAMED' => -8,
			'OP05_MATH_NEG' => -8,
			"use" => 20,
			"%{" => -8,
			"foreach my" => -8,
			"my" => -8,
			"for my integer" => -8,
			"use constant" => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"{" => -8,
			'OP05_LOGICAL_NEG' => -8,
			'OP10_NAMED_UNARY' => -8,
			'LITERAL' => -8,
			"\@{" => -8
		},
		GOTOS => {
			'Include' => 22,
			'STAR-3' => 21
		}
	},
	{#State 17
		ACTIONS => {
			"use strict;" => 9
		},
		GOTOS => {
			'Header' => 23
		}
	},
	{#State 18
		ACTIONS => {
			")" => -208,
			"::" => 25,
			";" => -208,
			"qw(" => -208,
			'WORD' => -208,
			"(" => -208
		},
		GOTOS => {
			'PAREN-60' => 24
		}
	},
	{#State 19
		ACTIONS => {
			'VERSION_NUMBER' => 26
		}
	},
	{#State 20
		ACTIONS => {
			'WORD' => 12
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 21
		ACTIONS => {
			'OP01_NAMED_VOID' => -10,
			'VARIABLE_SYMBOL' => -10,
			'OP03_MATH_INC_DEC' => -10,
			"[" => -10,
			'OP19_LOOP_CONTROL' => -10,
			"(" => -10,
			'WORD' => -10,
			"our" => -10,
			"while (" => -10,
			"if (" => -10,
			"undef" => -10,
			'OP22_LOGICAL_NOT' => -10,
			"my" => -10,
			"foreach my" => -10,
			"use constant" => 28,
			"for my integer" => -10,
			'OP01_NAMED' => -10,
			'OP05_MATH_NEG' => -10,
			"%{" => -10,
			'OP10_NAMED_UNARY' => -10,
			'LITERAL' => -10,
			"\@{" => -10,
			'OP05_LOGICAL_NEG' => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"{" => -10
		},
		GOTOS => {
			'Constant' => 29,
			'STAR-4' => 30
		}
	},
	{#State 22
		DEFAULT => -5
	},
	{#State 23
		ACTIONS => {
			"our" => -17,
			"use parent qw(" => 32,
			"use" => -17,
			"use constant" => -17
		},
		GOTOS => {
			'STAR-6' => 31
		}
	},
	{#State 24
		DEFAULT => -206
	},
	{#State 25
		ACTIONS => {
			'WORD' => 33
		}
	},
	{#State 26
		ACTIONS => {
			";" => 34
		}
	},
	{#State 27
		ACTIONS => {
			";" => 35,
			"qw(" => 36
		}
	},
	{#State 28
		ACTIONS => {
			'WORD' => 37
		}
	},
	{#State 29
		DEFAULT => -7
	},
	{#State 30
		ACTIONS => {
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"%{" => 40,
			"foreach my" => -149,
			"my" => 63,
			"for my integer" => -149,
			"{" => 43,
			'OP01_NAMED_VOID_PAREN' => 44,
			'OP05_LOGICAL_NEG' => 45,
			"\@{" => 47,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"(" => 71,
			'OP19_LOOP_CONTROL' => 69,
			'WORD' => 70,
			"[" => 53,
			"our" => 50,
			'VARIABLE_SYMBOL' => 55,
			'OP01_NAMED_VOID' => 56,
			'OP03_MATH_INC_DEC' => 54,
			"while (" => -149,
			'OP22_LOGICAL_NOT' => 60,
			"if (" => 59,
			"undef" => 58
		},
		GOTOS => {
			'LoopLabel' => 72,
			'Operator' => 51,
			'ArrayReference' => 52,
			'WordScoped' => 73,
			'PLUS-5' => 57,
			'VariableDeclaration' => 74,
			'Subroutine' => 77,
			'PAREN-46' => 75,
			'Statement' => 76,
			'Operation' => 38,
			'OperatorVoid' => 39,
			'HashReference' => 61,
			'ArrayDereferenced' => 62,
			'Variable' => 66,
			'VariableModification' => 67,
			'Expression' => 68,
			'HashDereferenced' => 46,
			'OPTIONAL-47' => 64,
			'Conditional' => 65
		}
	},
	{#State 31
		ACTIONS => {
			"use constant" => -19,
			"our" => -19,
			"use" => 20
		},
		GOTOS => {
			'Include' => 79,
			'STAR-7' => 78
		}
	},
	{#State 32
		ACTIONS => {
			'WORD' => 12
		},
		GOTOS => {
			'WordScoped' => 81,
			'PLUS-25' => 80
		}
	},
	{#State 33
		DEFAULT => -205
	},
	{#State 34
		ACTIONS => {
			"use Carp;" => 82
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			'WORD' => 83
		},
		GOTOS => {
			'PLUS-9' => 84
		}
	},
	{#State 37
		ACTIONS => {
			'OP20_HASH_FATARROW' => 85
		}
	},
	{#State 38
		DEFAULT => -12
	},
	{#State 39
		DEFAULT => -152
	},
	{#State 40
		ACTIONS => {
			"{" => 86,
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'Variable' => 87,
			'HashReference' => 88
		}
	},
	{#State 41
		ACTIONS => {
			"(" => 71,
			'OP01_NAMED' => 42,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			"[" => 53,
			"%{" => 40,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			"{" => 43,
			'OP05_LOGICAL_NEG' => 45,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60
		},
		GOTOS => {
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 90,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'Operator' => 51,
			'HashReference' => 61,
			'ArrayReference' => 52
		}
	},
	{#State 42
		ACTIONS => {
			"(" => 91
		}
	},
	{#State 43
		ACTIONS => {
			'WORD' => 94,
			"%{" => 40,
			"}" => 92
		},
		GOTOS => {
			'HashEntry' => 95,
			'HashDereferenced' => 93
		}
	},
	{#State 44
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP03_MATH_INC_DEC' => 54,
			")" => -119,
			'VARIABLE_SYMBOL' => 55,
			"(" => 71,
			'WORD' => 12,
			"[" => 53,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'KEYS_OR_VALUES' => 96,
			"{" => 43,
			"{*" => 103,
			"my" => 99,
			"%{" => 40,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42
		},
		GOTOS => {
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'TypeInner' => 101,
			'OPTIONAL-40' => 104,
			'ArrayReference' => 52,
			'HashReference' => 61,
			'ListElements' => 102,
			'Operator' => 51,
			'HashDereferenced' => 46,
			'Expression' => 98,
			'FileHandle' => 97,
			'Variable' => 89,
			'ListElement' => 100
		}
	},
	{#State 45
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"%{" => 40,
			"[" => 53,
			'WORD' => 12,
			"(" => 71,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'OP05_LOGICAL_NEG' => 45,
			"{" => 43
		},
		GOTOS => {
			'Expression' => 105,
			'HashDereferenced' => 46,
			'Variable' => 89,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'ArrayReference' => 52,
			'HashReference' => 61,
			'Operator' => 51
		}
	},
	{#State 46
		DEFAULT => -141
	},
	{#State 47
		ACTIONS => {
			"[" => 53,
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'Variable' => 107,
			'ArrayReference' => 106
		}
	},
	{#State 48
		ACTIONS => {
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47,
			"{" => 43,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"%{" => 40,
			'WORD' => 12,
			"(" => 71,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"[" => 53
		},
		GOTOS => {
			'ArrayReference' => 52,
			'HashReference' => 61,
			'Operator' => 51,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'Expression' => 108,
			'HashDereferenced' => 46,
			'Variable' => 89
		}
	},
	{#State 49
		DEFAULT => -136
	},
	{#State 50
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 109
		}
	},
	{#State 51
		DEFAULT => -143
	},
	{#State 52
		DEFAULT => -138
	},
	{#State 53
		ACTIONS => {
			"my" => 99,
			"%{" => 40,
			"]" => -189,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47,
			'KEYS_OR_VALUES' => 96,
			"{" => 43,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"(" => 71,
			'WORD' => 12,
			"[" => 53,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60
		},
		GOTOS => {
			'ArrayDereferenced' => 62,
			'TypeInner' => 101,
			'WordScoped' => 73,
			'ListElements' => 112,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'OPTIONAL-56' => 111,
			'Operator' => 51,
			'ListElement' => 100,
			'HashDereferenced' => 46,
			'Expression' => 98,
			'Variable' => 89
		}
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'Variable' => 113
		}
	},
	{#State 55
		DEFAULT => -172,
		GOTOS => {
			'STAR-53' => 114
		}
	},
	{#State 56
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'KEYS_OR_VALUES' => 96,
			"{" => 43,
			"{*" => 103,
			"my" => 99,
			"%{" => 40,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			";" => -123,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			'WORD' => 12,
			"(" => 71,
			"[" => 53
		},
		GOTOS => {
			'OPTIONAL-42' => 117,
			'ListElement' => 100,
			'HashDereferenced' => 46,
			'Expression' => 98,
			'FileHandle' => 115,
			'Variable' => 89,
			'ArrayReference' => 52,
			'ListElements' => 116,
			'HashReference' => 61,
			'Operator' => 51,
			'ArrayDereferenced' => 62,
			'TypeInner' => 101,
			'WordScoped' => 73
		}
	},
	{#State 57
		ACTIONS => {
			"while (" => -149,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			"if (" => 59,
			'OP19_LOOP_CONTROL' => 69,
			"(" => 71,
			'WORD' => 70,
			"[" => 53,
			'VARIABLE_SYMBOL' => 55,
			'OP01_NAMED_VOID' => 56,
			'OP03_MATH_INC_DEC' => 54,
			"{" => 43,
			'OP01_NAMED_VOID_PAREN' => 44,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'LITERAL' => 49,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"%{" => 40,
			"foreach my" => -149,
			"my" => 63,
			'' => -13,
			"for my integer" => -149
		},
		GOTOS => {
			'ArrayDereferenced' => 62,
			'HashReference' => 61,
			'OperatorVoid' => 39,
			'Operation' => 118,
			'Conditional' => 65,
			'OPTIONAL-47' => 64,
			'Expression' => 68,
			'HashDereferenced' => 46,
			'VariableModification' => 67,
			'Variable' => 66,
			'WordScoped' => 73,
			'ArrayReference' => 52,
			'Operator' => 51,
			'LoopLabel' => 72,
			'PAREN-46' => 75,
			'Statement' => 76,
			'VariableDeclaration' => 74
		}
	},
	{#State 58
		DEFAULT => -135
	},
	{#State 59
		ACTIONS => {
			"[" => 53,
			"(" => 71,
			'WORD' => 12,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"%{" => 40,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			"{" => 43,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47,
			'OP05_LOGICAL_NEG' => 45,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60
		},
		GOTOS => {
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'Operator' => 51,
			'ArrayReference' => 52,
			'HashReference' => 61,
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 119
		}
	},
	{#State 60
		ACTIONS => {
			"[" => 53,
			"(" => 71,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			'WORD' => 12,
			"%{" => 40,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			"{" => 43,
			'LITERAL' => 49,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP05_LOGICAL_NEG' => 45,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58
		},
		GOTOS => {
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'ArrayReference' => 52,
			'HashReference' => 61,
			'Operator' => 51,
			'HashDereferenced' => 46,
			'Expression' => 120,
			'Variable' => 89
		}
	},
	{#State 61
		DEFAULT => -140
	},
	{#State 62
		DEFAULT => -139
	},
	{#State 63
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 121
		}
	},
	{#State 64
		ACTIONS => {
			"foreach my" => 124,
			"while (" => 126,
			"for my integer" => 125
		},
		GOTOS => {
			'LoopFor' => 123,
			'LoopWhile' => 127,
			'Loop' => 122,
			'LoopForEach' => 128
		}
	},
	{#State 65
		DEFAULT => -150
	},
	{#State 66
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 132,
			'OP08_STRING_CAT' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP04_MATH_POW' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP18_TERNARY' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			";" => -137,
			'OP12_COMPARE_EQ_NEQ' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP03_MATH_INC_DEC' => 129,
			'OP11_COMPARE_LT_GT' => -137,
			'OP19_VARIABLE_ASSIGN_BY' => 130,
			'OP09_BITWISE_SHIFT' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP19_VARIABLE_ASSIGN' => 131
		}
	},
	{#State 67
		DEFAULT => -154
	},
	{#State 68
		ACTIONS => {
			'OP18_TERNARY' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP13_BITWISE_AND' => 139,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 149,
			'OP23_LOGICAL_AND' => 142,
			'OP09_BITWISE_SHIFT' => 143,
			'OP17_LIST_RANGE' => 141,
			'OP11_COMPARE_LT_GT' => 140,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			";" => 134,
			'OP15_LOGICAL_AND' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP24_LOGICAL_OR_XOR' => 133
		}
	},
	{#State 69
		ACTIONS => {
			'WORD' => 150
		},
		GOTOS => {
			'LoopLabel' => 151
		}
	},
	{#State 70
		ACTIONS => {
			":" => -212,
			"::" => -207,
			"(" => -207
		},
		GOTOS => {
			'STAR-61' => 18
		}
	},
	{#State 71
		ACTIONS => {
			"{" => 43,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			"(" => 71,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"[" => 53,
			"%{" => 40,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54
		},
		GOTOS => {
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'Operator' => 51,
			'Expression' => 152,
			'HashDereferenced' => 46,
			'Variable' => 89
		}
	},
	{#State 72
		ACTIONS => {
			":" => 153
		}
	},
	{#State 73
		ACTIONS => {
			"(" => 154
		}
	},
	{#State 74
		DEFAULT => -153
	},
	{#State 75
		DEFAULT => -148
	},
	{#State 76
		DEFAULT => -92
	},
	{#State 77
		DEFAULT => -9
	},
	{#State 78
		ACTIONS => {
			"our" => 50,
			"use constant" => 28
		},
		GOTOS => {
			'Subroutine' => 155,
			'Constant' => 157,
			'PLUS-8' => 156
		}
	},
	{#State 79
		DEFAULT => -16
	},
	{#State 80
		ACTIONS => {
			")" => 158,
			'WORD' => 12
		},
		GOTOS => {
			'WordScoped' => 159
		}
	},
	{#State 81
		DEFAULT => -62
	},
	{#State 82
		ACTIONS => {
			"use RPerl;" => 160
		}
	},
	{#State 83
		DEFAULT => -25
	},
	{#State 84
		ACTIONS => {
			'WORD' => 162,
			")" => 161
		}
	},
	{#State 85
		ACTIONS => {
			"my" => 99
		},
		GOTOS => {
			'TypeInner' => 163
		}
	},
	{#State 86
		ACTIONS => {
			'WORD' => 94,
			"%{" => 40
		},
		GOTOS => {
			'HashEntry' => 95,
			'HashDereferenced' => 93
		}
	},
	{#State 87
		ACTIONS => {
			"}" => 164
		}
	},
	{#State 88
		ACTIONS => {
			"}" => 165
		}
	},
	{#State 89
		ACTIONS => {
			'OP08_STRING_CAT' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP02_METHOD_THINARROW' => 132,
			'OP13_BITWISE_AND' => -137,
			'OP21_LIST_COMMA' => -137,
			'OP04_MATH_POW' => -137,
			"}" => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP18_TERNARY' => -137,
			'OP16_LOGICAL_OR' => -137,
			"]" => -137,
			";" => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP12_COMPARE_EQ_NEQ' => -137,
			".." => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP03_MATH_INC_DEC' => 129,
			")" => -137,
			'OP17_LIST_RANGE' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP23_LOGICAL_AND' => -137
		}
	},
	{#State 90
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 149,
			'OP13_BITWISE_AND' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			")" => 166,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 143,
			'OP17_LIST_RANGE' => 141,
			'OP23_LOGICAL_AND' => 142
		}
	},
	{#State 91
		ACTIONS => {
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'WORD' => 12,
			"(" => 71,
			"[" => 53,
			'OP03_MATH_INC_DEC' => 54,
			")" => -94,
			'VARIABLE_SYMBOL' => 55,
			'KEYS_OR_VALUES' => 96,
			"{" => 43,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			"%{" => 40,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"my" => 99
		},
		GOTOS => {
			'Operator' => 51,
			'ArrayReference' => 52,
			'ListElements' => 168,
			'HashReference' => 61,
			'TypeInner' => 101,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'OPTIONAL-39' => 167,
			'ListElement' => 100,
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 98
		}
	},
	{#State 92
		DEFAULT => -142
	},
	{#State 93
		DEFAULT => -196
	},
	{#State 94
		ACTIONS => {
			'OP20_HASH_FATARROW' => 169
		}
	},
	{#State 95
		DEFAULT => -201,
		GOTOS => {
			'STAR-59' => 170
		}
	},
	{#State 96
		ACTIONS => {
			"%{" => 40
		},
		GOTOS => {
			'HashDereferenced' => 171
		}
	},
	{#State 97
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 54,
			")" => -121,
			'VARIABLE_SYMBOL' => 55,
			"(" => 71,
			'WORD' => 12,
			"[" => 53,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			"my" => 99,
			"%{" => 40,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47,
			'KEYS_OR_VALUES' => 96,
			"{" => 43
		},
		GOTOS => {
			'Variable' => 89,
			'Expression' => 98,
			'HashDereferenced' => 46,
			'ListElement' => 100,
			'WordScoped' => 73,
			'TypeInner' => 101,
			'ArrayDereferenced' => 62,
			'OPTIONAL-41' => 173,
			'Operator' => 51,
			'ArrayReference' => 52,
			'ListElements' => 172,
			'HashReference' => 61
		}
	},
	{#State 98
		ACTIONS => {
			"]" => -185,
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			'OP21_LIST_COMMA' => -185,
			'OP13_BITWISE_AND' => 139,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP23_LOGICAL_AND' => 142,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			")" => -185,
			'OP11_COMPARE_LT_GT' => 140,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP15_LOGICAL_AND' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP24_LOGICAL_OR_XOR' => 133,
			";" => -185
		}
	},
	{#State 99
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 174
		}
	},
	{#State 100
		DEFAULT => -183,
		GOTOS => {
			'STAR-55' => 175
		}
	},
	{#State 101
		ACTIONS => {
			"[" => 53,
			'WORD' => 12,
			"(" => 71,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"%{" => 40,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			"{" => 43,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'OP05_LOGICAL_NEG' => 45,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58
		},
		GOTOS => {
			'HashDereferenced' => 46,
			'Expression' => 176,
			'Variable' => 89,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'ArrayReference' => 52,
			'HashReference' => 61,
			'Operator' => 51
		}
	},
	{#State 102
		DEFAULT => -118
	},
	{#State 103
		ACTIONS => {
			'WORD' => 177
		}
	},
	{#State 104
		ACTIONS => {
			")" => 178
		}
	},
	{#State 105
		ACTIONS => {
			")" => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			";" => -99,
			".." => -99,
			'OP06_REGEX_MATCH' => -99,
			'OP12_COMPARE_EQ_NEQ' => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP04_MATH_POW' => 147,
			"}" => -99,
			'OP16_LOGICAL_OR' => -99,
			"]" => -99,
			'OP18_TERNARY' => -99,
			'OP08_STRING_CAT' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP21_LIST_COMMA' => -99
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
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			"}" => -106,
			'OP16_LOGICAL_OR' => -106,
			"]" => -106,
			'OP18_TERNARY' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP08_STRING_CAT' => 149,
			'OP13_BITWISE_AND' => -106,
			'OP21_LIST_COMMA' => -106,
			")" => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP09_BITWISE_SHIFT' => 143,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			";" => -106,
			".." => -106,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => -106
		}
	},
	{#State 109
		ACTIONS => {
			'VARIABLE_SYMBOL' => 181
		}
	},
	{#State 110
		DEFAULT => -211
	},
	{#State 111
		ACTIONS => {
			"]" => 182
		}
	},
	{#State 112
		DEFAULT => -188
	},
	{#State 113
		DEFAULT => -96
	},
	{#State 114
		ACTIONS => {
			"}" => -173,
			'OP04_MATH_POW' => -173,
			'OP07_MATH_MULT_DIV_MOD' => -173,
			'OP18_TERNARY' => -173,
			"]" => -173,
			'OP16_LOGICAL_OR' => -173,
			'OP02_HASH_THINARROW' => 184,
			'OP02_METHOD_THINARROW' => -173,
			'OP08_STRING_CAT' => -173,
			'OP14_BITWISE_OR_XOR' => -173,
			'OP21_LIST_COMMA' => -173,
			'OP13_BITWISE_AND' => -173,
			'OP11_COMPARE_LT_GT' => -173,
			'OP19_VARIABLE_ASSIGN_BY' => -173,
			")" => -173,
			'OP03_MATH_INC_DEC' => -173,
			":" => -173,
			'OP02_ARRAY_THINARROW' => 183,
			'OP17_LIST_RANGE' => -173,
			'OP09_BITWISE_SHIFT' => -173,
			'OP23_LOGICAL_AND' => -173,
			'OP19_VARIABLE_ASSIGN' => -173,
			";" => -173,
			'OP24_LOGICAL_OR_XOR' => -173,
			'OP08_MATH_ADD_SUB' => -173,
			'OP15_LOGICAL_AND' => -173,
			'OP12_COMPARE_EQ_NEQ' => -173,
			'OP06_REGEX_MATCH' => -173,
			".." => -173
		},
		GOTOS => {
			'VariableRetrieval' => 185
		}
	},
	{#State 115
		ACTIONS => {
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"%{" => 40,
			"my" => 99,
			"{" => 43,
			'KEYS_OR_VALUES' => 96,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'LITERAL' => 49,
			'OP05_LOGICAL_NEG' => 45,
			"[" => 53,
			'WORD' => 12,
			"(" => 71,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			";" => -125,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58
		},
		GOTOS => {
			'WordScoped' => 73,
			'OPTIONAL-43' => 187,
			'ArrayDereferenced' => 62,
			'TypeInner' => 101,
			'HashReference' => 61,
			'ListElements' => 186,
			'ArrayReference' => 52,
			'Operator' => 51,
			'Expression' => 98,
			'HashDereferenced' => 46,
			'Variable' => 89,
			'ListElement' => 100
		}
	},
	{#State 116
		DEFAULT => -122
	},
	{#State 117
		ACTIONS => {
			";" => 188
		}
	},
	{#State 118
		DEFAULT => -11
	},
	{#State 119
		ACTIONS => {
			'OP17_LIST_RANGE' => 141,
			'OP23_LOGICAL_AND' => 142,
			'OP09_BITWISE_SHIFT' => 143,
			")" => 189,
			'OP11_COMPARE_LT_GT' => 140,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			'OP13_BITWISE_AND' => 139,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148
		}
	},
	{#State 120
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			"}" => -115,
			'OP16_LOGICAL_OR' => 137,
			"]" => -115,
			'OP18_TERNARY' => 138,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 149,
			'OP13_BITWISE_AND' => 139,
			'OP21_LIST_COMMA' => -115,
			")" => -115,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => -115,
			'OP08_MATH_ADD_SUB' => 145,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP15_LOGICAL_AND' => 144,
			";" => -115,
			".." => -115,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => 135
		}
	},
	{#State 121
		ACTIONS => {
			'VARIABLE_SYMBOL' => 190
		}
	},
	{#State 122
		DEFAULT => -151
	},
	{#State 123
		DEFAULT => -162
	},
	{#State 124
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 191
		}
	},
	{#State 125
		ACTIONS => {
			'VARIABLE_SYMBOL' => 192
		}
	},
	{#State 126
		ACTIONS => {
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47,
			"{" => 43,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"%{" => 40,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			"(" => 71,
			'OP01_NAMED' => 42,
			"[" => 53
		},
		GOTOS => {
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'Operator' => 51,
			'Expression' => 193,
			'HashDereferenced' => 46,
			'Variable' => 89
		}
	},
	{#State 127
		DEFAULT => -164
	},
	{#State 128
		DEFAULT => -163
	},
	{#State 129
		DEFAULT => -97
	},
	{#State 130
		ACTIONS => {
			"%{" => 40,
			'OP01_NAMED' => 42,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			"(" => 71,
			"[" => 53,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"{" => 43,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47
		},
		GOTOS => {
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'Operator' => 51,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'Variable' => 89,
			'Expression' => 194,
			'HashDereferenced' => 46
		}
	},
	{#State 131
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			"{" => 43,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			'WORD' => 12,
			"(" => 71,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"[" => 53,
			"%{" => 40
		},
		GOTOS => {
			'Variable' => 89,
			'Expression' => 195,
			'HashDereferenced' => 46,
			'Operator' => 51,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73
		}
	},
	{#State 132
		ACTIONS => {
			'WORD' => 196
		}
	},
	{#State 133
		ACTIONS => {
			"{" => 43,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'OP05_LOGICAL_NEG' => 45,
			"%{" => 40,
			"[" => 53,
			"(" => 71,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'Variable' => 89,
			'Expression' => 197,
			'HashDereferenced' => 46,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'Operator' => 51,
			'ArrayReference' => 52,
			'HashReference' => 61
		}
	},
	{#State 134
		DEFAULT => -91
	},
	{#State 135
		ACTIONS => {
			"{" => 43,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			'OP05_LOGICAL_NEG' => 45,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 53,
			'OP05_MATH_NEG' => 41,
			'WORD' => 12,
			"(" => 71,
			'OP01_NAMED' => 42,
			"%{" => 40,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54
		},
		GOTOS => {
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'Operator' => 51,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'Variable' => 89,
			'Expression' => 198,
			'HashDereferenced' => 46
		}
	},
	{#State 136
		ACTIONS => {
			"/" => 199
		}
	},
	{#State 137
		ACTIONS => {
			"{" => 43,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			"%{" => 40,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			"(" => 71,
			'OP01_NAMED' => 42,
			"[" => 53,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'ArrayReference' => 52,
			'HashReference' => 61,
			'Operator' => 51,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'HashDereferenced' => 46,
			'Expression' => 200,
			'Variable' => 89
		}
	},
	{#State 138
		ACTIONS => {
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'Variable' => 201
		}
	},
	{#State 139
		ACTIONS => {
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'OP05_LOGICAL_NEG' => 45,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			"{" => 43,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			"[" => 53,
			"(" => 71,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"%{" => 40
		},
		GOTOS => {
			'Variable' => 89,
			'Expression' => 202,
			'HashDereferenced' => 46,
			'Operator' => 51,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73
		}
	},
	{#State 140
		ACTIONS => {
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			'WORD' => 12,
			"(" => 71,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"[" => 53,
			"%{" => 40,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			"{" => 43
		},
		GOTOS => {
			'Variable' => 89,
			'Expression' => 203,
			'HashDereferenced' => 46,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'Operator' => 51,
			'HashReference' => 61,
			'ArrayReference' => 52
		}
	},
	{#State 141
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47,
			'OP05_LOGICAL_NEG' => 45,
			"{" => 43,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"%{" => 40,
			"[" => 53,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"(" => 71,
			'WORD' => 12
		},
		GOTOS => {
			'HashDereferenced' => 46,
			'Expression' => 204,
			'Variable' => 89,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'Operator' => 51
		}
	},
	{#State 142
		ACTIONS => {
			"(" => 71,
			'WORD' => 12,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"[" => 53,
			"%{" => 40,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			"{" => 43,
			'OP05_LOGICAL_NEG' => 45,
			"\@{" => 47,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60
		},
		GOTOS => {
			'Variable' => 89,
			'Expression' => 205,
			'HashDereferenced' => 46,
			'Operator' => 51,
			'ArrayReference' => 52,
			'HashReference' => 61,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73
		}
	},
	{#State 143
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"%{" => 40,
			"[" => 53,
			"(" => 71,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			'WORD' => 12,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			'OP05_LOGICAL_NEG' => 45,
			"{" => 43
		},
		GOTOS => {
			'HashReference' => 61,
			'ArrayReference' => 52,
			'Operator' => 51,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'HashDereferenced' => 46,
			'Expression' => 206,
			'Variable' => 89
		}
	},
	{#State 144
		ACTIONS => {
			"{" => 43,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47,
			'OP05_LOGICAL_NEG' => 45,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			"[" => 53,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"(" => 71,
			'WORD' => 12,
			"%{" => 40,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54
		},
		GOTOS => {
			'ArrayReference' => 52,
			'HashReference' => 61,
			'Operator' => 51,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'HashDereferenced' => 46,
			'Expression' => 207,
			'Variable' => 89
		}
	},
	{#State 145
		ACTIONS => {
			"%{" => 40,
			"[" => 53,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"(" => 71,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"{" => 43,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'LITERAL' => 49,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP05_LOGICAL_NEG' => 45
		},
		GOTOS => {
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 208,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'Operator' => 51,
			'HashReference' => 61,
			'ArrayReference' => 52
		}
	},
	{#State 146
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"%{" => 40,
			"[" => 53,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			'WORD' => 12,
			"(" => 71,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'LITERAL' => 49,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP05_LOGICAL_NEG' => 45,
			"{" => 43
		},
		GOTOS => {
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 209,
			'Operator' => 51,
			'ArrayReference' => 52,
			'HashReference' => 61,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62
		}
	},
	{#State 147
		ACTIONS => {
			"{" => 43,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 40,
			'WORD' => 12,
			"(" => 71,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"[" => 53,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'Operator' => 51,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 210
		}
	},
	{#State 148
		ACTIONS => {
			"{" => 43,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_LOGICAL_NEG' => 45,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"%{" => 40,
			'OP01_NAMED' => 42,
			"(" => 71,
			'OP05_MATH_NEG' => 41,
			'WORD' => 12,
			"[" => 53,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'HashDereferenced' => 46,
			'Expression' => 211,
			'Variable' => 89,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'Operator' => 51,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62
		}
	},
	{#State 149
		ACTIONS => {
			"%{" => 40,
			"(" => 71,
			'OP01_NAMED' => 42,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			"[" => 53,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"{" => 43,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47
		},
		GOTOS => {
			'HashDereferenced' => 46,
			'Expression' => 212,
			'Variable' => 89,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'Operator' => 51
		}
	},
	{#State 150
		DEFAULT => -212
	},
	{#State 151
		ACTIONS => {
			";" => 213
		}
	},
	{#State 152
		ACTIONS => {
			'OP18_TERNARY' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP13_BITWISE_AND' => 139,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP23_LOGICAL_AND' => 142,
			'OP09_BITWISE_SHIFT' => 143,
			'OP11_COMPARE_LT_GT' => 140,
			")" => 214,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 144,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 153
		DEFAULT => -147
	},
	{#State 154
		ACTIONS => {
			'VARIABLE_SYMBOL' => 55,
			")" => -132,
			'OP03_MATH_INC_DEC' => 54,
			"[" => 53,
			'WORD' => 12,
			"(" => 71,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			"my" => 99,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"%{" => 40,
			"\@{" => 47,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			'OP05_LOGICAL_NEG' => 45,
			"{" => 43,
			'KEYS_OR_VALUES' => 96
		},
		GOTOS => {
			'WordScoped' => 73,
			'TypeInner' => 101,
			'ArrayDereferenced' => 62,
			'OPTIONAL-44' => 216,
			'Operator' => 51,
			'HashReference' => 61,
			'ListElements' => 215,
			'ArrayReference' => 52,
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 98,
			'ListElement' => 100
		}
	},
	{#State 155
		DEFAULT => -21
	},
	{#State 156
		ACTIONS => {
			"1;1;" => 218,
			"our" => 50
		},
		GOTOS => {
			'Subroutine' => 217
		}
	},
	{#State 157
		DEFAULT => -18
	},
	{#State 158
		ACTIONS => {
			";" => 219
		}
	},
	{#State 159
		DEFAULT => -61
	},
	{#State 160
		DEFAULT => -23
	},
	{#State 161
		ACTIONS => {
			";" => 220
		}
	},
	{#State 162
		DEFAULT => -24
	},
	{#State 163
		ACTIONS => {
			'LITERAL' => 223,
			"[" => 222,
			"{" => 224
		},
		GOTOS => {
			'ConstantValue' => 221
		}
	},
	{#State 164
		DEFAULT => -203
	},
	{#State 165
		DEFAULT => -204
	},
	{#State 166
		DEFAULT => -100
	},
	{#State 167
		ACTIONS => {
			")" => 225
		}
	},
	{#State 168
		DEFAULT => -93
	},
	{#State 169
		ACTIONS => {
			'OP22_LOGICAL_NOT' => -194,
			"undef" => -194,
			'WORD' => -194,
			"(" => -194,
			"[" => -194,
			'VARIABLE_SYMBOL' => -194,
			'OP03_MATH_INC_DEC' => -194,
			"{" => -194,
			'OP05_LOGICAL_NEG' => -194,
			"\@{" => -194,
			'OP10_NAMED_UNARY' => -194,
			'LITERAL' => -194,
			'OP01_NAMED' => -194,
			'OP05_MATH_NEG' => -194,
			"%{" => -194,
			"my" => 99
		},
		GOTOS => {
			'OPTIONAL-57' => 226,
			'TypeInner' => 227
		}
	},
	{#State 170
		ACTIONS => {
			"}" => 229,
			'OP21_LIST_COMMA' => 228
		},
		GOTOS => {
			'PAREN-58' => 230
		}
	},
	{#State 171
		DEFAULT => -187
	},
	{#State 172
		DEFAULT => -120
	},
	{#State 173
		ACTIONS => {
			")" => 231
		}
	},
	{#State 174
		ACTIONS => {
			"\$TYPED_" => 232
		}
	},
	{#State 175
		ACTIONS => {
			"]" => -184,
			'OP21_LIST_COMMA' => 234,
			")" => -184,
			";" => -184
		},
		GOTOS => {
			'PAREN-54' => 233
		}
	},
	{#State 176
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 133,
			";" => -186,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			")" => -186,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP21_LIST_COMMA' => -186,
			'OP13_BITWISE_AND' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			"]" => -186,
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138
		}
	},
	{#State 177
		ACTIONS => {
			"}" => 235
		}
	},
	{#State 178
		ACTIONS => {
			";" => 236
		}
	},
	{#State 179
		DEFAULT => -192
	},
	{#State 180
		DEFAULT => -191
	},
	{#State 181
		ACTIONS => {
			"= sub {" => 237
		}
	},
	{#State 182
		DEFAULT => -190
	},
	{#State 183
		ACTIONS => {
			"{" => 43,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_LOGICAL_NEG' => 45,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"%{" => 40,
			'WORD' => 12,
			"(" => 71,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"[" => 53,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 238,
			'Operator' => 51,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62
		}
	},
	{#State 184
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"%{" => 40,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"(" => 71,
			'WORD' => 239,
			"[" => 53,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			"{" => 43
		},
		GOTOS => {
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'ArrayReference' => 52,
			'HashReference' => 61,
			'Operator' => 51,
			'HashDereferenced' => 46,
			'Expression' => 240,
			'Variable' => 89
		}
	},
	{#State 185
		DEFAULT => -171
	},
	{#State 186
		DEFAULT => -124
	},
	{#State 187
		ACTIONS => {
			";" => 241
		}
	},
	{#State 188
		DEFAULT => -128
	},
	{#State 189
		ACTIONS => {
			"{" => 242
		},
		GOTOS => {
			'CodeBlock' => 243
		}
	},
	{#State 190
		ACTIONS => {
			";" => 245,
			'OP19_VARIABLE_ASSIGN' => 244
		}
	},
	{#State 191
		ACTIONS => {
			'VARIABLE_SYMBOL' => 246
		}
	},
	{#State 192
		ACTIONS => {
			"(" => 247
		}
	},
	{#State 193
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 140,
			")" => 248,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP15_LOGICAL_AND' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP13_BITWISE_AND' => 139
		}
	},
	{#State 194
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 149,
			'OP13_BITWISE_AND' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			";" => 249,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => 142
		}
	},
	{#State 195
		ACTIONS => {
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => 135,
			";" => 250,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 145,
			'OP23_LOGICAL_AND' => 142,
			'OP09_BITWISE_SHIFT' => 143,
			'OP17_LIST_RANGE' => 141,
			'OP11_COMPARE_LT_GT' => 140,
			'OP13_BITWISE_AND' => 139,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146
		}
	},
	{#State 196
		ACTIONS => {
			"(" => 251
		}
	},
	{#State 197
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 149,
			'OP13_BITWISE_AND' => 139,
			'OP21_LIST_COMMA' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			"}" => -117,
			'OP16_LOGICAL_OR' => 137,
			"]" => -117,
			'OP18_TERNARY' => 138,
			'OP15_LOGICAL_AND' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP24_LOGICAL_OR_XOR' => -117,
			";" => -117,
			".." => -117,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => 135,
			")" => -117,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => 142
		}
	},
	{#State 198
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 140,
			")" => -108,
			'OP17_LIST_RANGE' => -108,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => -108,
			";" => -108,
			'OP08_MATH_ADD_SUB' => 145,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP06_REGEX_MATCH' => 136,
			".." => -108,
			"}" => -108,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => -108,
			"]" => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP08_STRING_CAT' => 149,
			'OP21_LIST_COMMA' => -108,
			'OP13_BITWISE_AND' => -108
		}
	},
	{#State 199
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 252
		}
	},
	{#State 200
		ACTIONS => {
			'OP16_LOGICAL_OR' => -112,
			"]" => -112,
			'OP18_TERNARY' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			"}" => -112,
			'OP13_BITWISE_AND' => 139,
			'OP21_LIST_COMMA' => -112,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 149,
			'OP09_BITWISE_SHIFT' => 143,
			'OP17_LIST_RANGE' => -112,
			'OP23_LOGICAL_AND' => -112,
			")" => -112,
			'OP11_COMPARE_LT_GT' => 140,
			".." => -112,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => -112,
			";" => -112
		}
	},
	{#State 201
		ACTIONS => {
			":" => 253
		}
	},
	{#State 202
		ACTIONS => {
			'OP16_LOGICAL_OR' => -109,
			"]" => -109,
			'OP18_TERNARY' => -109,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			"}" => -109,
			'OP13_BITWISE_AND' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP09_BITWISE_SHIFT' => 143,
			'OP17_LIST_RANGE' => -109,
			")" => -109,
			'OP11_COMPARE_LT_GT' => 140,
			".." => -109,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP08_MATH_ADD_SUB' => 145,
			";" => -109
		}
	},
	{#State 203
		ACTIONS => {
			'OP23_LOGICAL_AND' => -107,
			'OP09_BITWISE_SHIFT' => 143,
			'OP17_LIST_RANGE' => -107,
			'OP11_COMPARE_LT_GT' => undef,
			")" => -107,
			'OP12_COMPARE_EQ_NEQ' => -107,
			'OP06_REGEX_MATCH' => 136,
			".." => -107,
			";" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP15_LOGICAL_AND' => -107,
			'OP08_MATH_ADD_SUB' => 145,
			'OP18_TERNARY' => -107,
			"]" => -107,
			'OP16_LOGICAL_OR' => -107,
			"}" => -107,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP21_LIST_COMMA' => -107,
			'OP13_BITWISE_AND' => -107,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => -107
		}
	},
	{#State 204
		ACTIONS => {
			'OP18_TERNARY' => -113,
			"]" => -113,
			'OP16_LOGICAL_OR' => 137,
			"}" => -113,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP21_LIST_COMMA' => -113,
			'OP13_BITWISE_AND' => 139,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 149,
			'OP17_LIST_RANGE' => undef,
			'OP23_LOGICAL_AND' => -113,
			'OP09_BITWISE_SHIFT' => 143,
			'OP11_COMPARE_LT_GT' => 140,
			")" => -113,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			".." => -113,
			";" => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => 144
		}
	},
	{#State 205
		ACTIONS => {
			'OP23_LOGICAL_AND' => -116,
			'OP09_BITWISE_SHIFT' => 143,
			'OP17_LIST_RANGE' => 141,
			'OP11_COMPARE_LT_GT' => 140,
			")" => -116,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			".." => -116,
			";" => -116,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP18_TERNARY' => 138,
			"]" => -116,
			'OP16_LOGICAL_OR' => 137,
			"}" => -116,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP21_LIST_COMMA' => -116,
			'OP13_BITWISE_AND' => 139,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148
		}
	},
	{#State 206
		ACTIONS => {
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP04_MATH_POW' => 147,
			"}" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => -105,
			'OP16_LOGICAL_OR' => -105,
			"]" => -105,
			";" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => -105,
			".." => -105,
			'OP11_COMPARE_LT_GT' => -105,
			")" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP23_LOGICAL_AND' => -105
		}
	},
	{#State 207
		ACTIONS => {
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP21_LIST_COMMA' => -111,
			'OP13_BITWISE_AND' => 139,
			"}" => -111,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => -111,
			"]" => -111,
			'OP16_LOGICAL_OR' => -111,
			";" => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP08_MATH_ADD_SUB' => 145,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			".." => -111,
			'OP11_COMPARE_LT_GT' => 140,
			")" => -111,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => -111,
			'OP17_LIST_RANGE' => -111
		}
	},
	{#State 208
		ACTIONS => {
			")" => -103,
			'OP11_COMPARE_LT_GT' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP09_BITWISE_SHIFT' => -103,
			'OP08_MATH_ADD_SUB' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP15_LOGICAL_AND' => -103,
			";" => -103,
			".." => -103,
			'OP12_COMPARE_EQ_NEQ' => -103,
			'OP06_REGEX_MATCH' => 136,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			"}" => -103,
			'OP04_MATH_POW' => 147,
			"]" => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP18_TERNARY' => -103,
			'OP08_STRING_CAT' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP13_BITWISE_AND' => -103
		}
	},
	{#State 209
		ACTIONS => {
			".." => -102,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP08_MATH_ADD_SUB' => -102,
			";" => -102,
			'OP17_LIST_RANGE' => -102,
			'OP09_BITWISE_SHIFT' => -102,
			'OP23_LOGICAL_AND' => -102,
			")" => -102,
			'OP11_COMPARE_LT_GT' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP08_STRING_CAT' => -102,
			'OP16_LOGICAL_OR' => -102,
			"]" => -102,
			'OP18_TERNARY' => -102,
			'OP07_MATH_MULT_DIV_MOD' => -102,
			'OP04_MATH_POW' => 147,
			"}" => -102
		}
	},
	{#State 210
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -98,
			")" => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP23_LOGICAL_AND' => -98,
			";" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP12_COMPARE_EQ_NEQ' => -98,
			'OP06_REGEX_MATCH' => -98,
			".." => -98,
			"}" => -98,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => -98,
			'OP18_TERNARY' => -98,
			"]" => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP08_STRING_CAT' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP13_BITWISE_AND' => -98
		}
	},
	{#State 211
		ACTIONS => {
			'OP17_LIST_RANGE' => -110,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => -110,
			")" => -110,
			'OP11_COMPARE_LT_GT' => 140,
			".." => -110,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			";" => -110,
			"]" => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP18_TERNARY' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			"}" => -110,
			'OP04_MATH_POW' => 147,
			'OP21_LIST_COMMA' => -110,
			'OP13_BITWISE_AND' => 139,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => -110
		}
	},
	{#State 212
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -104,
			'OP08_STRING_CAT' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP13_BITWISE_AND' => -104,
			"}" => -104,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => -104,
			"]" => -104,
			'OP16_LOGICAL_OR' => -104,
			";" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => -104,
			'OP12_COMPARE_EQ_NEQ' => -104,
			'OP06_REGEX_MATCH' => 136,
			".." => -104,
			'OP11_COMPARE_LT_GT' => -104,
			")" => -104,
			'OP09_BITWISE_SHIFT' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP17_LIST_RANGE' => -104
		}
	},
	{#State 213
		DEFAULT => -130
	},
	{#State 214
		DEFAULT => -146
	},
	{#State 215
		DEFAULT => -131
	},
	{#State 216
		ACTIONS => {
			")" => 254
		}
	},
	{#State 217
		DEFAULT => -20
	},
	{#State 218
		DEFAULT => -22
	},
	{#State 219
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 255
		}
	},
	{#State 220
		DEFAULT => -27
	},
	{#State 221
		ACTIONS => {
			";" => 256
		}
	},
	{#State 222
		ACTIONS => {
			'LITERAL' => -30,
			"my" => 99
		},
		GOTOS => {
			'OPTIONAL-10' => 257,
			'TypeInner' => 258
		}
	},
	{#State 223
		DEFAULT => -43
	},
	{#State 224
		ACTIONS => {
			'WORD' => 259
		}
	},
	{#State 225
		DEFAULT => -95
	},
	{#State 226
		ACTIONS => {
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'OP05_LOGICAL_NEG' => 45,
			"{" => 43,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"%{" => 40,
			"[" => 53,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"(" => 71,
			'WORD' => 12
		},
		GOTOS => {
			'HashDereferenced' => 46,
			'Expression' => 260,
			'Variable' => 89,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'Operator' => 51,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73
		}
	},
	{#State 227
		DEFAULT => -193
	},
	{#State 228
		ACTIONS => {
			'WORD' => 94,
			"%{" => 40
		},
		GOTOS => {
			'HashDereferenced' => 93,
			'HashEntry' => 261
		}
	},
	{#State 229
		DEFAULT => -202
	},
	{#State 230
		DEFAULT => -200
	},
	{#State 231
		ACTIONS => {
			";" => 262
		}
	},
	{#State 232
		ACTIONS => {
			'WORD' => 263
		}
	},
	{#State 233
		DEFAULT => -182
	},
	{#State 234
		ACTIONS => {
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"%{" => 40,
			"my" => 99,
			"{" => 43,
			'KEYS_OR_VALUES' => 96,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47,
			'OP05_LOGICAL_NEG' => 45,
			"[" => 53,
			"(" => 71,
			'WORD' => 12,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58
		},
		GOTOS => {
			'ListElement' => 264,
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 98,
			'TypeInner' => 101,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'Operator' => 51,
			'ArrayReference' => 52,
			'HashReference' => 61
		}
	},
	{#State 235
		DEFAULT => -209
	},
	{#State 236
		DEFAULT => -126
	},
	{#State 237
		ACTIONS => {
			"while (" => -47,
			"if (" => -47,
			"undef" => -47,
			'OP22_LOGICAL_NOT' => -47,
			"( my" => 267,
			'VARIABLE_SYMBOL' => -47,
			'OP01_NAMED_VOID' => -47,
			'OP03_MATH_INC_DEC' => -47,
			'OP19_LOOP_CONTROL' => -47,
			"(" => -47,
			'WORD' => -47,
			"[" => -47,
			'OP05_LOGICAL_NEG' => -47,
			'LITERAL' => -47,
			"\@{" => -47,
			'OP10_NAMED_UNARY' => -47,
			"{" => -47,
			'OP01_NAMED_VOID_PAREN' => -47,
			"foreach my" => -47,
			"my" => -47,
			"for my integer" => -47,
			'OP05_MATH_NEG' => -47,
			'OP01_NAMED' => -47,
			"%{" => -47
		},
		GOTOS => {
			'OPTIONAL-18' => 266,
			'SubroutineArguments' => 265
		}
	},
	{#State 238
		ACTIONS => {
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP13_BITWISE_AND' => 139,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => 138,
			'OP16_LOGICAL_OR' => 137,
			"]" => 268,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => 142
		}
	},
	{#State 239
		ACTIONS => {
			"(" => -207,
			"}" => 269,
			"::" => -207
		},
		GOTOS => {
			'STAR-61' => 18
		}
	},
	{#State 240
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP17_LIST_RANGE' => 141,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			"}" => 270,
			'OP04_MATH_POW' => 147,
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP13_BITWISE_AND' => 139
		}
	},
	{#State 241
		DEFAULT => -129
	},
	{#State 242
		ACTIONS => {
			"undef" => 58,
			"if (" => 59,
			'OP22_LOGICAL_NOT' => 60,
			"while (" => -149,
			"[" => 53,
			'WORD' => 70,
			'OP19_LOOP_CONTROL' => 69,
			"(" => 71,
			'OP03_MATH_INC_DEC' => 54,
			'OP01_NAMED_VOID' => 56,
			'VARIABLE_SYMBOL' => 55,
			"{" => 43,
			'OP01_NAMED_VOID_PAREN' => 44,
			"\@{" => 47,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			'OP05_LOGICAL_NEG' => 45,
			"%{" => 40,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"for my integer" => -149,
			"my" => 63,
			"foreach my" => -149
		},
		GOTOS => {
			'Conditional' => 65,
			'OPTIONAL-47' => 64,
			'Expression' => 68,
			'HashDereferenced' => 46,
			'Variable' => 66,
			'VariableModification' => 67,
			'ArrayDereferenced' => 62,
			'OperatorVoid' => 39,
			'HashReference' => 61,
			'Operation' => 272,
			'PAREN-46' => 75,
			'Statement' => 76,
			'VariableDeclaration' => 74,
			'WordScoped' => 73,
			'ArrayReference' => 52,
			'Operator' => 51,
			'LoopLabel' => 72,
			'PLUS-52' => 271
		}
	},
	{#State 243
		DEFAULT => -157,
		GOTOS => {
			'STAR-49' => 273
		}
	},
	{#State 244
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			"%{" => 40,
			'OP01_NAMED' => 42,
			"(" => 71,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			"[" => 53,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			"{" => 43
		},
		GOTOS => {
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'ArrayReference' => 52,
			'HashReference' => 61,
			'Operator' => 51,
			'Expression' => 274,
			'HashDereferenced' => 46,
			'Variable' => 89
		}
	},
	{#State 245
		DEFAULT => -177
	},
	{#State 246
		ACTIONS => {
			"(" => 275
		}
	},
	{#State 247
		ACTIONS => {
			"(" => 71,
			'OP01_NAMED' => 42,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			"[" => 53,
			"%{" => 40,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			"{" => 43,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'LITERAL' => 49,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58
		},
		GOTOS => {
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'Operator' => 51,
			'HashDereferenced' => 46,
			'Expression' => 276,
			'Variable' => 89
		}
	},
	{#State 248
		ACTIONS => {
			"{" => 242
		},
		GOTOS => {
			'CodeBlock' => 277
		}
	},
	{#State 249
		DEFAULT => -180
	},
	{#State 250
		DEFAULT => -179
	},
	{#State 251
		ACTIONS => {
			"my" => 99,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"%{" => 40,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'LITERAL' => 49,
			'KEYS_OR_VALUES' => 96,
			"{" => 43,
			'VARIABLE_SYMBOL' => 55,
			")" => -134,
			'OP03_MATH_INC_DEC' => 54,
			"(" => 71,
			'WORD' => 12,
			"[" => 53,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58
		},
		GOTOS => {
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'TypeInner' => 101,
			'ListElements' => 279,
			'ArrayReference' => 52,
			'HashReference' => 61,
			'Operator' => 51,
			'HashDereferenced' => 46,
			'Expression' => 98,
			'Variable' => 89,
			'ListElement' => 100,
			'OPTIONAL-45' => 278
		}
	},
	{#State 252
		ACTIONS => {
			"/" => 280
		}
	},
	{#State 253
		ACTIONS => {
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'Variable' => 281
		}
	},
	{#State 254
		DEFAULT => -144
	},
	{#State 255
		ACTIONS => {
			"use constant" => -66,
			"our %properties = (" => -66,
			"use" => 20
		},
		GOTOS => {
			'STAR-27' => 282,
			'Include' => 283
		}
	},
	{#State 256
		DEFAULT => -28
	},
	{#State 257
		ACTIONS => {
			'LITERAL' => 284
		}
	},
	{#State 258
		DEFAULT => -29
	},
	{#State 259
		ACTIONS => {
			'OP20_HASH_FATARROW' => 285
		}
	},
	{#State 260
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP15_LOGICAL_AND' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			"}" => -195,
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP21_LIST_COMMA' => -195,
			'OP13_BITWISE_AND' => 139
		}
	},
	{#State 261
		DEFAULT => -199
	},
	{#State 262
		DEFAULT => -127
	},
	{#State 263
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 286
		}
	},
	{#State 264
		DEFAULT => -181
	},
	{#State 265
		DEFAULT => -46
	},
	{#State 266
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			"if (" => 59,
			"while (" => -149,
			'OP19_LOOP_CONTROL' => 69,
			'WORD' => 70,
			"(" => 71,
			"[" => 53,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			'OP01_NAMED_VOID' => 56,
			'OP01_NAMED_VOID_PAREN' => 44,
			"{" => 43,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			"%{" => 40,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"for my integer" => -149,
			"foreach my" => -149,
			"my" => 63
		},
		GOTOS => {
			'OperatorVoid' => 39,
			'HashReference' => 61,
			'Operation' => 288,
			'ArrayDereferenced' => 62,
			'HashDereferenced' => 46,
			'Expression' => 68,
			'Variable' => 66,
			'VariableModification' => 67,
			'OPTIONAL-47' => 64,
			'Conditional' => 65,
			'LoopLabel' => 72,
			'ArrayReference' => 52,
			'Operator' => 51,
			'PLUS-19' => 287,
			'WordScoped' => 73,
			'VariableDeclaration' => 74,
			'PAREN-46' => 75,
			'Statement' => 76
		}
	},
	{#State 267
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 289
		}
	},
	{#State 268
		DEFAULT => -174
	},
	{#State 269
		DEFAULT => -176
	},
	{#State 270
		DEFAULT => -175
	},
	{#State 271
		ACTIONS => {
			"while (" => -149,
			'OP22_LOGICAL_NOT' => 60,
			"if (" => 59,
			"undef" => 58,
			'OP19_LOOP_CONTROL' => 69,
			'WORD' => 70,
			"(" => 71,
			"[" => 53,
			'VARIABLE_SYMBOL' => 55,
			'OP01_NAMED_VOID' => 56,
			'OP03_MATH_INC_DEC' => 54,
			"{" => 43,
			'OP01_NAMED_VOID_PAREN' => 44,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			"%{" => 40,
			"foreach my" => -149,
			"my" => 63,
			"}" => 291,
			"for my integer" => -149
		},
		GOTOS => {
			'Conditional' => 65,
			'OPTIONAL-47' => 64,
			'VariableModification' => 67,
			'Variable' => 66,
			'Expression' => 68,
			'HashDereferenced' => 46,
			'Operation' => 290,
			'OperatorVoid' => 39,
			'HashReference' => 61,
			'ArrayDereferenced' => 62,
			'VariableDeclaration' => 74,
			'Statement' => 76,
			'PAREN-46' => 75,
			'Operator' => 51,
			'ArrayReference' => 52,
			'LoopLabel' => 72,
			'WordScoped' => 73
		}
	},
	{#State 272
		DEFAULT => -169
	},
	{#State 273
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -160,
			'OP10_NAMED_UNARY' => -160,
			'LITERAL' => -160,
			"\@{" => -160,
			"{" => -160,
			'OP01_NAMED_VOID_PAREN' => -160,
			"foreach my" => -160,
			"elsif (" => 292,
			"my" => -160,
			"}" => -160,
			'' => -160,
			"for my integer" => -160,
			'OP05_MATH_NEG' => -160,
			'OP01_NAMED' => -160,
			"%{" => -160,
			"while (" => -160,
			"undef" => -160,
			"if (" => -160,
			'OP22_LOGICAL_NOT' => -160,
			'VARIABLE_SYMBOL' => -160,
			"else" => 295,
			'OP01_NAMED_VOID' => -160,
			'OP03_MATH_INC_DEC' => -160,
			'OP19_LOOP_CONTROL' => -160,
			'WORD' => -160,
			"(" => -160,
			"[" => -160
		},
		GOTOS => {
			'OPTIONAL-51' => 294,
			'PAREN-48' => 293,
			'PAREN-50' => 296
		}
	},
	{#State 274
		ACTIONS => {
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP13_BITWISE_AND' => 139,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP17_LIST_RANGE' => 141,
			";" => 297,
			'OP15_LOGICAL_AND' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136
		}
	},
	{#State 275
		ACTIONS => {
			'WORD' => 12,
			"(" => 71,
			"[" => 53,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"%{" => 40,
			"my" => 99,
			'KEYS_OR_VALUES' => 96,
			"{" => 43,
			'OP05_LOGICAL_NEG' => 45,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49
		},
		GOTOS => {
			'ArrayDereferenced' => 62,
			'TypeInner' => 101,
			'WordScoped' => 73,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'ListElements' => 298,
			'Operator' => 51,
			'ListElement' => 100,
			'Expression' => 98,
			'HashDereferenced' => 46,
			'Variable' => 89
		}
	},
	{#State 276
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP13_BITWISE_AND' => 139,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP08_MATH_ADD_SUB' => 145,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 144,
			".." => 299,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136
		}
	},
	{#State 277
		DEFAULT => -167
	},
	{#State 278
		ACTIONS => {
			")" => 300
		}
	},
	{#State 279
		DEFAULT => -133
	},
	{#State 280
		DEFAULT => -101
	},
	{#State 281
		DEFAULT => -114
	},
	{#State 282
		ACTIONS => {
			"our %properties = (" => 301,
			"use constant" => 28
		},
		GOTOS => {
			'Constant' => 303,
			'Properties' => 302
		}
	},
	{#State 283
		DEFAULT => -63
	},
	{#State 284
		DEFAULT => -35,
		GOTOS => {
			'STAR-13' => 304
		}
	},
	{#State 285
		ACTIONS => {
			'LITERAL' => -37,
			"my" => 99
		},
		GOTOS => {
			'OPTIONAL-14' => 305,
			'TypeInner' => 306
		}
	},
	{#State 286
		DEFAULT => -210
	},
	{#State 287
		ACTIONS => {
			"while (" => -149,
			"if (" => 59,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'VARIABLE_SYMBOL' => 55,
			'OP01_NAMED_VOID' => 56,
			'OP03_MATH_INC_DEC' => 54,
			'WORD' => 70,
			'OP19_LOOP_CONTROL' => 69,
			"(" => 71,
			"[" => 53,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			"{" => 43,
			'OP01_NAMED_VOID_PAREN' => 44,
			"foreach my" => -149,
			"my" => 63,
			"}" => 307,
			"for my integer" => -149,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"%{" => 40
		},
		GOTOS => {
			'PAREN-46' => 75,
			'Statement' => 76,
			'VariableDeclaration' => 74,
			'WordScoped' => 73,
			'Operator' => 51,
			'ArrayReference' => 52,
			'LoopLabel' => 72,
			'Conditional' => 65,
			'OPTIONAL-47' => 64,
			'Variable' => 66,
			'VariableModification' => 67,
			'HashDereferenced' => 46,
			'Expression' => 68,
			'ArrayDereferenced' => 62,
			'Operation' => 308,
			'OperatorVoid' => 39,
			'HashReference' => 61
		}
	},
	{#State 288
		DEFAULT => -49
	},
	{#State 289
		ACTIONS => {
			'VARIABLE_SYMBOL' => 309
		}
	},
	{#State 290
		DEFAULT => -168
	},
	{#State 291
		DEFAULT => -170
	},
	{#State 292
		ACTIONS => {
			"{" => 43,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'WORD' => 12,
			'OP01_NAMED' => 42,
			"(" => 71,
			'OP05_MATH_NEG' => 41,
			"[" => 53,
			"%{" => 40,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54
		},
		GOTOS => {
			'Variable' => 89,
			'Expression' => 310,
			'HashDereferenced' => 46,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'Operator' => 51,
			'ArrayReference' => 52,
			'HashReference' => 61
		}
	},
	{#State 293
		DEFAULT => -156
	},
	{#State 294
		DEFAULT => -161
	},
	{#State 295
		ACTIONS => {
			"{" => 242
		},
		GOTOS => {
			'CodeBlock' => 311
		}
	},
	{#State 296
		DEFAULT => -159
	},
	{#State 297
		DEFAULT => -178
	},
	{#State 298
		ACTIONS => {
			")" => 312
		}
	},
	{#State 299
		ACTIONS => {
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			'OP01_NAMED' => 42,
			'OP05_MATH_NEG' => 41,
			'WORD' => 12,
			"(" => 71,
			"[" => 53,
			"%{" => 40,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			"{" => 43
		},
		GOTOS => {
			'Operator' => 51,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 313
		}
	},
	{#State 300
		DEFAULT => -145
	},
	{#State 301
		ACTIONS => {
			")" => 314,
			'WORD' => 317,
			"%{" => 40
		},
		GOTOS => {
			'HashEntryTyped' => 316,
			'HashDereferenced' => 315
		}
	},
	{#State 302
		DEFAULT => -68,
		GOTOS => {
			'STAR-28' => 318
		}
	},
	{#State 303
		DEFAULT => -65
	},
	{#State 304
		ACTIONS => {
			'OP21_LIST_COMMA' => 319,
			"]" => 321
		},
		GOTOS => {
			'PAREN-12' => 320
		}
	},
	{#State 305
		ACTIONS => {
			'LITERAL' => 322
		}
	},
	{#State 306
		DEFAULT => -36
	},
	{#State 307
		ACTIONS => {
			";" => 323
		}
	},
	{#State 308
		DEFAULT => -48
	},
	{#State 309
		DEFAULT => -53,
		GOTOS => {
			'STAR-21' => 324
		}
	},
	{#State 310
		ACTIONS => {
			'OP04_MATH_POW' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 149,
			'OP13_BITWISE_AND' => 139,
			'OP11_COMPARE_LT_GT' => 140,
			")" => 325,
			'OP23_LOGICAL_AND' => 142,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 145,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => 135
		}
	},
	{#State 311
		DEFAULT => -158
	},
	{#State 312
		ACTIONS => {
			"{" => 242
		},
		GOTOS => {
			'CodeBlock' => 326
		}
	},
	{#State 313
		ACTIONS => {
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP08_MATH_ADD_SUB' => 145,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 144,
			'OP17_LIST_RANGE' => 141,
			'OP23_LOGICAL_AND' => 142,
			'OP09_BITWISE_SHIFT' => 143,
			")" => 327,
			'OP11_COMPARE_LT_GT' => 140,
			'OP13_BITWISE_AND' => 139,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147
		}
	},
	{#State 314
		ACTIONS => {
			";" => 328
		}
	},
	{#State 315
		DEFAULT => -198
	},
	{#State 316
		DEFAULT => -77,
		GOTOS => {
			'STAR-33' => 329
		}
	},
	{#State 317
		ACTIONS => {
			'OP20_HASH_FATARROW' => 330
		}
	},
	{#State 318
		ACTIONS => {
			"our" => 333,
			"1;1;" => 332
		},
		GOTOS => {
			'Method' => 331
		}
	},
	{#State 319
		ACTIONS => {
			'LITERAL' => -32,
			"my" => 99
		},
		GOTOS => {
			'TypeInner' => 335,
			'OPTIONAL-11' => 334
		}
	},
	{#State 320
		DEFAULT => -34
	},
	{#State 321
		DEFAULT => -44
	},
	{#State 322
		DEFAULT => -42,
		GOTOS => {
			'STAR-17' => 336
		}
	},
	{#State 323
		DEFAULT => -50
	},
	{#State 324
		ACTIONS => {
			")" => 339,
			'OP21_LIST_COMMA' => 338
		},
		GOTOS => {
			'PAREN-20' => 337
		}
	},
	{#State 325
		ACTIONS => {
			"{" => 242
		},
		GOTOS => {
			'CodeBlock' => 340
		}
	},
	{#State 326
		DEFAULT => -166
	},
	{#State 327
		ACTIONS => {
			"{" => 242
		},
		GOTOS => {
			'CodeBlock' => 341
		}
	},
	{#State 328
		DEFAULT => -79
	},
	{#State 329
		ACTIONS => {
			'OP21_LIST_COMMA' => 343,
			")" => 342
		},
		GOTOS => {
			'PAREN-32' => 344
		}
	},
	{#State 330
		ACTIONS => {
			"my" => 99
		},
		GOTOS => {
			'TypeInner' => 345
		}
	},
	{#State 331
		DEFAULT => -67
	},
	{#State 332
		ACTIONS => {
			"our" => 50,
			'' => -73,
			"package" => -73
		},
		GOTOS => {
			'PLUS-29' => 349,
			'PAREN-30' => 348,
			'OPTIONAL-31' => 346,
			'Subroutine' => 347
		}
	},
	{#State 333
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 350
		}
	},
	{#State 334
		ACTIONS => {
			'LITERAL' => 351
		}
	},
	{#State 335
		DEFAULT => -31
	},
	{#State 336
		ACTIONS => {
			"}" => 353,
			'OP21_LIST_COMMA' => 352
		},
		GOTOS => {
			'PAREN-16' => 354
		}
	},
	{#State 337
		DEFAULT => -52
	},
	{#State 338
		ACTIONS => {
			"my" => 355
		}
	},
	{#State 339
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 356
		}
	},
	{#State 340
		DEFAULT => -155
	},
	{#State 341
		DEFAULT => -165
	},
	{#State 342
		ACTIONS => {
			";" => 357
		}
	},
	{#State 343
		ACTIONS => {
			'WORD' => 317,
			"%{" => 40
		},
		GOTOS => {
			'HashEntryTyped' => 358,
			'HashDereferenced' => 315
		}
	},
	{#State 344
		DEFAULT => -76
	},
	{#State 345
		ACTIONS => {
			"{" => 43,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'LITERAL' => 49,
			'OP05_LOGICAL_NEG' => 45,
			"%{" => 40,
			"[" => 53,
			"(" => 71,
			'OP05_MATH_NEG' => 41,
			'WORD' => 12,
			'OP01_NAMED' => 42,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'ArrayReference' => 52,
			'HashReference' => 61,
			'Operator' => 51,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'HashDereferenced' => 46,
			'Expression' => 359,
			'Variable' => 89
		}
	},
	{#State 346
		DEFAULT => -74
	},
	{#State 347
		DEFAULT => -70
	},
	{#State 348
		DEFAULT => -72
	},
	{#State 349
		ACTIONS => {
			"our" => 50,
			"1;1;" => 360
		},
		GOTOS => {
			'Subroutine' => 361
		}
	},
	{#State 350
		ACTIONS => {
			'VARIABLE_SYMBOL' => 362
		}
	},
	{#State 351
		DEFAULT => -33
	},
	{#State 352
		ACTIONS => {
			'WORD' => 363
		}
	},
	{#State 353
		DEFAULT => -45
	},
	{#State 354
		DEFAULT => -41
	},
	{#State 355
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 364
		}
	},
	{#State 356
		ACTIONS => {
			"\@_;" => 365
		}
	},
	{#State 357
		DEFAULT => -78
	},
	{#State 358
		DEFAULT => -75
	},
	{#State 359
		ACTIONS => {
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 145,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => 142,
			")" => -197,
			'OP11_COMPARE_LT_GT' => 140,
			'OP13_BITWISE_AND' => 139,
			'OP21_LIST_COMMA' => -197,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147
		}
	},
	{#State 360
		DEFAULT => -71
	},
	{#State 361
		DEFAULT => -69
	},
	{#State 362
		ACTIONS => {
			"= sub {" => 366
		}
	},
	{#State 363
		ACTIONS => {
			'OP20_HASH_FATARROW' => 367
		}
	},
	{#State 364
		ACTIONS => {
			'VARIABLE_SYMBOL' => 368
		}
	},
	{#State 365
		DEFAULT => -55,
		GOTOS => {
			'STAR-22' => 369
		}
	},
	{#State 366
		ACTIONS => {
			'VARIABLE_SYMBOL' => -81,
			'OP01_NAMED_VOID' => -81,
			'OP03_MATH_INC_DEC' => -81,
			'OP19_LOOP_CONTROL' => -81,
			"(" => -81,
			'WORD' => -81,
			"[" => -81,
			"while (" => -81,
			'OP22_LOGICAL_NOT' => -81,
			"undef" => -81,
			"if (" => -81,
			"( my" => 370,
			"foreach my" => -81,
			"my" => -81,
			"for my integer" => -81,
			'OP01_NAMED' => -81,
			'OP05_MATH_NEG' => -81,
			"%{" => -81,
			'OP05_LOGICAL_NEG' => -81,
			"\@{" => -81,
			'LITERAL' => -81,
			'OP10_NAMED_UNARY' => -81,
			"{" => -81,
			'OP01_NAMED_VOID_PAREN' => -81
		},
		GOTOS => {
			'OPTIONAL-34' => 371,
			'MethodArguments' => 372
		}
	},
	{#State 367
		ACTIONS => {
			"my" => 99,
			'LITERAL' => -39
		},
		GOTOS => {
			'TypeInner' => 374,
			'OPTIONAL-15' => 373
		}
	},
	{#State 368
		DEFAULT => -51
	},
	{#State 369
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -56,
			'VARIABLE_SYMBOL' => -56,
			'OP01_NAMED_VOID' => -56,
			"(" => -56,
			'OP19_LOOP_CONTROL' => -56,
			'WORD' => -56,
			"[" => -56,
			"if (" => -56,
			"undef" => -56,
			'OP22_LOGICAL_NOT' => -56,
			"while (" => -56,
			"for my integer" => -56,
			"::" => 375,
			"foreach my" => -56,
			"my" => -56,
			"%{" => -56,
			'OP05_MATH_NEG' => -56,
			'OP01_NAMED' => -56,
			'OP05_LOGICAL_NEG' => -56,
			'LITERAL' => -56,
			"\@{" => -56,
			'OP10_NAMED_UNARY' => -56,
			'OP01_NAMED_VOID_PAREN' => -56,
			"{" => -56
		},
		GOTOS => {
			'ArgumentCheck' => 376
		}
	},
	{#State 370
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 377
		}
	},
	{#State 371
		ACTIONS => {
			'VARIABLE_SYMBOL' => 55,
			'OP01_NAMED_VOID' => 56,
			'OP03_MATH_INC_DEC' => 54,
			'OP19_LOOP_CONTROL' => 69,
			"(" => 71,
			'WORD' => 70,
			"[" => 53,
			"while (" => -149,
			"if (" => 59,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			"foreach my" => -149,
			"my" => 63,
			"for my integer" => -149,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"%{" => 40,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 49,
			"\@{" => 47,
			"{" => 43,
			'OP01_NAMED_VOID_PAREN' => 44
		},
		GOTOS => {
			'Expression' => 68,
			'HashDereferenced' => 46,
			'Variable' => 66,
			'VariableModification' => 67,
			'Conditional' => 65,
			'OPTIONAL-47' => 64,
			'PLUS-35' => 379,
			'ArrayDereferenced' => 62,
			'HashReference' => 61,
			'OperatorVoid' => 39,
			'Operation' => 378,
			'Statement' => 76,
			'PAREN-46' => 75,
			'VariableDeclaration' => 74,
			'WordScoped' => 73,
			'LoopLabel' => 72,
			'ArrayReference' => 52,
			'Operator' => 51
		}
	},
	{#State 372
		DEFAULT => -80
	},
	{#State 373
		ACTIONS => {
			'LITERAL' => 380
		}
	},
	{#State 374
		DEFAULT => -38
	},
	{#State 375
		ACTIONS => {
			'CHECK_OR_CHECKTRACE' => 381
		}
	},
	{#State 376
		DEFAULT => -54
	},
	{#State 377
		DEFAULT => -87,
		GOTOS => {
			'STAR-37' => 382
		}
	},
	{#State 378
		DEFAULT => -83
	},
	{#State 379
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => 44,
			"{" => 43,
			'OP05_LOGICAL_NEG' => 45,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			'LITERAL' => 49,
			"%{" => 40,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"for my integer" => -149,
			"foreach my" => -149,
			"my" => 63,
			"}" => 383,
			'OP22_LOGICAL_NOT' => 60,
			"if (" => 59,
			"undef" => 58,
			"while (" => -149,
			'WORD' => 70,
			"(" => 71,
			'OP19_LOOP_CONTROL' => 69,
			"[" => 53,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55,
			'OP01_NAMED_VOID' => 56
		},
		GOTOS => {
			'Conditional' => 65,
			'OPTIONAL-47' => 64,
			'Variable' => 66,
			'VariableModification' => 67,
			'HashDereferenced' => 46,
			'Expression' => 68,
			'Operation' => 384,
			'OperatorVoid' => 39,
			'HashReference' => 61,
			'ArrayDereferenced' => 62,
			'VariableDeclaration' => 74,
			'PAREN-46' => 75,
			'Statement' => 76,
			'Operator' => 51,
			'ArrayReference' => 52,
			'LoopLabel' => 72,
			'WordScoped' => 73
		}
	},
	{#State 380
		DEFAULT => -40
	},
	{#State 381
		ACTIONS => {
			"(" => 385
		}
	},
	{#State 382
		ACTIONS => {
			'OP21_LIST_COMMA' => 388,
			")" => 387
		},
		GOTOS => {
			'PAREN-36' => 386
		}
	},
	{#State 383
		ACTIONS => {
			";" => 389
		}
	},
	{#State 384
		DEFAULT => -82
	},
	{#State 385
		ACTIONS => {
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			"(" => 71,
			'OP05_MATH_NEG' => 41,
			'WORD' => 12,
			'OP01_NAMED' => 42,
			"[" => 53,
			"%{" => 40,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			"{" => 43
		},
		GOTOS => {
			'Operator' => 51,
			'ArrayReference' => 52,
			'HashReference' => 61,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73,
			'Variable' => 89,
			'Expression' => 390,
			'HashDereferenced' => 46
		}
	},
	{#State 386
		DEFAULT => -86
	},
	{#State 387
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 391
		}
	},
	{#State 388
		ACTIONS => {
			"my" => 392
		}
	},
	{#State 389
		DEFAULT => -84
	},
	{#State 390
		ACTIONS => {
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP21_LIST_COMMA' => 395,
			'OP13_BITWISE_AND' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 145,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			")" => -59,
			'OP11_COMPARE_LT_GT' => 140,
			'OP23_LOGICAL_AND' => 142,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143
		},
		GOTOS => {
			'OPTIONAL-24' => 393,
			'PAREN-23' => 394
		}
	},
	{#State 391
		ACTIONS => {
			"\@_;" => 396
		}
	},
	{#State 392
		ACTIONS => {
			'WORD' => 110
		},
		GOTOS => {
			'Type' => 397
		}
	},
	{#State 393
		ACTIONS => {
			")" => 398
		}
	},
	{#State 394
		DEFAULT => -58
	},
	{#State 395
		ACTIONS => {
			"{" => 43,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'OP05_LOGICAL_NEG' => 45,
			'LITERAL' => 49,
			'OP10_NAMED_UNARY' => 48,
			"\@{" => 47,
			"%{" => 40,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			'OP01_NAMED' => 42,
			"(" => 71,
			"[" => 53,
			'OP03_MATH_INC_DEC' => 54,
			'VARIABLE_SYMBOL' => 55
		},
		GOTOS => {
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 399,
			'WordScoped' => 73,
			'ArrayDereferenced' => 62,
			'Operator' => 51,
			'ArrayReference' => 52,
			'HashReference' => 61
		}
	},
	{#State 396
		DEFAULT => -89,
		GOTOS => {
			'STAR-38' => 400
		}
	},
	{#State 397
		ACTIONS => {
			'VARIABLE_SYMBOL' => 401
		}
	},
	{#State 398
		ACTIONS => {
			";" => 402
		}
	},
	{#State 399
		ACTIONS => {
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			'OP21_LIST_COMMA' => 403,
			'OP13_BITWISE_AND' => 139,
			'OP08_STRING_CAT' => 149,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP23_LOGICAL_AND' => 142,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP11_COMPARE_LT_GT' => 140,
			'OP12_COMPARE_EQ_NEQ' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 400
		ACTIONS => {
			"\@{" => -90,
			'OP10_NAMED_UNARY' => -90,
			'LITERAL' => -90,
			'OP05_LOGICAL_NEG' => -90,
			"{" => -90,
			'OP01_NAMED_VOID_PAREN' => -90,
			"for my integer" => -90,
			"my" => -90,
			"foreach my" => -90,
			"::" => 375,
			"%{" => -90,
			'OP01_NAMED' => -90,
			'OP05_MATH_NEG' => -90,
			'OP22_LOGICAL_NOT' => -90,
			"undef" => -90,
			"if (" => -90,
			"while (" => -90,
			'OP03_MATH_INC_DEC' => -90,
			'OP01_NAMED_VOID' => -90,
			'VARIABLE_SYMBOL' => -90,
			"[" => -90,
			"(" => -90,
			'OP19_LOOP_CONTROL' => -90,
			'WORD' => -90
		},
		GOTOS => {
			'ArgumentCheck' => 404
		}
	},
	{#State 401
		DEFAULT => -85
	},
	{#State 402
		DEFAULT => -60
	},
	{#State 403
		ACTIONS => {
			"[" => 53,
			'WORD' => 12,
			'OP05_MATH_NEG' => 41,
			"(" => 71,
			'OP01_NAMED' => 42,
			"%{" => 40,
			'VARIABLE_SYMBOL' => 55,
			'OP03_MATH_INC_DEC' => 54,
			"{" => 43,
			'LITERAL' => 49,
			"\@{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP05_LOGICAL_NEG' => 45,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58
		},
		GOTOS => {
			'Variable' => 89,
			'HashDereferenced' => 46,
			'Expression' => 405,
			'Operator' => 51,
			'HashReference' => 61,
			'ArrayReference' => 52,
			'ArrayDereferenced' => 62,
			'WordScoped' => 73
		}
	},
	{#State 404
		DEFAULT => -88
	},
	{#State 405
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP04_MATH_POW' => 147,
			'OP16_LOGICAL_OR' => 137,
			'OP18_TERNARY' => 138,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 149,
			'OP13_BITWISE_AND' => 139,
			")" => -57,
			'OP11_COMPARE_LT_GT' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP09_BITWISE_SHIFT' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP08_MATH_ADD_SUB' => 145,
			'OP24_LOGICAL_OR_XOR' => 133,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NEQ' => 135
		}
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5139 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5146 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 103 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5153 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5164 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5175 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 104 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5182 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 104 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5189 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 104 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5196 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 104 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5203 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 104 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5210 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 104 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5217 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-5', 2,
sub {
#line 104 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5224 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-5', 1,
sub {
#line 104 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5231 lib/RPerl/Grammar.pm
	],
	[#Rule Program_13
		 'Program', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5242 lib/RPerl/Grammar.pm
	],
	[#Rule Module_14
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5253 lib/RPerl/Grammar.pm
	],
	[#Rule Module_15
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5264 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5271 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5278 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5285 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5292 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5299 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 106 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5306 lib/RPerl/Grammar.pm
	],
	[#Rule Package_22
		 'Package', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5317 lib/RPerl/Grammar.pm
	],
	[#Rule Header_23
		 'Header', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5328 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-9', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5335 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-9', 1,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5342 lib/RPerl/Grammar.pm
	],
	[#Rule Include_26
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5353 lib/RPerl/Grammar.pm
	],
	[#Rule Include_27
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5364 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_28
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5375 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5382 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5389 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-11', 1,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5396 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-11', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5403 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-12', 3,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5410 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5417 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5424 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5431 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5438 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5445 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5452 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-16', 5,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5459 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5466 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5473 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_43
		 'ConstantValue', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5484 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_44
		 'ConstantValue', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5495 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_45
		 'ConstantValue', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5506 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5513 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5520 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-19', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5527 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-19', 1,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5534 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_50
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5545 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 4,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5552 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5559 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5566 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5573 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5580 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_56
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5591 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5598 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5605 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5612 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_60
		 'ArgumentCheck', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5623 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-25', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5630 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-25', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5637 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5644 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5651 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5658 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5665 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5672 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5679 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-29', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5686 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-29', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5693 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5700 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5707 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5714 lib/RPerl/Grammar.pm
	],
	[#Rule Class_74
		 'Class', 14,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5725 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5732 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5739 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5746 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_78
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5757 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_79
		 'Properties', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5768 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5775 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5782 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-35', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5789 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-35', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5796 lib/RPerl/Grammar.pm
	],
	[#Rule Method_84
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5807 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 4,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5814 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5821 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5828 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5835 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5842 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_90
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5853 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_91
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5864 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_92
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5875 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5882 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5889 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5900 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5911 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5933 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5944 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5955 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5966 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5977 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5988 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6010 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6021 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6032 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6043 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6065 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6076 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6087 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6098 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6109 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6120 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6131 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6142 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6149 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6156 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6163 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6170 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6177 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6184 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6191 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6198 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_126
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6209 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_127
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6220 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_128
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6231 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_129
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6242 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_130
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6253 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6260 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6267 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6274 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6281 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_135
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_136
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6303 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_137
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_138
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6325 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_139
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6336 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_140
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6347 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_141
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6358 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_142
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6369 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6380 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6391 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6413 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6420 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6427 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6434 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6445 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6456 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6467 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6478 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6489 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 4,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6496 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6503 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6510 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-50', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6517 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6524 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6531 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_161
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6542 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6553 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6564 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6575 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_165
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6586 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_166
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6597 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_167
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6608 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6615 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6622 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_170
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6633 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6640 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6647 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_173
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6658 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_174
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6669 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6680 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_176
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6691 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_177
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_178
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6713 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_179
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6724 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_180
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6735 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-54', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6742 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-55', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6749 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-55', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6756 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_184
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6767 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_185
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6778 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_186
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6789 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_187
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6800 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6814 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_190
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6825 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_191
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_192
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6847 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6854 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_195
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_196
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_197
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_198
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6905 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-58', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6912 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6919 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6926 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_202
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6937 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_203
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6948 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_204
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-60', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_208
		 'WordScoped', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_209
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_210
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule Type_211
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_212
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7035 lib/RPerl/Grammar.pm
	]
],
#line 7038 lib/RPerl/Grammar.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_135', 
         'Expression_136', 
         'Expression_137', 
         'Expression_138', 
         'Expression_139', 
         'Expression_140', 
         'Expression_141', 
         'Expression_142', 
         'Expression_143', 
         'Expression_144', 
         'Expression_145', 
         'Expression_146', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_150', 
         'Statement_151', 
         'Statement_152', 
         'Statement_153', 
         'Statement_154', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_161', 
         'Loop_162', 
         'Loop_163', 
         'Loop_164', 
         'LoopFor_165', 
         'LoopForEach_166', 
         'LoopWhile_167', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_170', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_173', 
         'VariableRetrieval_174', 
         'VariableRetrieval_175', 
         'VariableRetrieval_176', 
         'VariableDeclaration_177', 
         'VariableDeclaration_178', 
         'VariableModification_179', 
         'VariableModification_180', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_184', 
         'ListElement_185', 
         'ListElement_186', 
         'ListElement_187', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_190', 
         'ArrayDereferenced_191', 
         'ArrayDereferenced_192', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_195', 
         'HashEntry_196', 
         'HashEntryTyped_197', 
         'HashEntryTyped_198', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_202', 
         'HashDereferenced_203', 
         'HashDereferenced_204', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'WordScoped_208', 
         'FileHandle_209', 
         'TypeInner_210', 
         'Type_211', 
         'LoopLabel_212', );
  $self;
}

#line 161 "lib/RPerl/Grammar.eyp"


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


#line 7298 lib/RPerl/Grammar.pm



1;
