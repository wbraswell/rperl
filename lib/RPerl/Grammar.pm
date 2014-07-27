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
    our $VERSION = 0.000_700;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G(\s*(\#.+)*\s*)+/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|our\ \$VERSION\ \=|for\ my\ integer|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|use\ Carp\;|\$TYPED_|package|while\ \(|\=\ sub\ \{|elsif\ \(|undef|\(\ my|1\;1\;|else|if\ \(|qw\(|our|use|\@_\;|\{\*|\@\{|\.\.|\%\{|my|\[|\(|\}|\]|\/|\)|\;|\{)}gc and return ($1, $1);

      /\G(^(\#\!\/[\w\/]*\/perl)$)/gc and return ('SHEBANG', $1);
      /\G(\d+\.\d{3}\_\d{3})/gc and return ('VERSION_NUMBER', $1);
      /\G((-?\d+(\.\d+)?)|('[^']*')|("[^"]*"))/gc and return ('LITERAL', $1);
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


#line 113 lib/RPerl/Grammar.pm

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
  [ 'ArgumentCheck_60' => 'ArgumentCheck', [ 'CHECK_OR_CHECKTRACE', '(', 'Expression', 'OPTIONAL-24', ')', ';' ], 0 ],
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
  [ 'Operator_107' => 'Operator', [ 'OP10_NAMED_UNARY_STRINGIFY', 'Expression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'Expression', 'OP11_COMPARE_LT_GT', 'Expression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'Expression', 'OP12_COMPARE_EQ_NEQ', 'Expression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'Expression', 'OP13_BITWISE_AND', 'Expression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'Expression', 'OP14_BITWISE_OR_XOR', 'Expression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'Expression', 'OP15_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'Expression', 'OP16_LOGICAL_OR', 'Expression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'Expression', 'OP17_LIST_RANGE', 'Expression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'Expression', 'OP18_TERNARY', 'Variable', 'COLON', 'Variable' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'OP22_LOGICAL_NOT', 'Expression' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'Expression', 'OP23_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_118' => 'Operator', [ 'Expression', 'OP24_LOGICAL_OR_XOR', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'OperatorVoid_127' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'OPTIONAL-40', ')', ';' ], 0 ],
  [ 'OperatorVoid_128' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'FileHandle', 'OPTIONAL-41', ')', ';' ], 0 ],
  [ 'OperatorVoid_129' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-42', ';' ], 0 ],
  [ 'OperatorVoid_130' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'FileHandle', 'OPTIONAL-43', ';' ], 0 ],
  [ 'OperatorVoid_131' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'Expression_136' => 'Expression', [ 'undef' ], 0 ],
  [ 'Expression_137' => 'Expression', [ 'LITERAL' ], 0 ],
  [ 'Expression_138' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_139' => 'Expression', [ 'ArrayReference' ], 0 ],
  [ 'Expression_140' => 'Expression', [ 'ArrayDereferenced' ], 0 ],
  [ 'Expression_141' => 'Expression', [ 'HashReference' ], 0 ],
  [ 'Expression_142' => 'Expression', [ 'HashDereferenced' ], 0 ],
  [ 'Expression_143' => 'Expression', [ '{', '}' ], 0 ],
  [ 'Expression_144' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_145' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-44', ')' ], 0 ],
  [ 'Expression_146' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-45', ')' ], 0 ],
  [ 'Expression_147' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'PAREN-46' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'OPTIONAL-47', 'Loop' ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_154' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_155' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-48', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [ 'STAR-49', 'PAREN-48' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [  ], 0 ],
  [ '_PAREN' => 'PAREN-50', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'PAREN-50' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'Conditional_162' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-49', 'OPTIONAL-51' ], 0 ],
  [ 'Loop_163' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_164' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_165' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_166' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_167' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_168' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'PLUS-52', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'Operation' ], 0 ],
  [ 'CodeBlock_171' => 'CodeBlock', [ '{', 'PLUS-52', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [ 'STAR-53', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [  ], 0 ],
  [ 'Variable_174' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-53' ], 0 ],
  [ 'VariableRetrieval_175' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_176' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_177' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_178' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_179' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_180' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_181' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-54', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-55', [ 'STAR-55', 'PAREN-54' ], 0 ],
  [ '_STAR_LIST' => 'STAR-55', [  ], 0 ],
  [ 'ListElements_185' => 'ListElements', [ 'ListElement', 'STAR-55' ], 0 ],
  [ 'ListElement_186' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_187' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_188' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [  ], 0 ],
  [ 'ArrayReference_191' => 'ArrayReference', [ '[', 'OPTIONAL-56', ']' ], 0 ],
  [ 'ArrayDereferenced_192' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_193' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [  ], 0 ],
  [ 'HashEntry_196' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-57', 'Expression' ], 0 ],
  [ 'HashEntry_197' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_198' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_199' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-58', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [ 'STAR-59', 'PAREN-58' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [  ], 0 ],
  [ 'HashReference_203' => 'HashReference', [ '{', 'HashEntry', 'STAR-59', '}' ], 0 ],
  [ 'HashDereferenced_204' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_205' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_206' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_207' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'FileHandle_208' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'TypeInner_209' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Type_210' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_211' => 'LoopLabel', [ 'WORD' ], 0 ],
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
  'Operator_118' => 118,
  '_OPTIONAL' => 119,
  '_OPTIONAL' => 120,
  '_OPTIONAL' => 121,
  '_OPTIONAL' => 122,
  '_OPTIONAL' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  'OperatorVoid_127' => 127,
  'OperatorVoid_128' => 128,
  'OperatorVoid_129' => 129,
  'OperatorVoid_130' => 130,
  'OperatorVoid_131' => 131,
  '_OPTIONAL' => 132,
  '_OPTIONAL' => 133,
  '_OPTIONAL' => 134,
  '_OPTIONAL' => 135,
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
  'Expression_147' => 147,
  '_PAREN' => 148,
  '_OPTIONAL' => 149,
  '_OPTIONAL' => 150,
  'Statement_151' => 151,
  'Statement_152' => 152,
  'Statement_153' => 153,
  'Statement_154' => 154,
  'Statement_155' => 155,
  '_PAREN' => 156,
  '_STAR_LIST' => 157,
  '_STAR_LIST' => 158,
  '_PAREN' => 159,
  '_OPTIONAL' => 160,
  '_OPTIONAL' => 161,
  'Conditional_162' => 162,
  'Loop_163' => 163,
  'Loop_164' => 164,
  'Loop_165' => 165,
  'LoopFor_166' => 166,
  'LoopForEach_167' => 167,
  'LoopWhile_168' => 168,
  '_PLUS_LIST' => 169,
  '_PLUS_LIST' => 170,
  'CodeBlock_171' => 171,
  '_STAR_LIST' => 172,
  '_STAR_LIST' => 173,
  'Variable_174' => 174,
  'VariableRetrieval_175' => 175,
  'VariableRetrieval_176' => 176,
  'VariableRetrieval_177' => 177,
  'VariableDeclaration_178' => 178,
  'VariableDeclaration_179' => 179,
  'VariableModification_180' => 180,
  'VariableModification_181' => 181,
  '_PAREN' => 182,
  '_STAR_LIST' => 183,
  '_STAR_LIST' => 184,
  'ListElements_185' => 185,
  'ListElement_186' => 186,
  'ListElement_187' => 187,
  'ListElement_188' => 188,
  '_OPTIONAL' => 189,
  '_OPTIONAL' => 190,
  'ArrayReference_191' => 191,
  'ArrayDereferenced_192' => 192,
  'ArrayDereferenced_193' => 193,
  '_OPTIONAL' => 194,
  '_OPTIONAL' => 195,
  'HashEntry_196' => 196,
  'HashEntry_197' => 197,
  'HashEntryTyped_198' => 198,
  'HashEntryTyped_199' => 199,
  '_PAREN' => 200,
  '_STAR_LIST' => 201,
  '_STAR_LIST' => 202,
  'HashReference_203' => 203,
  'HashDereferenced_204' => 204,
  'HashDereferenced_205' => 205,
  'WordScoped_206' => 206,
  'WordScoped_207' => 207,
  'FileHandle_208' => 208,
  'TypeInner_209' => 209,
  'Type_210' => 210,
  'LoopLabel_211' => 211,
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
	COLON => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 8,
			"package" => 7
		},
		GOTOS => {
			'Module' => 1,
			'Class' => 2,
			'Package' => 4,
			'CompileUnit' => 5,
			'PLUS-1' => 6,
			'Program' => 3
		}
	},
	{#State 1
		DEFAULT => -2
	},
	{#State 2
		DEFAULT => -15
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		DEFAULT => -14
	},
	{#State 5
		ACTIONS => {
			'' => 9
		}
	},
	{#State 6
		ACTIONS => {
			'' => -4,
			"package" => 7
		},
		GOTOS => {
			'Package' => 4,
			'Class' => 2,
			'Module' => 10
		}
	},
	{#State 7
		ACTIONS => {
			'WORD_SCOPED' => 11,
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 12
		}
	},
	{#State 8
		ACTIONS => {
			"use strict;" => 14
		},
		GOTOS => {
			'Header' => 15
		}
	},
	{#State 9
		DEFAULT => 0
	},
	{#State 10
		DEFAULT => -1
	},
	{#State 11
		DEFAULT => -207
	},
	{#State 12
		ACTIONS => {
			";" => 16
		}
	},
	{#State 13
		DEFAULT => -206
	},
	{#State 14
		ACTIONS => {
			"use warnings;" => 17
		}
	},
	{#State 15
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 18
		}
	},
	{#State 16
		ACTIONS => {
			"use strict;" => 14
		},
		GOTOS => {
			'Header' => 19
		}
	},
	{#State 17
		ACTIONS => {
			"our \$VERSION =" => 20
		}
	},
	{#State 18
		ACTIONS => {
			"{" => -8,
			'OP01_NAMED_VOID' => -8,
			"for my integer" => -8,
			'WORD' => -8,
			'OP22_LOGICAL_NOT' => -8,
			'OP10_NAMED_UNARY' => -8,
			"%{" => -8,
			'OP05_MATH_NEG' => -8,
			'OP19_LOOP_CONTROL' => -8,
			"our" => -8,
			'OP01_NAMED' => -8,
			"if (" => -8,
			'LITERAL' => -8,
			'OP03_MATH_INC_DEC' => -8,
			"foreach my" => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"undef" => -8,
			"\@{" => -8,
			"[" => -8,
			"my" => -8,
			"while (" => -8,
			'OP05_LOGICAL_NEG' => -8,
			'WORD_SCOPED' => -8,
			"(" => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			"use" => 21,
			'VARIABLE_SYMBOL' => -8,
			"use constant" => -8
		},
		GOTOS => {
			'STAR-3' => 22,
			'Include' => 23
		}
	},
	{#State 19
		ACTIONS => {
			"use constant" => -17,
			"use" => -17,
			"use parent qw(" => 24,
			"our" => -17
		},
		GOTOS => {
			'STAR-6' => 25
		}
	},
	{#State 20
		ACTIONS => {
			'VERSION_NUMBER' => 26
		}
	},
	{#State 21
		ACTIONS => {
			'WORD_SCOPED' => 11,
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 22
		ACTIONS => {
			"my" => -10,
			"while (" => -10,
			"(" => -10,
			'WORD_SCOPED' => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			'OP05_LOGICAL_NEG' => -10,
			"use constant" => 28,
			'VARIABLE_SYMBOL' => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"undef" => -10,
			"\@{" => -10,
			"[" => -10,
			'OP01_NAMED' => -10,
			"our" => -10,
			"if (" => -10,
			'LITERAL' => -10,
			"foreach my" => -10,
			'OP03_MATH_INC_DEC' => -10,
			'WORD' => -10,
			'OP22_LOGICAL_NOT' => -10,
			'OP01_NAMED_VOID' => -10,
			"for my integer" => -10,
			"{" => -10,
			"%{" => -10,
			'OP10_NAMED_UNARY' => -10,
			'OP05_MATH_NEG' => -10,
			'OP19_LOOP_CONTROL' => -10
		},
		GOTOS => {
			'Constant' => 30,
			'STAR-4' => 29
		}
	},
	{#State 23
		DEFAULT => -5
	},
	{#State 24
		ACTIONS => {
			'WORD_SCOPED' => 11,
			'WORD' => 13
		},
		GOTOS => {
			'PLUS-25' => 31,
			'WordScoped' => 32
		}
	},
	{#State 25
		ACTIONS => {
			"our" => -19,
			"use" => 21,
			"use constant" => -19
		},
		GOTOS => {
			'Include' => 33,
			'STAR-7' => 34
		}
	},
	{#State 26
		ACTIONS => {
			";" => 35
		}
	},
	{#State 27
		ACTIONS => {
			"qw(" => 37,
			";" => 36
		}
	},
	{#State 28
		ACTIONS => {
			'WORD' => 38
		}
	},
	{#State 29
		ACTIONS => {
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'WORD' => 45,
			'OP22_LOGICAL_NOT' => 44,
			'OP01_NAMED_VOID' => 72,
			"for my integer" => -150,
			"{" => 46,
			'OP19_LOOP_CONTROL' => 43,
			'OP05_MATH_NEG' => 66,
			"if (" => 42,
			"our" => 41,
			'OP01_NAMED' => 63,
			"foreach my" => -150,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"undef" => 60,
			'OP01_NAMED_VOID_PAREN' => 79,
			"\@{" => 59,
			"[" => 78,
			"while (" => -150,
			"my" => 75,
			'VARIABLE_SYMBOL' => 53,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_LOGICAL_NEG' => 74
		},
		GOTOS => {
			'HashReference' => 77,
			'Subroutine' => 58,
			'OPTIONAL-47' => 76,
			'VariableModification' => 51,
			'PAREN-46' => 52,
			'ArrayReference' => 54,
			'LoopLabel' => 55,
			'Variable' => 57,
			'WordScoped' => 56,
			'Statement' => 70,
			'Operation' => 67,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashDereferenced' => 49,
			'OperatorVoid' => 71,
			'PLUS-5' => 61,
			'Conditional' => 39,
			'VariableDeclaration' => 65,
			'Expression' => 64
		}
	},
	{#State 30
		DEFAULT => -7
	},
	{#State 31
		ACTIONS => {
			")" => 80,
			'WORD_SCOPED' => 11,
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 81
		}
	},
	{#State 32
		DEFAULT => -62
	},
	{#State 33
		DEFAULT => -16
	},
	{#State 34
		ACTIONS => {
			"our" => 41,
			"use constant" => 28
		},
		GOTOS => {
			'PLUS-8' => 84,
			'Subroutine' => 82,
			'Constant' => 83
		}
	},
	{#State 35
		ACTIONS => {
			"use Carp;" => 85
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			'WORD' => 87
		},
		GOTOS => {
			'PLUS-9' => 86
		}
	},
	{#State 38
		ACTIONS => {
			'OP20_HASH_FATARROW' => 88
		}
	},
	{#State 39
		DEFAULT => -151
	},
	{#State 40
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Variable' => 89
		}
	},
	{#State 41
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 91
		}
	},
	{#State 42
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 60,
			"\@{" => 59,
			"[" => 78,
			'OP01_NAMED' => 63,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP05_MATH_NEG' => 66
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashReference' => 77,
			'Expression' => 93,
			'ArrayReference' => 54,
			'WordScoped' => 56,
			'Variable' => 92
		}
	},
	{#State 43
		ACTIONS => {
			'WORD' => 94
		},
		GOTOS => {
			'LoopLabel' => 95
		}
	},
	{#State 44
		ACTIONS => {
			"{" => 46,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			'OP05_MATH_NEG' => 66,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"undef" => 60,
			"\@{" => 59,
			"[" => 78,
			'OP05_LOGICAL_NEG' => 74,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'Expression' => 96,
			'HashReference' => 77,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashDereferenced' => 49
		}
	},
	{#State 45
		ACTIONS => {
			"(" => -206,
			'COLON' => -211
		}
	},
	{#State 46
		ACTIONS => {
			"%{" => 47,
			"}" => 99,
			'WORD' => 97
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'HashEntry' => 100
		}
	},
	{#State 47
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			"{" => 102
		},
		GOTOS => {
			'Variable' => 103,
			'HashReference' => 101
		}
	},
	{#State 48
		ACTIONS => {
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			"{" => 46,
			'OP05_MATH_NEG' => 66,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"undef" => 60,
			"\@{" => 59,
			"[" => 78,
			'VARIABLE_SYMBOL' => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 74
		},
		GOTOS => {
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'Expression' => 104,
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashDereferenced' => 49
		}
	},
	{#State 49
		DEFAULT => -142
	},
	{#State 50
		ACTIONS => {
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			"{" => 46,
			'OP05_MATH_NEG' => 66,
			'VARIABLE_SYMBOL' => 53,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 60,
			"\@{" => 59,
			"[" => 78
		},
		GOTOS => {
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'Expression' => 105,
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashDereferenced' => 49
		}
	},
	{#State 51
		DEFAULT => -155
	},
	{#State 52
		DEFAULT => -149
	},
	{#State 53
		DEFAULT => -173,
		GOTOS => {
			'STAR-53' => 106
		}
	},
	{#State 54
		DEFAULT => -139
	},
	{#State 55
		ACTIONS => {
			'COLON' => 107
		}
	},
	{#State 56
		ACTIONS => {
			"(" => 108
		}
	},
	{#State 57
		ACTIONS => {
			'OP16_LOGICAL_OR' => -138,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			'OP23_LOGICAL_AND' => -138,
			";" => -138,
			'OP03_MATH_INC_DEC' => 111,
			'OP12_COMPARE_EQ_NEQ' => -138,
			'OP08_STRING_CAT' => -138,
			'OP18_TERNARY' => -138,
			'OP19_VARIABLE_ASSIGN' => 110,
			'OP11_COMPARE_LT_GT' => -138,
			'OP13_BITWISE_AND' => -138,
			'OP14_BITWISE_OR_XOR' => -138,
			'OP24_LOGICAL_OR_XOR' => -138,
			'OP17_LIST_RANGE' => -138,
			'OP19_VARIABLE_ASSIGN_BY' => 112,
			'OP09_BITWISE_SHIFT' => -138,
			'OP06_REGEX_MATCH' => -138,
			'OP04_MATH_POW' => -138,
			'OP15_LOGICAL_AND' => -138,
			'OP02_METHOD_THINARROW' => 109,
			'OP08_MATH_ADD_SUB' => -138
		}
	},
	{#State 58
		DEFAULT => -9
	},
	{#State 59
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			"[" => 78
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Variable' => 113
		}
	},
	{#State 60
		DEFAULT => -136
	},
	{#State 61
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'VARIABLE_SYMBOL' => 53,
			"my" => 75,
			"while (" => -150,
			"[" => 78,
			"\@{" => 59,
			'OP01_NAMED_VOID_PAREN' => 79,
			"undef" => 60,
			"foreach my" => -150,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'OP01_NAMED' => 63,
			'' => -13,
			"if (" => 42,
			'OP05_MATH_NEG' => 66,
			'OP19_LOOP_CONTROL' => 43,
			"for my integer" => -150,
			'OP01_NAMED_VOID' => 72,
			"{" => 46,
			'WORD' => 45,
			'OP22_LOGICAL_NOT' => 44,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47
		},
		GOTOS => {
			'VariableDeclaration' => 65,
			'Expression' => 64,
			'Conditional' => 39,
			'HashDereferenced' => 49,
			'OperatorVoid' => 71,
			'Statement' => 70,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'Operation' => 115,
			'Variable' => 57,
			'WordScoped' => 56,
			'LoopLabel' => 55,
			'ArrayReference' => 54,
			'PAREN-46' => 52,
			'VariableModification' => 51,
			'HashReference' => 77,
			'OPTIONAL-47' => 76
		}
	},
	{#State 62
		DEFAULT => -137
	},
	{#State 63
		ACTIONS => {
			"(" => 116
		}
	},
	{#State 64
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126,
			";" => 128,
			'OP23_LOGICAL_AND' => 127,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124,
			'OP17_LIST_RANGE' => 120,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP08_MATH_ADD_SUB' => 129,
			'OP09_BITWISE_SHIFT' => 117,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 118,
			'OP04_MATH_POW' => 119
		}
	},
	{#State 65
		DEFAULT => -154
	},
	{#State 66
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			"[" => 78,
			"\@{" => 59,
			"undef" => 60,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			'OP05_MATH_NEG' => 66,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44
		},
		GOTOS => {
			'HashReference' => 77,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashDereferenced' => 49,
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56,
			'Expression' => 134
		}
	},
	{#State 67
		DEFAULT => -12
	},
	{#State 68
		DEFAULT => -144
	},
	{#State 69
		DEFAULT => -140
	},
	{#State 70
		DEFAULT => -92
	},
	{#State 71
		DEFAULT => -153
	},
	{#State 72
		ACTIONS => {
			'OP05_MATH_NEG' => 66,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			";" => -124,
			'OP01_NAMED' => 63,
			"\@{" => 59,
			"[" => 78,
			"undef" => 60,
			"{*" => 136,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53,
			"my" => 135,
			'KEYS_OR_VALUES' => 140
		},
		GOTOS => {
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56,
			'TypeInner' => 143,
			'Expression' => 137,
			'OPTIONAL-42' => 139,
			'ListElement' => 141,
			'HashReference' => 77,
			'ListElements' => 138,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashDereferenced' => 49,
			'FileHandle' => 142
		}
	},
	{#State 73
		ACTIONS => {
			'OP05_MATH_NEG' => 66,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			"{" => 46,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'OP01_NAMED' => 63,
			"[" => 78,
			"\@{" => 59,
			"undef" => 60,
			'VARIABLE_SYMBOL' => 53,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_LOGICAL_NEG' => 74
		},
		GOTOS => {
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashDereferenced' => 49,
			'ArrayReference' => 54,
			'WordScoped' => 56,
			'Variable' => 92,
			'Expression' => 144
		}
	},
	{#State 74
		ACTIONS => {
			'OP05_MATH_NEG' => 66,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			"\@{" => 59,
			"[" => 78,
			"undef" => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'Expression' => 145,
			'HashDereferenced' => 49,
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69
		}
	},
	{#State 75
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 146
		}
	},
	{#State 76
		ACTIONS => {
			"foreach my" => 152,
			"for my integer" => 147,
			"while (" => 149
		},
		GOTOS => {
			'Loop' => 153,
			'LoopFor' => 151,
			'LoopForEach' => 150,
			'LoopWhile' => 148
		}
	},
	{#State 77
		DEFAULT => -141
	},
	{#State 78
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 74,
			"my" => 135,
			'KEYS_OR_VALUES' => 140,
			"\@{" => 59,
			"[" => 78,
			"]" => -190,
			"undef" => 60,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			'OP05_MATH_NEG' => 66,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			"{" => 46
		},
		GOTOS => {
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'ListElements' => 154,
			'HashReference' => 77,
			'HashDereferenced' => 49,
			'OPTIONAL-56' => 155,
			'Expression' => 137,
			'ListElement' => 141,
			'TypeInner' => 143,
			'Variable' => 92,
			'WordScoped' => 56,
			'ArrayReference' => 54
		}
	},
	{#State 79
		ACTIONS => {
			")" => -120,
			'OP05_MATH_NEG' => 66,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			"\@{" => 59,
			"[" => 78,
			"{*" => 136,
			"undef" => 60,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'KEYS_OR_VALUES' => 140,
			"my" => 135
		},
		GOTOS => {
			'FileHandle' => 156,
			'OPTIONAL-40' => 157,
			'HashDereferenced' => 49,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'ListElements' => 158,
			'HashReference' => 77,
			'ListElement' => 141,
			'Expression' => 137,
			'TypeInner' => 143,
			'Variable' => 92,
			'WordScoped' => 56,
			'ArrayReference' => 54
		}
	},
	{#State 80
		ACTIONS => {
			";" => 159
		}
	},
	{#State 81
		DEFAULT => -61
	},
	{#State 82
		DEFAULT => -21
	},
	{#State 83
		DEFAULT => -18
	},
	{#State 84
		ACTIONS => {
			"our" => 41,
			"1;1;" => 161
		},
		GOTOS => {
			'Subroutine' => 160
		}
	},
	{#State 85
		ACTIONS => {
			"use RPerl;" => 162
		}
	},
	{#State 86
		ACTIONS => {
			'WORD' => 163,
			")" => 164
		}
	},
	{#State 87
		DEFAULT => -25
	},
	{#State 88
		ACTIONS => {
			"my" => 135
		},
		GOTOS => {
			'TypeInner' => 165
		}
	},
	{#State 89
		DEFAULT => -96
	},
	{#State 90
		DEFAULT => -210
	},
	{#State 91
		ACTIONS => {
			'VARIABLE_SYMBOL' => 166
		}
	},
	{#State 92
		ACTIONS => {
			'OP17_LIST_RANGE' => -138,
			".." => -138,
			'OP21_LIST_COMMA' => -138,
			'OP13_BITWISE_AND' => -138,
			'OP11_COMPARE_LT_GT' => -138,
			'OP14_BITWISE_OR_XOR' => -138,
			'OP24_LOGICAL_OR_XOR' => -138,
			'OP08_MATH_ADD_SUB' => -138,
			"]" => -138,
			'OP09_BITWISE_SHIFT' => -138,
			'OP04_MATH_POW' => -138,
			'OP15_LOGICAL_AND' => -138,
			'OP06_REGEX_MATCH' => -138,
			'OP02_METHOD_THINARROW' => 109,
			'OP12_COMPARE_EQ_NEQ' => -138,
			'OP03_MATH_INC_DEC' => 111,
			'OP07_MATH_MULT_DIV_MOD' => -138,
			"}" => -138,
			'OP16_LOGICAL_OR' => -138,
			";" => -138,
			'OP23_LOGICAL_AND' => -138,
			")" => -138,
			'OP08_STRING_CAT' => -138,
			'OP18_TERNARY' => -138
		}
	},
	{#State 93
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP17_LIST_RANGE' => 120,
			'OP09_BITWISE_SHIFT' => 117,
			'OP15_LOGICAL_AND' => 118,
			'OP04_MATH_POW' => 119,
			'OP06_REGEX_MATCH' => 130,
			'OP08_MATH_ADD_SUB' => 129,
			'OP16_LOGICAL_OR' => 126,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => 127,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124,
			")" => 167
		}
	},
	{#State 94
		DEFAULT => -211
	},
	{#State 95
		ACTIONS => {
			";" => 168
		}
	},
	{#State 96
		ACTIONS => {
			'OP17_LIST_RANGE' => 120,
			".." => -116,
			'OP21_LIST_COMMA' => -116,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP08_MATH_ADD_SUB' => 129,
			"]" => -116,
			'OP09_BITWISE_SHIFT' => 117,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 118,
			'OP04_MATH_POW' => 119,
			'OP12_COMPARE_EQ_NEQ' => 125,
			"}" => -116,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126,
			";" => -116,
			'OP23_LOGICAL_AND' => -116,
			")" => -116,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124
		}
	},
	{#State 97
		ACTIONS => {
			'OP20_HASH_FATARROW' => 169
		}
	},
	{#State 98
		DEFAULT => -197
	},
	{#State 99
		DEFAULT => -143
	},
	{#State 100
		DEFAULT => -202,
		GOTOS => {
			'STAR-59' => 170
		}
	},
	{#State 101
		ACTIONS => {
			"}" => 171
		}
	},
	{#State 102
		ACTIONS => {
			"%{" => 47,
			'WORD' => 97
		},
		GOTOS => {
			'HashEntry' => 100,
			'HashDereferenced' => 98
		}
	},
	{#State 103
		ACTIONS => {
			"}" => 172
		}
	},
	{#State 104
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 129,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => -106,
			'OP04_MATH_POW' => 119,
			'OP09_BITWISE_SHIFT' => 117,
			"]" => -106,
			'OP21_LIST_COMMA' => -106,
			".." => -106,
			'OP17_LIST_RANGE' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP13_BITWISE_AND' => -106,
			")" => -106,
			'OP18_TERNARY' => -106,
			'OP08_STRING_CAT' => 123,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP23_LOGICAL_AND' => -106,
			";" => -106,
			'OP16_LOGICAL_OR' => -106,
			"}" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 133
		}
	},
	{#State 105
		ACTIONS => {
			'OP18_TERNARY' => -107,
			'OP08_STRING_CAT' => 123,
			")" => -107,
			";" => -107,
			'OP23_LOGICAL_AND' => -107,
			"}" => -107,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => -107,
			'OP12_COMPARE_EQ_NEQ' => -107,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => -107,
			'OP04_MATH_POW' => 119,
			'OP09_BITWISE_SHIFT' => 117,
			"]" => -107,
			'OP08_MATH_ADD_SUB' => 129,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP13_BITWISE_AND' => -107,
			'OP11_COMPARE_LT_GT' => -107,
			".." => -107,
			'OP21_LIST_COMMA' => -107,
			'OP17_LIST_RANGE' => -107
		}
	},
	{#State 106
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 174,
			'OP12_COMPARE_EQ_NEQ' => -174,
			'OP03_MATH_INC_DEC' => -174,
			'COLON' => -174,
			'OP07_MATH_MULT_DIV_MOD' => -174,
			"}" => -174,
			'OP16_LOGICAL_OR' => -174,
			";" => -174,
			'OP23_LOGICAL_AND' => -174,
			")" => -174,
			'OP02_HASH_THINARROW' => 173,
			'OP08_STRING_CAT' => -174,
			'OP18_TERNARY' => -174,
			'OP19_VARIABLE_ASSIGN_BY' => -174,
			'OP17_LIST_RANGE' => -174,
			".." => -174,
			'OP21_LIST_COMMA' => -174,
			'OP13_BITWISE_AND' => -174,
			'OP11_COMPARE_LT_GT' => -174,
			'OP19_VARIABLE_ASSIGN' => -174,
			'OP14_BITWISE_OR_XOR' => -174,
			'OP24_LOGICAL_OR_XOR' => -174,
			'OP08_MATH_ADD_SUB' => -174,
			"]" => -174,
			'OP09_BITWISE_SHIFT' => -174,
			'OP02_METHOD_THINARROW' => -174,
			'OP04_MATH_POW' => -174,
			'OP15_LOGICAL_AND' => -174,
			'OP06_REGEX_MATCH' => -174
		},
		GOTOS => {
			'VariableRetrieval' => 175
		}
	},
	{#State 107
		DEFAULT => -148
	},
	{#State 108
		ACTIONS => {
			"undef" => 60,
			"[" => 78,
			"\@{" => 59,
			'KEYS_OR_VALUES' => 140,
			"my" => 135,
			'OP05_LOGICAL_NEG' => 74,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'VARIABLE_SYMBOL' => 53,
			"{" => 46,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			'OP05_MATH_NEG' => 66,
			")" => -133,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62
		},
		GOTOS => {
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'ListElements' => 177,
			'HashReference' => 77,
			'HashDereferenced' => 49,
			'OPTIONAL-44' => 176,
			'Expression' => 137,
			'ListElement' => 141,
			'TypeInner' => 143,
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54
		}
	},
	{#State 109
		ACTIONS => {
			'WORD' => 178
		}
	},
	{#State 110
		ACTIONS => {
			"undef" => 60,
			"\@{" => 59,
			"[" => 78,
			'VARIABLE_SYMBOL' => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 74,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			'OP05_MATH_NEG' => 66,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62
		},
		GOTOS => {
			'Variable' => 92,
			'WordScoped' => 56,
			'ArrayReference' => 54,
			'Expression' => 179,
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashDereferenced' => 49
		}
	},
	{#State 111
		DEFAULT => -97
	},
	{#State 112
		ACTIONS => {
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			'OP05_MATH_NEG' => 66,
			'VARIABLE_SYMBOL' => 53,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 60,
			"\@{" => 59,
			"[" => 78
		},
		GOTOS => {
			'Expression' => 180,
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56,
			'HashDereferenced' => 49,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashReference' => 77
		}
	},
	{#State 113
		ACTIONS => {
			"}" => 181
		}
	},
	{#State 114
		ACTIONS => {
			"}" => 182
		}
	},
	{#State 115
		DEFAULT => -11
	},
	{#State 116
		ACTIONS => {
			"my" => 135,
			'KEYS_OR_VALUES' => 140,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 60,
			"[" => 78,
			"\@{" => 59,
			'OP01_NAMED' => 63,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP05_MATH_NEG' => 66,
			")" => -94
		},
		GOTOS => {
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'ListElements' => 183,
			'HashReference' => 77,
			'HashDereferenced' => 49,
			'OPTIONAL-39' => 184,
			'Expression' => 137,
			'ListElement' => 141,
			'TypeInner' => 143,
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54
		}
	},
	{#State 117
		ACTIONS => {
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"{" => 46,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			'OP05_MATH_NEG' => 66,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 60,
			"[" => 78,
			"\@{" => 59
		},
		GOTOS => {
			'Expression' => 185,
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashReference' => 77,
			'HashDereferenced' => 49
		}
	},
	{#State 118
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 74,
			"\@{" => 59,
			"[" => 78,
			"undef" => 60,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			'OP05_MATH_NEG' => 66,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46
		},
		GOTOS => {
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56,
			'Expression' => 186,
			'HashDereferenced' => 49,
			'HashReference' => 77,
			'ArrayDereferenced' => 69,
			'Operator' => 68
		}
	},
	{#State 119
		ACTIONS => {
			'OP01_NAMED' => 63,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			'OP05_MATH_NEG' => 66,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'WORD_SCOPED' => 11,
			"undef" => 60,
			"[" => 78,
			"\@{" => 59
		},
		GOTOS => {
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56,
			'Expression' => 187,
			'HashDereferenced' => 49,
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69
		}
	},
	{#State 120
		ACTIONS => {
			"undef" => 60,
			"[" => 78,
			"\@{" => 59,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			'OP05_MATH_NEG' => 66,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62
		},
		GOTOS => {
			'HashReference' => 77,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashDereferenced' => 49,
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'Expression' => 188
		}
	},
	{#State 121
		ACTIONS => {
			"undef" => 60,
			"[" => 78,
			"\@{" => 59,
			'OP05_LOGICAL_NEG' => 74,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'VARIABLE_SYMBOL' => 53,
			"{" => 46,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			'OP05_MATH_NEG' => 66,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashReference' => 77,
			'Expression' => 189,
			'Variable' => 92,
			'WordScoped' => 56,
			'ArrayReference' => 54
		}
	},
	{#State 122
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'OP01_NAMED' => 63,
			'OP05_MATH_NEG' => 66,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53,
			"\@{" => 59,
			"[" => 78,
			"undef" => 60
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashReference' => 77,
			'Expression' => 190,
			'Variable' => 92,
			'WordScoped' => 56,
			'ArrayReference' => 54
		}
	},
	{#State 123
		ACTIONS => {
			'OP01_NAMED' => 63,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			"{" => 46,
			'OP05_MATH_NEG' => 66,
			'VARIABLE_SYMBOL' => 53,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 60,
			"\@{" => 59,
			"[" => 78
		},
		GOTOS => {
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashReference' => 77,
			'HashDereferenced' => 49,
			'Expression' => 191,
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56
		}
	},
	{#State 124
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Variable' => 192
		}
	},
	{#State 125
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53,
			"[" => 78,
			"\@{" => 59,
			"undef" => 60,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'OP01_NAMED' => 63,
			'OP05_MATH_NEG' => 66,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48
		},
		GOTOS => {
			'HashReference' => 77,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashDereferenced' => 49,
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56,
			'Expression' => 193
		}
	},
	{#State 126
		ACTIONS => {
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53,
			"[" => 78,
			"\@{" => 59,
			"undef" => 60,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'OP01_NAMED' => 63,
			'OP05_MATH_NEG' => 66,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'HashReference' => 77,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'ArrayReference' => 54,
			'WordScoped' => 56,
			'Variable' => 92,
			'Expression' => 194
		}
	},
	{#State 127
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP05_MATH_NEG' => 66,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"undef" => 60,
			"\@{" => 59,
			"[" => 78,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Expression' => 195,
			'ArrayReference' => 54,
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashReference' => 77,
			'HashDereferenced' => 49
		}
	},
	{#State 128
		DEFAULT => -91
	},
	{#State 129
		ACTIONS => {
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			'OP05_MATH_NEG' => 66,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			"{" => 46,
			'VARIABLE_SYMBOL' => 53,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_LOGICAL_NEG' => 74,
			"\@{" => 59,
			"[" => 78,
			"undef" => 60
		},
		GOTOS => {
			'Expression' => 196,
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56,
			'HashDereferenced' => 49,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashReference' => 77
		}
	},
	{#State 130
		ACTIONS => {
			"/" => 197
		}
	},
	{#State 131
		ACTIONS => {
			'OP05_MATH_NEG' => 66,
			"{" => 46,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			"[" => 78,
			"\@{" => 59,
			"undef" => 60,
			'OP05_LOGICAL_NEG' => 74,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'ArrayReference' => 54,
			'WordScoped' => 56,
			'Variable' => 92,
			'Expression' => 198,
			'HashDereferenced' => 49,
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69
		}
	},
	{#State 132
		ACTIONS => {
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP05_MATH_NEG' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 60,
			"\@{" => 59,
			"[" => 78
		},
		GOTOS => {
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashReference' => 77,
			'HashDereferenced' => 49,
			'Expression' => 199,
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56
		}
	},
	{#State 133
		ACTIONS => {
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"{" => 46,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			'OP05_MATH_NEG' => 66,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 60,
			"\@{" => 59,
			"[" => 78
		},
		GOTOS => {
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashReference' => 77,
			'HashDereferenced' => 49,
			'Expression' => 200,
			'ArrayReference' => 54,
			'WordScoped' => 56,
			'Variable' => 92
		}
	},
	{#State 134
		ACTIONS => {
			")" => 201,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP16_LOGICAL_OR' => 126,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => 127,
			'OP08_MATH_ADD_SUB' => 129,
			'OP09_BITWISE_SHIFT' => 117,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130,
			'OP17_LIST_RANGE' => 120,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP14_BITWISE_OR_XOR' => 132
		}
	},
	{#State 135
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 202
		}
	},
	{#State 136
		ACTIONS => {
			'WORD' => 203
		}
	},
	{#State 137
		ACTIONS => {
			'OP16_LOGICAL_OR' => 126,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => 127,
			";" => -186,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124,
			")" => -186,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP17_LIST_RANGE' => 120,
			'OP21_LIST_COMMA' => -186,
			"]" => -186,
			'OP09_BITWISE_SHIFT' => 117,
			'OP06_REGEX_MATCH' => 130,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP08_MATH_ADD_SUB' => 129
		}
	},
	{#State 138
		DEFAULT => -123
	},
	{#State 139
		ACTIONS => {
			";" => 204
		}
	},
	{#State 140
		ACTIONS => {
			"%{" => 47
		},
		GOTOS => {
			'HashDereferenced' => 205
		}
	},
	{#State 141
		DEFAULT => -184,
		GOTOS => {
			'STAR-55' => 206
		}
	},
	{#State 142
		ACTIONS => {
			"\@{" => 59,
			"[" => 78,
			"undef" => 60,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'KEYS_OR_VALUES' => 140,
			"my" => 135,
			'OP05_MATH_NEG' => 66,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			";" => -126
		},
		GOTOS => {
			'Expression' => 137,
			'ListElement' => 141,
			'TypeInner' => 143,
			'Variable' => 92,
			'WordScoped' => 56,
			'ArrayReference' => 54,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'ListElements' => 207,
			'OPTIONAL-43' => 208,
			'HashReference' => 77,
			'HashDereferenced' => 49
		}
	},
	{#State 143
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_LOGICAL_NEG' => 74,
			"\@{" => 59,
			"[" => 78,
			"undef" => 60,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			'OP05_MATH_NEG' => 66,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46
		},
		GOTOS => {
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'Expression' => 209,
			'HashDereferenced' => 49,
			'HashReference' => 77,
			'ArrayDereferenced' => 69,
			'Operator' => 68
		}
	},
	{#State 144
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 129,
			'OP09_BITWISE_SHIFT' => 117,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130,
			'OP17_LIST_RANGE' => 120,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP14_BITWISE_OR_XOR' => 132,
			")" => 210,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126,
			'OP23_LOGICAL_AND' => 127
		}
	},
	{#State 145
		ACTIONS => {
			'OP17_LIST_RANGE' => -99,
			'OP21_LIST_COMMA' => -99,
			".." => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			"]" => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => -99,
			'OP06_REGEX_MATCH' => -99,
			'OP12_COMPARE_EQ_NEQ' => -99,
			'OP16_LOGICAL_OR' => -99,
			"}" => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP23_LOGICAL_AND' => -99,
			";" => -99,
			")" => -99,
			'OP08_STRING_CAT' => -99,
			'OP18_TERNARY' => -99
		}
	},
	{#State 146
		ACTIONS => {
			'VARIABLE_SYMBOL' => 211
		}
	},
	{#State 147
		ACTIONS => {
			'VARIABLE_SYMBOL' => 212
		}
	},
	{#State 148
		DEFAULT => -165
	},
	{#State 149
		ACTIONS => {
			"\@{" => 59,
			"[" => 78,
			"undef" => 60,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_MATH_NEG' => 66,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'OP01_NAMED' => 63
		},
		GOTOS => {
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashDereferenced' => 49,
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56,
			'Expression' => 213
		}
	},
	{#State 150
		DEFAULT => -164
	},
	{#State 151
		DEFAULT => -163
	},
	{#State 152
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 214
		}
	},
	{#State 153
		DEFAULT => -152
	},
	{#State 154
		DEFAULT => -189
	},
	{#State 155
		ACTIONS => {
			"]" => 215
		}
	},
	{#State 156
		ACTIONS => {
			"my" => 135,
			'KEYS_OR_VALUES' => 140,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53,
			"undef" => 60,
			"\@{" => 59,
			"[" => 78,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP05_MATH_NEG' => 66,
			")" => -122
		},
		GOTOS => {
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'OPTIONAL-41' => 216,
			'Expression' => 137,
			'ListElement' => 141,
			'TypeInner' => 143,
			'HashReference' => 77,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'ListElements' => 217,
			'HashDereferenced' => 49
		}
	},
	{#State 157
		ACTIONS => {
			")" => 218
		}
	},
	{#State 158
		DEFAULT => -119
	},
	{#State 159
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 219
		}
	},
	{#State 160
		DEFAULT => -20
	},
	{#State 161
		DEFAULT => -22
	},
	{#State 162
		DEFAULT => -23
	},
	{#State 163
		DEFAULT => -24
	},
	{#State 164
		ACTIONS => {
			";" => 220
		}
	},
	{#State 165
		ACTIONS => {
			"{" => 221,
			'LITERAL' => 223,
			"[" => 224
		},
		GOTOS => {
			'ConstantValue' => 222
		}
	},
	{#State 166
		ACTIONS => {
			"= sub {" => 225
		}
	},
	{#State 167
		ACTIONS => {
			"{" => 226
		},
		GOTOS => {
			'CodeBlock' => 227
		}
	},
	{#State 168
		DEFAULT => -131
	},
	{#State 169
		ACTIONS => {
			'OP05_MATH_NEG' => -195,
			"{" => -195,
			'WORD' => -195,
			'OP22_LOGICAL_NOT' => -195,
			'OP10_NAMED_UNARY' => -195,
			"%{" => -195,
			'OP03_MATH_INC_DEC' => -195,
			'LITERAL' => -195,
			'OP01_NAMED' => -195,
			"[" => -195,
			"\@{" => -195,
			"undef" => -195,
			'OP05_LOGICAL_NEG' => -195,
			'WORD_SCOPED' => -195,
			"(" => -195,
			'OP10_NAMED_UNARY_STRINGIFY' => -195,
			'VARIABLE_SYMBOL' => -195,
			"my" => 135
		},
		GOTOS => {
			'TypeInner' => 229,
			'OPTIONAL-57' => 228
		}
	},
	{#State 170
		ACTIONS => {
			'OP21_LIST_COMMA' => 232,
			"}" => 230
		},
		GOTOS => {
			'PAREN-58' => 231
		}
	},
	{#State 171
		DEFAULT => -205
	},
	{#State 172
		DEFAULT => -204
	},
	{#State 173
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			"(" => 73,
			"[" => 78,
			"\@{" => 59,
			"undef" => 60,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			'OP05_MATH_NEG' => 66,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'WORD' => 234,
			'OP22_LOGICAL_NOT' => 44
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashReference' => 77,
			'Expression' => 233,
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56
		}
	},
	{#State 174
		ACTIONS => {
			"\@{" => 59,
			"[" => 78,
			"undef" => 60,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53,
			'OP05_MATH_NEG' => 66,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'OP01_NAMED' => 63
		},
		GOTOS => {
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56,
			'Expression' => 235,
			'HashDereferenced' => 49,
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69
		}
	},
	{#State 175
		DEFAULT => -172
	},
	{#State 176
		ACTIONS => {
			")" => 236
		}
	},
	{#State 177
		DEFAULT => -132
	},
	{#State 178
		ACTIONS => {
			"(" => 237
		}
	},
	{#State 179
		ACTIONS => {
			'OP17_LIST_RANGE' => 120,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP08_MATH_ADD_SUB' => 129,
			'OP09_BITWISE_SHIFT' => 117,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126,
			";" => 238,
			'OP23_LOGICAL_AND' => 127,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124
		}
	},
	{#State 180
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 129,
			'OP09_BITWISE_SHIFT' => 117,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 118,
			'OP04_MATH_POW' => 119,
			'OP17_LIST_RANGE' => 120,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126,
			";" => 239,
			'OP23_LOGICAL_AND' => 127
		}
	},
	{#State 181
		DEFAULT => -192
	},
	{#State 182
		DEFAULT => -193
	},
	{#State 183
		DEFAULT => -93
	},
	{#State 184
		ACTIONS => {
			")" => 240
		}
	},
	{#State 185
		ACTIONS => {
			'OP13_BITWISE_AND' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP17_LIST_RANGE' => -105,
			".." => -105,
			'OP21_LIST_COMMA' => -105,
			"]" => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP04_MATH_POW' => 119,
			'OP06_REGEX_MATCH' => 130,
			'OP08_MATH_ADD_SUB' => 129,
			"}" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => -105,
			";" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => -105,
			")" => -105
		}
	},
	{#State 186
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 132,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP21_LIST_COMMA' => -112,
			".." => -112,
			'OP17_LIST_RANGE' => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP06_REGEX_MATCH' => 130,
			'OP04_MATH_POW' => 119,
			'OP09_BITWISE_SHIFT' => 117,
			"]" => -112,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => -112,
			";" => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			"}" => -112,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP18_TERNARY' => -112,
			'OP08_STRING_CAT' => 123,
			")" => -112
		}
	},
	{#State 187
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -98,
			'OP06_REGEX_MATCH' => -98,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => -98,
			'OP09_BITWISE_SHIFT' => -98,
			"]" => -98,
			".." => -98,
			'OP21_LIST_COMMA' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			")" => -98,
			'OP18_TERNARY' => -98,
			'OP08_STRING_CAT' => -98,
			'OP12_COMPARE_EQ_NEQ' => -98,
			";" => -98,
			'OP23_LOGICAL_AND' => -98,
			"}" => -98,
			'OP07_MATH_MULT_DIV_MOD' => -98,
			'OP16_LOGICAL_OR' => -98
		}
	},
	{#State 188
		ACTIONS => {
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => -114,
			")" => -114,
			'OP16_LOGICAL_OR' => 126,
			"}" => -114,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => -114,
			";" => -114,
			'OP12_COMPARE_EQ_NEQ' => 125,
			"]" => -114,
			'OP09_BITWISE_SHIFT' => 117,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130,
			'OP08_MATH_ADD_SUB' => 129,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP17_LIST_RANGE' => undef,
			'OP21_LIST_COMMA' => -114,
			".." => -114
		}
	},
	{#State 189
		ACTIONS => {
			";" => -108,
			'OP23_LOGICAL_AND' => -108,
			"}" => -108,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => -108,
			'OP12_COMPARE_EQ_NEQ' => -108,
			'OP18_TERNARY' => -108,
			'OP08_STRING_CAT' => 123,
			")" => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP13_BITWISE_AND' => -108,
			'OP11_COMPARE_LT_GT' => undef,
			".." => -108,
			'OP21_LIST_COMMA' => -108,
			'OP17_LIST_RANGE' => -108,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => -108,
			'OP06_REGEX_MATCH' => 130,
			'OP09_BITWISE_SHIFT' => 117,
			"]" => -108,
			'OP08_MATH_ADD_SUB' => 129
		}
	},
	{#State 190
		ACTIONS => {
			".." => -118,
			'OP21_LIST_COMMA' => -118,
			'OP17_LIST_RANGE' => 120,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121,
			'OP08_MATH_ADD_SUB' => 129,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130,
			'OP09_BITWISE_SHIFT' => 117,
			"]" => -118,
			'OP12_COMPARE_EQ_NEQ' => 125,
			";" => -118,
			'OP23_LOGICAL_AND' => 127,
			"}" => -118,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126,
			")" => -118,
			'OP18_TERNARY' => 124,
			'OP08_STRING_CAT' => 123
		}
	},
	{#State 191
		ACTIONS => {
			")" => -104,
			'OP08_STRING_CAT' => -104,
			'OP18_TERNARY' => -104,
			'OP12_COMPARE_EQ_NEQ' => -104,
			'OP16_LOGICAL_OR' => -104,
			"}" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => -104,
			";" => -104,
			'OP08_MATH_ADD_SUB' => 129,
			"]" => -104,
			'OP09_BITWISE_SHIFT' => -104,
			'OP06_REGEX_MATCH' => 130,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP21_LIST_COMMA' => -104,
			".." => -104,
			'OP11_COMPARE_LT_GT' => -104,
			'OP13_BITWISE_AND' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP24_LOGICAL_OR_XOR' => -104
		}
	},
	{#State 192
		ACTIONS => {
			'COLON' => 241
		}
	},
	{#State 193
		ACTIONS => {
			'OP06_REGEX_MATCH' => 130,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => -109,
			'OP09_BITWISE_SHIFT' => 117,
			"]" => -109,
			'OP08_MATH_ADD_SUB' => 129,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => -109,
			'OP21_LIST_COMMA' => -109,
			".." => -109,
			'OP17_LIST_RANGE' => -109,
			'OP18_TERNARY' => -109,
			'OP08_STRING_CAT' => 123,
			")" => -109,
			'OP23_LOGICAL_AND' => -109,
			";" => -109,
			'OP16_LOGICAL_OR' => -109,
			"}" => -109,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP12_COMPARE_EQ_NEQ' => undef
		}
	},
	{#State 194
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP17_LIST_RANGE' => -113,
			'OP21_LIST_COMMA' => -113,
			".." => -113,
			"]" => -113,
			'OP09_BITWISE_SHIFT' => 117,
			'OP15_LOGICAL_AND' => 118,
			'OP04_MATH_POW' => 119,
			'OP06_REGEX_MATCH' => 130,
			'OP08_MATH_ADD_SUB' => 129,
			'OP16_LOGICAL_OR' => -113,
			"}" => -113,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => -113,
			";" => -113,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => -113,
			")" => -113
		}
	},
	{#State 195
		ACTIONS => {
			")" => -117,
			'OP18_TERNARY' => 124,
			'OP08_STRING_CAT' => 123,
			'OP12_COMPARE_EQ_NEQ' => 125,
			";" => -117,
			'OP23_LOGICAL_AND' => -117,
			"}" => -117,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126,
			'OP08_MATH_ADD_SUB' => 129,
			'OP15_LOGICAL_AND' => 118,
			'OP04_MATH_POW' => 119,
			'OP06_REGEX_MATCH' => 130,
			'OP09_BITWISE_SHIFT' => 117,
			"]" => -117,
			".." => -117,
			'OP21_LIST_COMMA' => -117,
			'OP17_LIST_RANGE' => 120,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121
		}
	},
	{#State 196
		ACTIONS => {
			'OP08_STRING_CAT' => -103,
			'OP18_TERNARY' => -103,
			")" => -103,
			'OP16_LOGICAL_OR' => -103,
			"}" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => -103,
			";" => -103,
			'OP12_COMPARE_EQ_NEQ' => -103,
			"]" => -103,
			'OP09_BITWISE_SHIFT' => -103,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => -103,
			'OP06_REGEX_MATCH' => 130,
			'OP08_MATH_ADD_SUB' => -103,
			'OP11_COMPARE_LT_GT' => -103,
			'OP13_BITWISE_AND' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP21_LIST_COMMA' => -103,
			".." => -103
		}
	},
	{#State 197
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 242
		}
	},
	{#State 198
		ACTIONS => {
			")" => -110,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => -110,
			'OP12_COMPARE_EQ_NEQ' => 125,
			"}" => -110,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => -110,
			";" => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP08_MATH_ADD_SUB' => 129,
			"]" => -110,
			'OP09_BITWISE_SHIFT' => 117,
			'OP06_REGEX_MATCH' => 130,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => -110,
			'OP17_LIST_RANGE' => -110,
			".." => -110,
			'OP21_LIST_COMMA' => -110,
			'OP13_BITWISE_AND' => -110,
			'OP11_COMPARE_LT_GT' => 121,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP14_BITWISE_OR_XOR' => -110
		}
	},
	{#State 199
		ACTIONS => {
			'OP17_LIST_RANGE' => -111,
			'OP21_LIST_COMMA' => -111,
			".." => -111,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP08_MATH_ADD_SUB' => 129,
			"]" => -111,
			'OP09_BITWISE_SHIFT' => 117,
			'OP15_LOGICAL_AND' => -111,
			'OP04_MATH_POW' => 119,
			'OP06_REGEX_MATCH' => 130,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP16_LOGICAL_OR' => -111,
			"}" => -111,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => -111,
			";" => -111,
			")" => -111,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => -111
		}
	},
	{#State 200
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP11_COMPARE_LT_GT' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP21_LIST_COMMA' => -102,
			".." => -102,
			'OP17_LIST_RANGE' => -102,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => -102,
			'OP06_REGEX_MATCH' => 130,
			'OP09_BITWISE_SHIFT' => -102,
			"]" => -102,
			'OP08_MATH_ADD_SUB' => -102,
			'OP23_LOGICAL_AND' => -102,
			";" => -102,
			'OP16_LOGICAL_OR' => -102,
			"}" => -102,
			'OP07_MATH_MULT_DIV_MOD' => -102,
			'OP12_COMPARE_EQ_NEQ' => -102,
			'OP18_TERNARY' => -102,
			'OP08_STRING_CAT' => -102,
			")" => -102
		}
	},
	{#State 201
		DEFAULT => -100
	},
	{#State 202
		ACTIONS => {
			"\$TYPED_" => 243
		}
	},
	{#State 203
		ACTIONS => {
			"}" => 244
		}
	},
	{#State 204
		DEFAULT => -129
	},
	{#State 205
		DEFAULT => -188
	},
	{#State 206
		ACTIONS => {
			")" => -185,
			'OP21_LIST_COMMA' => 245,
			"]" => -185,
			";" => -185
		},
		GOTOS => {
			'PAREN-54' => 246
		}
	},
	{#State 207
		DEFAULT => -125
	},
	{#State 208
		ACTIONS => {
			";" => 247
		}
	},
	{#State 209
		ACTIONS => {
			'OP17_LIST_RANGE' => 120,
			'OP21_LIST_COMMA' => -187,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP08_MATH_ADD_SUB' => 129,
			"]" => -187,
			'OP09_BITWISE_SHIFT' => 117,
			'OP04_MATH_POW' => 119,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 118,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126,
			";" => -187,
			'OP23_LOGICAL_AND' => 127,
			")" => -187,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124
		}
	},
	{#State 210
		DEFAULT => -147
	},
	{#State 211
		ACTIONS => {
			";" => 248,
			'OP19_VARIABLE_ASSIGN' => 249
		}
	},
	{#State 212
		ACTIONS => {
			"(" => 250
		}
	},
	{#State 213
		ACTIONS => {
			")" => 251,
			'OP18_TERNARY' => 124,
			'OP08_STRING_CAT' => 123,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP23_LOGICAL_AND' => 127,
			'OP16_LOGICAL_OR' => 126,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP08_MATH_ADD_SUB' => 129,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130,
			'OP09_BITWISE_SHIFT' => 117,
			'OP17_LIST_RANGE' => 120,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131
		}
	},
	{#State 214
		ACTIONS => {
			'VARIABLE_SYMBOL' => 252
		}
	},
	{#State 215
		DEFAULT => -191
	},
	{#State 216
		ACTIONS => {
			")" => 253
		}
	},
	{#State 217
		DEFAULT => -121
	},
	{#State 218
		ACTIONS => {
			";" => 254
		}
	},
	{#State 219
		ACTIONS => {
			"use" => 21,
			"use constant" => -66,
			"our %properties = (" => -66
		},
		GOTOS => {
			'STAR-27' => 256,
			'Include' => 255
		}
	},
	{#State 220
		DEFAULT => -27
	},
	{#State 221
		ACTIONS => {
			'WORD' => 257
		}
	},
	{#State 222
		ACTIONS => {
			";" => 258
		}
	},
	{#State 223
		DEFAULT => -43
	},
	{#State 224
		ACTIONS => {
			'LITERAL' => -30,
			"my" => 135
		},
		GOTOS => {
			'OPTIONAL-10' => 260,
			'TypeInner' => 259
		}
	},
	{#State 225
		ACTIONS => {
			'LITERAL' => -47,
			'OP03_MATH_INC_DEC' => -47,
			"foreach my" => -47,
			"if (" => -47,
			'OP01_NAMED' => -47,
			'OP19_LOOP_CONTROL' => -47,
			"( my" => 261,
			'OP05_MATH_NEG' => -47,
			'OP10_NAMED_UNARY' => -47,
			"%{" => -47,
			"{" => -47,
			'OP01_NAMED_VOID' => -47,
			"for my integer" => -47,
			'OP22_LOGICAL_NOT' => -47,
			'WORD' => -47,
			'VARIABLE_SYMBOL' => -47,
			'OP05_LOGICAL_NEG' => -47,
			'WORD_SCOPED' => -47,
			"(" => -47,
			'OP10_NAMED_UNARY_STRINGIFY' => -47,
			"my" => -47,
			"while (" => -47,
			"[" => -47,
			"\@{" => -47,
			"undef" => -47,
			'OP01_NAMED_VOID_PAREN' => -47
		},
		GOTOS => {
			'OPTIONAL-18' => 263,
			'SubroutineArguments' => 262
		}
	},
	{#State 226
		ACTIONS => {
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"for my integer" => -150,
			'OP01_NAMED_VOID' => 72,
			"{" => 46,
			'WORD' => 45,
			'OP22_LOGICAL_NOT' => 44,
			'OP19_LOOP_CONTROL' => 43,
			'OP05_MATH_NEG' => 66,
			"if (" => 42,
			'OP01_NAMED' => 63,
			"foreach my" => -150,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"undef" => 60,
			'OP01_NAMED_VOID_PAREN' => 79,
			"\@{" => 59,
			"[" => 78,
			"while (" => -150,
			"my" => 75,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'PAREN-46' => 52,
			'PLUS-52' => 264,
			'VariableModification' => 51,
			'Variable' => 57,
			'WordScoped' => 56,
			'LoopLabel' => 55,
			'ArrayReference' => 54,
			'OPTIONAL-47' => 76,
			'HashReference' => 77,
			'Conditional' => 39,
			'Expression' => 64,
			'VariableDeclaration' => 65,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'Operation' => 265,
			'Statement' => 70,
			'OperatorVoid' => 71,
			'HashDereferenced' => 49
		}
	},
	{#State 227
		DEFAULT => -158,
		GOTOS => {
			'STAR-49' => 266
		}
	},
	{#State 228
		ACTIONS => {
			'OP05_MATH_NEG' => 66,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'OP01_NAMED' => 63,
			"\@{" => 59,
			"[" => 78,
			"undef" => 60,
			'VARIABLE_SYMBOL' => 53,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 74
		},
		GOTOS => {
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashReference' => 77,
			'HashDereferenced' => 49,
			'Expression' => 267,
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54
		}
	},
	{#State 229
		DEFAULT => -194
	},
	{#State 230
		DEFAULT => -203
	},
	{#State 231
		DEFAULT => -201
	},
	{#State 232
		ACTIONS => {
			"%{" => 47,
			'WORD' => 97
		},
		GOTOS => {
			'HashEntry' => 268,
			'HashDereferenced' => 98
		}
	},
	{#State 233
		ACTIONS => {
			"}" => 269,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126,
			'OP23_LOGICAL_AND' => 127,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP17_LIST_RANGE' => 120,
			'OP09_BITWISE_SHIFT' => 117,
			'OP15_LOGICAL_AND' => 118,
			'OP04_MATH_POW' => 119,
			'OP06_REGEX_MATCH' => 130,
			'OP08_MATH_ADD_SUB' => 129
		}
	},
	{#State 234
		ACTIONS => {
			"}" => 270,
			"(" => -206
		}
	},
	{#State 235
		ACTIONS => {
			'OP17_LIST_RANGE' => 120,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP08_MATH_ADD_SUB' => 129,
			'OP09_BITWISE_SHIFT' => 117,
			"]" => 271,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 118,
			'OP04_MATH_POW' => 119,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP16_LOGICAL_OR' => 126,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => 127,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124
		}
	},
	{#State 236
		DEFAULT => -145
	},
	{#State 237
		ACTIONS => {
			"undef" => 60,
			"[" => 78,
			"\@{" => 59,
			"my" => 135,
			'KEYS_OR_VALUES' => 140,
			'VARIABLE_SYMBOL' => 53,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_LOGICAL_NEG' => 74,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			"{" => 46,
			")" => -135,
			'OP05_MATH_NEG' => 66,
			'OP01_NAMED' => 63,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40
		},
		GOTOS => {
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'ListElements' => 272,
			'HashDereferenced' => 49,
			'Variable' => 92,
			'WordScoped' => 56,
			'ArrayReference' => 54,
			'Expression' => 137,
			'ListElement' => 141,
			'OPTIONAL-45' => 273,
			'TypeInner' => 143
		}
	},
	{#State 238
		DEFAULT => -180
	},
	{#State 239
		DEFAULT => -181
	},
	{#State 240
		DEFAULT => -95
	},
	{#State 241
		ACTIONS => {
			'VARIABLE_SYMBOL' => 53
		},
		GOTOS => {
			'Variable' => 274
		}
	},
	{#State 242
		ACTIONS => {
			"/" => 275
		}
	},
	{#State 243
		ACTIONS => {
			'WORD' => 276
		}
	},
	{#State 244
		DEFAULT => -208
	},
	{#State 245
		ACTIONS => {
			'KEYS_OR_VALUES' => 140,
			"my" => 135,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"undef" => 60,
			"[" => 78,
			"\@{" => 59,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			'OP05_MATH_NEG' => 66
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashReference' => 77,
			'Expression' => 137,
			'ListElement' => 277,
			'TypeInner' => 143,
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54
		}
	},
	{#State 246
		DEFAULT => -183
	},
	{#State 247
		DEFAULT => -130
	},
	{#State 248
		DEFAULT => -178
	},
	{#State 249
		ACTIONS => {
			'OP01_NAMED' => 63,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			'OP05_MATH_NEG' => 66,
			'VARIABLE_SYMBOL' => 53,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 60,
			"[" => 78,
			"\@{" => 59
		},
		GOTOS => {
			'Expression' => 278,
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'HashDereferenced' => 49,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashReference' => 77
		}
	},
	{#State 250
		ACTIONS => {
			"[" => 78,
			"\@{" => 59,
			"undef" => 60,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'OP05_MATH_NEG' => 66,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63
		},
		GOTOS => {
			'Expression' => 279,
			'ArrayReference' => 54,
			'WordScoped' => 56,
			'Variable' => 92,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashReference' => 77,
			'HashDereferenced' => 49
		}
	},
	{#State 251
		ACTIONS => {
			"{" => 226
		},
		GOTOS => {
			'CodeBlock' => 280
		}
	},
	{#State 252
		ACTIONS => {
			"(" => 281
		}
	},
	{#State 253
		ACTIONS => {
			";" => 282
		}
	},
	{#State 254
		DEFAULT => -127
	},
	{#State 255
		DEFAULT => -63
	},
	{#State 256
		ACTIONS => {
			"our %properties = (" => 283,
			"use constant" => 28
		},
		GOTOS => {
			'Constant' => 285,
			'Properties' => 284
		}
	},
	{#State 257
		ACTIONS => {
			'OP20_HASH_FATARROW' => 286
		}
	},
	{#State 258
		DEFAULT => -28
	},
	{#State 259
		DEFAULT => -29
	},
	{#State 260
		ACTIONS => {
			'LITERAL' => 287
		}
	},
	{#State 261
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 288
		}
	},
	{#State 262
		DEFAULT => -46
	},
	{#State 263
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 43,
			'OP05_MATH_NEG' => 66,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			'OP01_NAMED_VOID' => 72,
			"for my integer" => -150,
			"{" => 46,
			'WORD' => 45,
			'OP22_LOGICAL_NOT' => 44,
			"foreach my" => -150,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			"if (" => 42,
			'OP01_NAMED' => 63,
			"\@{" => 59,
			"[" => 78,
			"undef" => 60,
			'OP01_NAMED_VOID_PAREN' => 79,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"my" => 75,
			"while (" => -150
		},
		GOTOS => {
			'Conditional' => 39,
			'VariableDeclaration' => 65,
			'Expression' => 64,
			'Statement' => 70,
			'Operation' => 290,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashDereferenced' => 49,
			'OperatorVoid' => 71,
			'VariableModification' => 51,
			'PAREN-46' => 52,
			'ArrayReference' => 54,
			'Variable' => 57,
			'WordScoped' => 56,
			'LoopLabel' => 55,
			'HashReference' => 77,
			'PLUS-19' => 289,
			'OPTIONAL-47' => 76
		}
	},
	{#State 264
		ACTIONS => {
			'OP05_MATH_NEG' => 66,
			'OP19_LOOP_CONTROL' => 43,
			'WORD' => 45,
			'OP22_LOGICAL_NOT' => 44,
			"for my integer" => -150,
			'OP01_NAMED_VOID' => 72,
			"{" => 46,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 62,
			"foreach my" => -150,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			"}" => 291,
			"if (" => 42,
			"[" => 78,
			"\@{" => 59,
			'OP01_NAMED_VOID_PAREN' => 79,
			"undef" => 60,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_LOGICAL_NEG' => 74,
			'VARIABLE_SYMBOL' => 53,
			"while (" => -150,
			"my" => 75
		},
		GOTOS => {
			'HashReference' => 77,
			'OPTIONAL-47' => 76,
			'ArrayReference' => 54,
			'Variable' => 57,
			'WordScoped' => 56,
			'LoopLabel' => 55,
			'VariableModification' => 51,
			'PAREN-46' => 52,
			'HashDereferenced' => 49,
			'OperatorVoid' => 71,
			'Statement' => 70,
			'Operation' => 292,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'VariableDeclaration' => 65,
			'Expression' => 64,
			'Conditional' => 39
		}
	},
	{#State 265
		DEFAULT => -170
	},
	{#State 266
		ACTIONS => {
			"\@{" => -161,
			"[" => -161,
			"else" => 296,
			'OP01_NAMED_VOID_PAREN' => -161,
			"undef" => -161,
			'OP05_LOGICAL_NEG' => -161,
			"(" => -161,
			'WORD_SCOPED' => -161,
			'OP10_NAMED_UNARY_STRINGIFY' => -161,
			'VARIABLE_SYMBOL' => -161,
			"elsif (" => 293,
			"while (" => -161,
			"my" => -161,
			'OP05_MATH_NEG' => -161,
			'OP19_LOOP_CONTROL' => -161,
			"for my integer" => -161,
			'OP01_NAMED_VOID' => -161,
			"{" => -161,
			'WORD' => -161,
			'OP22_LOGICAL_NOT' => -161,
			'OP10_NAMED_UNARY' => -161,
			"%{" => -161,
			'OP03_MATH_INC_DEC' => -161,
			'LITERAL' => -161,
			"foreach my" => -161,
			'OP01_NAMED' => -161,
			'' => -161,
			"}" => -161,
			"if (" => -161
		},
		GOTOS => {
			'PAREN-48' => 294,
			'OPTIONAL-51' => 297,
			'PAREN-50' => 295
		}
	},
	{#State 267
		ACTIONS => {
			'OP18_TERNARY' => 124,
			'OP08_STRING_CAT' => 123,
			'OP23_LOGICAL_AND' => 127,
			'OP16_LOGICAL_OR' => 126,
			"}" => -196,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP06_REGEX_MATCH' => 130,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP09_BITWISE_SHIFT' => 117,
			'OP08_MATH_ADD_SUB' => 129,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP21_LIST_COMMA' => -196,
			'OP17_LIST_RANGE' => 120
		}
	},
	{#State 268
		DEFAULT => -200
	},
	{#State 269
		DEFAULT => -176
	},
	{#State 270
		DEFAULT => -177
	},
	{#State 271
		DEFAULT => -175
	},
	{#State 272
		DEFAULT => -134
	},
	{#State 273
		ACTIONS => {
			")" => 298
		}
	},
	{#State 274
		DEFAULT => -115
	},
	{#State 275
		DEFAULT => -101
	},
	{#State 276
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 277
		DEFAULT => -182
	},
	{#State 278
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP16_LOGICAL_OR' => 126,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => 127,
			";" => 300,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124,
			'OP17_LIST_RANGE' => 120,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP08_MATH_ADD_SUB' => 129,
			'OP09_BITWISE_SHIFT' => 117,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130
		}
	},
	{#State 279
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP16_LOGICAL_OR' => 126,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => 127,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124,
			'OP17_LIST_RANGE' => 120,
			".." => 301,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP08_MATH_ADD_SUB' => 129,
			'OP09_BITWISE_SHIFT' => 117,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 118,
			'OP04_MATH_POW' => 119
		}
	},
	{#State 280
		DEFAULT => -168
	},
	{#State 281
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 74,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'VARIABLE_SYMBOL' => 53,
			'KEYS_OR_VALUES' => 140,
			"my" => 135,
			"\@{" => 59,
			"[" => 78,
			"undef" => 60,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			'OP01_NAMED' => 63,
			'OP05_MATH_NEG' => 66,
			"{" => 46,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47
		},
		GOTOS => {
			'ListElements' => 302,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashReference' => 77,
			'HashDereferenced' => 49,
			'TypeInner' => 143,
			'Expression' => 137,
			'ListElement' => 141,
			'ArrayReference' => 54,
			'Variable' => 92,
			'WordScoped' => 56
		}
	},
	{#State 282
		DEFAULT => -128
	},
	{#State 283
		ACTIONS => {
			")" => 305,
			'WORD' => 303,
			"%{" => 47
		},
		GOTOS => {
			'HashEntryTyped' => 306,
			'HashDereferenced' => 304
		}
	},
	{#State 284
		DEFAULT => -68,
		GOTOS => {
			'STAR-28' => 307
		}
	},
	{#State 285
		DEFAULT => -65
	},
	{#State 286
		ACTIONS => {
			"my" => 135,
			'LITERAL' => -37
		},
		GOTOS => {
			'TypeInner' => 309,
			'OPTIONAL-14' => 308
		}
	},
	{#State 287
		DEFAULT => -35,
		GOTOS => {
			'STAR-13' => 310
		}
	},
	{#State 288
		ACTIONS => {
			'VARIABLE_SYMBOL' => 311
		}
	},
	{#State 289
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 43,
			'OP05_MATH_NEG' => 66,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"for my integer" => -150,
			"{" => 46,
			'OP01_NAMED_VOID' => 72,
			'WORD' => 45,
			'OP22_LOGICAL_NOT' => 44,
			"foreach my" => -150,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"}" => 312,
			"if (" => 42,
			'OP01_NAMED' => 63,
			"\@{" => 59,
			"[" => 78,
			"undef" => 60,
			'OP01_NAMED_VOID_PAREN' => 79,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'WORD_SCOPED' => 11,
			"my" => 75,
			"while (" => -150
		},
		GOTOS => {
			'Statement' => 70,
			'Operation' => 313,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashDereferenced' => 49,
			'OperatorVoid' => 71,
			'Conditional' => 39,
			'VariableDeclaration' => 65,
			'Expression' => 64,
			'HashReference' => 77,
			'OPTIONAL-47' => 76,
			'VariableModification' => 51,
			'PAREN-46' => 52,
			'ArrayReference' => 54,
			'WordScoped' => 56,
			'Variable' => 57,
			'LoopLabel' => 55
		}
	},
	{#State 290
		DEFAULT => -49
	},
	{#State 291
		DEFAULT => -171
	},
	{#State 292
		DEFAULT => -169
	},
	{#State 293
		ACTIONS => {
			"undef" => 60,
			"\@{" => 59,
			"[" => 78,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			'OP05_MATH_NEG' => 66,
			'OP01_NAMED' => 63,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashReference' => 77,
			'Expression' => 314,
			'ArrayReference' => 54,
			'WordScoped' => 56,
			'Variable' => 92
		}
	},
	{#State 294
		DEFAULT => -157
	},
	{#State 295
		DEFAULT => -160
	},
	{#State 296
		ACTIONS => {
			"{" => 226
		},
		GOTOS => {
			'CodeBlock' => 315
		}
	},
	{#State 297
		DEFAULT => -162
	},
	{#State 298
		DEFAULT => -146
	},
	{#State 299
		DEFAULT => -209
	},
	{#State 300
		DEFAULT => -179
	},
	{#State 301
		ACTIONS => {
			"undef" => 60,
			"[" => 78,
			"\@{" => 59,
			'VARIABLE_SYMBOL' => 53,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 74,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			'OP05_MATH_NEG' => 66,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'HashReference' => 77,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'Variable' => 92,
			'WordScoped' => 56,
			'ArrayReference' => 54,
			'Expression' => 316
		}
	},
	{#State 302
		ACTIONS => {
			")" => 317
		}
	},
	{#State 303
		ACTIONS => {
			'OP20_HASH_FATARROW' => 318
		}
	},
	{#State 304
		DEFAULT => -199
	},
	{#State 305
		ACTIONS => {
			";" => 319
		}
	},
	{#State 306
		DEFAULT => -77,
		GOTOS => {
			'STAR-33' => 320
		}
	},
	{#State 307
		ACTIONS => {
			"1;1;" => 322,
			"our" => 323
		},
		GOTOS => {
			'Method' => 321
		}
	},
	{#State 308
		ACTIONS => {
			'LITERAL' => 324
		}
	},
	{#State 309
		DEFAULT => -36
	},
	{#State 310
		ACTIONS => {
			'OP21_LIST_COMMA' => 326,
			"]" => 325
		},
		GOTOS => {
			'PAREN-12' => 327
		}
	},
	{#State 311
		DEFAULT => -53,
		GOTOS => {
			'STAR-21' => 328
		}
	},
	{#State 312
		ACTIONS => {
			";" => 329
		}
	},
	{#State 313
		DEFAULT => -48
	},
	{#State 314
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 129,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130,
			'OP09_BITWISE_SHIFT' => 117,
			'OP17_LIST_RANGE' => 120,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121,
			")" => 330,
			'OP18_TERNARY' => 124,
			'OP08_STRING_CAT' => 123,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP23_LOGICAL_AND' => 127,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126
		}
	},
	{#State 315
		DEFAULT => -159
	},
	{#State 316
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP23_LOGICAL_AND' => 127,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126,
			")" => 331,
			'OP18_TERNARY' => 124,
			'OP08_STRING_CAT' => 123,
			'OP17_LIST_RANGE' => 120,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121,
			'OP08_MATH_ADD_SUB' => 129,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130,
			'OP04_MATH_POW' => 119,
			'OP09_BITWISE_SHIFT' => 117
		}
	},
	{#State 317
		ACTIONS => {
			"{" => 226
		},
		GOTOS => {
			'CodeBlock' => 332
		}
	},
	{#State 318
		ACTIONS => {
			"my" => 135
		},
		GOTOS => {
			'TypeInner' => 333
		}
	},
	{#State 319
		DEFAULT => -79
	},
	{#State 320
		ACTIONS => {
			")" => 334,
			'OP21_LIST_COMMA' => 335
		},
		GOTOS => {
			'PAREN-32' => 336
		}
	},
	{#State 321
		DEFAULT => -67
	},
	{#State 322
		ACTIONS => {
			"package" => -73,
			"our" => 41,
			'' => -73
		},
		GOTOS => {
			'OPTIONAL-31' => 339,
			'Subroutine' => 337,
			'PLUS-29' => 340,
			'PAREN-30' => 338
		}
	},
	{#State 323
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 341
		}
	},
	{#State 324
		DEFAULT => -42,
		GOTOS => {
			'STAR-17' => 342
		}
	},
	{#State 325
		DEFAULT => -44
	},
	{#State 326
		ACTIONS => {
			'LITERAL' => -32,
			"my" => 135
		},
		GOTOS => {
			'OPTIONAL-11' => 344,
			'TypeInner' => 343
		}
	},
	{#State 327
		DEFAULT => -34
	},
	{#State 328
		ACTIONS => {
			")" => 346,
			'OP21_LIST_COMMA' => 347
		},
		GOTOS => {
			'PAREN-20' => 345
		}
	},
	{#State 329
		DEFAULT => -50
	},
	{#State 330
		ACTIONS => {
			"{" => 226
		},
		GOTOS => {
			'CodeBlock' => 348
		}
	},
	{#State 331
		ACTIONS => {
			"{" => 226
		},
		GOTOS => {
			'CodeBlock' => 349
		}
	},
	{#State 332
		DEFAULT => -167
	},
	{#State 333
		ACTIONS => {
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 13,
			'OP05_MATH_NEG' => 66,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"undef" => 60,
			"[" => 78,
			"\@{" => 59,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50
		},
		GOTOS => {
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashDereferenced' => 49,
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'Expression' => 350
		}
	},
	{#State 334
		ACTIONS => {
			";" => 351
		}
	},
	{#State 335
		ACTIONS => {
			'WORD' => 303,
			"%{" => 47
		},
		GOTOS => {
			'HashEntryTyped' => 352,
			'HashDereferenced' => 304
		}
	},
	{#State 336
		DEFAULT => -76
	},
	{#State 337
		DEFAULT => -70
	},
	{#State 338
		DEFAULT => -72
	},
	{#State 339
		DEFAULT => -74
	},
	{#State 340
		ACTIONS => {
			"our" => 41,
			"1;1;" => 354
		},
		GOTOS => {
			'Subroutine' => 353
		}
	},
	{#State 341
		ACTIONS => {
			'VARIABLE_SYMBOL' => 355
		}
	},
	{#State 342
		ACTIONS => {
			"}" => 358,
			'OP21_LIST_COMMA' => 356
		},
		GOTOS => {
			'PAREN-16' => 357
		}
	},
	{#State 343
		DEFAULT => -31
	},
	{#State 344
		ACTIONS => {
			'LITERAL' => 359
		}
	},
	{#State 345
		DEFAULT => -52
	},
	{#State 346
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 360
		}
	},
	{#State 347
		ACTIONS => {
			"my" => 361
		}
	},
	{#State 348
		DEFAULT => -156
	},
	{#State 349
		DEFAULT => -166
	},
	{#State 350
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 117,
			'OP06_REGEX_MATCH' => 130,
			'OP15_LOGICAL_AND' => 118,
			'OP04_MATH_POW' => 119,
			'OP08_MATH_ADD_SUB' => 129,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP17_LIST_RANGE' => 120,
			'OP21_LIST_COMMA' => -198,
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124,
			")" => -198,
			'OP16_LOGICAL_OR' => 126,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP23_LOGICAL_AND' => 127,
			'OP12_COMPARE_EQ_NEQ' => 125
		}
	},
	{#State 351
		DEFAULT => -78
	},
	{#State 352
		DEFAULT => -75
	},
	{#State 353
		DEFAULT => -69
	},
	{#State 354
		DEFAULT => -71
	},
	{#State 355
		ACTIONS => {
			"= sub {" => 362
		}
	},
	{#State 356
		ACTIONS => {
			'WORD' => 363
		}
	},
	{#State 357
		DEFAULT => -41
	},
	{#State 358
		DEFAULT => -45
	},
	{#State 359
		DEFAULT => -33
	},
	{#State 360
		ACTIONS => {
			"\@_;" => 364
		}
	},
	{#State 361
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 365
		}
	},
	{#State 362
		ACTIONS => {
			"while (" => -81,
			"my" => -81,
			'VARIABLE_SYMBOL' => -81,
			'OP05_LOGICAL_NEG' => -81,
			'OP10_NAMED_UNARY_STRINGIFY' => -81,
			'WORD_SCOPED' => -81,
			"(" => -81,
			"undef" => -81,
			'OP01_NAMED_VOID_PAREN' => -81,
			"\@{" => -81,
			"[" => -81,
			"if (" => -81,
			'OP01_NAMED' => -81,
			'LITERAL' => -81,
			'OP03_MATH_INC_DEC' => -81,
			"foreach my" => -81,
			'OP10_NAMED_UNARY' => -81,
			"%{" => -81,
			'OP01_NAMED_VOID' => -81,
			"for my integer" => -81,
			"{" => -81,
			'OP22_LOGICAL_NOT' => -81,
			'WORD' => -81,
			'OP19_LOOP_CONTROL' => -81,
			"( my" => 367,
			'OP05_MATH_NEG' => -81
		},
		GOTOS => {
			'MethodArguments' => 368,
			'OPTIONAL-34' => 366
		}
	},
	{#State 363
		ACTIONS => {
			'OP20_HASH_FATARROW' => 369
		}
	},
	{#State 364
		DEFAULT => -55,
		GOTOS => {
			'STAR-22' => 370
		}
	},
	{#State 365
		ACTIONS => {
			'VARIABLE_SYMBOL' => 371
		}
	},
	{#State 366
		ACTIONS => {
			'OP01_NAMED' => 63,
			"if (" => 42,
			'LITERAL' => 62,
			"foreach my" => -150,
			'OP03_MATH_INC_DEC' => 40,
			"for my integer" => -150,
			'OP01_NAMED_VOID' => 72,
			"{" => 46,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 45,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			'OP05_MATH_NEG' => 66,
			'OP19_LOOP_CONTROL' => 43,
			"my" => 75,
			"while (" => -150,
			'OP05_LOGICAL_NEG' => 74,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			"(" => 73,
			'VARIABLE_SYMBOL' => 53,
			'OP01_NAMED_VOID_PAREN' => 79,
			"undef" => 60,
			"[" => 78,
			"\@{" => 59
		},
		GOTOS => {
			'Conditional' => 39,
			'Expression' => 64,
			'VariableDeclaration' => 65,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'Operation' => 372,
			'Statement' => 70,
			'PLUS-35' => 373,
			'OperatorVoid' => 71,
			'HashDereferenced' => 49,
			'PAREN-46' => 52,
			'VariableModification' => 51,
			'LoopLabel' => 55,
			'Variable' => 57,
			'WordScoped' => 56,
			'ArrayReference' => 54,
			'OPTIONAL-47' => 76,
			'HashReference' => 77
		}
	},
	{#State 367
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 374
		}
	},
	{#State 368
		DEFAULT => -80
	},
	{#State 369
		ACTIONS => {
			"my" => 135,
			'LITERAL' => -39
		},
		GOTOS => {
			'TypeInner' => 375,
			'OPTIONAL-15' => 376
		}
	},
	{#State 370
		ACTIONS => {
			'OP22_LOGICAL_NOT' => -56,
			'WORD' => -56,
			'OP01_NAMED_VOID' => -56,
			"for my integer" => -56,
			"{" => -56,
			"%{" => -56,
			'OP10_NAMED_UNARY' => -56,
			'OP05_MATH_NEG' => -56,
			'CHECK_OR_CHECKTRACE' => 377,
			'OP19_LOOP_CONTROL' => -56,
			'OP01_NAMED' => -56,
			"if (" => -56,
			"foreach my" => -56,
			'LITERAL' => -56,
			'OP03_MATH_INC_DEC' => -56,
			'OP01_NAMED_VOID_PAREN' => -56,
			"undef" => -56,
			"[" => -56,
			"\@{" => -56,
			"my" => -56,
			"while (" => -56,
			'OP10_NAMED_UNARY_STRINGIFY' => -56,
			'WORD_SCOPED' => -56,
			"(" => -56,
			'OP05_LOGICAL_NEG' => -56,
			'VARIABLE_SYMBOL' => -56
		},
		GOTOS => {
			'ArgumentCheck' => 378
		}
	},
	{#State 371
		DEFAULT => -51
	},
	{#State 372
		DEFAULT => -83
	},
	{#State 373
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 74,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'VARIABLE_SYMBOL' => 53,
			"my" => 75,
			"while (" => -150,
			"[" => 78,
			"\@{" => 59,
			'OP01_NAMED_VOID_PAREN' => 79,
			"undef" => 60,
			'OP03_MATH_INC_DEC' => 40,
			"foreach my" => -150,
			'LITERAL' => 62,
			'OP01_NAMED' => 63,
			"}" => 379,
			"if (" => 42,
			'OP05_MATH_NEG' => 66,
			'OP19_LOOP_CONTROL' => 43,
			"for my integer" => -150,
			"{" => 46,
			'OP01_NAMED_VOID' => 72,
			'OP22_LOGICAL_NOT' => 44,
			'WORD' => 45,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47
		},
		GOTOS => {
			'Conditional' => 39,
			'VariableDeclaration' => 65,
			'Expression' => 64,
			'Statement' => 70,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'Operation' => 380,
			'HashDereferenced' => 49,
			'OperatorVoid' => 71,
			'PAREN-46' => 52,
			'VariableModification' => 51,
			'LoopLabel' => 55,
			'WordScoped' => 56,
			'Variable' => 57,
			'ArrayReference' => 54,
			'HashReference' => 77,
			'OPTIONAL-47' => 76
		}
	},
	{#State 374
		DEFAULT => -87,
		GOTOS => {
			'STAR-37' => 381
		}
	},
	{#State 375
		DEFAULT => -38
	},
	{#State 376
		ACTIONS => {
			'LITERAL' => 382
		}
	},
	{#State 377
		ACTIONS => {
			"(" => 383
		}
	},
	{#State 378
		DEFAULT => -54
	},
	{#State 379
		ACTIONS => {
			";" => 384
		}
	},
	{#State 380
		DEFAULT => -82
	},
	{#State 381
		ACTIONS => {
			'OP21_LIST_COMMA' => 386,
			")" => 387
		},
		GOTOS => {
			'PAREN-36' => 385
		}
	},
	{#State 382
		DEFAULT => -40
	},
	{#State 383
		ACTIONS => {
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 40,
			'LITERAL' => 62,
			"%{" => 47,
			'OP10_NAMED_UNARY' => 48,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			"{" => 46,
			'OP05_MATH_NEG' => 66,
			'VARIABLE_SYMBOL' => 53,
			"(" => 73,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP05_LOGICAL_NEG' => 74,
			"undef" => 60,
			"\@{" => 59,
			"[" => 78
		},
		GOTOS => {
			'Variable' => 92,
			'WordScoped' => 56,
			'ArrayReference' => 54,
			'Expression' => 388,
			'HashReference' => 77,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'HashDereferenced' => 49
		}
	},
	{#State 384
		DEFAULT => -84
	},
	{#State 385
		DEFAULT => -86
	},
	{#State 386
		ACTIONS => {
			"my" => 389
		}
	},
	{#State 387
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 390
		}
	},
	{#State 388
		ACTIONS => {
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130,
			'OP04_MATH_POW' => 119,
			'OP09_BITWISE_SHIFT' => 117,
			'OP08_MATH_ADD_SUB' => 129,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			'OP21_LIST_COMMA' => 392,
			'OP17_LIST_RANGE' => 120,
			'OP18_TERNARY' => 124,
			'OP08_STRING_CAT' => 123,
			")" => -59,
			'OP23_LOGICAL_AND' => 127,
			'OP16_LOGICAL_OR' => 126,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP12_COMPARE_EQ_NEQ' => 125
		},
		GOTOS => {
			'OPTIONAL-24' => 393,
			'PAREN-23' => 391
		}
	},
	{#State 389
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 394
		}
	},
	{#State 390
		ACTIONS => {
			"\@_;" => 395
		}
	},
	{#State 391
		DEFAULT => -58
	},
	{#State 392
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 74,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'VARIABLE_SYMBOL' => 53,
			"[" => 78,
			"\@{" => 59,
			"undef" => 60,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40,
			'OP01_NAMED' => 63,
			'OP05_MATH_NEG' => 66,
			"{" => 46,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47
		},
		GOTOS => {
			'HashReference' => 77,
			'Operator' => 68,
			'ArrayDereferenced' => 69,
			'HashDereferenced' => 49,
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'Expression' => 396
		}
	},
	{#State 393
		ACTIONS => {
			")" => 397
		}
	},
	{#State 394
		ACTIONS => {
			'VARIABLE_SYMBOL' => 398
		}
	},
	{#State 395
		DEFAULT => -89,
		GOTOS => {
			'STAR-38' => 399
		}
	},
	{#State 396
		ACTIONS => {
			'OP08_STRING_CAT' => 123,
			'OP18_TERNARY' => 124,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP07_MATH_MULT_DIV_MOD' => 133,
			'OP16_LOGICAL_OR' => 126,
			'OP23_LOGICAL_AND' => 127,
			'OP08_MATH_ADD_SUB' => 129,
			'OP09_BITWISE_SHIFT' => 117,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130,
			'OP17_LIST_RANGE' => 120,
			'OP21_LIST_COMMA' => 400,
			'OP13_BITWISE_AND' => 131,
			'OP11_COMPARE_LT_GT' => 121,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP14_BITWISE_OR_XOR' => 132
		}
	},
	{#State 397
		ACTIONS => {
			";" => 401
		}
	},
	{#State 398
		DEFAULT => -85
	},
	{#State 399
		ACTIONS => {
			'OP01_NAMED' => -90,
			"if (" => -90,
			"foreach my" => -90,
			'LITERAL' => -90,
			'OP03_MATH_INC_DEC' => -90,
			'OP22_LOGICAL_NOT' => -90,
			'WORD' => -90,
			"{" => -90,
			'OP01_NAMED_VOID' => -90,
			"for my integer" => -90,
			"%{" => -90,
			'OP10_NAMED_UNARY' => -90,
			'OP05_MATH_NEG' => -90,
			'CHECK_OR_CHECKTRACE' => 377,
			'OP19_LOOP_CONTROL' => -90,
			"my" => -90,
			"while (" => -90,
			'WORD_SCOPED' => -90,
			"(" => -90,
			'OP10_NAMED_UNARY_STRINGIFY' => -90,
			'OP05_LOGICAL_NEG' => -90,
			'VARIABLE_SYMBOL' => -90,
			'OP01_NAMED_VOID_PAREN' => -90,
			"undef" => -90,
			"\@{" => -90,
			"[" => -90
		},
		GOTOS => {
			'ArgumentCheck' => 402
		}
	},
	{#State 400
		ACTIONS => {
			"undef" => 60,
			"\@{" => 59,
			"[" => 78,
			'VARIABLE_SYMBOL' => 53,
			'OP05_LOGICAL_NEG' => 74,
			'WORD_SCOPED' => 11,
			"(" => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 50,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 47,
			"{" => 46,
			'WORD' => 13,
			'OP22_LOGICAL_NOT' => 44,
			'OP05_MATH_NEG' => 66,
			'OP01_NAMED' => 63,
			'LITERAL' => 62,
			'OP03_MATH_INC_DEC' => 40
		},
		GOTOS => {
			'HashDereferenced' => 49,
			'HashReference' => 77,
			'ArrayDereferenced' => 69,
			'Operator' => 68,
			'WordScoped' => 56,
			'Variable' => 92,
			'ArrayReference' => 54,
			'Expression' => 403
		}
	},
	{#State 401
		DEFAULT => -60
	},
	{#State 402
		DEFAULT => -88
	},
	{#State 403
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 129,
			'OP04_MATH_POW' => 119,
			'OP15_LOGICAL_AND' => 118,
			'OP06_REGEX_MATCH' => 130,
			'OP09_BITWISE_SHIFT' => 117,
			'OP17_LIST_RANGE' => 120,
			'OP14_BITWISE_OR_XOR' => 132,
			'OP24_LOGICAL_OR_XOR' => 122,
			'OP11_COMPARE_LT_GT' => 121,
			'OP13_BITWISE_AND' => 131,
			")" => -57,
			'OP18_TERNARY' => 124,
			'OP08_STRING_CAT' => 123,
			'OP12_COMPARE_EQ_NEQ' => 125,
			'OP23_LOGICAL_AND' => 127,
			'OP16_LOGICAL_OR' => 126,
			'OP07_MATH_MULT_DIV_MOD' => 133
		}
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5287 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 107 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5294 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 107 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5301 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5312 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5323 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5330 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5337 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5344 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5351 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5358 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5365 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-5', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5372 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-5', 1,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5379 lib/RPerl/Grammar.pm
	],
	[#Rule Program_13
		 'Program', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5390 lib/RPerl/Grammar.pm
	],
	[#Rule Module_14
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5401 lib/RPerl/Grammar.pm
	],
	[#Rule Module_15
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5412 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5419 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5426 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5433 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5440 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5447 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5454 lib/RPerl/Grammar.pm
	],
	[#Rule Package_22
		 'Package', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5465 lib/RPerl/Grammar.pm
	],
	[#Rule Header_23
		 'Header', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5476 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-9', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5483 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-9', 1,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5490 lib/RPerl/Grammar.pm
	],
	[#Rule Include_26
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5501 lib/RPerl/Grammar.pm
	],
	[#Rule Include_27
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5512 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_28
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5523 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5530 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5537 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-11', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5544 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-11', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5551 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-12', 3,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5558 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5565 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5572 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5579 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5586 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5593 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5600 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-16', 5,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5607 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5614 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5621 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_43
		 'ConstantValue', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5632 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_44
		 'ConstantValue', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5643 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_45
		 'ConstantValue', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5654 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5661 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5668 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-19', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5675 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-19', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5682 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_50
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5693 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 4,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5700 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5707 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5714 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5721 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5728 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_56
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5739 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5746 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5753 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5760 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_60
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5771 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-25', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5778 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-25', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5785 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5792 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5799 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5806 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5813 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5820 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-29', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-29', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5841 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5862 lib/RPerl/Grammar.pm
	],
	[#Rule Class_74
		 'Class', 14,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5873 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5880 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5887 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5894 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_78
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5905 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_79
		 'Properties', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5923 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5930 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-35', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5937 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-35', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5944 lib/RPerl/Grammar.pm
	],
	[#Rule Method_84
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5955 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 4,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5962 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5976 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5983 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5990 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_90
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6001 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_91
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6012 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_92
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6023 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6030 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6037 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6048 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6059 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6070 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6081 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6092 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6103 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6114 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6125 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6136 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6147 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6169 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6180 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6191 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6202 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6213 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6224 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6235 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6246 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6257 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6268 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6279 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6290 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6301 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6315 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6322 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6329 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6336 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6343 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6350 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6357 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_127
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6368 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_128
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6379 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_129
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6390 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_130
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6401 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_131
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6412 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6419 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6426 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6433 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6440 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_136
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6451 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_137
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6462 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_138
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6473 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_139
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6484 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_140
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6495 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_141
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6506 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_142
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6517 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6528 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6539 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6550 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6561 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6572 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6579 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6586 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6593 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6604 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6615 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6626 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6637 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6648 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 4,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6655 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6662 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6669 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-50', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6676 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6683 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6690 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_162
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6701 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6712 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6734 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_166
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6745 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_167
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6756 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_168
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6767 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6774 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6781 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_171
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6792 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6799 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6806 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_174
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6817 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6828 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_176
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_178
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_179
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_180
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_181
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-54', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6901 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-55', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-55', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_185
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6926 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_186
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6937 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_187
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6948 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_191
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6984 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_192
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_193
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7006 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7020 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_196
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7031 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_197
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7042 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_198
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7053 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_199
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-58', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_203
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7096 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_204
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7107 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_205
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_206
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7129 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_207
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7140 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_208
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7151 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_209
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7162 lib/RPerl/Grammar.pm
	],
	[#Rule Type_210
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7173 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_211
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7184 lib/RPerl/Grammar.pm
	]
],
#line 7187 lib/RPerl/Grammar.pm
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
         'Operator_118', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_127', 
         'OperatorVoid_128', 
         'OperatorVoid_129', 
         'OperatorVoid_130', 
         'OperatorVoid_131', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         'Expression_147', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_151', 
         'Statement_152', 
         'Statement_153', 
         'Statement_154', 
         'Statement_155', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_162', 
         'Loop_163', 
         'Loop_164', 
         'Loop_165', 
         'LoopFor_166', 
         'LoopForEach_167', 
         'LoopWhile_168', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_171', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_174', 
         'VariableRetrieval_175', 
         'VariableRetrieval_176', 
         'VariableRetrieval_177', 
         'VariableDeclaration_178', 
         'VariableDeclaration_179', 
         'VariableModification_180', 
         'VariableModification_181', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_185', 
         'ListElement_186', 
         'ListElement_187', 
         'ListElement_188', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_191', 
         'ArrayDereferenced_192', 
         'ArrayDereferenced_193', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_196', 
         'HashEntry_197', 
         'HashEntryTyped_198', 
         'HashEntryTyped_199', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_203', 
         'HashDereferenced_204', 
         'HashDereferenced_205', 
         'WordScoped_206', 
         'WordScoped_207', 
         'FileHandle_208', 
         'TypeInner_209', 
         'Type_210', 
         'LoopLabel_211', );
  $self;
}

#line 168 "lib/RPerl/Grammar.eyp"


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


#line 7446 lib/RPerl/Grammar.pm



1;
