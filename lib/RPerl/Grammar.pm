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

      m{\G(our\ \%properties\ \=\ \(|use\ parent\ qw\(|our\ \$VERSION\ \=|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|use\ Carp\;|elsif\ \(|package|while\ \(|\$TYPED_|\=\ sub\ \{|undef|1\;1\;|if\ \(|else|\(\ my|use|\@_\;|qw\(|our|\%\{|\.\.|\@\{|my|\{\*|\}|\]|\;|\)|\(|\/|\{|\[)}gc and return ($1, $1);

      /\G(^(\#\!\/[\w\/]*\/perl)$)/gc and return ('SHEBANG', $1);
      /\G(\d+\.\d{3}\_\d{3})/gc and return ('VERSION_NUMBER', $1);
      /\G((-?\d+(\.\d+)?)|('[^']*')|("[^"]*"))/gc and return ('LITERAL', $1);
      /\G(\$[a-zA-Z]\w*__OPS_TYPES_ID)/gc and return ('OPS_TYPES_ID', $1);
      /\G(\$[a-zA-Z]\w*__ops)/gc and return ('OPS_SUB', $1);
      /\G(\$[a-zA-Z]\w*__types)/gc and return ('TYPES_SUB', $1);
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


#line 116 lib/RPerl/Grammar.pm

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
  [ 'Header_23' => 'Header', [ 'use strict;', 'use warnings;', 'our $VERSION =', 'VERSION_NUMBER', ';', 'use Carp;', 'use RPerl;', 'OpsTypes' ], 0 ],
  [ 'OpsTypes_24' => 'OpsTypes', [ 'our', 'Type', 'OPS_TYPES_ID', 'OP19_VARIABLE_ASSIGN', 'LITERAL', ';', 'our', 'Type', 'OPS_SUB', 'OpsTypesSub', 'our', 'Type', 'TYPES_SUB', 'OpsTypesSub' ], 0 ],
  [ 'OpsTypesSub_25' => 'OpsTypesSub', [ '= sub {', 'OP01_NAMED_VOID_PAREN', 'LITERAL', ')', ';', '}', ';' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-9', [ 'PLUS-9', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-9', [ 'WORD' ], 0 ],
  [ 'Include_28' => 'Include', [ 'use', 'WordScoped', ';' ], 0 ],
  [ 'Include_29' => 'Include', [ 'use', 'WordScoped', 'qw(', 'PLUS-9', ')', ';' ], 0 ],
  [ 'Constant_30' => 'Constant', [ 'use constant', 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'ConstantValue', ';' ], 0 ],
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
  [ 'ConstantValue_45' => 'ConstantValue', [ 'LITERAL' ], 0 ],
  [ 'ConstantValue_46' => 'ConstantValue', [ '[', 'OPTIONAL-10', 'LITERAL', 'STAR-13', ']' ], 0 ],
  [ 'ConstantValue_47' => 'ConstantValue', [ '{', 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-14', 'LITERAL', 'STAR-17', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-19', [ 'PLUS-19', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-19', [ 'Operation' ], 0 ],
  [ 'Subroutine_52' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-18', 'PLUS-19', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-20', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [ 'STAR-21', 'PAREN-20' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [ 'STAR-22', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [  ], 0 ],
  [ 'SubroutineArguments_58' => 'SubroutineArguments', [ '( my', 'Type', 'VARIABLE_SYMBOL', 'STAR-21', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-22' ], 0 ],
  [ '_PAREN' => 'PAREN-23', [ 'OP21_LIST_COMMA', 'Expression', 'OP21_LIST_COMMA', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [ 'PAREN-23' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [  ], 0 ],
  [ 'ArgumentCheck_62' => 'ArgumentCheck', [ 'CHECK_OR_CHECKTRACE', '(', 'Expression', 'OPTIONAL-24', ')', ';' ], 0 ],
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
  [ 'Class_76' => 'Class', [ 'package', 'WordScoped', ';', 'Header', 'use parent qw(', 'PLUS-25', ')', ';', 'STAR-26', 'STAR-27', 'Properties', 'STAR-28', '1;1;', 'OPTIONAL-31' ], 0 ],
  [ '_PAREN' => 'PAREN-32', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [ 'STAR-33', 'PAREN-32' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [  ], 0 ],
  [ 'Properties_80' => 'Properties', [ 'our %properties = (', 'HashEntryTyped', 'STAR-33', ')', ';' ], 0 ],
  [ 'Properties_81' => 'Properties', [ 'our %properties = (', ')', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-35', [ 'PLUS-35', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-35', [ 'Operation' ], 0 ],
  [ 'Method_86' => 'Method', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-34', 'PLUS-35', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [ 'STAR-37', 'PAREN-36' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [ 'STAR-38', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [  ], 0 ],
  [ 'MethodArguments_92' => 'MethodArguments', [ '( my', 'TYPE_CLASS_OR_SELF', 'STAR-37', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-38' ], 0 ],
  [ 'Operation_93' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_94' => 'Operation', [ 'Statement' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'OP01_NAMED', '(', 'OPTIONAL-39', ')' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'Expression', 'OP04_MATH_POW', 'Expression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP05_LOGICAL_NEG', 'Expression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'OP05_MATH_NEG', 'Expression', ')' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'Expression', 'OP06_REGEX_MATCH', '/', 'OP06_REGEX_PATTERN', '/' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'Expression', 'OP07_MATH_MULT_DIV_MOD', 'Expression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'Expression', 'OP08_MATH_ADD_SUB', 'Expression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'Expression', 'OP08_STRING_CAT', 'Expression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'Expression', 'OP09_BITWISE_SHIFT', 'Expression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'OP10_NAMED_UNARY', 'Expression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'OP10_NAMED_UNARY_STRINGIFY', 'Expression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'Expression', 'OP11_COMPARE_LT_GT', 'Expression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'Expression', 'OP12_COMPARE_EQ_NEQ', 'Expression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'Expression', 'OP13_BITWISE_AND', 'Expression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'Expression', 'OP14_BITWISE_OR_XOR', 'Expression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'Expression', 'OP15_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'Expression', 'OP16_LOGICAL_OR', 'Expression' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'Expression', 'OP17_LIST_RANGE', 'Expression' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'Expression', 'OP18_TERNARY', 'Variable', 'COLON', 'Variable' ], 0 ],
  [ 'Operator_118' => 'Operator', [ 'OP22_LOGICAL_NOT', 'Expression' ], 0 ],
  [ 'Operator_119' => 'Operator', [ 'Expression', 'OP23_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_120' => 'Operator', [ 'Expression', 'OP24_LOGICAL_OR_XOR', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'OperatorVoid_129' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'OPTIONAL-40', ')', ';' ], 0 ],
  [ 'OperatorVoid_130' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'FileHandle', 'OPTIONAL-41', ')', ';' ], 0 ],
  [ 'OperatorVoid_131' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-42', ';' ], 0 ],
  [ 'OperatorVoid_132' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'FileHandle', 'OPTIONAL-43', ';' ], 0 ],
  [ 'OperatorVoid_133' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'Expression_138' => 'Expression', [ 'undef' ], 0 ],
  [ 'Expression_139' => 'Expression', [ 'LITERAL' ], 0 ],
  [ 'Expression_140' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_141' => 'Expression', [ 'ArrayReference' ], 0 ],
  [ 'Expression_142' => 'Expression', [ 'ArrayDereferenced' ], 0 ],
  [ 'Expression_143' => 'Expression', [ 'HashReference' ], 0 ],
  [ 'Expression_144' => 'Expression', [ 'HashDereferenced' ], 0 ],
  [ 'Expression_145' => 'Expression', [ '{', '}' ], 0 ],
  [ 'Expression_146' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_147' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-44', ')' ], 0 ],
  [ 'Expression_148' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-45', ')' ], 0 ],
  [ 'Expression_149' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'PAREN-46' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_154' => 'Statement', [ 'OPTIONAL-47', 'Loop' ], 0 ],
  [ 'Statement_155' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_156' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_157' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-48', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [ 'STAR-49', 'PAREN-48' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [  ], 0 ],
  [ '_PAREN' => 'PAREN-50', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'PAREN-50' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'Conditional_164' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-49', 'OPTIONAL-51' ], 0 ],
  [ 'Loop_165' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_166' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_167' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_168' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_169' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_170' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'PLUS-52', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'Operation' ], 0 ],
  [ 'CodeBlock_173' => 'CodeBlock', [ '{', 'PLUS-52', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [ 'STAR-53', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [  ], 0 ],
  [ 'Variable_176' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-53' ], 0 ],
  [ 'VariableRetrieval_177' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_178' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_179' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_180' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_181' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_182' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_183' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-54', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-55', [ 'STAR-55', 'PAREN-54' ], 0 ],
  [ '_STAR_LIST' => 'STAR-55', [  ], 0 ],
  [ 'ListElements_187' => 'ListElements', [ 'ListElement', 'STAR-55' ], 0 ],
  [ 'ListElement_188' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_189' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_190' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [  ], 0 ],
  [ 'ArrayReference_193' => 'ArrayReference', [ '[', 'OPTIONAL-56', ']' ], 0 ],
  [ 'ArrayDereferenced_194' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_195' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [  ], 0 ],
  [ 'HashEntry_198' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-57', 'Expression' ], 0 ],
  [ 'HashEntry_199' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_200' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_201' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-58', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [ 'STAR-59', 'PAREN-58' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [  ], 0 ],
  [ 'HashReference_205' => 'HashReference', [ '{', 'HashEntry', 'STAR-59', '}' ], 0 ],
  [ 'HashDereferenced_206' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_207' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_208' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_209' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'FileHandle_210' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'TypeInner_211' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Type_212' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_213' => 'LoopLabel', [ 'WORD' ], 0 ],
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
  'OpsTypes_24' => 24,
  'OpsTypesSub_25' => 25,
  '_PLUS_LIST' => 26,
  '_PLUS_LIST' => 27,
  'Include_28' => 28,
  'Include_29' => 29,
  'Constant_30' => 30,
  '_OPTIONAL' => 31,
  '_OPTIONAL' => 32,
  '_OPTIONAL' => 33,
  '_OPTIONAL' => 34,
  '_PAREN' => 35,
  '_STAR_LIST' => 36,
  '_STAR_LIST' => 37,
  '_OPTIONAL' => 38,
  '_OPTIONAL' => 39,
  '_OPTIONAL' => 40,
  '_OPTIONAL' => 41,
  '_PAREN' => 42,
  '_STAR_LIST' => 43,
  '_STAR_LIST' => 44,
  'ConstantValue_45' => 45,
  'ConstantValue_46' => 46,
  'ConstantValue_47' => 47,
  '_OPTIONAL' => 48,
  '_OPTIONAL' => 49,
  '_PLUS_LIST' => 50,
  '_PLUS_LIST' => 51,
  'Subroutine_52' => 52,
  '_PAREN' => 53,
  '_STAR_LIST' => 54,
  '_STAR_LIST' => 55,
  '_STAR_LIST' => 56,
  '_STAR_LIST' => 57,
  'SubroutineArguments_58' => 58,
  '_PAREN' => 59,
  '_OPTIONAL' => 60,
  '_OPTIONAL' => 61,
  'ArgumentCheck_62' => 62,
  '_PLUS_LIST' => 63,
  '_PLUS_LIST' => 64,
  '_STAR_LIST' => 65,
  '_STAR_LIST' => 66,
  '_STAR_LIST' => 67,
  '_STAR_LIST' => 68,
  '_STAR_LIST' => 69,
  '_STAR_LIST' => 70,
  '_PLUS_LIST' => 71,
  '_PLUS_LIST' => 72,
  '_PAREN' => 73,
  '_OPTIONAL' => 74,
  '_OPTIONAL' => 75,
  'Class_76' => 76,
  '_PAREN' => 77,
  '_STAR_LIST' => 78,
  '_STAR_LIST' => 79,
  'Properties_80' => 80,
  'Properties_81' => 81,
  '_OPTIONAL' => 82,
  '_OPTIONAL' => 83,
  '_PLUS_LIST' => 84,
  '_PLUS_LIST' => 85,
  'Method_86' => 86,
  '_PAREN' => 87,
  '_STAR_LIST' => 88,
  '_STAR_LIST' => 89,
  '_STAR_LIST' => 90,
  '_STAR_LIST' => 91,
  'MethodArguments_92' => 92,
  'Operation_93' => 93,
  'Operation_94' => 94,
  '_OPTIONAL' => 95,
  '_OPTIONAL' => 96,
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
  'Operator_119' => 119,
  'Operator_120' => 120,
  '_OPTIONAL' => 121,
  '_OPTIONAL' => 122,
  '_OPTIONAL' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  '_OPTIONAL' => 128,
  'OperatorVoid_129' => 129,
  'OperatorVoid_130' => 130,
  'OperatorVoid_131' => 131,
  'OperatorVoid_132' => 132,
  'OperatorVoid_133' => 133,
  '_OPTIONAL' => 134,
  '_OPTIONAL' => 135,
  '_OPTIONAL' => 136,
  '_OPTIONAL' => 137,
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
  '_OPTIONAL' => 191,
  '_OPTIONAL' => 192,
  'ArrayReference_193' => 193,
  'ArrayDereferenced_194' => 194,
  'ArrayDereferenced_195' => 195,
  '_OPTIONAL' => 196,
  '_OPTIONAL' => 197,
  'HashEntry_198' => 198,
  'HashEntry_199' => 199,
  'HashEntryTyped_200' => 200,
  'HashEntryTyped_201' => 201,
  '_PAREN' => 202,
  '_STAR_LIST' => 203,
  '_STAR_LIST' => 204,
  'HashReference_205' => 205,
  'HashDereferenced_206' => 206,
  'HashDereferenced_207' => 207,
  'WordScoped_208' => 208,
  'WordScoped_209' => 209,
  'FileHandle_210' => 210,
  'TypeInner_211' => 211,
  'Type_212' => 212,
  'LoopLabel_213' => 213,
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
	OPS_SUB => { ISSEMANTIC => 1 },
	OPS_TYPES_ID => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	TYPES_SUB => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 1,
			"package" => 8
		},
		GOTOS => {
			'PLUS-1' => 5,
			'Class' => 6,
			'Package' => 7,
			'CompileUnit' => 2,
			'Module' => 3,
			'Program' => 4
		}
	},
	{#State 1
		ACTIONS => {
			"use strict;" => 10
		},
		GOTOS => {
			'Header' => 9
		}
	},
	{#State 2
		ACTIONS => {
			'' => 11
		}
	},
	{#State 3
		DEFAULT => -2
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			'' => -4,
			"package" => 8
		},
		GOTOS => {
			'Class' => 6,
			'Package' => 7,
			'Module' => 12
		}
	},
	{#State 6
		DEFAULT => -15
	},
	{#State 7
		DEFAULT => -14
	},
	{#State 8
		ACTIONS => {
			'WORD' => 15,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'WordScoped' => 13
		}
	},
	{#State 9
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 16
		}
	},
	{#State 10
		ACTIONS => {
			"use warnings;" => 17
		}
	},
	{#State 11
		DEFAULT => 0
	},
	{#State 12
		DEFAULT => -1
	},
	{#State 13
		ACTIONS => {
			";" => 18
		}
	},
	{#State 14
		DEFAULT => -209
	},
	{#State 15
		DEFAULT => -208
	},
	{#State 16
		ACTIONS => {
			"undef" => -8,
			"use constant" => -8,
			'OP05_LOGICAL_NEG' => -8,
			"my" => -8,
			'VARIABLE_SYMBOL' => -8,
			"foreach my" => -8,
			'WORD' => -8,
			"use" => 20,
			'OP01_NAMED' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			'OP03_MATH_INC_DEC' => -8,
			"if (" => -8,
			'OP10_NAMED_UNARY' => -8,
			"%{" => -8,
			'LITERAL' => -8,
			'OP01_NAMED_VOID' => -8,
			"[" => -8,
			"for my integer" => -8,
			"(" => -8,
			'OP22_LOGICAL_NOT' => -8,
			"\@{" => -8,
			'OP05_MATH_NEG' => -8,
			"{" => -8,
			"while (" => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			'OP19_LOOP_CONTROL' => -8,
			"our" => -8,
			'WORD_SCOPED' => -8
		},
		GOTOS => {
			'STAR-3' => 19,
			'Include' => 21
		}
	},
	{#State 17
		ACTIONS => {
			"our \$VERSION =" => 22
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
			"(" => -10,
			"[" => -10,
			"for my integer" => -10,
			'OP01_NAMED_VOID' => -10,
			'LITERAL' => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			'OP19_LOOP_CONTROL' => -10,
			'WORD_SCOPED' => -10,
			"our" => -10,
			"while (" => -10,
			"{" => -10,
			'OP05_MATH_NEG' => -10,
			"\@{" => -10,
			'OP22_LOGICAL_NOT' => -10,
			'VARIABLE_SYMBOL' => -10,
			'OP05_LOGICAL_NEG' => -10,
			"use constant" => 25,
			"my" => -10,
			"undef" => -10,
			'OP03_MATH_INC_DEC' => -10,
			"if (" => -10,
			"%{" => -10,
			'OP10_NAMED_UNARY' => -10,
			'OP01_NAMED' => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			"foreach my" => -10,
			'WORD' => -10
		},
		GOTOS => {
			'Constant' => 26,
			'STAR-4' => 24
		}
	},
	{#State 20
		ACTIONS => {
			'WORD' => 15,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 21
		DEFAULT => -5
	},
	{#State 22
		ACTIONS => {
			'VERSION_NUMBER' => 28
		}
	},
	{#State 23
		ACTIONS => {
			"our" => -17,
			"use parent qw(" => 30,
			"use constant" => -17,
			"use" => -17
		},
		GOTOS => {
			'STAR-6' => 29
		}
	},
	{#State 24
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"our" => 32,
			'OP19_LOOP_CONTROL' => 56,
			'OP01_NAMED_VOID_PAREN' => 55,
			"while (" => -152,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			"(" => 40,
			"for my integer" => -152,
			"[" => 38,
			'OP01_NAMED_VOID' => 61,
			'LITERAL' => 60,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			"if (" => 64,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD' => 45,
			"foreach my" => -152,
			'VARIABLE_SYMBOL' => 70,
			"my" => 69,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71
		},
		GOTOS => {
			'Operator' => 53,
			'Conditional' => 52,
			'ArrayReference' => 54,
			'PLUS-5' => 57,
			'Subroutine' => 35,
			'VariableDeclaration' => 34,
			'Statement' => 37,
			'Expression' => 39,
			'WordScoped' => 59,
			'VariableModification' => 41,
			'LoopLabel' => 62,
			'PAREN-46' => 42,
			'Operation' => 66,
			'OperatorVoid' => 46,
			'Variable' => 47,
			'HashReference' => 68,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'OPTIONAL-47' => 51
		}
	},
	{#State 25
		ACTIONS => {
			'WORD' => 72
		}
	},
	{#State 26
		DEFAULT => -7
	},
	{#State 27
		ACTIONS => {
			";" => 73,
			"qw(" => 74
		}
	},
	{#State 28
		ACTIONS => {
			";" => 75
		}
	},
	{#State 29
		ACTIONS => {
			"use constant" => -19,
			"our" => -19,
			"use" => 20
		},
		GOTOS => {
			'Include' => 77,
			'STAR-7' => 76
		}
	},
	{#State 30
		ACTIONS => {
			'WORD' => 15,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'PLUS-25' => 79,
			'WordScoped' => 78
		}
	},
	{#State 31
		ACTIONS => {
			"}" => 81,
			'WORD' => 82,
			"%{" => 67
		},
		GOTOS => {
			'HashEntry' => 80,
			'HashDereferenced' => 83
		}
	},
	{#State 32
		ACTIONS => {
			'WORD' => 85
		},
		GOTOS => {
			'Type' => 84
		}
	},
	{#State 33
		ACTIONS => {
			"[" => 38,
			'VARIABLE_SYMBOL' => 70
		},
		GOTOS => {
			'Variable' => 87,
			'ArrayReference' => 86
		}
	},
	{#State 34
		DEFAULT => -156
	},
	{#State 35
		DEFAULT => -9
	},
	{#State 36
		ACTIONS => {
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP03_MATH_INC_DEC' => 65,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD' => 15
		},
		GOTOS => {
			'ArrayReference' => 54,
			'Operator' => 53,
			'Variable' => 88,
			'HashReference' => 68,
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'Expression' => 89,
			'ArrayDereferenced' => 49
		}
	},
	{#State 37
		DEFAULT => -94
	},
	{#State 38
		ACTIONS => {
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			"]" => -192,
			'OP05_LOGICAL_NEG' => 48,
			"my" => 91,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'KEYS_OR_VALUES' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'WORD_SCOPED' => 14,
			"{" => 31
		},
		GOTOS => {
			'TypeInner' => 94,
			'Operator' => 53,
			'ArrayReference' => 54,
			'ListElement' => 92,
			'Variable' => 88,
			'HashReference' => 68,
			'OPTIONAL-56' => 90,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'Expression' => 96,
			'ArrayDereferenced' => 49,
			'ListElements' => 95
		}
	},
	{#State 39
		ACTIONS => {
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP11_COMPARE_LT_GT' => 101,
			'OP18_TERNARY' => 106,
			'OP06_REGEX_MATCH' => 99,
			'OP23_LOGICAL_AND' => 97,
			'OP04_MATH_POW' => 98,
			'OP08_MATH_ADD_SUB' => 107,
			'OP08_STRING_CAT' => 109,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP15_LOGICAL_AND' => 111,
			'OP09_BITWISE_SHIFT' => 112,
			";" => 113,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => 104
		}
	},
	{#State 40
		ACTIONS => {
			"[" => 38,
			"(" => 40,
			'LITERAL' => 60,
			"{" => 31,
			'WORD_SCOPED' => 14,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			"undef" => 71,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 65,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'WORD' => 15
		},
		GOTOS => {
			'HashReference' => 68,
			'Variable' => 88,
			'Operator' => 53,
			'ArrayReference' => 54,
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'Expression' => 114,
			'ArrayDereferenced' => 49
		}
	},
	{#State 41
		DEFAULT => -157
	},
	{#State 42
		DEFAULT => -151
	},
	{#State 43
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			'OP03_MATH_INC_DEC' => 65,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD' => 15,
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33
		},
		GOTOS => {
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'ArrayDereferenced' => 49,
			'Expression' => 115,
			'Operator' => 53,
			'ArrayReference' => 54,
			'HashReference' => 68,
			'Variable' => 88
		}
	},
	{#State 44
		ACTIONS => {
			'LITERAL' => 60,
			"[" => 38,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'OP05_MATH_NEG' => 36,
			"{" => 31,
			'WORD_SCOPED' => 14,
			"undef" => 71,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			'WORD' => 15,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65
		},
		GOTOS => {
			'Operator' => 53,
			'ArrayReference' => 54,
			'HashReference' => 68,
			'Variable' => 88,
			'Expression' => 116,
			'ArrayDereferenced' => 49,
			'WordScoped' => 59,
			'HashDereferenced' => 50
		}
	},
	{#State 45
		ACTIONS => {
			"(" => -208,
			'COLON' => -213
		}
	},
	{#State 46
		DEFAULT => -155
	},
	{#State 47
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -140,
			'OP08_STRING_CAT' => -140,
			'OP07_MATH_MULT_DIV_MOD' => -140,
			'OP06_REGEX_MATCH' => -140,
			'OP04_MATH_POW' => -140,
			'OP23_LOGICAL_AND' => -140,
			'OP18_TERNARY' => -140,
			'OP08_MATH_ADD_SUB' => -140,
			'OP16_LOGICAL_OR' => -140,
			'OP24_LOGICAL_OR_XOR' => -140,
			'OP02_METHOD_THINARROW' => 120,
			'OP11_COMPARE_LT_GT' => -140,
			'OP17_LIST_RANGE' => -140,
			'OP13_BITWISE_AND' => -140,
			'OP19_VARIABLE_ASSIGN_BY' => 119,
			'OP19_VARIABLE_ASSIGN' => 118,
			'OP14_BITWISE_OR_XOR' => -140,
			'OP03_MATH_INC_DEC' => 117,
			'OP15_LOGICAL_AND' => -140,
			'OP09_BITWISE_SHIFT' => -140,
			";" => -140
		}
	},
	{#State 48
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD' => 15,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71
		},
		GOTOS => {
			'ArrayDereferenced' => 49,
			'Expression' => 121,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'Operator' => 53,
			'ArrayReference' => 54,
			'Variable' => 88,
			'HashReference' => 68
		}
	},
	{#State 49
		DEFAULT => -142
	},
	{#State 50
		DEFAULT => -144
	},
	{#State 51
		ACTIONS => {
			"foreach my" => 128,
			"while (" => 123,
			"for my integer" => 122
		},
		GOTOS => {
			'LoopFor' => 126,
			'LoopWhile' => 125,
			'Loop' => 124,
			'LoopForEach' => 127
		}
	},
	{#State 52
		DEFAULT => -153
	},
	{#State 53
		DEFAULT => -146
	},
	{#State 54
		DEFAULT => -141
	},
	{#State 55
		ACTIONS => {
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			"{*" => 130,
			'WORD_SCOPED' => 14,
			"{" => 31,
			")" => -122,
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			'WORD' => 15,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP03_MATH_INC_DEC' => 65,
			'OP01_NAMED' => 63,
			'KEYS_OR_VALUES' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			"my" => 91,
			'OP05_LOGICAL_NEG' => 48
		},
		GOTOS => {
			'Variable' => 88,
			'HashReference' => 68,
			'TypeInner' => 94,
			'Operator' => 53,
			'ArrayReference' => 54,
			'ListElement' => 92,
			'ListElements' => 129,
			'OPTIONAL-40' => 131,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'FileHandle' => 132,
			'Expression' => 96,
			'ArrayDereferenced' => 49
		}
	},
	{#State 56
		ACTIONS => {
			'WORD' => 134
		},
		GOTOS => {
			'LoopLabel' => 133
		}
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"my" => 69,
			"undef" => 71,
			'OP03_MATH_INC_DEC' => 65,
			"if (" => 64,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			"foreach my" => -152,
			'WORD' => 45,
			"(" => 40,
			'' => -13,
			"[" => 38,
			"for my integer" => -152,
			'OP01_NAMED_VOID' => 61,
			'LITERAL' => 60,
			'OP19_LOOP_CONTROL' => 56,
			'OP01_NAMED_VOID_PAREN' => 55,
			'WORD_SCOPED' => 14,
			"{" => 31,
			"while (" => -152,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33
		},
		GOTOS => {
			'HashReference' => 68,
			'Variable' => 47,
			'OperatorVoid' => 46,
			'Operation' => 135,
			'PAREN-46' => 42,
			'OPTIONAL-47' => 51,
			'HashDereferenced' => 50,
			'ArrayDereferenced' => 49,
			'Statement' => 37,
			'VariableDeclaration' => 34,
			'Operator' => 53,
			'Conditional' => 52,
			'ArrayReference' => 54,
			'LoopLabel' => 62,
			'VariableModification' => 41,
			'WordScoped' => 59,
			'Expression' => 39
		}
	},
	{#State 58
		ACTIONS => {
			"undef" => 71,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			'WORD' => 15,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'LITERAL' => 60,
			"[" => 38,
			"(" => 40,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36,
			"{" => 31,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'HashReference' => 68,
			'Variable' => 88,
			'Operator' => 53,
			'ArrayReference' => 54,
			'Expression' => 136,
			'ArrayDereferenced' => 49,
			'WordScoped' => 59,
			'HashDereferenced' => 50
		}
	},
	{#State 59
		ACTIONS => {
			"(" => 137
		}
	},
	{#State 60
		DEFAULT => -139
	},
	{#State 61
		ACTIONS => {
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"my" => 91,
			";" => -126,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'KEYS_OR_VALUES' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			'OP05_MATH_NEG' => 36,
			"{*" => 130,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'WORD_SCOPED' => 14,
			"{" => 31
		},
		GOTOS => {
			'ListElements' => 140,
			'Expression' => 96,
			'ArrayDereferenced' => 49,
			'FileHandle' => 138,
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'OPTIONAL-42' => 139,
			'Variable' => 88,
			'HashReference' => 68,
			'ArrayReference' => 54,
			'Operator' => 53,
			'ListElement' => 92,
			'TypeInner' => 94
		}
	},
	{#State 62
		ACTIONS => {
			'COLON' => 141
		}
	},
	{#State 63
		ACTIONS => {
			"(" => 142
		}
	},
	{#State 64
		ACTIONS => {
			'WORD' => 15,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP03_MATH_INC_DEC' => 65,
			"undef" => 71,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'OP05_MATH_NEG' => 36,
			"{" => 31,
			'WORD_SCOPED' => 14,
			'LITERAL' => 60,
			"[" => 38,
			"(" => 40
		},
		GOTOS => {
			'HashReference' => 68,
			'Variable' => 88,
			'ArrayReference' => 54,
			'Operator' => 53,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'ArrayDereferenced' => 49,
			'Expression' => 143
		}
	},
	{#State 65
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70
		},
		GOTOS => {
			'Variable' => 144
		}
	},
	{#State 66
		DEFAULT => -12
	},
	{#State 67
		ACTIONS => {
			"{" => 146,
			'VARIABLE_SYMBOL' => 70
		},
		GOTOS => {
			'Variable' => 145,
			'HashReference' => 147
		}
	},
	{#State 68
		DEFAULT => -143
	},
	{#State 69
		ACTIONS => {
			'WORD' => 85
		},
		GOTOS => {
			'Type' => 148
		}
	},
	{#State 70
		DEFAULT => -175,
		GOTOS => {
			'STAR-53' => 149
		}
	},
	{#State 71
		DEFAULT => -138
	},
	{#State 72
		ACTIONS => {
			'OP20_HASH_FATARROW' => 150
		}
	},
	{#State 73
		DEFAULT => -28
	},
	{#State 74
		ACTIONS => {
			'WORD' => 152
		},
		GOTOS => {
			'PLUS-9' => 151
		}
	},
	{#State 75
		ACTIONS => {
			"use Carp;" => 153
		}
	},
	{#State 76
		ACTIONS => {
			"our" => 32,
			"use constant" => 25
		},
		GOTOS => {
			'Subroutine' => 156,
			'Constant' => 155,
			'PLUS-8' => 154
		}
	},
	{#State 77
		DEFAULT => -16
	},
	{#State 78
		DEFAULT => -64
	},
	{#State 79
		ACTIONS => {
			'WORD_SCOPED' => 14,
			")" => 157,
			'WORD' => 15
		},
		GOTOS => {
			'WordScoped' => 158
		}
	},
	{#State 80
		DEFAULT => -204,
		GOTOS => {
			'STAR-59' => 159
		}
	},
	{#State 81
		DEFAULT => -145
	},
	{#State 82
		ACTIONS => {
			'OP20_HASH_FATARROW' => 160
		}
	},
	{#State 83
		DEFAULT => -199
	},
	{#State 84
		ACTIONS => {
			'VARIABLE_SYMBOL' => 161
		}
	},
	{#State 85
		DEFAULT => -212
	},
	{#State 86
		ACTIONS => {
			"}" => 162
		}
	},
	{#State 87
		ACTIONS => {
			"}" => 163
		}
	},
	{#State 88
		ACTIONS => {
			'OP17_LIST_RANGE' => -140,
			"]" => -140,
			'OP13_BITWISE_AND' => -140,
			"}" => -140,
			'OP14_BITWISE_OR_XOR' => -140,
			".." => -140,
			'OP03_MATH_INC_DEC' => 117,
			'OP15_LOGICAL_AND' => -140,
			";" => -140,
			'OP09_BITWISE_SHIFT' => -140,
			'OP21_LIST_COMMA' => -140,
			'OP12_COMPARE_EQ_NEQ' => -140,
			'OP08_STRING_CAT' => -140,
			")" => -140,
			'OP07_MATH_MULT_DIV_MOD' => -140,
			'OP04_MATH_POW' => -140,
			'OP23_LOGICAL_AND' => -140,
			'OP06_REGEX_MATCH' => -140,
			'OP18_TERNARY' => -140,
			'OP08_MATH_ADD_SUB' => -140,
			'OP16_LOGICAL_OR' => -140,
			'OP02_METHOD_THINARROW' => 120,
			'OP24_LOGICAL_OR_XOR' => -140,
			'OP11_COMPARE_LT_GT' => -140
		}
	},
	{#State 89
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 101,
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP08_MATH_ADD_SUB' => 107,
			'OP18_TERNARY' => 106,
			'OP06_REGEX_MATCH' => 99,
			'OP23_LOGICAL_AND' => 97,
			'OP04_MATH_POW' => 98,
			")" => 164,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP08_STRING_CAT' => 109,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP09_BITWISE_SHIFT' => 112,
			'OP15_LOGICAL_AND' => 111,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP17_LIST_RANGE' => 104,
			'OP13_BITWISE_AND' => 103
		}
	},
	{#State 90
		ACTIONS => {
			"]" => 165
		}
	},
	{#State 91
		ACTIONS => {
			'WORD' => 85
		},
		GOTOS => {
			'Type' => 166
		}
	},
	{#State 92
		DEFAULT => -186,
		GOTOS => {
			'STAR-55' => 167
		}
	},
	{#State 93
		ACTIONS => {
			"%{" => 67
		},
		GOTOS => {
			'HashDereferenced' => 168
		}
	},
	{#State 94
		ACTIONS => {
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'WORD' => 15
		},
		GOTOS => {
			'Expression' => 169,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'ArrayReference' => 54,
			'Operator' => 53,
			'HashReference' => 68,
			'Variable' => 88
		}
	},
	{#State 95
		DEFAULT => -191
	},
	{#State 96
		ACTIONS => {
			'OP15_LOGICAL_AND' => 111,
			'OP21_LIST_COMMA' => -188,
			";" => -188,
			'OP09_BITWISE_SHIFT' => 112,
			'OP14_BITWISE_OR_XOR' => 105,
			"]" => -188,
			'OP17_LIST_RANGE' => 104,
			'OP13_BITWISE_AND' => 103,
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP11_COMPARE_LT_GT' => 101,
			'OP18_TERNARY' => 106,
			'OP23_LOGICAL_AND' => 97,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP08_MATH_ADD_SUB' => 107,
			'OP08_STRING_CAT' => 109,
			")" => -188,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP12_COMPARE_EQ_NEQ' => 102
		}
	},
	{#State 97
		ACTIONS => {
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'WORD_SCOPED' => 14,
			"{" => 31,
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63
		},
		GOTOS => {
			'Operator' => 53,
			'ArrayReference' => 54,
			'Variable' => 88,
			'HashReference' => 68,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'ArrayDereferenced' => 49,
			'Expression' => 170
		}
	},
	{#State 98
		ACTIONS => {
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 65,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'WORD_SCOPED' => 14,
			"{" => 31
		},
		GOTOS => {
			'Operator' => 53,
			'ArrayReference' => 54,
			'HashReference' => 68,
			'Variable' => 88,
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'Expression' => 171,
			'ArrayDereferenced' => 49
		}
	},
	{#State 99
		ACTIONS => {
			"/" => 172
		}
	},
	{#State 100
		ACTIONS => {
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'WORD_SCOPED' => 14,
			"{" => 31,
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			'WORD' => 15,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP03_MATH_INC_DEC' => 65,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43
		},
		GOTOS => {
			'Expression' => 173,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'Operator' => 53,
			'ArrayReference' => 54,
			'Variable' => 88,
			'HashReference' => 68
		}
	},
	{#State 101
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'WORD' => 15,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71
		},
		GOTOS => {
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'Expression' => 174,
			'ArrayDereferenced' => 49,
			'ArrayReference' => 54,
			'Operator' => 53,
			'HashReference' => 68,
			'Variable' => 88
		}
	},
	{#State 102
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'WORD' => 15,
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58
		},
		GOTOS => {
			'Operator' => 53,
			'ArrayReference' => 54,
			'Variable' => 88,
			'HashReference' => 68,
			'Expression' => 175,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'WordScoped' => 59
		}
	},
	{#State 103
		ACTIONS => {
			'WORD' => 15,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38
		},
		GOTOS => {
			'Expression' => 176,
			'ArrayDereferenced' => 49,
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'Variable' => 88,
			'HashReference' => 68,
			'ArrayReference' => 54,
			'Operator' => 53
		}
	},
	{#State 104
		ACTIONS => {
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36,
			"{" => 31,
			'WORD_SCOPED' => 14,
			'LITERAL' => 60,
			"[" => 38,
			"(" => 40,
			'WORD' => 15,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			"undef" => 71,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70
		},
		GOTOS => {
			'HashReference' => 68,
			'Variable' => 88,
			'Operator' => 53,
			'ArrayReference' => 54,
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'Expression' => 177,
			'ArrayDereferenced' => 49
		}
	},
	{#State 105
		ACTIONS => {
			'LITERAL' => 60,
			"[" => 38,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'OP05_MATH_NEG' => 36,
			"{" => 31,
			'WORD_SCOPED' => 14,
			"undef" => 71,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			'WORD' => 15,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67
		},
		GOTOS => {
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'ArrayDereferenced' => 49,
			'Expression' => 178,
			'ArrayReference' => 54,
			'Operator' => 53,
			'HashReference' => 68,
			'Variable' => 88
		}
	},
	{#State 106
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70
		},
		GOTOS => {
			'Variable' => 179
		}
	},
	{#State 107
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD' => 15,
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33
		},
		GOTOS => {
			'ArrayDereferenced' => 49,
			'Expression' => 180,
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'HashReference' => 68,
			'Variable' => 88,
			'Operator' => 53,
			'ArrayReference' => 54
		}
	},
	{#State 108
		ACTIONS => {
			"undef" => 71,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			'WORD' => 15,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'LITERAL' => 60,
			"[" => 38,
			"(" => 40,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36,
			"{" => 31,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'Variable' => 88,
			'HashReference' => 68,
			'Operator' => 53,
			'ArrayReference' => 54,
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'ArrayDereferenced' => 49,
			'Expression' => 181
		}
	},
	{#State 109
		ACTIONS => {
			"undef" => 71,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			'WORD' => 15,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP03_MATH_INC_DEC' => 65,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'LITERAL' => 60,
			"[" => 38,
			"(" => 40,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36,
			"{" => 31,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'ArrayDereferenced' => 49,
			'Expression' => 182,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'Variable' => 88,
			'HashReference' => 68,
			'Operator' => 53,
			'ArrayReference' => 54
		}
	},
	{#State 110
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD' => 15,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71
		},
		GOTOS => {
			'Operator' => 53,
			'ArrayReference' => 54,
			'HashReference' => 68,
			'Variable' => 88,
			'Expression' => 183,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'WordScoped' => 59
		}
	},
	{#State 111
		ACTIONS => {
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD' => 15
		},
		GOTOS => {
			'Operator' => 53,
			'ArrayReference' => 54,
			'Variable' => 88,
			'HashReference' => 68,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'ArrayDereferenced' => 49,
			'Expression' => 184
		}
	},
	{#State 112
		ACTIONS => {
			'WORD' => 15,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			"undef" => 71,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36,
			"{" => 31,
			'WORD_SCOPED' => 14,
			'LITERAL' => 60,
			"[" => 38,
			"(" => 40
		},
		GOTOS => {
			'Expression' => 185,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'Operator' => 53,
			'ArrayReference' => 54,
			'HashReference' => 68,
			'Variable' => 88
		}
	},
	{#State 113
		DEFAULT => -93
	},
	{#State 114
		ACTIONS => {
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP11_COMPARE_LT_GT' => 101,
			'OP18_TERNARY' => 106,
			'OP23_LOGICAL_AND' => 97,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP08_MATH_ADD_SUB' => 107,
			'OP08_STRING_CAT' => 109,
			")" => 186,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP15_LOGICAL_AND' => 111,
			'OP09_BITWISE_SHIFT' => 112,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => 104
		}
	},
	{#State 115
		ACTIONS => {
			'OP21_LIST_COMMA' => -109,
			'OP09_BITWISE_SHIFT' => 112,
			";" => -109,
			'OP15_LOGICAL_AND' => -109,
			".." => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			"}" => -109,
			"]" => -109,
			'OP13_BITWISE_AND' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP08_MATH_ADD_SUB' => 107,
			'OP18_TERNARY' => -109,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP23_LOGICAL_AND' => -109,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -109,
			'OP08_STRING_CAT' => 109,
			'OP12_COMPARE_EQ_NEQ' => -109
		}
	},
	{#State 116
		ACTIONS => {
			"]" => -108,
			'OP17_LIST_RANGE' => -108,
			'OP13_BITWISE_AND' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			".." => -108,
			"}" => -108,
			'OP21_LIST_COMMA' => -108,
			";" => -108,
			'OP09_BITWISE_SHIFT' => 112,
			'OP15_LOGICAL_AND' => -108,
			'OP12_COMPARE_EQ_NEQ' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -108,
			'OP08_STRING_CAT' => 109,
			'OP08_MATH_ADD_SUB' => 107,
			'OP18_TERNARY' => -108,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99,
			'OP23_LOGICAL_AND' => -108,
			'OP11_COMPARE_LT_GT' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP24_LOGICAL_OR_XOR' => -108
		}
	},
	{#State 117
		DEFAULT => -99
	},
	{#State 118
		ACTIONS => {
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD' => 15,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60
		},
		GOTOS => {
			'Variable' => 88,
			'HashReference' => 68,
			'Operator' => 53,
			'ArrayReference' => 54,
			'ArrayDereferenced' => 49,
			'Expression' => 187,
			'HashDereferenced' => 50,
			'WordScoped' => 59
		}
	},
	{#State 119
		ACTIONS => {
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'WORD' => 15
		},
		GOTOS => {
			'Expression' => 188,
			'ArrayDereferenced' => 49,
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'Operator' => 53,
			'ArrayReference' => 54,
			'Variable' => 88,
			'HashReference' => 68
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 189
		}
	},
	{#State 121
		ACTIONS => {
			'OP21_LIST_COMMA' => -101,
			";" => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP15_LOGICAL_AND' => -101,
			".." => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			"}" => -101,
			"]" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP18_TERNARY' => -101,
			'OP06_REGEX_MATCH' => -101,
			'OP04_MATH_POW' => 98,
			'OP23_LOGICAL_AND' => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			")" => -101,
			'OP08_STRING_CAT' => -101,
			'OP12_COMPARE_EQ_NEQ' => -101
		}
	},
	{#State 122
		ACTIONS => {
			'VARIABLE_SYMBOL' => 190
		}
	},
	{#State 123
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'WORD' => 15,
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58
		},
		GOTOS => {
			'Operator' => 53,
			'ArrayReference' => 54,
			'HashReference' => 68,
			'Variable' => 88,
			'ArrayDereferenced' => 49,
			'Expression' => 191,
			'HashDereferenced' => 50,
			'WordScoped' => 59
		}
	},
	{#State 124
		DEFAULT => -154
	},
	{#State 125
		DEFAULT => -167
	},
	{#State 126
		DEFAULT => -165
	},
	{#State 127
		DEFAULT => -166
	},
	{#State 128
		ACTIONS => {
			'WORD' => 85
		},
		GOTOS => {
			'Type' => 192
		}
	},
	{#State 129
		DEFAULT => -121
	},
	{#State 130
		ACTIONS => {
			'WORD' => 193
		}
	},
	{#State 131
		ACTIONS => {
			")" => 194
		}
	},
	{#State 132
		ACTIONS => {
			'LITERAL' => 60,
			")" => -124,
			"[" => 38,
			"(" => 40,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36,
			"{" => 31,
			'WORD_SCOPED' => 14,
			"undef" => 71,
			'OP05_LOGICAL_NEG' => 48,
			"my" => 91,
			'VARIABLE_SYMBOL' => 70,
			'WORD' => 15,
			'OP01_NAMED' => 63,
			'KEYS_OR_VALUES' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP03_MATH_INC_DEC' => 65,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44
		},
		GOTOS => {
			'ListElement' => 92,
			'Operator' => 53,
			'ArrayReference' => 54,
			'TypeInner' => 94,
			'HashReference' => 68,
			'Variable' => 88,
			'Expression' => 96,
			'ArrayDereferenced' => 49,
			'OPTIONAL-41' => 196,
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'ListElements' => 195
		}
	},
	{#State 133
		ACTIONS => {
			";" => 197
		}
	},
	{#State 134
		DEFAULT => -213
	},
	{#State 135
		DEFAULT => -11
	},
	{#State 136
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -118,
			'OP08_STRING_CAT' => 109,
			'OP08_MATH_ADD_SUB' => 107,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99,
			'OP23_LOGICAL_AND' => -118,
			'OP18_TERNARY' => 106,
			'OP11_COMPARE_LT_GT' => 101,
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP17_LIST_RANGE' => 104,
			"]" => -118,
			'OP13_BITWISE_AND' => 103,
			"}" => -118,
			'OP14_BITWISE_OR_XOR' => 105,
			".." => -118,
			'OP09_BITWISE_SHIFT' => 112,
			";" => -118,
			'OP21_LIST_COMMA' => -118,
			'OP15_LOGICAL_AND' => 111
		}
	},
	{#State 137
		ACTIONS => {
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'KEYS_OR_VALUES' => 93,
			'WORD' => 15,
			'VARIABLE_SYMBOL' => 70,
			"my" => 91,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			"(" => 40,
			"[" => 38,
			")" => -135,
			'LITERAL' => 60
		},
		GOTOS => {
			'Expression' => 96,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'OPTIONAL-44' => 198,
			'ListElements' => 199,
			'Operator' => 53,
			'ArrayReference' => 54,
			'ListElement' => 92,
			'TypeInner' => 94,
			'Variable' => 88,
			'HashReference' => 68
		}
	},
	{#State 138
		ACTIONS => {
			"my" => 91,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			"undef" => 71,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'KEYS_OR_VALUES' => 93,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP03_MATH_INC_DEC' => 65,
			'WORD' => 15,
			";" => -128,
			"[" => 38,
			"(" => 40,
			'LITERAL' => 60,
			"{" => 31,
			'WORD_SCOPED' => 14,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'OP05_MATH_NEG' => 36
		},
		GOTOS => {
			'ListElements' => 201,
			'Expression' => 96,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'HashReference' => 68,
			'Variable' => 88,
			'ListElement' => 92,
			'OPTIONAL-43' => 200,
			'Operator' => 53,
			'ArrayReference' => 54,
			'TypeInner' => 94
		}
	},
	{#State 139
		ACTIONS => {
			";" => 202
		}
	},
	{#State 140
		DEFAULT => -125
	},
	{#State 141
		DEFAULT => -150
	},
	{#State 142
		ACTIONS => {
			'KEYS_OR_VALUES' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'WORD' => 15,
			'OP05_LOGICAL_NEG' => 48,
			"my" => 91,
			'VARIABLE_SYMBOL' => 70,
			"undef" => 71,
			"{" => 31,
			'WORD_SCOPED' => 14,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'OP05_MATH_NEG' => 36,
			"[" => 38,
			"(" => 40,
			'LITERAL' => 60,
			")" => -96
		},
		GOTOS => {
			'ListElements' => 204,
			'Expression' => 96,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'HashReference' => 68,
			'Variable' => 88,
			'ListElement' => 92,
			'Operator' => 53,
			'ArrayReference' => 54,
			'TypeInner' => 94,
			'OPTIONAL-39' => 203
		}
	},
	{#State 143
		ACTIONS => {
			")" => 205,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP08_STRING_CAT' => 109,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP11_COMPARE_LT_GT' => 101,
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP08_MATH_ADD_SUB' => 107,
			'OP18_TERNARY' => 106,
			'OP23_LOGICAL_AND' => 97,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => 104,
			'OP09_BITWISE_SHIFT' => 112,
			'OP15_LOGICAL_AND' => 111
		}
	},
	{#State 144
		DEFAULT => -98
	},
	{#State 145
		ACTIONS => {
			"}" => 206
		}
	},
	{#State 146
		ACTIONS => {
			'WORD' => 82,
			"%{" => 67
		},
		GOTOS => {
			'HashDereferenced' => 83,
			'HashEntry' => 80
		}
	},
	{#State 147
		ACTIONS => {
			"}" => 207
		}
	},
	{#State 148
		ACTIONS => {
			'VARIABLE_SYMBOL' => 208
		}
	},
	{#State 149
		ACTIONS => {
			'COLON' => -176,
			'OP15_LOGICAL_AND' => -176,
			'OP21_LIST_COMMA' => -176,
			'OP09_BITWISE_SHIFT' => -176,
			";" => -176,
			'OP03_MATH_INC_DEC' => -176,
			'OP19_VARIABLE_ASSIGN' => -176,
			'OP14_BITWISE_OR_XOR' => -176,
			".." => -176,
			"}" => -176,
			'OP19_VARIABLE_ASSIGN_BY' => -176,
			'OP13_BITWISE_AND' => -176,
			"]" => -176,
			'OP17_LIST_RANGE' => -176,
			'OP16_LOGICAL_OR' => -176,
			'OP02_METHOD_THINARROW' => -176,
			'OP24_LOGICAL_OR_XOR' => -176,
			'OP11_COMPARE_LT_GT' => -176,
			'OP18_TERNARY' => -176,
			'OP04_MATH_POW' => -176,
			'OP23_LOGICAL_AND' => -176,
			'OP06_REGEX_MATCH' => -176,
			'OP08_MATH_ADD_SUB' => -176,
			'OP02_ARRAY_THINARROW' => 209,
			'OP08_STRING_CAT' => -176,
			")" => -176,
			'OP07_MATH_MULT_DIV_MOD' => -176,
			'OP02_HASH_THINARROW' => 210,
			'OP12_COMPARE_EQ_NEQ' => -176
		},
		GOTOS => {
			'VariableRetrieval' => 211
		}
	},
	{#State 150
		ACTIONS => {
			"my" => 91
		},
		GOTOS => {
			'TypeInner' => 212
		}
	},
	{#State 151
		ACTIONS => {
			'WORD' => 214,
			")" => 213
		}
	},
	{#State 152
		DEFAULT => -27
	},
	{#State 153
		ACTIONS => {
			"use RPerl;" => 215
		}
	},
	{#State 154
		ACTIONS => {
			"1;1;" => 217,
			"our" => 32
		},
		GOTOS => {
			'Subroutine' => 216
		}
	},
	{#State 155
		DEFAULT => -18
	},
	{#State 156
		DEFAULT => -21
	},
	{#State 157
		ACTIONS => {
			";" => 218
		}
	},
	{#State 158
		DEFAULT => -63
	},
	{#State 159
		ACTIONS => {
			"}" => 220,
			'OP21_LIST_COMMA' => 219
		},
		GOTOS => {
			'PAREN-58' => 221
		}
	},
	{#State 160
		ACTIONS => {
			'OP05_MATH_NEG' => -197,
			"\@{" => -197,
			'OP22_LOGICAL_NOT' => -197,
			'WORD_SCOPED' => -197,
			"{" => -197,
			'LITERAL' => -197,
			"(" => -197,
			"[" => -197,
			'WORD' => -197,
			'OP10_NAMED_UNARY' => -197,
			"%{" => -197,
			'OP03_MATH_INC_DEC' => -197,
			'OP10_NAMED_UNARY_STRINGIFY' => -197,
			'OP01_NAMED' => -197,
			"undef" => -197,
			'VARIABLE_SYMBOL' => -197,
			"my" => 91,
			'OP05_LOGICAL_NEG' => -197
		},
		GOTOS => {
			'OPTIONAL-57' => 223,
			'TypeInner' => 222
		}
	},
	{#State 161
		ACTIONS => {
			"= sub {" => 224
		}
	},
	{#State 162
		DEFAULT => -195
	},
	{#State 163
		DEFAULT => -194
	},
	{#State 164
		DEFAULT => -102
	},
	{#State 165
		DEFAULT => -193
	},
	{#State 166
		ACTIONS => {
			"\$TYPED_" => 225
		}
	},
	{#State 167
		ACTIONS => {
			";" => -187,
			")" => -187,
			'OP21_LIST_COMMA' => 227,
			"]" => -187
		},
		GOTOS => {
			'PAREN-54' => 226
		}
	},
	{#State 168
		DEFAULT => -190
	},
	{#State 169
		ACTIONS => {
			'OP15_LOGICAL_AND' => 111,
			'OP21_LIST_COMMA' => -189,
			";" => -189,
			'OP09_BITWISE_SHIFT' => 112,
			'OP14_BITWISE_OR_XOR' => 105,
			"]" => -189,
			'OP17_LIST_RANGE' => 104,
			'OP13_BITWISE_AND' => 103,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP16_LOGICAL_OR' => 108,
			'OP11_COMPARE_LT_GT' => 101,
			'OP18_TERNARY' => 106,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99,
			'OP23_LOGICAL_AND' => 97,
			'OP08_MATH_ADD_SUB' => 107,
			'OP08_STRING_CAT' => 109,
			")" => -189,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP12_COMPARE_EQ_NEQ' => 102
		}
	},
	{#State 170
		ACTIONS => {
			"}" => -119,
			'OP14_BITWISE_OR_XOR' => 105,
			".." => -119,
			"]" => -119,
			'OP17_LIST_RANGE' => 104,
			'OP13_BITWISE_AND' => 103,
			'OP15_LOGICAL_AND' => 111,
			";" => -119,
			'OP09_BITWISE_SHIFT' => 112,
			'OP21_LIST_COMMA' => -119,
			'OP08_STRING_CAT' => 109,
			")" => -119,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP16_LOGICAL_OR' => 108,
			'OP11_COMPARE_LT_GT' => 101,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP23_LOGICAL_AND' => -119,
			'OP18_TERNARY' => 106,
			'OP08_MATH_ADD_SUB' => 107
		}
	},
	{#State 171
		ACTIONS => {
			'OP08_STRING_CAT' => -100,
			")" => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP18_TERNARY' => -100,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			".." => -100,
			"}" => -100,
			"]" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP21_LIST_COMMA' => -100,
			";" => -100,
			'OP09_BITWISE_SHIFT' => -100
		}
	},
	{#State 172
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 228
		}
	},
	{#State 173
		ACTIONS => {
			"}" => -120,
			'OP14_BITWISE_OR_XOR' => 105,
			".." => -120,
			"]" => -120,
			'OP17_LIST_RANGE' => 104,
			'OP13_BITWISE_AND' => 103,
			'OP15_LOGICAL_AND' => 111,
			'OP09_BITWISE_SHIFT' => 112,
			";" => -120,
			'OP21_LIST_COMMA' => -120,
			'OP08_STRING_CAT' => 109,
			")" => -120,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP16_LOGICAL_OR' => 108,
			'OP11_COMPARE_LT_GT' => 101,
			'OP23_LOGICAL_AND' => 97,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP18_TERNARY' => 106,
			'OP08_MATH_ADD_SUB' => 107
		}
	},
	{#State 174
		ACTIONS => {
			'OP21_LIST_COMMA' => -110,
			'OP09_BITWISE_SHIFT' => 112,
			";" => -110,
			'OP15_LOGICAL_AND' => -110,
			".." => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			"}" => -110,
			'OP13_BITWISE_AND' => -110,
			"]" => -110,
			'OP17_LIST_RANGE' => -110,
			'OP11_COMPARE_LT_GT' => undef,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP08_MATH_ADD_SUB' => 107,
			'OP18_TERNARY' => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -110,
			'OP08_STRING_CAT' => 109,
			'OP12_COMPARE_EQ_NEQ' => -110
		}
	},
	{#State 175
		ACTIONS => {
			'OP08_STRING_CAT' => 109,
			")" => -111,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP16_LOGICAL_OR' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP11_COMPARE_LT_GT' => 101,
			'OP23_LOGICAL_AND' => -111,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP18_TERNARY' => -111,
			'OP08_MATH_ADD_SUB' => 107,
			"}" => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			".." => -111,
			'OP17_LIST_RANGE' => -111,
			"]" => -111,
			'OP13_BITWISE_AND' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP09_BITWISE_SHIFT' => 112,
			";" => -111,
			'OP21_LIST_COMMA' => -111
		}
	},
	{#State 176
		ACTIONS => {
			'OP23_LOGICAL_AND' => -112,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99,
			'OP18_TERNARY' => -112,
			'OP08_MATH_ADD_SUB' => 107,
			'OP16_LOGICAL_OR' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP11_COMPARE_LT_GT' => 101,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP08_STRING_CAT' => 109,
			")" => -112,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP15_LOGICAL_AND' => -112,
			'OP09_BITWISE_SHIFT' => 112,
			";" => -112,
			'OP21_LIST_COMMA' => -112,
			'OP17_LIST_RANGE' => -112,
			"]" => -112,
			'OP13_BITWISE_AND' => -112,
			"}" => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			".." => -112
		}
	},
	{#State 177
		ACTIONS => {
			'OP21_LIST_COMMA' => -116,
			'OP09_BITWISE_SHIFT' => 112,
			";" => -116,
			'OP15_LOGICAL_AND' => 111,
			".." => -116,
			'OP14_BITWISE_OR_XOR' => 105,
			"}" => -116,
			"]" => -116,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => undef,
			'OP11_COMPARE_LT_GT' => 101,
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP08_MATH_ADD_SUB' => 107,
			'OP18_TERNARY' => -116,
			'OP06_REGEX_MATCH' => 99,
			'OP23_LOGICAL_AND' => -116,
			'OP04_MATH_POW' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -116,
			'OP08_STRING_CAT' => 109,
			'OP12_COMPARE_EQ_NEQ' => 102
		}
	},
	{#State 178
		ACTIONS => {
			";" => -113,
			'OP09_BITWISE_SHIFT' => 112,
			'OP21_LIST_COMMA' => -113,
			'OP15_LOGICAL_AND' => -113,
			"]" => -113,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => -113,
			"}" => -113,
			".." => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP08_MATH_ADD_SUB' => 107,
			'OP23_LOGICAL_AND' => -113,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99,
			'OP18_TERNARY' => -113,
			'OP11_COMPARE_LT_GT' => 101,
			'OP16_LOGICAL_OR' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -113,
			'OP08_STRING_CAT' => 109
		}
	},
	{#State 179
		ACTIONS => {
			'COLON' => 229
		}
	},
	{#State 180
		ACTIONS => {
			'OP13_BITWISE_AND' => -105,
			"]" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			".." => -105,
			"}" => -105,
			'OP21_LIST_COMMA' => -105,
			";" => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -105,
			'OP08_STRING_CAT' => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP18_TERNARY' => -105,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP23_LOGICAL_AND' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP16_LOGICAL_OR' => -105
		}
	},
	{#State 181
		ACTIONS => {
			'OP17_LIST_RANGE' => -115,
			"]" => -115,
			'OP13_BITWISE_AND' => 103,
			"}" => -115,
			'OP14_BITWISE_OR_XOR' => 105,
			".." => -115,
			'OP09_BITWISE_SHIFT' => 112,
			";" => -115,
			'OP21_LIST_COMMA' => -115,
			'OP15_LOGICAL_AND' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -115,
			'OP08_STRING_CAT' => 109,
			'OP08_MATH_ADD_SUB' => 107,
			'OP04_MATH_POW' => 98,
			'OP23_LOGICAL_AND' => -115,
			'OP06_REGEX_MATCH' => 99,
			'OP18_TERNARY' => -115,
			'OP11_COMPARE_LT_GT' => 101,
			'OP16_LOGICAL_OR' => -115,
			'OP24_LOGICAL_OR_XOR' => -115
		}
	},
	{#State 182
		ACTIONS => {
			";" => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => -106,
			"]" => -106,
			'OP17_LIST_RANGE' => -106,
			'OP13_BITWISE_AND' => -106,
			"}" => -106,
			".." => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP08_MATH_ADD_SUB' => 107,
			'OP23_LOGICAL_AND' => -106,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP18_TERNARY' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -106,
			'OP08_STRING_CAT' => -106
		}
	},
	{#State 183
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -104,
			".." => -104,
			"}" => -104,
			"]" => -104,
			'OP13_BITWISE_AND' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP21_LIST_COMMA' => -104,
			";" => -104,
			'OP09_BITWISE_SHIFT' => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP07_MATH_MULT_DIV_MOD' => -104,
			")" => -104,
			'OP08_STRING_CAT' => -104,
			'OP12_COMPARE_EQ_NEQ' => -104,
			'OP11_COMPARE_LT_GT' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP08_MATH_ADD_SUB' => -104,
			'OP18_TERNARY' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99
		}
	},
	{#State 184
		ACTIONS => {
			'OP04_MATH_POW' => 98,
			'OP23_LOGICAL_AND' => -114,
			'OP06_REGEX_MATCH' => 99,
			'OP18_TERNARY' => -114,
			'OP08_MATH_ADD_SUB' => 107,
			'OP16_LOGICAL_OR' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP11_COMPARE_LT_GT' => 101,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP08_STRING_CAT' => 109,
			")" => -114,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP15_LOGICAL_AND' => -114,
			'OP09_BITWISE_SHIFT' => 112,
			";" => -114,
			'OP21_LIST_COMMA' => -114,
			'OP13_BITWISE_AND' => 103,
			"]" => -114,
			'OP17_LIST_RANGE' => -114,
			"}" => -114,
			'OP14_BITWISE_OR_XOR' => 105,
			".." => -114
		}
	},
	{#State 185
		ACTIONS => {
			'OP17_LIST_RANGE' => -107,
			"]" => -107,
			'OP13_BITWISE_AND' => -107,
			'OP14_BITWISE_OR_XOR' => -107,
			".." => -107,
			"}" => -107,
			'OP21_LIST_COMMA' => -107,
			";" => -107,
			'OP09_BITWISE_SHIFT' => -107,
			'OP15_LOGICAL_AND' => -107,
			'OP12_COMPARE_EQ_NEQ' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -107,
			'OP08_STRING_CAT' => 109,
			'OP08_MATH_ADD_SUB' => 107,
			'OP18_TERNARY' => -107,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99,
			'OP23_LOGICAL_AND' => -107,
			'OP11_COMPARE_LT_GT' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP24_LOGICAL_OR_XOR' => -107
		}
	},
	{#State 186
		DEFAULT => -149
	},
	{#State 187
		ACTIONS => {
			";" => 230,
			'OP09_BITWISE_SHIFT' => 112,
			'OP15_LOGICAL_AND' => 111,
			'OP17_LIST_RANGE' => 104,
			'OP13_BITWISE_AND' => 103,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP08_MATH_ADD_SUB' => 107,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP23_LOGICAL_AND' => 97,
			'OP18_TERNARY' => 106,
			'OP11_COMPARE_LT_GT' => 101,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP16_LOGICAL_OR' => 108,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP08_STRING_CAT' => 109
		}
	},
	{#State 188
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 105,
			'OP17_LIST_RANGE' => 104,
			'OP13_BITWISE_AND' => 103,
			'OP15_LOGICAL_AND' => 111,
			'OP09_BITWISE_SHIFT' => 112,
			";" => 231,
			'OP08_STRING_CAT' => 109,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP16_LOGICAL_OR' => 108,
			'OP11_COMPARE_LT_GT' => 101,
			'OP23_LOGICAL_AND' => 97,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99,
			'OP18_TERNARY' => 106,
			'OP08_MATH_ADD_SUB' => 107
		}
	},
	{#State 189
		ACTIONS => {
			"(" => 232
		}
	},
	{#State 190
		ACTIONS => {
			"(" => 233
		}
	},
	{#State 191
		ACTIONS => {
			'OP15_LOGICAL_AND' => 111,
			'OP09_BITWISE_SHIFT' => 112,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => 104,
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP11_COMPARE_LT_GT' => 101,
			'OP18_TERNARY' => 106,
			'OP06_REGEX_MATCH' => 99,
			'OP23_LOGICAL_AND' => 97,
			'OP04_MATH_POW' => 98,
			'OP08_MATH_ADD_SUB' => 107,
			'OP08_STRING_CAT' => 109,
			")" => 234,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP12_COMPARE_EQ_NEQ' => 102
		}
	},
	{#State 192
		ACTIONS => {
			'VARIABLE_SYMBOL' => 235
		}
	},
	{#State 193
		ACTIONS => {
			"}" => 236
		}
	},
	{#State 194
		ACTIONS => {
			";" => 237
		}
	},
	{#State 195
		DEFAULT => -123
	},
	{#State 196
		ACTIONS => {
			")" => 238
		}
	},
	{#State 197
		DEFAULT => -133
	},
	{#State 198
		ACTIONS => {
			")" => 239
		}
	},
	{#State 199
		DEFAULT => -134
	},
	{#State 200
		ACTIONS => {
			";" => 240
		}
	},
	{#State 201
		DEFAULT => -127
	},
	{#State 202
		DEFAULT => -131
	},
	{#State 203
		ACTIONS => {
			")" => 241
		}
	},
	{#State 204
		DEFAULT => -95
	},
	{#State 205
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 242
		}
	},
	{#State 206
		DEFAULT => -206
	},
	{#State 207
		DEFAULT => -207
	},
	{#State 208
		ACTIONS => {
			";" => 245,
			'OP19_VARIABLE_ASSIGN' => 244
		}
	},
	{#State 209
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			"undef" => 71,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP03_MATH_INC_DEC' => 65,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'WORD' => 15,
			"[" => 38,
			"(" => 40,
			'LITERAL' => 60,
			"{" => 31,
			'WORD_SCOPED' => 14,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36
		},
		GOTOS => {
			'Operator' => 53,
			'ArrayReference' => 54,
			'Variable' => 88,
			'HashReference' => 68,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'ArrayDereferenced' => 49,
			'Expression' => 246
		}
	},
	{#State 210
		ACTIONS => {
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'WORD' => 247
		},
		GOTOS => {
			'Expression' => 248,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'Variable' => 88,
			'HashReference' => 68,
			'ArrayReference' => 54,
			'Operator' => 53
		}
	},
	{#State 211
		DEFAULT => -174
	},
	{#State 212
		ACTIONS => {
			'LITERAL' => 251,
			"{" => 249,
			"[" => 250
		},
		GOTOS => {
			'ConstantValue' => 252
		}
	},
	{#State 213
		ACTIONS => {
			";" => 253
		}
	},
	{#State 214
		DEFAULT => -26
	},
	{#State 215
		ACTIONS => {
			"our" => 254
		},
		GOTOS => {
			'OpsTypes' => 255
		}
	},
	{#State 216
		DEFAULT => -20
	},
	{#State 217
		DEFAULT => -22
	},
	{#State 218
		DEFAULT => -66,
		GOTOS => {
			'STAR-26' => 256
		}
	},
	{#State 219
		ACTIONS => {
			"%{" => 67,
			'WORD' => 82
		},
		GOTOS => {
			'HashEntry' => 257,
			'HashDereferenced' => 83
		}
	},
	{#State 220
		DEFAULT => -205
	},
	{#State 221
		DEFAULT => -203
	},
	{#State 222
		DEFAULT => -196
	},
	{#State 223
		ACTIONS => {
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'WORD_SCOPED' => 14,
			"{" => 31,
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 65,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43
		},
		GOTOS => {
			'Expression' => 258,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'Variable' => 88,
			'HashReference' => 68,
			'ArrayReference' => 54,
			'Operator' => 53
		}
	},
	{#State 224
		ACTIONS => {
			"(" => -49,
			"[" => -49,
			"for my integer" => -49,
			'OP01_NAMED_VOID' => -49,
			'LITERAL' => -49,
			'OP01_NAMED_VOID_PAREN' => -49,
			'OP19_LOOP_CONTROL' => -49,
			'WORD_SCOPED' => -49,
			"{" => -49,
			"while (" => -49,
			'OP05_MATH_NEG' => -49,
			"\@{" => -49,
			'OP22_LOGICAL_NOT' => -49,
			'VARIABLE_SYMBOL' => -49,
			'OP05_LOGICAL_NEG' => -49,
			"my" => -49,
			"( my" => 261,
			"undef" => -49,
			'OP03_MATH_INC_DEC' => -49,
			"if (" => -49,
			'OP10_NAMED_UNARY' => -49,
			"%{" => -49,
			'OP10_NAMED_UNARY_STRINGIFY' => -49,
			'OP01_NAMED' => -49,
			"foreach my" => -49,
			'WORD' => -49
		},
		GOTOS => {
			'OPTIONAL-18' => 259,
			'SubroutineArguments' => 260
		}
	},
	{#State 225
		ACTIONS => {
			'WORD' => 262
		}
	},
	{#State 226
		DEFAULT => -185
	},
	{#State 227
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70,
			"my" => 91,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'KEYS_OR_VALUES' => 93,
			'OP01_NAMED' => 63,
			'WORD' => 15,
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33
		},
		GOTOS => {
			'Expression' => 96,
			'ArrayDereferenced' => 49,
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'HashReference' => 68,
			'Variable' => 88,
			'ListElement' => 263,
			'ArrayReference' => 54,
			'Operator' => 53,
			'TypeInner' => 94
		}
	},
	{#State 228
		ACTIONS => {
			"/" => 264
		}
	},
	{#State 229
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70
		},
		GOTOS => {
			'Variable' => 265
		}
	},
	{#State 230
		DEFAULT => -182
	},
	{#State 231
		DEFAULT => -183
	},
	{#State 232
		ACTIONS => {
			"{" => 31,
			'WORD_SCOPED' => 14,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36,
			"[" => 38,
			"(" => 40,
			")" => -137,
			'LITERAL' => 60,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'KEYS_OR_VALUES' => 93,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'WORD' => 15,
			"my" => 91,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			"undef" => 71
		},
		GOTOS => {
			'Variable' => 88,
			'HashReference' => 68,
			'ArrayReference' => 54,
			'Operator' => 53,
			'ListElement' => 92,
			'TypeInner' => 94,
			'ListElements' => 267,
			'OPTIONAL-45' => 266,
			'Expression' => 96,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'WordScoped' => 59
		}
	},
	{#State 233
		ACTIONS => {
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			'WORD' => 15,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'WORD_SCOPED' => 14,
			"{" => 31
		},
		GOTOS => {
			'Operator' => 53,
			'ArrayReference' => 54,
			'HashReference' => 68,
			'Variable' => 88,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'ArrayDereferenced' => 49,
			'Expression' => 268
		}
	},
	{#State 234
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 269
		}
	},
	{#State 235
		ACTIONS => {
			"(" => 270
		}
	},
	{#State 236
		DEFAULT => -210
	},
	{#State 237
		DEFAULT => -129
	},
	{#State 238
		ACTIONS => {
			";" => 271
		}
	},
	{#State 239
		DEFAULT => -147
	},
	{#State 240
		DEFAULT => -132
	},
	{#State 241
		DEFAULT => -97
	},
	{#State 242
		DEFAULT => -160,
		GOTOS => {
			'STAR-49' => 272
		}
	},
	{#State 243
		ACTIONS => {
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"my" => 69,
			"foreach my" => -152,
			'WORD' => 45,
			"if (" => 64,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED_VOID' => 61,
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			"for my integer" => -152,
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP19_LOOP_CONTROL' => 56,
			'OP01_NAMED_VOID_PAREN' => 55,
			'WORD_SCOPED' => 14,
			"while (" => -152,
			"{" => 31
		},
		GOTOS => {
			'VariableDeclaration' => 34,
			'Statement' => 37,
			'Operator' => 53,
			'Conditional' => 52,
			'ArrayReference' => 54,
			'VariableModification' => 41,
			'PLUS-52' => 273,
			'LoopLabel' => 62,
			'Expression' => 39,
			'WordScoped' => 59,
			'OperatorVoid' => 46,
			'Variable' => 47,
			'HashReference' => 68,
			'PAREN-46' => 42,
			'Operation' => 274,
			'OPTIONAL-47' => 51,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50
		}
	},
	{#State 244
		ACTIONS => {
			"{" => 31,
			'WORD_SCOPED' => 14,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36,
			"[" => 38,
			"(" => 40,
			'LITERAL' => 60,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'WORD' => 15,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			"undef" => 71
		},
		GOTOS => {
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'ArrayDereferenced' => 49,
			'Expression' => 275,
			'HashReference' => 68,
			'Variable' => 88,
			'Operator' => 53,
			'ArrayReference' => 54
		}
	},
	{#State 245
		DEFAULT => -180
	},
	{#State 246
		ACTIONS => {
			'OP15_LOGICAL_AND' => 111,
			'OP09_BITWISE_SHIFT' => 112,
			'OP17_LIST_RANGE' => 104,
			"]" => 276,
			'OP13_BITWISE_AND' => 103,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP23_LOGICAL_AND' => 97,
			'OP18_TERNARY' => 106,
			'OP08_MATH_ADD_SUB' => 107,
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP11_COMPARE_LT_GT' => 101,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP08_STRING_CAT' => 109,
			'OP07_MATH_MULT_DIV_MOD' => 110
		}
	},
	{#State 247
		ACTIONS => {
			"(" => -208,
			"}" => 277
		}
	},
	{#State 248
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP08_STRING_CAT' => 109,
			'OP08_MATH_ADD_SUB' => 107,
			'OP23_LOGICAL_AND' => 97,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP18_TERNARY' => 106,
			'OP11_COMPARE_LT_GT' => 101,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP16_LOGICAL_OR' => 108,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => 104,
			"}" => 278,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP09_BITWISE_SHIFT' => 112,
			'OP15_LOGICAL_AND' => 111
		}
	},
	{#State 249
		ACTIONS => {
			'WORD' => 279
		}
	},
	{#State 250
		ACTIONS => {
			"my" => 91,
			'LITERAL' => -32
		},
		GOTOS => {
			'TypeInner' => 281,
			'OPTIONAL-10' => 280
		}
	},
	{#State 251
		DEFAULT => -45
	},
	{#State 252
		ACTIONS => {
			";" => 282
		}
	},
	{#State 253
		DEFAULT => -29
	},
	{#State 254
		ACTIONS => {
			'WORD' => 85
		},
		GOTOS => {
			'Type' => 283
		}
	},
	{#State 255
		DEFAULT => -23
	},
	{#State 256
		ACTIONS => {
			"our %properties = (" => -68,
			"use" => 20,
			"use constant" => -68
		},
		GOTOS => {
			'Include' => 284,
			'STAR-27' => 285
		}
	},
	{#State 257
		DEFAULT => -202
	},
	{#State 258
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP08_STRING_CAT' => 109,
			'OP08_MATH_ADD_SUB' => 107,
			'OP18_TERNARY' => 106,
			'OP04_MATH_POW' => 98,
			'OP23_LOGICAL_AND' => 97,
			'OP06_REGEX_MATCH' => 99,
			'OP11_COMPARE_LT_GT' => 101,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP16_LOGICAL_OR' => 108,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => 104,
			'OP14_BITWISE_OR_XOR' => 105,
			"}" => -198,
			'OP21_LIST_COMMA' => -198,
			'OP09_BITWISE_SHIFT' => 112,
			'OP15_LOGICAL_AND' => 111
		}
	},
	{#State 259
		ACTIONS => {
			"foreach my" => -152,
			'WORD' => 45,
			'OP03_MATH_INC_DEC' => 65,
			"if (" => 64,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"my" => 69,
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP19_LOOP_CONTROL' => 56,
			'OP01_NAMED_VOID_PAREN' => 55,
			'WORD_SCOPED' => 14,
			"while (" => -152,
			"{" => 31,
			'OP01_NAMED_VOID' => 61,
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			"for my integer" => -152
		},
		GOTOS => {
			'OperatorVoid' => 46,
			'Variable' => 47,
			'PLUS-19' => 286,
			'HashReference' => 68,
			'PAREN-46' => 42,
			'Operation' => 287,
			'OPTIONAL-47' => 51,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'VariableDeclaration' => 34,
			'Statement' => 37,
			'Conditional' => 52,
			'Operator' => 53,
			'ArrayReference' => 54,
			'VariableModification' => 41,
			'LoopLabel' => 62,
			'Expression' => 39,
			'WordScoped' => 59
		}
	},
	{#State 260
		DEFAULT => -48
	},
	{#State 261
		ACTIONS => {
			'WORD' => 85
		},
		GOTOS => {
			'Type' => 288
		}
	},
	{#State 262
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 289
		}
	},
	{#State 263
		DEFAULT => -184
	},
	{#State 264
		DEFAULT => -103
	},
	{#State 265
		DEFAULT => -117
	},
	{#State 266
		ACTIONS => {
			")" => 290
		}
	},
	{#State 267
		DEFAULT => -136
	},
	{#State 268
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 112,
			'OP15_LOGICAL_AND' => 111,
			".." => 291,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => 104,
			'OP11_COMPARE_LT_GT' => 101,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP16_LOGICAL_OR' => 108,
			'OP08_MATH_ADD_SUB' => 107,
			'OP18_TERNARY' => 106,
			'OP23_LOGICAL_AND' => 97,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP08_STRING_CAT' => 109,
			'OP12_COMPARE_EQ_NEQ' => 102
		}
	},
	{#State 269
		DEFAULT => -170
	},
	{#State 270
		ACTIONS => {
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'WORD_SCOPED' => 14,
			"{" => 31,
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			'WORD' => 15,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'KEYS_OR_VALUES' => 93,
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			"my" => 91,
			'OP05_LOGICAL_NEG' => 48
		},
		GOTOS => {
			'ArrayDereferenced' => 49,
			'Expression' => 96,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'ListElements' => 292,
			'ListElement' => 92,
			'ArrayReference' => 54,
			'Operator' => 53,
			'TypeInner' => 94,
			'HashReference' => 68,
			'Variable' => 88
		}
	},
	{#State 271
		DEFAULT => -130
	},
	{#State 272
		ACTIONS => {
			"[" => -163,
			"for my integer" => -163,
			"(" => -163,
			'' => -163,
			'LITERAL' => -163,
			'OP01_NAMED_VOID' => -163,
			"while (" => -163,
			"{" => -163,
			'OP19_LOOP_CONTROL' => -163,
			'OP01_NAMED_VOID_PAREN' => -163,
			'WORD_SCOPED' => -163,
			'OP22_LOGICAL_NOT' => -163,
			"\@{" => -163,
			'OP05_MATH_NEG' => -163,
			'OP05_LOGICAL_NEG' => -163,
			"elsif (" => 295,
			"my" => -163,
			'VARIABLE_SYMBOL' => -163,
			"undef" => -163,
			"}" => -163,
			"else" => 294,
			'OP10_NAMED_UNARY_STRINGIFY' => -163,
			'OP01_NAMED' => -163,
			'OP03_MATH_INC_DEC' => -163,
			"if (" => -163,
			"%{" => -163,
			'OP10_NAMED_UNARY' => -163,
			"foreach my" => -163,
			'WORD' => -163
		},
		GOTOS => {
			'OPTIONAL-51' => 293,
			'PAREN-48' => 297,
			'PAREN-50' => 296
		}
	},
	{#State 273
		ACTIONS => {
			"undef" => 71,
			"}" => 299,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"my" => 69,
			"foreach my" => -152,
			'WORD' => 45,
			'OP03_MATH_INC_DEC' => 65,
			"if (" => 64,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'OP01_NAMED_VOID' => 61,
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			"for my integer" => -152,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'OP19_LOOP_CONTROL' => 56,
			'OP01_NAMED_VOID_PAREN' => 55,
			'WORD_SCOPED' => 14,
			"while (" => -152,
			"{" => 31
		},
		GOTOS => {
			'HashDereferenced' => 50,
			'ArrayDereferenced' => 49,
			'OPTIONAL-47' => 51,
			'Operation' => 298,
			'PAREN-46' => 42,
			'Variable' => 47,
			'HashReference' => 68,
			'OperatorVoid' => 46,
			'WordScoped' => 59,
			'Expression' => 39,
			'VariableModification' => 41,
			'LoopLabel' => 62,
			'Operator' => 53,
			'ArrayReference' => 54,
			'Conditional' => 52,
			'Statement' => 37,
			'VariableDeclaration' => 34
		}
	},
	{#State 274
		DEFAULT => -172
	},
	{#State 275
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP08_STRING_CAT' => 109,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP11_COMPARE_LT_GT' => 101,
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP08_MATH_ADD_SUB' => 107,
			'OP18_TERNARY' => 106,
			'OP23_LOGICAL_AND' => 97,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => 104,
			";" => 300,
			'OP09_BITWISE_SHIFT' => 112,
			'OP15_LOGICAL_AND' => 111
		}
	},
	{#State 276
		DEFAULT => -177
	},
	{#State 277
		DEFAULT => -179
	},
	{#State 278
		DEFAULT => -178
	},
	{#State 279
		ACTIONS => {
			'OP20_HASH_FATARROW' => 301
		}
	},
	{#State 280
		ACTIONS => {
			'LITERAL' => 302
		}
	},
	{#State 281
		DEFAULT => -31
	},
	{#State 282
		DEFAULT => -30
	},
	{#State 283
		ACTIONS => {
			'OPS_TYPES_ID' => 303
		}
	},
	{#State 284
		DEFAULT => -65
	},
	{#State 285
		ACTIONS => {
			"use constant" => 25,
			"our %properties = (" => 306
		},
		GOTOS => {
			'Properties' => 304,
			'Constant' => 305
		}
	},
	{#State 286
		ACTIONS => {
			"[" => 38,
			"for my integer" => -152,
			"(" => 40,
			'LITERAL' => 60,
			'OP01_NAMED_VOID' => 61,
			"{" => 31,
			"while (" => -152,
			'OP19_LOOP_CONTROL' => 56,
			'OP01_NAMED_VOID_PAREN' => 55,
			'WORD_SCOPED' => 14,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36,
			'OP05_LOGICAL_NEG' => 48,
			"my" => 69,
			'VARIABLE_SYMBOL' => 70,
			"undef" => 71,
			"}" => 308,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"if (" => 64,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			"foreach my" => -152,
			'WORD' => 45
		},
		GOTOS => {
			'PAREN-46' => 42,
			'Operation' => 307,
			'OperatorVoid' => 46,
			'HashReference' => 68,
			'Variable' => 47,
			'ArrayDereferenced' => 49,
			'HashDereferenced' => 50,
			'OPTIONAL-47' => 51,
			'Operator' => 53,
			'Conditional' => 52,
			'ArrayReference' => 54,
			'VariableDeclaration' => 34,
			'Statement' => 37,
			'Expression' => 39,
			'WordScoped' => 59,
			'LoopLabel' => 62,
			'VariableModification' => 41
		}
	},
	{#State 287
		DEFAULT => -51
	},
	{#State 288
		ACTIONS => {
			'VARIABLE_SYMBOL' => 309
		}
	},
	{#State 289
		DEFAULT => -211
	},
	{#State 290
		DEFAULT => -148
	},
	{#State 291
		ACTIONS => {
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'WORD_SCOPED' => 14,
			"{" => 31,
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			'WORD' => 15,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43
		},
		GOTOS => {
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'Expression' => 310,
			'ArrayDereferenced' => 49,
			'HashReference' => 68,
			'Variable' => 88,
			'ArrayReference' => 54,
			'Operator' => 53
		}
	},
	{#State 292
		ACTIONS => {
			")" => 311
		}
	},
	{#State 293
		DEFAULT => -164
	},
	{#State 294
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 312
		}
	},
	{#State 295
		ACTIONS => {
			"undef" => 71,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			'WORD' => 15,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			'LITERAL' => 60,
			"[" => 38,
			"(" => 40,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'OP05_MATH_NEG' => 36,
			"{" => 31,
			'WORD_SCOPED' => 14
		},
		GOTOS => {
			'Variable' => 88,
			'HashReference' => 68,
			'Operator' => 53,
			'ArrayReference' => 54,
			'ArrayDereferenced' => 49,
			'Expression' => 313,
			'HashDereferenced' => 50,
			'WordScoped' => 59
		}
	},
	{#State 296
		DEFAULT => -162
	},
	{#State 297
		DEFAULT => -159
	},
	{#State 298
		DEFAULT => -171
	},
	{#State 299
		DEFAULT => -173
	},
	{#State 300
		DEFAULT => -181
	},
	{#State 301
		ACTIONS => {
			'LITERAL' => -39,
			"my" => 91
		},
		GOTOS => {
			'OPTIONAL-14' => 314,
			'TypeInner' => 315
		}
	},
	{#State 302
		DEFAULT => -37,
		GOTOS => {
			'STAR-13' => 316
		}
	},
	{#State 303
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 317
		}
	},
	{#State 304
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 318
		}
	},
	{#State 305
		DEFAULT => -67
	},
	{#State 306
		ACTIONS => {
			"%{" => 67,
			")" => 321,
			'WORD' => 320
		},
		GOTOS => {
			'HashEntryTyped' => 322,
			'HashDereferenced' => 319
		}
	},
	{#State 307
		DEFAULT => -50
	},
	{#State 308
		ACTIONS => {
			";" => 323
		}
	},
	{#State 309
		DEFAULT => -55,
		GOTOS => {
			'STAR-21' => 324
		}
	},
	{#State 310
		ACTIONS => {
			'OP15_LOGICAL_AND' => 111,
			'OP09_BITWISE_SHIFT' => 112,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => 104,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP18_TERNARY' => 106,
			'OP23_LOGICAL_AND' => 97,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP08_MATH_ADD_SUB' => 107,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP16_LOGICAL_OR' => 108,
			'OP11_COMPARE_LT_GT' => 101,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP08_STRING_CAT' => 109,
			")" => 325,
			'OP07_MATH_MULT_DIV_MOD' => 110
		}
	},
	{#State 311
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 326
		}
	},
	{#State 312
		DEFAULT => -161
	},
	{#State 313
		ACTIONS => {
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP11_COMPARE_LT_GT' => 101,
			'OP23_LOGICAL_AND' => 97,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99,
			'OP18_TERNARY' => 106,
			'OP08_MATH_ADD_SUB' => 107,
			'OP08_STRING_CAT' => 109,
			")" => 327,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP15_LOGICAL_AND' => 111,
			'OP09_BITWISE_SHIFT' => 112,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP17_LIST_RANGE' => 104,
			'OP13_BITWISE_AND' => 103
		}
	},
	{#State 314
		ACTIONS => {
			'LITERAL' => 328
		}
	},
	{#State 315
		DEFAULT => -38
	},
	{#State 316
		ACTIONS => {
			'OP21_LIST_COMMA' => 330,
			"]" => 331
		},
		GOTOS => {
			'PAREN-12' => 329
		}
	},
	{#State 317
		ACTIONS => {
			'LITERAL' => 332
		}
	},
	{#State 318
		ACTIONS => {
			"1;1;" => 334,
			"our" => 333
		},
		GOTOS => {
			'Method' => 335
		}
	},
	{#State 319
		DEFAULT => -201
	},
	{#State 320
		ACTIONS => {
			'OP20_HASH_FATARROW' => 336
		}
	},
	{#State 321
		ACTIONS => {
			";" => 337
		}
	},
	{#State 322
		DEFAULT => -79,
		GOTOS => {
			'STAR-33' => 338
		}
	},
	{#State 323
		DEFAULT => -52
	},
	{#State 324
		ACTIONS => {
			")" => 341,
			'OP21_LIST_COMMA' => 340
		},
		GOTOS => {
			'PAREN-20' => 339
		}
	},
	{#State 325
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 342
		}
	},
	{#State 326
		DEFAULT => -169
	},
	{#State 327
		ACTIONS => {
			"{" => 243
		},
		GOTOS => {
			'CodeBlock' => 343
		}
	},
	{#State 328
		DEFAULT => -44,
		GOTOS => {
			'STAR-17' => 344
		}
	},
	{#State 329
		DEFAULT => -36
	},
	{#State 330
		ACTIONS => {
			'LITERAL' => -34,
			"my" => 91
		},
		GOTOS => {
			'OPTIONAL-11' => 346,
			'TypeInner' => 345
		}
	},
	{#State 331
		DEFAULT => -46
	},
	{#State 332
		ACTIONS => {
			";" => 347
		}
	},
	{#State 333
		ACTIONS => {
			'WORD' => 85
		},
		GOTOS => {
			'Type' => 348
		}
	},
	{#State 334
		ACTIONS => {
			"package" => -75,
			"our" => 32,
			'' => -75
		},
		GOTOS => {
			'PAREN-30' => 349,
			'Subroutine' => 352,
			'PLUS-29' => 351,
			'OPTIONAL-31' => 350
		}
	},
	{#State 335
		DEFAULT => -69
	},
	{#State 336
		ACTIONS => {
			"my" => 91
		},
		GOTOS => {
			'TypeInner' => 353
		}
	},
	{#State 337
		DEFAULT => -81
	},
	{#State 338
		ACTIONS => {
			")" => 354,
			'OP21_LIST_COMMA' => 355
		},
		GOTOS => {
			'PAREN-32' => 356
		}
	},
	{#State 339
		DEFAULT => -54
	},
	{#State 340
		ACTIONS => {
			"my" => 357
		}
	},
	{#State 341
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 358
		}
	},
	{#State 342
		DEFAULT => -168
	},
	{#State 343
		DEFAULT => -158
	},
	{#State 344
		ACTIONS => {
			'OP21_LIST_COMMA' => 359,
			"}" => 361
		},
		GOTOS => {
			'PAREN-16' => 360
		}
	},
	{#State 345
		DEFAULT => -33
	},
	{#State 346
		ACTIONS => {
			'LITERAL' => 362
		}
	},
	{#State 347
		ACTIONS => {
			"our" => 363
		}
	},
	{#State 348
		ACTIONS => {
			'VARIABLE_SYMBOL' => 364
		}
	},
	{#State 349
		DEFAULT => -74
	},
	{#State 350
		DEFAULT => -76
	},
	{#State 351
		ACTIONS => {
			"1;1;" => 365,
			"our" => 32
		},
		GOTOS => {
			'Subroutine' => 366
		}
	},
	{#State 352
		DEFAULT => -72
	},
	{#State 353
		ACTIONS => {
			'LITERAL' => 60,
			"(" => 40,
			"[" => 38,
			'OP05_MATH_NEG' => 36,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'WORD_SCOPED' => 14,
			"{" => 31,
			"undef" => 71,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			'WORD' => 15,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43
		},
		GOTOS => {
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'Expression' => 367,
			'ArrayDereferenced' => 49,
			'ArrayReference' => 54,
			'Operator' => 53,
			'Variable' => 88,
			'HashReference' => 68
		}
	},
	{#State 354
		ACTIONS => {
			";" => 368
		}
	},
	{#State 355
		ACTIONS => {
			"%{" => 67,
			'WORD' => 320
		},
		GOTOS => {
			'HashEntryTyped' => 369,
			'HashDereferenced' => 319
		}
	},
	{#State 356
		DEFAULT => -78
	},
	{#State 357
		ACTIONS => {
			'WORD' => 85
		},
		GOTOS => {
			'Type' => 370
		}
	},
	{#State 358
		ACTIONS => {
			"\@_;" => 371
		}
	},
	{#State 359
		ACTIONS => {
			'WORD' => 372
		}
	},
	{#State 360
		DEFAULT => -43
	},
	{#State 361
		DEFAULT => -47
	},
	{#State 362
		DEFAULT => -35
	},
	{#State 363
		ACTIONS => {
			'WORD' => 85
		},
		GOTOS => {
			'Type' => 373
		}
	},
	{#State 364
		ACTIONS => {
			"= sub {" => 374
		}
	},
	{#State 365
		DEFAULT => -73
	},
	{#State 366
		DEFAULT => -71
	},
	{#State 367
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -200,
			'OP08_STRING_CAT' => 109,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP11_COMPARE_LT_GT' => 101,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP16_LOGICAL_OR' => 108,
			'OP08_MATH_ADD_SUB' => 107,
			'OP23_LOGICAL_AND' => 97,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99,
			'OP18_TERNARY' => 106,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP17_LIST_RANGE' => 104,
			'OP13_BITWISE_AND' => 103,
			'OP09_BITWISE_SHIFT' => 112,
			'OP21_LIST_COMMA' => -200,
			'OP15_LOGICAL_AND' => 111
		}
	},
	{#State 368
		DEFAULT => -80
	},
	{#State 369
		DEFAULT => -77
	},
	{#State 370
		ACTIONS => {
			'VARIABLE_SYMBOL' => 375
		}
	},
	{#State 371
		DEFAULT => -57,
		GOTOS => {
			'STAR-22' => 376
		}
	},
	{#State 372
		ACTIONS => {
			'OP20_HASH_FATARROW' => 377
		}
	},
	{#State 373
		ACTIONS => {
			'OPS_SUB' => 378
		}
	},
	{#State 374
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -83,
			"my" => -83,
			'VARIABLE_SYMBOL' => -83,
			"undef" => -83,
			"( my" => 379,
			'OP10_NAMED_UNARY_STRINGIFY' => -83,
			'OP01_NAMED' => -83,
			'OP03_MATH_INC_DEC' => -83,
			"if (" => -83,
			"%{" => -83,
			'OP10_NAMED_UNARY' => -83,
			"foreach my" => -83,
			'WORD' => -83,
			"[" => -83,
			"for my integer" => -83,
			"(" => -83,
			'LITERAL' => -83,
			'OP01_NAMED_VOID' => -83,
			"while (" => -83,
			"{" => -83,
			'OP01_NAMED_VOID_PAREN' => -83,
			'OP19_LOOP_CONTROL' => -83,
			'WORD_SCOPED' => -83,
			'OP22_LOGICAL_NOT' => -83,
			"\@{" => -83,
			'OP05_MATH_NEG' => -83
		},
		GOTOS => {
			'MethodArguments' => 381,
			'OPTIONAL-34' => 380
		}
	},
	{#State 375
		DEFAULT => -53
	},
	{#State 376
		ACTIONS => {
			"\@{" => -58,
			'OP22_LOGICAL_NOT' => -58,
			'OP05_MATH_NEG' => -58,
			'CHECK_OR_CHECKTRACE' => 383,
			"{" => -58,
			"while (" => -58,
			'OP01_NAMED_VOID_PAREN' => -58,
			'OP19_LOOP_CONTROL' => -58,
			'WORD_SCOPED' => -58,
			'LITERAL' => -58,
			'OP01_NAMED_VOID' => -58,
			"[" => -58,
			"for my integer" => -58,
			"(" => -58,
			"foreach my" => -58,
			'WORD' => -58,
			'OP01_NAMED' => -58,
			'OP10_NAMED_UNARY_STRINGIFY' => -58,
			'OP03_MATH_INC_DEC' => -58,
			"if (" => -58,
			"%{" => -58,
			'OP10_NAMED_UNARY' => -58,
			"undef" => -58,
			'OP05_LOGICAL_NEG' => -58,
			"my" => -58,
			'VARIABLE_SYMBOL' => -58
		},
		GOTOS => {
			'ArgumentCheck' => 382
		}
	},
	{#State 377
		ACTIONS => {
			'LITERAL' => -41,
			"my" => 91
		},
		GOTOS => {
			'TypeInner' => 385,
			'OPTIONAL-15' => 384
		}
	},
	{#State 378
		ACTIONS => {
			"= sub {" => 387
		},
		GOTOS => {
			'OpsTypesSub' => 386
		}
	},
	{#State 379
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 388
		}
	},
	{#State 380
		ACTIONS => {
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 65,
			"if (" => 64,
			'WORD' => 45,
			"foreach my" => -152,
			"my" => 69,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			"undef" => 71,
			"{" => 31,
			"while (" => -152,
			'WORD_SCOPED' => 14,
			'OP01_NAMED_VOID_PAREN' => 55,
			'OP19_LOOP_CONTROL' => 56,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'OP05_MATH_NEG' => 36,
			"for my integer" => -152,
			"[" => 38,
			"(" => 40,
			'LITERAL' => 60,
			'OP01_NAMED_VOID' => 61
		},
		GOTOS => {
			'Variable' => 47,
			'HashReference' => 68,
			'OperatorVoid' => 46,
			'Operation' => 390,
			'PAREN-46' => 42,
			'OPTIONAL-47' => 51,
			'HashDereferenced' => 50,
			'ArrayDereferenced' => 49,
			'Statement' => 37,
			'VariableDeclaration' => 34,
			'PLUS-35' => 389,
			'Operator' => 53,
			'Conditional' => 52,
			'ArrayReference' => 54,
			'VariableModification' => 41,
			'LoopLabel' => 62,
			'WordScoped' => 59,
			'Expression' => 39
		}
	},
	{#State 381
		DEFAULT => -82
	},
	{#State 382
		DEFAULT => -56
	},
	{#State 383
		ACTIONS => {
			"(" => 391
		}
	},
	{#State 384
		ACTIONS => {
			'LITERAL' => 392
		}
	},
	{#State 385
		DEFAULT => -40
	},
	{#State 386
		ACTIONS => {
			"our" => 393
		}
	},
	{#State 387
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => 394
		}
	},
	{#State 388
		DEFAULT => -89,
		GOTOS => {
			'STAR-37' => 395
		}
	},
	{#State 389
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 65,
			"if (" => 64,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			"foreach my" => -152,
			'WORD' => 45,
			'OP05_LOGICAL_NEG' => 48,
			"my" => 69,
			'VARIABLE_SYMBOL' => 70,
			"undef" => 71,
			"}" => 396,
			"{" => 31,
			"while (" => -152,
			'OP01_NAMED_VOID_PAREN' => 55,
			'OP19_LOOP_CONTROL' => 56,
			'WORD_SCOPED' => 14,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			'OP05_MATH_NEG' => 36,
			"[" => 38,
			"for my integer" => -152,
			"(" => 40,
			'LITERAL' => 60,
			'OP01_NAMED_VOID' => 61
		},
		GOTOS => {
			'Variable' => 47,
			'HashReference' => 68,
			'OperatorVoid' => 46,
			'Operation' => 397,
			'PAREN-46' => 42,
			'OPTIONAL-47' => 51,
			'HashDereferenced' => 50,
			'ArrayDereferenced' => 49,
			'Statement' => 37,
			'VariableDeclaration' => 34,
			'ArrayReference' => 54,
			'Operator' => 53,
			'Conditional' => 52,
			'VariableModification' => 41,
			'LoopLabel' => 62,
			'WordScoped' => 59,
			'Expression' => 39
		}
	},
	{#State 390
		DEFAULT => -85
	},
	{#State 391
		ACTIONS => {
			'WORD_SCOPED' => 14,
			"{" => 31,
			'OP05_MATH_NEG' => 36,
			"\@{" => 33,
			'OP22_LOGICAL_NOT' => 58,
			"(" => 40,
			"[" => 38,
			'LITERAL' => 60,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'WORD' => 15,
			'VARIABLE_SYMBOL' => 70,
			'OP05_LOGICAL_NEG' => 48,
			"undef" => 71
		},
		GOTOS => {
			'ArrayReference' => 54,
			'Operator' => 53,
			'HashReference' => 68,
			'Variable' => 88,
			'HashDereferenced' => 50,
			'WordScoped' => 59,
			'Expression' => 398,
			'ArrayDereferenced' => 49
		}
	},
	{#State 392
		DEFAULT => -42
	},
	{#State 393
		ACTIONS => {
			'WORD' => 85
		},
		GOTOS => {
			'Type' => 399
		}
	},
	{#State 394
		ACTIONS => {
			'LITERAL' => 400
		}
	},
	{#State 395
		ACTIONS => {
			")" => 402,
			'OP21_LIST_COMMA' => 403
		},
		GOTOS => {
			'PAREN-36' => 401
		}
	},
	{#State 396
		ACTIONS => {
			";" => 404
		}
	},
	{#State 397
		DEFAULT => -84
	},
	{#State 398
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 107,
			'OP06_REGEX_MATCH' => 99,
			'OP04_MATH_POW' => 98,
			'OP23_LOGICAL_AND' => 97,
			'OP18_TERNARY' => 106,
			'OP11_COMPARE_LT_GT' => 101,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP16_LOGICAL_OR' => 108,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -61,
			'OP08_STRING_CAT' => 109,
			'OP09_BITWISE_SHIFT' => 112,
			'OP21_LIST_COMMA' => 406,
			'OP15_LOGICAL_AND' => 111,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => 104,
			'OP14_BITWISE_OR_XOR' => 105
		},
		GOTOS => {
			'PAREN-23' => 407,
			'OPTIONAL-24' => 405
		}
	},
	{#State 399
		ACTIONS => {
			'TYPES_SUB' => 408
		}
	},
	{#State 400
		ACTIONS => {
			")" => 409
		}
	},
	{#State 401
		DEFAULT => -88
	},
	{#State 402
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 410
		}
	},
	{#State 403
		ACTIONS => {
			"my" => 411
		}
	},
	{#State 404
		DEFAULT => -86
	},
	{#State 405
		ACTIONS => {
			")" => 412
		}
	},
	{#State 406
		ACTIONS => {
			"{" => 31,
			'WORD_SCOPED' => 14,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'OP05_MATH_NEG' => 36,
			"[" => 38,
			"(" => 40,
			'LITERAL' => 60,
			'OP01_NAMED' => 63,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'OP03_MATH_INC_DEC' => 65,
			'WORD' => 15,
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			"undef" => 71
		},
		GOTOS => {
			'HashReference' => 68,
			'Variable' => 88,
			'Operator' => 53,
			'ArrayReference' => 54,
			'ArrayDereferenced' => 49,
			'Expression' => 413,
			'WordScoped' => 59,
			'HashDereferenced' => 50
		}
	},
	{#State 407
		DEFAULT => -60
	},
	{#State 408
		ACTIONS => {
			"= sub {" => 387
		},
		GOTOS => {
			'OpsTypesSub' => 414
		}
	},
	{#State 409
		ACTIONS => {
			";" => 415
		}
	},
	{#State 410
		ACTIONS => {
			"\@_;" => 416
		}
	},
	{#State 411
		ACTIONS => {
			'WORD' => 85
		},
		GOTOS => {
			'Type' => 417
		}
	},
	{#State 412
		ACTIONS => {
			";" => 418
		}
	},
	{#State 413
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 105,
			'OP17_LIST_RANGE' => 104,
			'OP13_BITWISE_AND' => 103,
			'OP15_LOGICAL_AND' => 111,
			'OP21_LIST_COMMA' => 419,
			'OP09_BITWISE_SHIFT' => 112,
			'OP08_STRING_CAT' => 109,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP16_LOGICAL_OR' => 108,
			'OP11_COMPARE_LT_GT' => 101,
			'OP18_TERNARY' => 106,
			'OP04_MATH_POW' => 98,
			'OP06_REGEX_MATCH' => 99,
			'OP23_LOGICAL_AND' => 97,
			'OP08_MATH_ADD_SUB' => 107
		}
	},
	{#State 414
		DEFAULT => -24
	},
	{#State 415
		ACTIONS => {
			"}" => 420
		}
	},
	{#State 416
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 421
		}
	},
	{#State 417
		ACTIONS => {
			'VARIABLE_SYMBOL' => 422
		}
	},
	{#State 418
		DEFAULT => -62
	},
	{#State 419
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 48,
			'VARIABLE_SYMBOL' => 70,
			"undef" => 71,
			'OP10_NAMED_UNARY_STRINGIFY' => 43,
			'OP01_NAMED' => 63,
			'OP03_MATH_INC_DEC' => 65,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 67,
			'WORD' => 15,
			"[" => 38,
			"(" => 40,
			'LITERAL' => 60,
			"{" => 31,
			'WORD_SCOPED' => 14,
			'OP22_LOGICAL_NOT' => 58,
			"\@{" => 33,
			'OP05_MATH_NEG' => 36
		},
		GOTOS => {
			'WordScoped' => 59,
			'HashDereferenced' => 50,
			'Expression' => 423,
			'ArrayDereferenced' => 49,
			'Variable' => 88,
			'HashReference' => 68,
			'ArrayReference' => 54,
			'Operator' => 53
		}
	},
	{#State 420
		ACTIONS => {
			";" => 424
		}
	},
	{#State 421
		ACTIONS => {
			"{" => -92,
			"while (" => -92,
			'OP19_LOOP_CONTROL' => -92,
			'OP01_NAMED_VOID_PAREN' => -92,
			'WORD_SCOPED' => -92,
			"\@{" => -92,
			'OP22_LOGICAL_NOT' => -92,
			'OP05_MATH_NEG' => -92,
			'CHECK_OR_CHECKTRACE' => 383,
			"[" => -92,
			"for my integer" => -92,
			"(" => -92,
			'LITERAL' => -92,
			'OP01_NAMED_VOID' => -92,
			'OP01_NAMED' => -92,
			'OP10_NAMED_UNARY_STRINGIFY' => -92,
			'OP03_MATH_INC_DEC' => -92,
			"if (" => -92,
			"%{" => -92,
			'OP10_NAMED_UNARY' => -92,
			"foreach my" => -92,
			'WORD' => -92,
			'OP05_LOGICAL_NEG' => -92,
			"my" => -92,
			'VARIABLE_SYMBOL' => -92,
			"undef" => -92
		},
		GOTOS => {
			'ArgumentCheck' => 425
		}
	},
	{#State 422
		DEFAULT => -87
	},
	{#State 423
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 110,
			")" => -59,
			'OP08_STRING_CAT' => 109,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP11_COMPARE_LT_GT' => 101,
			'OP16_LOGICAL_OR' => 108,
			'OP24_LOGICAL_OR_XOR' => 100,
			'OP08_MATH_ADD_SUB' => 107,
			'OP18_TERNARY' => 106,
			'OP06_REGEX_MATCH' => 99,
			'OP23_LOGICAL_AND' => 97,
			'OP04_MATH_POW' => 98,
			'OP14_BITWISE_OR_XOR' => 105,
			'OP13_BITWISE_AND' => 103,
			'OP17_LIST_RANGE' => 104,
			'OP09_BITWISE_SHIFT' => 112,
			'OP15_LOGICAL_AND' => 111
		}
	},
	{#State 424
		DEFAULT => -25
	},
	{#State 425
		DEFAULT => -90
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5421 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5428 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 110 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5435 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5446 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5457 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5464 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5471 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5478 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5485 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5492 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5499 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-5', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5506 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-5', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5513 lib/RPerl/Grammar.pm
	],
	[#Rule Program_13
		 'Program', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5524 lib/RPerl/Grammar.pm
	],
	[#Rule Module_14
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5535 lib/RPerl/Grammar.pm
	],
	[#Rule Module_15
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5546 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5553 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5560 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5567 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5574 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5581 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5588 lib/RPerl/Grammar.pm
	],
	[#Rule Package_22
		 'Package', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5599 lib/RPerl/Grammar.pm
	],
	[#Rule Header_23
		 'Header', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5610 lib/RPerl/Grammar.pm
	],
	[#Rule OpsTypes_24
		 'OpsTypes', 14,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5621 lib/RPerl/Grammar.pm
	],
	[#Rule OpsTypesSub_25
		 'OpsTypesSub', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5632 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-9', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5639 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-9', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5646 lib/RPerl/Grammar.pm
	],
	[#Rule Include_28
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5657 lib/RPerl/Grammar.pm
	],
	[#Rule Include_29
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5668 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_30
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5679 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5686 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5693 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-11', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5700 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-11', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5707 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-12', 3,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5714 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5721 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5728 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5735 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5742 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5749 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5756 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-16', 5,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5763 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5770 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5777 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_45
		 'ConstantValue', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5788 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_46
		 'ConstantValue', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5799 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_47
		 'ConstantValue', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5810 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5817 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5824 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-19', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5831 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-19', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5838 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_52
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5849 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 4,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5856 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5863 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5877 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5884 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_58
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5895 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5902 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5909 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_62
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5927 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-25', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5934 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-25', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5941 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5948 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5955 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5962 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5976 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5983 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-29', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5990 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-29', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5997 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6011 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6018 lib/RPerl/Grammar.pm
	],
	[#Rule Class_76
		 'Class', 14,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6029 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6036 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6043 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6050 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_80
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6061 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_81
		 'Properties', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6086 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-35', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6093 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-35', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6100 lib/RPerl/Grammar.pm
	],
	[#Rule Method_86
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6111 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 4,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6118 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6125 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6132 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6139 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6146 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6157 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_93
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6168 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_94
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6179 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6186 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6193 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6215 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6237 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6248 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6259 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6270 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6281 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6303 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6325 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6336 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6347 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6358 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6369 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6380 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6391 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6413 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6446 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6457 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6464 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6471 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6478 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6485 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6492 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6506 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_129
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6524 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_130
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6535 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_131
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6546 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_132
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6557 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_133
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6568 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6575 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6582 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6596 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_138
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6607 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_139
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6618 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_140
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6629 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_141
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6640 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_142
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6651 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6662 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6673 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6684 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6695 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6706 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6717 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6728 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6735 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6742 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6749 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6760 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6771 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_155
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6782 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_156
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6793 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_157
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 4,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6811 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6825 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-50', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6832 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6846 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_164
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6857 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_165
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6868 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_166
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6879 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_167
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6890 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_168
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6901 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_169
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6912 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_170
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6923 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6930 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6937 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_173
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6948 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6955 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6962 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_176
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6984 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_179
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7006 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7017 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7028 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7039 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7050 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-54', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-55', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-55', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_187
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7082 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_189
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7115 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7129 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_193
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7140 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_194
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7151 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_195
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7162 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7169 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7176 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_198
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7187 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_199
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7198 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_200
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7209 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_201
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-58', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7234 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7241 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_205
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_206
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_207
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7274 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_208
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_209
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7296 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_210
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7307 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_211
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7318 lib/RPerl/Grammar.pm
	],
	[#Rule Type_212
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_213
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7340 lib/RPerl/Grammar.pm
	]
],
#line 7343 lib/RPerl/Grammar.pm
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
         'OpsTypes_24', 
         'OpsTypesSub_25', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Include_28', 
         'Include_29', 
         'Constant_30', 
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
         'ConstantValue_45', 
         'ConstantValue_46', 
         'ConstantValue_47', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Subroutine_52', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_58', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArgumentCheck_62', 
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
         'Class_76', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_80', 
         'Properties_81', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Method_86', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_92', 
         'Operation_93', 
         'Operation_94', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         'Operator_119', 
         'Operator_120', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_129', 
         'OperatorVoid_130', 
         'OperatorVoid_131', 
         'OperatorVoid_132', 
         'OperatorVoid_133', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_193', 
         'ArrayDereferenced_194', 
         'ArrayDereferenced_195', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_198', 
         'HashEntry_199', 
         'HashEntryTyped_200', 
         'HashEntryTyped_201', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_205', 
         'HashDereferenced_206', 
         'HashDereferenced_207', 
         'WordScoped_208', 
         'WordScoped_209', 
         'FileHandle_210', 
         'TypeInner_211', 
         'Type_212', 
         'LoopLabel_213', );
  $self;
}

#line 173 "lib/RPerl/Grammar.eyp"


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


#line 7604 lib/RPerl/Grammar.pm



1;
