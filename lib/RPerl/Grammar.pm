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

      m{\G(our\ \%properties\ \=\ \(|our\ \$VERSION\ \=|use\ parent\ qw\(|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|use\ Carp\;|\$TYPED_|while\ \(|package|\=\ sub\ \{|elsif\ \(|undef|else|1\;1\;|\(\ my|if\ \(|use|\@_\;|our|qw\(|\.\.|\%\{|\@\{|my|\{\*|\(|\{|\}|\]|\[|\/|\)|\;)}gc and return ($1, $1);

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
			"package" => 3,
			'SHEBANG' => 4
		},
		GOTOS => {
			'PLUS-1' => 7,
			'Program' => 8,
			'Package' => 6,
			'Class' => 5,
			'Module' => 1,
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
		ACTIONS => {
			'WORD' => 11,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'WordScoped' => 10
		}
	},
	{#State 4
		ACTIONS => {
			"use strict;" => 13
		},
		GOTOS => {
			'Header' => 14
		}
	},
	{#State 5
		DEFAULT => -15
	},
	{#State 6
		DEFAULT => -14
	},
	{#State 7
		ACTIONS => {
			"package" => 3,
			'' => -4
		},
		GOTOS => {
			'Package' => 6,
			'Class' => 5,
			'Module' => 15
		}
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		DEFAULT => 0
	},
	{#State 10
		ACTIONS => {
			";" => 16
		}
	},
	{#State 11
		DEFAULT => -208
	},
	{#State 12
		DEFAULT => -209
	},
	{#State 13
		ACTIONS => {
			"use warnings;" => 17
		}
	},
	{#State 14
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 18
		}
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		ACTIONS => {
			"use strict;" => 13
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
			'VARIABLE_SYMBOL' => -8,
			"%{" => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"my" => -8,
			'WORD_SCOPED' => -8,
			'OP01_NAMED' => -8,
			"use" => 23,
			"our" => -8,
			"[" => -8,
			'OP05_LOGICAL_NEG' => -8,
			'OP03_MATH_INC_DEC' => -8,
			"if (" => -8,
			"(" => -8,
			"while (" => -8,
			'OP01_NAMED_VOID' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			'OP05_MATH_NEG' => -8,
			'OP19_LOOP_CONTROL' => -8,
			'OP10_NAMED_UNARY' => -8,
			"use constant" => -8,
			'WORD' => -8,
			'OP22_LOGICAL_NOT' => -8,
			"foreach my" => -8,
			"undef" => -8,
			"\@{" => -8,
			"{" => -8,
			'LITERAL' => -8,
			"for my integer" => -8
		},
		GOTOS => {
			'STAR-3' => 22,
			'Include' => 21
		}
	},
	{#State 19
		ACTIONS => {
			"our" => -17,
			"use" => -17,
			"use constant" => -17,
			"use parent qw(" => 25
		},
		GOTOS => {
			'STAR-6' => 24
		}
	},
	{#State 20
		ACTIONS => {
			'VERSION_NUMBER' => 26
		}
	},
	{#State 21
		DEFAULT => -5
	},
	{#State 22
		ACTIONS => {
			'WORD' => -10,
			"use constant" => 29,
			'OP10_NAMED_UNARY' => -10,
			'OP05_MATH_NEG' => -10,
			'OP19_LOOP_CONTROL' => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			'OP01_NAMED_VOID' => -10,
			"\@{" => -10,
			"{" => -10,
			"for my integer" => -10,
			'LITERAL' => -10,
			"undef" => -10,
			"foreach my" => -10,
			'OP22_LOGICAL_NOT' => -10,
			'OP01_NAMED' => -10,
			"our" => -10,
			"my" => -10,
			'WORD_SCOPED' => -10,
			"%{" => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			'VARIABLE_SYMBOL' => -10,
			"(" => -10,
			"while (" => -10,
			"if (" => -10,
			'OP03_MATH_INC_DEC' => -10,
			"[" => -10,
			'OP05_LOGICAL_NEG' => -10
		},
		GOTOS => {
			'STAR-4' => 28,
			'Constant' => 27
		}
	},
	{#State 23
		ACTIONS => {
			'WORD_SCOPED' => 12,
			'WORD' => 11
		},
		GOTOS => {
			'WordScoped' => 30
		}
	},
	{#State 24
		ACTIONS => {
			"use constant" => -19,
			"use" => 23,
			"our" => -19
		},
		GOTOS => {
			'Include' => 32,
			'STAR-7' => 31
		}
	},
	{#State 25
		ACTIONS => {
			'WORD' => 11,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'WordScoped' => 34,
			'PLUS-25' => 33
		}
	},
	{#State 26
		ACTIONS => {
			";" => 35
		}
	},
	{#State 27
		DEFAULT => -7
	},
	{#State 28
		ACTIONS => {
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP03_MATH_INC_DEC' => 57,
			"if (" => 53,
			"(" => 38,
			"while (" => -152,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			'OP01_NAMED_VOID_PAREN' => 64,
			"my" => 58,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41,
			"our" => 42,
			'OP22_LOGICAL_NOT' => 48,
			"foreach my" => -152,
			"undef" => 70,
			"\@{" => 46,
			"{" => 67,
			"for my integer" => -152,
			'LITERAL' => 47,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_NAMED_VOID' => 49,
			'OP05_MATH_NEG' => 75,
			'OP19_LOOP_CONTROL' => 51,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 73
		},
		GOTOS => {
			'Operation' => 69,
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'PLUS-5' => 50,
			'OPTIONAL-47' => 76,
			'LoopLabel' => 72,
			'OperatorVoid' => 39,
			'PAREN-46' => 40,
			'VariableDeclaration' => 52,
			'Operator' => 37,
			'Conditional' => 36,
			'Statement' => 54,
			'ArrayReference' => 62,
			'Expression' => 43,
			'VariableModification' => 65,
			'Variable' => 63,
			'WordScoped' => 44,
			'Subroutine' => 59,
			'HashDereferenced' => 60
		}
	},
	{#State 29
		ACTIONS => {
			'WORD' => 77
		}
	},
	{#State 30
		ACTIONS => {
			"qw(" => 78,
			";" => 79
		}
	},
	{#State 31
		ACTIONS => {
			"our" => 42,
			"use constant" => 29
		},
		GOTOS => {
			'Constant' => 81,
			'Subroutine' => 82,
			'PLUS-8' => 80
		}
	},
	{#State 32
		DEFAULT => -16
	},
	{#State 33
		ACTIONS => {
			")" => 84,
			'WORD' => 11,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'WordScoped' => 83
		}
	},
	{#State 34
		DEFAULT => -64
	},
	{#State 35
		ACTIONS => {
			"use Carp;" => 85
		}
	},
	{#State 36
		DEFAULT => -153
	},
	{#State 37
		DEFAULT => -146
	},
	{#State 38
		ACTIONS => {
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			"(" => 38,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'HashDereferenced' => 60,
			'Variable' => 86,
			'WordScoped' => 44,
			'ArrayReference' => 62,
			'Expression' => 87,
			'HashReference' => 66,
			'Operator' => 37,
			'ArrayDereferenced' => 68
		}
	},
	{#State 39
		DEFAULT => -155
	},
	{#State 40
		DEFAULT => -151
	},
	{#State 41
		ACTIONS => {
			"(" => 88
		}
	},
	{#State 42
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 89
		}
	},
	{#State 43
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP06_REGEX_MATCH' => 96,
			'OP04_MATH_POW' => 105,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => 94,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP23_LOGICAL_AND' => 95,
			'OP13_BITWISE_AND' => 92,
			";" => 102,
			'OP15_LOGICAL_AND' => 101,
			'OP08_STRING_CAT' => 99,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_MATH_ADD_SUB' => 91
		}
	},
	{#State 44
		ACTIONS => {
			"(" => 108
		}
	},
	{#State 45
		ACTIONS => {
			"{" => 110,
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'Variable' => 111,
			'HashReference' => 109
		}
	},
	{#State 46
		ACTIONS => {
			"[" => 55,
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Variable' => 113
		}
	},
	{#State 47
		DEFAULT => -139
	},
	{#State 48
		ACTIONS => {
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP03_MATH_INC_DEC' => 57,
			"(" => 38,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66,
			'Expression' => 114,
			'ArrayReference' => 62,
			'Variable' => 86,
			'WordScoped' => 44,
			'HashDereferenced' => 60
		}
	},
	{#State 49
		ACTIONS => {
			"{*" => 117,
			'LITERAL' => 47,
			"\@{" => 46,
			"{" => 67,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			'OP10_NAMED_UNARY' => 71,
			";" => -126,
			'WORD' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			'KEYS_OR_VALUES' => 119,
			"(" => 38,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP03_MATH_INC_DEC' => 57,
			'WORD_SCOPED' => 12,
			"my" => 115,
			'OP01_NAMED' => 41,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66,
			'Variable' => 86,
			'WordScoped' => 44,
			'FileHandle' => 118,
			'ListElement' => 120,
			'Expression' => 122,
			'TypeInner' => 123,
			'ArrayReference' => 62,
			'HashDereferenced' => 60,
			'ListElements' => 121,
			'OPTIONAL-42' => 116
		}
	},
	{#State 50
		ACTIONS => {
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			"for my integer" => -152,
			"undef" => 70,
			"foreach my" => -152,
			'OP22_LOGICAL_NOT' => 48,
			'WORD' => 73,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP19_LOOP_CONTROL' => 51,
			'OP01_NAMED_VOID' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"(" => 38,
			"while (" => -152,
			"if (" => 53,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP01_NAMED' => 41,
			"my" => 58,
			'' => -13,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'OP01_NAMED_VOID_PAREN' => 64,
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'LoopLabel' => 72,
			'OPTIONAL-47' => 76,
			'HashReference' => 66,
			'ArrayDereferenced' => 68,
			'Operation' => 124,
			'HashDereferenced' => 60,
			'WordScoped' => 44,
			'Variable' => 63,
			'VariableModification' => 65,
			'Expression' => 43,
			'ArrayReference' => 62,
			'Statement' => 54,
			'Conditional' => 36,
			'Operator' => 37,
			'VariableDeclaration' => 52,
			'PAREN-46' => 40,
			'OperatorVoid' => 39
		}
	},
	{#State 51
		ACTIONS => {
			'WORD' => 126
		},
		GOTOS => {
			'LoopLabel' => 125
		}
	},
	{#State 52
		DEFAULT => -156
	},
	{#State 53
		ACTIONS => {
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"{" => 67,
			"\@{" => 46,
			'LITERAL' => 47,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48
		},
		GOTOS => {
			'Expression' => 127,
			'ArrayReference' => 62,
			'Variable' => 86,
			'WordScoped' => 44,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66
		}
	},
	{#State 54
		DEFAULT => -94
	},
	{#State 55
		ACTIONS => {
			"my" => 115,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			"(" => 38,
			"]" => -192,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP03_MATH_INC_DEC' => 57,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'KEYS_OR_VALUES' => 119,
			'OP05_MATH_NEG' => 75,
			"{" => 67,
			"\@{" => 46,
			'LITERAL' => 47,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37,
			'ListElement' => 120,
			'Variable' => 86,
			'WordScoped' => 44,
			'TypeInner' => 123,
			'ArrayReference' => 62,
			'Expression' => 122,
			'OPTIONAL-56' => 128,
			'ListElements' => 129,
			'HashDereferenced' => 60
		}
	},
	{#State 56
		ACTIONS => {
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"{" => 67,
			"\@{" => 46,
			'LITERAL' => 47,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48
		},
		GOTOS => {
			'ArrayReference' => 62,
			'Expression' => 130,
			'Variable' => 86,
			'WordScoped' => 44,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37
		}
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'Variable' => 131
		}
	},
	{#State 58
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 132
		}
	},
	{#State 59
		DEFAULT => -9
	},
	{#State 60
		DEFAULT => -144
	},
	{#State 61
		DEFAULT => -175,
		GOTOS => {
			'STAR-53' => 133
		}
	},
	{#State 62
		DEFAULT => -141
	},
	{#State 63
		ACTIONS => {
			";" => -140,
			'OP13_BITWISE_AND' => -140,
			'OP08_STRING_CAT' => -140,
			'OP11_COMPARE_LT_GT' => -140,
			'OP08_MATH_ADD_SUB' => -140,
			'OP15_LOGICAL_AND' => -140,
			'OP14_BITWISE_OR_XOR' => -140,
			'OP17_LIST_RANGE' => -140,
			'OP18_TERNARY' => -140,
			'OP19_VARIABLE_ASSIGN_BY' => 136,
			'OP09_BITWISE_SHIFT' => -140,
			'OP23_LOGICAL_AND' => -140,
			'OP24_LOGICAL_OR_XOR' => -140,
			'OP19_VARIABLE_ASSIGN' => 137,
			'OP06_REGEX_MATCH' => -140,
			'OP02_METHOD_THINARROW' => 134,
			'OP04_MATH_POW' => -140,
			'OP03_MATH_INC_DEC' => 135,
			'OP16_LOGICAL_OR' => -140,
			'OP07_MATH_MULT_DIV_MOD' => -140,
			'OP12_COMPARE_EQ_NEQ' => -140
		}
	},
	{#State 64
		ACTIONS => {
			"{" => 67,
			"\@{" => 46,
			'LITERAL' => 47,
			"{*" => 117,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			")" => -122,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'KEYS_OR_VALUES' => 119,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP01_NAMED' => 41,
			"my" => 115,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'HashDereferenced' => 60,
			'ListElements' => 138,
			'Expression' => 122,
			'ArrayReference' => 62,
			'TypeInner' => 123,
			'Variable' => 86,
			'FileHandle' => 139,
			'WordScoped' => 44,
			'ListElement' => 120,
			'Operator' => 37,
			'HashReference' => 66,
			'OPTIONAL-40' => 140,
			'ArrayDereferenced' => 68
		}
	},
	{#State 65
		DEFAULT => -157
	},
	{#State 66
		DEFAULT => -143
	},
	{#State 67
		ACTIONS => {
			"%{" => 45,
			"}" => 141,
			'WORD' => 142
		},
		GOTOS => {
			'HashDereferenced' => 144,
			'HashEntry' => 143
		}
	},
	{#State 68
		DEFAULT => -142
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		DEFAULT => -138
	},
	{#State 71
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			"(" => 38,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			"{" => 67,
			"\@{" => 46,
			'LITERAL' => 47,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71
		},
		GOTOS => {
			'Operator' => 37,
			'HashReference' => 66,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 60,
			'Expression' => 145,
			'ArrayReference' => 62,
			'WordScoped' => 44,
			'Variable' => 86
		}
	},
	{#State 72
		ACTIONS => {
			'COLON' => 146
		}
	},
	{#State 73
		ACTIONS => {
			'COLON' => -213,
			"(" => -208
		}
	},
	{#State 74
		ACTIONS => {
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'ArrayReference' => 62,
			'Expression' => 147,
			'WordScoped' => 44,
			'Variable' => 86,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66
		}
	},
	{#State 75
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			"(" => 38,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71
		},
		GOTOS => {
			'HashReference' => 66,
			'Operator' => 37,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 60,
			'Variable' => 86,
			'WordScoped' => 44,
			'Expression' => 148,
			'ArrayReference' => 62
		}
	},
	{#State 76
		ACTIONS => {
			"foreach my" => 151,
			"for my integer" => 152,
			"while (" => 155
		},
		GOTOS => {
			'LoopForEach' => 153,
			'LoopWhile' => 154,
			'Loop' => 150,
			'LoopFor' => 149
		}
	},
	{#State 77
		ACTIONS => {
			'OP20_HASH_FATARROW' => 156
		}
	},
	{#State 78
		ACTIONS => {
			'WORD' => 158
		},
		GOTOS => {
			'PLUS-9' => 157
		}
	},
	{#State 79
		DEFAULT => -28
	},
	{#State 80
		ACTIONS => {
			"1;1;" => 160,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 159
		}
	},
	{#State 81
		DEFAULT => -18
	},
	{#State 82
		DEFAULT => -21
	},
	{#State 83
		DEFAULT => -63
	},
	{#State 84
		ACTIONS => {
			";" => 161
		}
	},
	{#State 85
		ACTIONS => {
			"use RPerl;" => 162
		}
	},
	{#State 86
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -140,
			"]" => -140,
			'OP07_MATH_MULT_DIV_MOD' => -140,
			'OP16_LOGICAL_OR' => -140,
			'OP03_MATH_INC_DEC' => 135,
			'OP02_METHOD_THINARROW' => 134,
			"}" => -140,
			'OP04_MATH_POW' => -140,
			'OP21_LIST_COMMA' => -140,
			'OP24_LOGICAL_OR_XOR' => -140,
			'OP06_REGEX_MATCH' => -140,
			'OP23_LOGICAL_AND' => -140,
			'OP14_BITWISE_OR_XOR' => -140,
			'OP17_LIST_RANGE' => -140,
			'OP18_TERNARY' => -140,
			'OP09_BITWISE_SHIFT' => -140,
			";" => -140,
			'OP13_BITWISE_AND' => -140,
			'OP08_MATH_ADD_SUB' => -140,
			")" => -140,
			'OP08_STRING_CAT' => -140,
			'OP11_COMPARE_LT_GT' => -140,
			'OP15_LOGICAL_AND' => -140,
			".." => -140
		}
	},
	{#State 87
		ACTIONS => {
			'OP04_MATH_POW' => 105,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP06_REGEX_MATCH' => 96,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP13_BITWISE_AND' => 92,
			'OP15_LOGICAL_AND' => 101,
			")" => 163,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_MATH_ADD_SUB' => 91,
			'OP08_STRING_CAT' => 99,
			'OP23_LOGICAL_AND' => 95,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => 94,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104
		}
	},
	{#State 88
		ACTIONS => {
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 11,
			")" => -96,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'KEYS_OR_VALUES' => 119,
			'OP05_MATH_NEG' => 75,
			"(" => 38,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP03_MATH_INC_DEC' => 57,
			'WORD_SCOPED' => 12,
			"my" => 115,
			'OP01_NAMED' => 41,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37,
			'Variable' => 86,
			'WordScoped' => 44,
			'ListElement' => 120,
			'Expression' => 122,
			'ArrayReference' => 62,
			'TypeInner' => 123,
			'ListElements' => 165,
			'HashDereferenced' => 60,
			'OPTIONAL-39' => 164
		}
	},
	{#State 89
		ACTIONS => {
			'VARIABLE_SYMBOL' => 166
		}
	},
	{#State 90
		DEFAULT => -212
	},
	{#State 91
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			"(" => 38,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			"{" => 67,
			"\@{" => 46,
			'LITERAL' => 47,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71
		},
		GOTOS => {
			'HashReference' => 66,
			'Operator' => 37,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 60,
			'ArrayReference' => 62,
			'Expression' => 167,
			'WordScoped' => 44,
			'Variable' => 86
		}
	},
	{#State 92
		ACTIONS => {
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'LITERAL' => 47,
			"\@{" => 46,
			"{" => 67,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48
		},
		GOTOS => {
			'HashDereferenced' => 60,
			'Expression' => 168,
			'ArrayReference' => 62,
			'Variable' => 86,
			'WordScoped' => 44,
			'Operator' => 37,
			'HashReference' => 66,
			'ArrayDereferenced' => 68
		}
	},
	{#State 93
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 11,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP03_MATH_INC_DEC' => 57,
			"(" => 38,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41
		},
		GOTOS => {
			'HashDereferenced' => 60,
			'Variable' => 86,
			'WordScoped' => 44,
			'ArrayReference' => 62,
			'Expression' => 169,
			'HashReference' => 66,
			'Operator' => 37,
			'ArrayDereferenced' => 68
		}
	},
	{#State 94
		ACTIONS => {
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56
		},
		GOTOS => {
			'WordScoped' => 44,
			'Variable' => 86,
			'ArrayReference' => 62,
			'Expression' => 170,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37
		}
	},
	{#State 95
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 11,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP03_MATH_INC_DEC' => 57,
			"(" => 38,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41
		},
		GOTOS => {
			'Variable' => 86,
			'WordScoped' => 44,
			'Expression' => 171,
			'ArrayReference' => 62,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66
		}
	},
	{#State 96
		ACTIONS => {
			"/" => 172
		}
	},
	{#State 97
		ACTIONS => {
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74
		},
		GOTOS => {
			'Operator' => 37,
			'HashReference' => 66,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 60,
			'WordScoped' => 44,
			'Variable' => 86,
			'Expression' => 173,
			'ArrayReference' => 62
		}
	},
	{#State 98
		ACTIONS => {
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			"(" => 38
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66,
			'Variable' => 86,
			'WordScoped' => 44,
			'ArrayReference' => 62,
			'Expression' => 174,
			'HashDereferenced' => 60
		}
	},
	{#State 99
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP03_MATH_INC_DEC' => 57,
			"(" => 38,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 11
		},
		GOTOS => {
			'HashDereferenced' => 60,
			'Expression' => 175,
			'ArrayReference' => 62,
			'WordScoped' => 44,
			'Variable' => 86,
			'Operator' => 37,
			'HashReference' => 66,
			'ArrayDereferenced' => 68
		}
	},
	{#State 100
		ACTIONS => {
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37,
			'ArrayReference' => 62,
			'Expression' => 176,
			'Variable' => 86,
			'WordScoped' => 44,
			'HashDereferenced' => 60
		}
	},
	{#State 101
		ACTIONS => {
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			"{" => 67,
			"\@{" => 46,
			'LITERAL' => 47,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			"(" => 38,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'Operator' => 37,
			'HashReference' => 66,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 60,
			'WordScoped' => 44,
			'Variable' => 86,
			'ArrayReference' => 62,
			'Expression' => 177
		}
	},
	{#State 102
		DEFAULT => -93
	},
	{#State 103
		ACTIONS => {
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'Variable' => 178
		}
	},
	{#State 104
		ACTIONS => {
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"{" => 67,
			"\@{" => 46,
			'LITERAL' => 47,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48
		},
		GOTOS => {
			'Operator' => 37,
			'HashReference' => 66,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 60,
			'ArrayReference' => 62,
			'Expression' => 179,
			'Variable' => 86,
			'WordScoped' => 44
		}
	},
	{#State 105
		ACTIONS => {
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74
		},
		GOTOS => {
			'ArrayReference' => 62,
			'Expression' => 180,
			'Variable' => 86,
			'WordScoped' => 44,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37
		}
	},
	{#State 106
		ACTIONS => {
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66,
			'Expression' => 181,
			'ArrayReference' => 62,
			'Variable' => 86,
			'WordScoped' => 44,
			'HashDereferenced' => 60
		}
	},
	{#State 107
		ACTIONS => {
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'Expression' => 182,
			'ArrayReference' => 62,
			'Variable' => 86,
			'WordScoped' => 44,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37
		}
	},
	{#State 108
		ACTIONS => {
			'OP10_NAMED_UNARY' => 71,
			")" => -135,
			'WORD' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'KEYS_OR_VALUES' => 119,
			'OP05_MATH_NEG' => 75,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			"my" => 115,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			"(" => 38,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP03_MATH_INC_DEC' => 57
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'OPTIONAL-44' => 183,
			'HashReference' => 66,
			'Operator' => 37,
			'Expression' => 122,
			'ArrayReference' => 62,
			'TypeInner' => 123,
			'Variable' => 86,
			'WordScoped' => 44,
			'ListElement' => 120,
			'HashDereferenced' => 60,
			'ListElements' => 184
		}
	},
	{#State 109
		ACTIONS => {
			"}" => 185
		}
	},
	{#State 110
		ACTIONS => {
			'WORD' => 142,
			"%{" => 45
		},
		GOTOS => {
			'HashEntry' => 143,
			'HashDereferenced' => 144
		}
	},
	{#State 111
		ACTIONS => {
			"}" => 186
		}
	},
	{#State 112
		ACTIONS => {
			"}" => 187
		}
	},
	{#State 113
		ACTIONS => {
			"}" => 188
		}
	},
	{#State 114
		ACTIONS => {
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			"]" => -118,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP06_REGEX_MATCH' => 96,
			'OP21_LIST_COMMA' => -118,
			"}" => -118,
			'OP04_MATH_POW' => 105,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => 94,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP23_LOGICAL_AND' => -118,
			".." => -118,
			'OP13_BITWISE_AND' => 92,
			";" => -118,
			'OP08_MATH_ADD_SUB' => 91,
			")" => -118,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_STRING_CAT' => 99,
			'OP15_LOGICAL_AND' => 101
		}
	},
	{#State 115
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 189
		}
	},
	{#State 116
		ACTIONS => {
			";" => 190
		}
	},
	{#State 117
		ACTIONS => {
			'WORD' => 191
		}
	},
	{#State 118
		ACTIONS => {
			'WORD' => 11,
			";" => -128,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'KEYS_OR_VALUES' => 119,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'LITERAL' => 47,
			"\@{" => 46,
			"{" => 67,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"my" => 115,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55
		},
		GOTOS => {
			'HashReference' => 66,
			'Operator' => 37,
			'ArrayDereferenced' => 68,
			'ListElements' => 193,
			'HashDereferenced' => 60,
			'TypeInner' => 123,
			'ArrayReference' => 62,
			'Expression' => 122,
			'OPTIONAL-43' => 192,
			'ListElement' => 120,
			'Variable' => 86,
			'WordScoped' => 44
		}
	},
	{#State 119
		ACTIONS => {
			"%{" => 45
		},
		GOTOS => {
			'HashDereferenced' => 194
		}
	},
	{#State 120
		DEFAULT => -186,
		GOTOS => {
			'STAR-55' => 195
		}
	},
	{#State 121
		DEFAULT => -125
	},
	{#State 122
		ACTIONS => {
			'OP13_BITWISE_AND' => 92,
			";" => -188,
			'OP15_LOGICAL_AND' => 101,
			")" => -188,
			'OP08_STRING_CAT' => 99,
			'OP08_MATH_ADD_SUB' => 91,
			'OP11_COMPARE_LT_GT' => 100,
			'OP23_LOGICAL_AND' => 95,
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => 103,
			'OP21_LIST_COMMA' => -188,
			'OP04_MATH_POW' => 105,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP06_REGEX_MATCH' => 96,
			'OP12_COMPARE_EQ_NEQ' => 98,
			"]" => -188,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106
		}
	},
	{#State 123
		ACTIONS => {
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			'LITERAL' => 47,
			"\@{" => 46,
			"{" => 67,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			"(" => 38,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP03_MATH_INC_DEC' => 57
		},
		GOTOS => {
			'HashDereferenced' => 60,
			'ArrayReference' => 62,
			'Expression' => 196,
			'WordScoped' => 44,
			'Variable' => 86,
			'Operator' => 37,
			'HashReference' => 66,
			'ArrayDereferenced' => 68
		}
	},
	{#State 124
		DEFAULT => -11
	},
	{#State 125
		ACTIONS => {
			";" => 197
		}
	},
	{#State 126
		DEFAULT => -213
	},
	{#State 127
		ACTIONS => {
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP23_LOGICAL_AND' => 95,
			'OP13_BITWISE_AND' => 92,
			'OP08_MATH_ADD_SUB' => 91,
			'OP11_COMPARE_LT_GT' => 100,
			")" => 198,
			'OP08_STRING_CAT' => 99,
			'OP15_LOGICAL_AND' => 101,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP06_REGEX_MATCH' => 96,
			'OP04_MATH_POW' => 105
		}
	},
	{#State 128
		ACTIONS => {
			"]" => 199
		}
	},
	{#State 129
		DEFAULT => -191
	},
	{#State 130
		ACTIONS => {
			'OP04_MATH_POW' => 105,
			"}" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP06_REGEX_MATCH' => -101,
			"]" => -101,
			'OP12_COMPARE_EQ_NEQ' => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP13_BITWISE_AND' => -101,
			";" => -101,
			")" => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP08_STRING_CAT' => -101,
			'OP15_LOGICAL_AND' => -101,
			".." => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP18_TERNARY' => -101
		}
	},
	{#State 131
		DEFAULT => -98
	},
	{#State 132
		ACTIONS => {
			'VARIABLE_SYMBOL' => 200
		}
	},
	{#State 133
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -176,
			")" => -176,
			'OP08_STRING_CAT' => -176,
			'OP08_MATH_ADD_SUB' => -176,
			'OP15_LOGICAL_AND' => -176,
			";" => -176,
			'OP13_BITWISE_AND' => -176,
			".." => -176,
			'COLON' => -176,
			'OP02_HASH_THINARROW' => 202,
			'OP23_LOGICAL_AND' => -176,
			'OP19_VARIABLE_ASSIGN_BY' => -176,
			'OP18_TERNARY' => -176,
			'OP09_BITWISE_SHIFT' => -176,
			'OP14_BITWISE_OR_XOR' => -176,
			'OP17_LIST_RANGE' => -176,
			'OP21_LIST_COMMA' => -176,
			"}" => -176,
			'OP02_METHOD_THINARROW' => -176,
			'OP04_MATH_POW' => -176,
			'OP19_VARIABLE_ASSIGN' => -176,
			'OP06_REGEX_MATCH' => -176,
			'OP24_LOGICAL_OR_XOR' => -176,
			"]" => -176,
			'OP12_COMPARE_EQ_NEQ' => -176,
			'OP02_ARRAY_THINARROW' => 203,
			'OP03_MATH_INC_DEC' => -176,
			'OP07_MATH_MULT_DIV_MOD' => -176,
			'OP16_LOGICAL_OR' => -176
		},
		GOTOS => {
			'VariableRetrieval' => 201
		}
	},
	{#State 134
		ACTIONS => {
			'WORD' => 204
		}
	},
	{#State 135
		DEFAULT => -99
	},
	{#State 136
		ACTIONS => {
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			"(" => 38
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37,
			'Variable' => 86,
			'WordScoped' => 44,
			'ArrayReference' => 62,
			'Expression' => 205,
			'HashDereferenced' => 60
		}
	},
	{#State 137
		ACTIONS => {
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			"(" => 38,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP03_MATH_INC_DEC' => 57
		},
		GOTOS => {
			'WordScoped' => 44,
			'Variable' => 86,
			'Expression' => 206,
			'ArrayReference' => 62,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37
		}
	},
	{#State 138
		DEFAULT => -121
	},
	{#State 139
		ACTIONS => {
			"(" => 38,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP03_MATH_INC_DEC' => 57,
			"my" => 115,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			'OP10_NAMED_UNARY' => 71,
			")" => -124,
			'WORD' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			'KEYS_OR_VALUES' => 119
		},
		GOTOS => {
			'Expression' => 122,
			'OPTIONAL-41' => 208,
			'TypeInner' => 123,
			'ArrayReference' => 62,
			'Variable' => 86,
			'WordScoped' => 44,
			'ListElement' => 120,
			'HashDereferenced' => 60,
			'ListElements' => 207,
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66
		}
	},
	{#State 140
		ACTIONS => {
			")" => 209
		}
	},
	{#State 141
		DEFAULT => -145
	},
	{#State 142
		ACTIONS => {
			'OP20_HASH_FATARROW' => 210
		}
	},
	{#State 143
		DEFAULT => -204,
		GOTOS => {
			'STAR-59' => 211
		}
	},
	{#State 144
		DEFAULT => -199
	},
	{#State 145
		ACTIONS => {
			'OP04_MATH_POW' => 105,
			"}" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP06_REGEX_MATCH' => 96,
			'OP12_COMPARE_EQ_NEQ' => -108,
			"]" => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			";" => -108,
			'OP13_BITWISE_AND' => -108,
			'OP15_LOGICAL_AND' => -108,
			")" => -108,
			'OP08_STRING_CAT' => 99,
			'OP11_COMPARE_LT_GT' => -108,
			'OP08_MATH_ADD_SUB' => 91,
			".." => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP17_LIST_RANGE' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => -108
		}
	},
	{#State 146
		DEFAULT => -150
	},
	{#State 147
		ACTIONS => {
			'OP16_LOGICAL_OR' => -109,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP12_COMPARE_EQ_NEQ' => -109,
			"]" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP06_REGEX_MATCH' => 96,
			'OP21_LIST_COMMA' => -109,
			"}" => -109,
			'OP04_MATH_POW' => 105,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP18_TERNARY' => -109,
			'OP09_BITWISE_SHIFT' => 104,
			'OP23_LOGICAL_AND' => -109,
			".." => -109,
			'OP13_BITWISE_AND' => -109,
			";" => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			")" => -109,
			'OP08_MATH_ADD_SUB' => 91,
			'OP08_STRING_CAT' => 99
		}
	},
	{#State 148
		ACTIONS => {
			'OP15_LOGICAL_AND' => 101,
			'OP08_STRING_CAT' => 99,
			'OP08_MATH_ADD_SUB' => 91,
			")" => 212,
			'OP11_COMPARE_LT_GT' => 100,
			'OP13_BITWISE_AND' => 92,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => 94,
			'OP23_LOGICAL_AND' => 95,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP04_MATH_POW' => 105,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106,
			'OP12_COMPARE_EQ_NEQ' => 98
		}
	},
	{#State 149
		DEFAULT => -165
	},
	{#State 150
		DEFAULT => -154
	},
	{#State 151
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 213
		}
	},
	{#State 152
		ACTIONS => {
			'VARIABLE_SYMBOL' => 214
		}
	},
	{#State 153
		DEFAULT => -166
	},
	{#State 154
		DEFAULT => -167
	},
	{#State 155
		ACTIONS => {
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			"(" => 38,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'Variable' => 86,
			'WordScoped' => 44,
			'Expression' => 215,
			'ArrayReference' => 62,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37
		}
	},
	{#State 156
		ACTIONS => {
			"my" => 115
		},
		GOTOS => {
			'TypeInner' => 216
		}
	},
	{#State 157
		ACTIONS => {
			'WORD' => 217,
			")" => 218
		}
	},
	{#State 158
		DEFAULT => -27
	},
	{#State 159
		DEFAULT => -20
	},
	{#State 160
		DEFAULT => -22
	},
	{#State 161
		DEFAULT => -66,
		GOTOS => {
			'STAR-26' => 219
		}
	},
	{#State 162
		ACTIONS => {
			"our" => 221
		},
		GOTOS => {
			'OpsTypes' => 220
		}
	},
	{#State 163
		DEFAULT => -149
	},
	{#State 164
		ACTIONS => {
			")" => 222
		}
	},
	{#State 165
		DEFAULT => -95
	},
	{#State 166
		ACTIONS => {
			"= sub {" => 223
		}
	},
	{#State 167
		ACTIONS => {
			"]" => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => -105,
			"}" => -105,
			'OP04_MATH_POW' => 105,
			'OP21_LIST_COMMA' => -105,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP18_TERNARY' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP17_LIST_RANGE' => -105,
			")" => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP08_STRING_CAT' => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP15_LOGICAL_AND' => -105,
			";" => -105,
			'OP13_BITWISE_AND' => -105,
			".." => -105
		}
	},
	{#State 168
		ACTIONS => {
			'OP23_LOGICAL_AND' => -112,
			'OP18_TERNARY' => -112,
			'OP09_BITWISE_SHIFT' => 104,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP17_LIST_RANGE' => -112,
			")" => -112,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_STRING_CAT' => 99,
			'OP08_MATH_ADD_SUB' => 91,
			'OP15_LOGICAL_AND' => -112,
			";" => -112,
			'OP13_BITWISE_AND' => -112,
			".." => -112,
			"]" => -112,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => -112,
			'OP21_LIST_COMMA' => -112,
			"}" => -112,
			'OP04_MATH_POW' => 105,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => -112
		}
	},
	{#State 169
		ACTIONS => {
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => -113,
			"}" => -113,
			'OP21_LIST_COMMA' => -113,
			'OP04_MATH_POW' => 105,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => -113,
			'OP12_COMPARE_EQ_NEQ' => 98,
			"]" => -113,
			".." => -113,
			'OP15_LOGICAL_AND' => -113,
			")" => -113,
			'OP08_MATH_ADD_SUB' => 91,
			'OP08_STRING_CAT' => 99,
			'OP11_COMPARE_LT_GT' => 100,
			";" => -113,
			'OP13_BITWISE_AND' => 92,
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP17_LIST_RANGE' => -113,
			'OP23_LOGICAL_AND' => -113
		}
	},
	{#State 170
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP06_REGEX_MATCH' => 96,
			"}" => -116,
			'OP21_LIST_COMMA' => -116,
			'OP04_MATH_POW' => 105,
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP12_COMPARE_EQ_NEQ' => 98,
			"]" => -116,
			".." => -116,
			'OP13_BITWISE_AND' => 92,
			";" => -116,
			")" => -116,
			'OP08_MATH_ADD_SUB' => 91,
			'OP08_STRING_CAT' => 99,
			'OP11_COMPARE_LT_GT' => 100,
			'OP15_LOGICAL_AND' => 101,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP18_TERNARY' => -116,
			'OP09_BITWISE_SHIFT' => 104,
			'OP23_LOGICAL_AND' => -116
		}
	},
	{#State 171
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => 103,
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP23_LOGICAL_AND' => -119,
			".." => -119,
			'OP15_LOGICAL_AND' => 101,
			'OP11_COMPARE_LT_GT' => 100,
			")" => -119,
			'OP08_MATH_ADD_SUB' => 91,
			'OP08_STRING_CAT' => 99,
			";" => -119,
			'OP13_BITWISE_AND' => 92,
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			"]" => -119,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => -119,
			"}" => -119,
			'OP21_LIST_COMMA' => -119,
			'OP04_MATH_POW' => 105
		}
	},
	{#State 172
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 224
		}
	},
	{#State 173
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP06_REGEX_MATCH' => 96,
			"}" => -120,
			'OP21_LIST_COMMA' => -120,
			'OP04_MATH_POW' => 105,
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			"]" => -120,
			'OP12_COMPARE_EQ_NEQ' => 98,
			".." => -120,
			'OP13_BITWISE_AND' => 92,
			";" => -120,
			'OP15_LOGICAL_AND' => 101,
			")" => -120,
			'OP08_STRING_CAT' => 99,
			'OP08_MATH_ADD_SUB' => 91,
			'OP11_COMPARE_LT_GT' => 100,
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP23_LOGICAL_AND' => 95
		}
	},
	{#State 174
		ACTIONS => {
			'OP23_LOGICAL_AND' => -111,
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP15_LOGICAL_AND' => -111,
			")" => -111,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_MATH_ADD_SUB' => 91,
			'OP08_STRING_CAT' => 99,
			";" => -111,
			'OP13_BITWISE_AND' => -111,
			".." => -111,
			'OP12_COMPARE_EQ_NEQ' => undef,
			"]" => -111,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => -111,
			'OP04_MATH_POW' => 105,
			"}" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => -111
		}
	},
	{#State 175
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP06_REGEX_MATCH' => 96,
			'OP21_LIST_COMMA' => -106,
			"}" => -106,
			'OP04_MATH_POW' => 105,
			'OP16_LOGICAL_OR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			"]" => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			".." => -106,
			";" => -106,
			'OP13_BITWISE_AND' => -106,
			")" => -106,
			'OP08_MATH_ADD_SUB' => 91,
			'OP11_COMPARE_LT_GT' => -106,
			'OP08_STRING_CAT' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP18_TERNARY' => -106,
			'OP23_LOGICAL_AND' => -106
		}
	},
	{#State 176
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => -110,
			'OP17_LIST_RANGE' => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP23_LOGICAL_AND' => -110,
			".." => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP08_MATH_ADD_SUB' => 91,
			")" => -110,
			'OP11_COMPARE_LT_GT' => undef,
			'OP08_STRING_CAT' => 99,
			";" => -110,
			'OP13_BITWISE_AND' => -110,
			'OP16_LOGICAL_OR' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			"]" => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => -110,
			"}" => -110,
			'OP04_MATH_POW' => 105,
			'OP21_LIST_COMMA' => -110
		}
	},
	{#State 177
		ACTIONS => {
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => -114,
			"}" => -114,
			'OP04_MATH_POW' => 105,
			'OP21_LIST_COMMA' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP12_COMPARE_EQ_NEQ' => 98,
			"]" => -114,
			".." => -114,
			'OP15_LOGICAL_AND' => -114,
			")" => -114,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_STRING_CAT' => 99,
			'OP08_MATH_ADD_SUB' => 91,
			";" => -114,
			'OP13_BITWISE_AND' => 92,
			'OP18_TERNARY' => -114,
			'OP09_BITWISE_SHIFT' => 104,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => -114,
			'OP23_LOGICAL_AND' => -114
		}
	},
	{#State 178
		ACTIONS => {
			'COLON' => 225
		}
	},
	{#State 179
		ACTIONS => {
			"}" => -107,
			'OP21_LIST_COMMA' => -107,
			'OP04_MATH_POW' => 105,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP06_REGEX_MATCH' => 96,
			"]" => -107,
			'OP12_COMPARE_EQ_NEQ' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			";" => -107,
			'OP13_BITWISE_AND' => -107,
			'OP15_LOGICAL_AND' => -107,
			")" => -107,
			'OP08_MATH_ADD_SUB' => 91,
			'OP11_COMPARE_LT_GT' => -107,
			'OP08_STRING_CAT' => 99,
			".." => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP17_LIST_RANGE' => -107,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP09_BITWISE_SHIFT' => -107,
			'OP18_TERNARY' => -107
		}
	},
	{#State 180
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -100,
			'OP18_TERNARY' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP23_LOGICAL_AND' => -100,
			".." => -100,
			'OP08_STRING_CAT' => -100,
			")" => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP15_LOGICAL_AND' => -100,
			";" => -100,
			'OP13_BITWISE_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP16_LOGICAL_OR' => -100,
			"]" => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP06_REGEX_MATCH' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP21_LIST_COMMA' => -100,
			"}" => -100,
			'OP04_MATH_POW' => 105
		}
	},
	{#State 181
		ACTIONS => {
			'OP23_LOGICAL_AND' => -115,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => -115,
			'OP18_TERNARY' => -115,
			'OP09_BITWISE_SHIFT' => 104,
			'OP13_BITWISE_AND' => 92,
			";" => -115,
			'OP15_LOGICAL_AND' => 101,
			'OP11_COMPARE_LT_GT' => 100,
			")" => -115,
			'OP08_MATH_ADD_SUB' => 91,
			'OP08_STRING_CAT' => 99,
			".." => -115,
			"]" => -115,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => -115,
			"}" => -115,
			'OP04_MATH_POW' => 105,
			'OP21_LIST_COMMA' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP06_REGEX_MATCH' => 96
		}
	},
	{#State 182
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP06_REGEX_MATCH' => 96,
			"}" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP04_MATH_POW' => 105,
			'OP16_LOGICAL_OR' => -104,
			'OP07_MATH_MULT_DIV_MOD' => -104,
			'OP12_COMPARE_EQ_NEQ' => -104,
			"]" => -104,
			".." => -104,
			'OP13_BITWISE_AND' => -104,
			";" => -104,
			'OP15_LOGICAL_AND' => -104,
			")" => -104,
			'OP08_MATH_ADD_SUB' => -104,
			'OP08_STRING_CAT' => -104,
			'OP11_COMPARE_LT_GT' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP18_TERNARY' => -104,
			'OP09_BITWISE_SHIFT' => -104,
			'OP23_LOGICAL_AND' => -104
		}
	},
	{#State 183
		ACTIONS => {
			")" => 226
		}
	},
	{#State 184
		DEFAULT => -134
	},
	{#State 185
		DEFAULT => -207
	},
	{#State 186
		DEFAULT => -206
	},
	{#State 187
		DEFAULT => -195
	},
	{#State 188
		DEFAULT => -194
	},
	{#State 189
		ACTIONS => {
			"\$TYPED_" => 227
		}
	},
	{#State 190
		DEFAULT => -131
	},
	{#State 191
		ACTIONS => {
			"}" => 228
		}
	},
	{#State 192
		ACTIONS => {
			";" => 229
		}
	},
	{#State 193
		DEFAULT => -127
	},
	{#State 194
		DEFAULT => -190
	},
	{#State 195
		ACTIONS => {
			";" => -187,
			'OP21_LIST_COMMA' => 231,
			"]" => -187,
			")" => -187
		},
		GOTOS => {
			'PAREN-54' => 230
		}
	},
	{#State 196
		ACTIONS => {
			'OP23_LOGICAL_AND' => 95,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP15_LOGICAL_AND' => 101,
			")" => -189,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_MATH_ADD_SUB' => 91,
			'OP08_STRING_CAT' => 99,
			";" => -189,
			'OP13_BITWISE_AND' => 92,
			"]" => -189,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP21_LIST_COMMA' => -189,
			'OP04_MATH_POW' => 105,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => 97
		}
	},
	{#State 197
		DEFAULT => -133
	},
	{#State 198
		ACTIONS => {
			"{" => 232
		},
		GOTOS => {
			'CodeBlock' => 233
		}
	},
	{#State 199
		DEFAULT => -193
	},
	{#State 200
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 235,
			";" => 234
		}
	},
	{#State 201
		DEFAULT => -174
	},
	{#State 202
		ACTIONS => {
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			"(" => 38,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 237,
			'OP10_NAMED_UNARY' => 71,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'LITERAL' => 47,
			"\@{" => 46,
			"{" => 67
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66,
			'Expression' => 236,
			'ArrayReference' => 62,
			'WordScoped' => 44,
			'Variable' => 86,
			'HashDereferenced' => 60
		}
	},
	{#State 203
		ACTIONS => {
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'Expression' => 238,
			'ArrayReference' => 62,
			'WordScoped' => 44,
			'Variable' => 86,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37
		}
	},
	{#State 204
		ACTIONS => {
			"(" => 239
		}
	},
	{#State 205
		ACTIONS => {
			'OP15_LOGICAL_AND' => 101,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_STRING_CAT' => 99,
			'OP08_MATH_ADD_SUB' => 91,
			'OP13_BITWISE_AND' => 92,
			";" => 240,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP23_LOGICAL_AND' => 95,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP04_MATH_POW' => 105,
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP12_COMPARE_EQ_NEQ' => 98
		}
	},
	{#State 206
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP06_REGEX_MATCH' => 96,
			'OP04_MATH_POW' => 105,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => 94,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP23_LOGICAL_AND' => 95,
			'OP13_BITWISE_AND' => 92,
			";" => 241,
			'OP08_MATH_ADD_SUB' => 91,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_STRING_CAT' => 99,
			'OP15_LOGICAL_AND' => 101
		}
	},
	{#State 207
		DEFAULT => -123
	},
	{#State 208
		ACTIONS => {
			")" => 242
		}
	},
	{#State 209
		ACTIONS => {
			";" => 243
		}
	},
	{#State 210
		ACTIONS => {
			"(" => -197,
			'OP05_LOGICAL_NEG' => -197,
			"[" => -197,
			'OP03_MATH_INC_DEC' => -197,
			'WORD_SCOPED' => -197,
			"my" => 115,
			'OP01_NAMED' => -197,
			'VARIABLE_SYMBOL' => -197,
			"%{" => -197,
			'LITERAL' => -197,
			"\@{" => -197,
			"{" => -197,
			'OP22_LOGICAL_NOT' => -197,
			"undef" => -197,
			'OP10_NAMED_UNARY' => -197,
			'WORD' => -197,
			'OP10_NAMED_UNARY_STRINGIFY' => -197,
			'OP05_MATH_NEG' => -197
		},
		GOTOS => {
			'OPTIONAL-57' => 245,
			'TypeInner' => 244
		}
	},
	{#State 211
		ACTIONS => {
			"}" => 246,
			'OP21_LIST_COMMA' => 247
		},
		GOTOS => {
			'PAREN-58' => 248
		}
	},
	{#State 212
		DEFAULT => -102
	},
	{#State 213
		ACTIONS => {
			'VARIABLE_SYMBOL' => 249
		}
	},
	{#State 214
		ACTIONS => {
			"(" => 250
		}
	},
	{#State 215
		ACTIONS => {
			'OP13_BITWISE_AND' => 92,
			'OP15_LOGICAL_AND' => 101,
			'OP08_STRING_CAT' => 99,
			'OP08_MATH_ADD_SUB' => 91,
			")" => 251,
			'OP11_COMPARE_LT_GT' => 100,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => 94,
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => 103,
			'OP23_LOGICAL_AND' => 95,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP06_REGEX_MATCH' => 96,
			'OP04_MATH_POW' => 105,
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP12_COMPARE_EQ_NEQ' => 98
		}
	},
	{#State 216
		ACTIONS => {
			"[" => 253,
			'LITERAL' => 254,
			"{" => 252
		},
		GOTOS => {
			'ConstantValue' => 255
		}
	},
	{#State 217
		DEFAULT => -26
	},
	{#State 218
		ACTIONS => {
			";" => 256
		}
	},
	{#State 219
		ACTIONS => {
			"use" => 23,
			"use constant" => -68,
			"our %properties = (" => -68
		},
		GOTOS => {
			'Include' => 258,
			'STAR-27' => 257
		}
	},
	{#State 220
		DEFAULT => -23
	},
	{#State 221
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 259
		}
	},
	{#State 222
		DEFAULT => -97
	},
	{#State 223
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -49,
			'OP05_MATH_NEG' => -49,
			'OP10_NAMED_UNARY_STRINGIFY' => -49,
			'OP01_NAMED_VOID' => -49,
			'WORD' => -49,
			'OP10_NAMED_UNARY' => -49,
			"undef" => -49,
			'OP22_LOGICAL_NOT' => -49,
			"foreach my" => -49,
			"for my integer" => -49,
			'LITERAL' => -49,
			"\@{" => -49,
			"{" => -49,
			'OP01_NAMED_VOID_PAREN' => -49,
			"%{" => -49,
			'VARIABLE_SYMBOL' => -49,
			'OP01_NAMED' => -49,
			'WORD_SCOPED' => -49,
			"my" => -49,
			'OP03_MATH_INC_DEC' => -49,
			'OP05_LOGICAL_NEG' => -49,
			"[" => -49,
			"while (" => -49,
			"(" => -49,
			"if (" => -49,
			"( my" => 260
		},
		GOTOS => {
			'SubroutineArguments' => 262,
			'OPTIONAL-18' => 261
		}
	},
	{#State 224
		ACTIONS => {
			"/" => 263
		}
	},
	{#State 225
		ACTIONS => {
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'Variable' => 264
		}
	},
	{#State 226
		DEFAULT => -147
	},
	{#State 227
		ACTIONS => {
			'WORD' => 265
		}
	},
	{#State 228
		DEFAULT => -210
	},
	{#State 229
		DEFAULT => -132
	},
	{#State 230
		DEFAULT => -185
	},
	{#State 231
		ACTIONS => {
			'OP05_MATH_NEG' => 75,
			'KEYS_OR_VALUES' => 119,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			"my" => 115,
			'WORD_SCOPED' => 12,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			"(" => 38
		},
		GOTOS => {
			'ListElement' => 266,
			'WordScoped' => 44,
			'Variable' => 86,
			'ArrayReference' => 62,
			'TypeInner' => 123,
			'Expression' => 122,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37
		}
	},
	{#State 232
		ACTIONS => {
			'LITERAL' => 47,
			"for my integer" => -152,
			"{" => 67,
			"\@{" => 46,
			'OP22_LOGICAL_NOT' => 48,
			"foreach my" => -152,
			"undef" => 70,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 73,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_NAMED_VOID' => 49,
			'OP19_LOOP_CONTROL' => 51,
			'OP05_MATH_NEG' => 75,
			"if (" => 53,
			"while (" => -152,
			"(" => 38,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP03_MATH_INC_DEC' => 57,
			'WORD_SCOPED' => 12,
			"my" => 58,
			'OP01_NAMED' => 41,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED_VOID_PAREN' => 64,
			"%{" => 45
		},
		GOTOS => {
			'OperatorVoid' => 39,
			'PAREN-46' => 40,
			'Operator' => 37,
			'Conditional' => 36,
			'PLUS-52' => 268,
			'VariableDeclaration' => 52,
			'Statement' => 54,
			'Expression' => 43,
			'ArrayReference' => 62,
			'Variable' => 63,
			'WordScoped' => 44,
			'VariableModification' => 65,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'Operation' => 267,
			'HashReference' => 66,
			'OPTIONAL-47' => 76,
			'LoopLabel' => 72
		}
	},
	{#State 233
		DEFAULT => -160,
		GOTOS => {
			'STAR-49' => 269
		}
	},
	{#State 234
		DEFAULT => -180
	},
	{#State 235
		ACTIONS => {
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'LITERAL' => 47,
			"\@{" => 46,
			"{" => 67,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			"(" => 38
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66,
			'Variable' => 86,
			'WordScoped' => 44,
			'Expression' => 270,
			'ArrayReference' => 62,
			'HashDereferenced' => 60
		}
	},
	{#State 236
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => 103,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => 94,
			'OP23_LOGICAL_AND' => 95,
			'OP08_STRING_CAT' => 99,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_MATH_ADD_SUB' => 91,
			'OP15_LOGICAL_AND' => 101,
			'OP13_BITWISE_AND' => 92,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP04_MATH_POW' => 105,
			"}" => 271
		}
	},
	{#State 237
		ACTIONS => {
			"(" => -208,
			"}" => 272
		}
	},
	{#State 238
		ACTIONS => {
			'OP08_STRING_CAT' => 99,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_MATH_ADD_SUB' => 91,
			'OP15_LOGICAL_AND' => 101,
			'OP13_BITWISE_AND' => 92,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => 94,
			'OP23_LOGICAL_AND' => 95,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP04_MATH_POW' => 105,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106,
			"]" => 273,
			'OP12_COMPARE_EQ_NEQ' => 98
		}
	},
	{#State 239
		ACTIONS => {
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'WORD' => 11,
			")" => -137,
			'OP10_NAMED_UNARY' => 71,
			'OP05_MATH_NEG' => 75,
			'KEYS_OR_VALUES' => 119,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			"(" => 38,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"my" => 115,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61
		},
		GOTOS => {
			'Operator' => 37,
			'HashReference' => 66,
			'ArrayDereferenced' => 68,
			'OPTIONAL-45' => 274,
			'HashDereferenced' => 60,
			'ListElements' => 275,
			'Expression' => 122,
			'ArrayReference' => 62,
			'TypeInner' => 123,
			'Variable' => 86,
			'WordScoped' => 44,
			'ListElement' => 120
		}
	},
	{#State 240
		DEFAULT => -183
	},
	{#State 241
		DEFAULT => -182
	},
	{#State 242
		ACTIONS => {
			";" => 276
		}
	},
	{#State 243
		DEFAULT => -129
	},
	{#State 244
		DEFAULT => -196
	},
	{#State 245
		ACTIONS => {
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			"(" => 38,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66,
			'Expression' => 277,
			'ArrayReference' => 62,
			'Variable' => 86,
			'WordScoped' => 44,
			'HashDereferenced' => 60
		}
	},
	{#State 246
		DEFAULT => -205
	},
	{#State 247
		ACTIONS => {
			'WORD' => 142,
			"%{" => 45
		},
		GOTOS => {
			'HashDereferenced' => 144,
			'HashEntry' => 278
		}
	},
	{#State 248
		DEFAULT => -203
	},
	{#State 249
		ACTIONS => {
			"(" => 279
		}
	},
	{#State 250
		ACTIONS => {
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			"(" => 38,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP03_MATH_INC_DEC' => 57,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			'LITERAL' => 47,
			"\@{" => 46,
			"{" => 67,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70
		},
		GOTOS => {
			'HashDereferenced' => 60,
			'ArrayReference' => 62,
			'Expression' => 280,
			'WordScoped' => 44,
			'Variable' => 86,
			'Operator' => 37,
			'HashReference' => 66,
			'ArrayDereferenced' => 68
		}
	},
	{#State 251
		ACTIONS => {
			"{" => 232
		},
		GOTOS => {
			'CodeBlock' => 281
		}
	},
	{#State 252
		ACTIONS => {
			'WORD' => 282
		}
	},
	{#State 253
		ACTIONS => {
			"my" => 115,
			'LITERAL' => -32
		},
		GOTOS => {
			'OPTIONAL-10' => 284,
			'TypeInner' => 283
		}
	},
	{#State 254
		DEFAULT => -45
	},
	{#State 255
		ACTIONS => {
			";" => 285
		}
	},
	{#State 256
		DEFAULT => -29
	},
	{#State 257
		ACTIONS => {
			"our %properties = (" => 288,
			"use constant" => 29
		},
		GOTOS => {
			'Constant' => 286,
			'Properties' => 287
		}
	},
	{#State 258
		DEFAULT => -65
	},
	{#State 259
		ACTIONS => {
			'OPS_TYPES_ID' => 289
		}
	},
	{#State 260
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 290
		}
	},
	{#State 261
		ACTIONS => {
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			"foreach my" => -152,
			"{" => 67,
			"\@{" => 46,
			'LITERAL' => 47,
			"for my integer" => -152,
			'OP05_MATH_NEG' => 75,
			'OP19_LOOP_CONTROL' => 51,
			'OP01_NAMED_VOID' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 73,
			'OP10_NAMED_UNARY' => 71,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			"(" => 38,
			"while (" => -152,
			"if (" => 53,
			"%{" => 45,
			'OP01_NAMED_VOID_PAREN' => 64,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			"my" => 58,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'Operation' => 291,
			'HashReference' => 66,
			'OPTIONAL-47' => 76,
			'LoopLabel' => 72,
			'OperatorVoid' => 39,
			'PAREN-46' => 40,
			'PLUS-19' => 292,
			'Conditional' => 36,
			'Operator' => 37,
			'VariableDeclaration' => 52,
			'Statement' => 54,
			'Expression' => 43,
			'ArrayReference' => 62,
			'Variable' => 63,
			'WordScoped' => 44,
			'VariableModification' => 65,
			'HashDereferenced' => 60
		}
	},
	{#State 262
		DEFAULT => -48
	},
	{#State 263
		DEFAULT => -103
	},
	{#State 264
		DEFAULT => -117
	},
	{#State 265
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 293
		}
	},
	{#State 266
		DEFAULT => -184
	},
	{#State 267
		DEFAULT => -172
	},
	{#State 268
		ACTIONS => {
			'LITERAL' => 47,
			"for my integer" => -152,
			"{" => 67,
			"\@{" => 46,
			'OP22_LOGICAL_NOT' => 48,
			"foreach my" => -152,
			"undef" => 70,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 73,
			'OP01_NAMED_VOID' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP19_LOOP_CONTROL' => 51,
			'OP05_MATH_NEG' => 75,
			"if (" => 53,
			"while (" => -152,
			"(" => 38,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP03_MATH_INC_DEC' => 57,
			'WORD_SCOPED' => 12,
			"}" => 294,
			"my" => 58,
			'OP01_NAMED' => 41,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED_VOID_PAREN' => 64,
			"%{" => 45
		},
		GOTOS => {
			'HashDereferenced' => 60,
			'VariableModification' => 65,
			'WordScoped' => 44,
			'Variable' => 63,
			'ArrayReference' => 62,
			'Expression' => 43,
			'Statement' => 54,
			'VariableDeclaration' => 52,
			'Operator' => 37,
			'Conditional' => 36,
			'PAREN-46' => 40,
			'OperatorVoid' => 39,
			'LoopLabel' => 72,
			'OPTIONAL-47' => 76,
			'HashReference' => 66,
			'Operation' => 295,
			'ArrayDereferenced' => 68
		}
	},
	{#State 269
		ACTIONS => {
			"if (" => -163,
			"(" => -163,
			"while (" => -163,
			"[" => -163,
			'OP05_LOGICAL_NEG' => -163,
			'OP03_MATH_INC_DEC' => -163,
			"my" => -163,
			"}" => -163,
			'WORD_SCOPED' => -163,
			'' => -163,
			'OP01_NAMED' => -163,
			'VARIABLE_SYMBOL' => -163,
			"else" => 298,
			"%{" => -163,
			'OP01_NAMED_VOID_PAREN' => -163,
			"\@{" => -163,
			"{" => -163,
			"for my integer" => -163,
			'LITERAL' => -163,
			"foreach my" => -163,
			'OP22_LOGICAL_NOT' => -163,
			"undef" => -163,
			'OP10_NAMED_UNARY' => -163,
			'WORD' => -163,
			'OP01_NAMED_VOID' => -163,
			'OP10_NAMED_UNARY_STRINGIFY' => -163,
			"elsif (" => 300,
			'OP05_MATH_NEG' => -163,
			'OP19_LOOP_CONTROL' => -163
		},
		GOTOS => {
			'PAREN-48' => 296,
			'PAREN-50' => 297,
			'OPTIONAL-51' => 299
		}
	},
	{#State 270
		ACTIONS => {
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP04_MATH_POW' => 105,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP15_LOGICAL_AND' => 101,
			'OP08_MATH_ADD_SUB' => 91,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_STRING_CAT' => 99,
			";" => 301,
			'OP13_BITWISE_AND' => 92,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP23_LOGICAL_AND' => 95
		}
	},
	{#State 271
		DEFAULT => -178
	},
	{#State 272
		DEFAULT => -179
	},
	{#State 273
		DEFAULT => -177
	},
	{#State 274
		ACTIONS => {
			")" => 302
		}
	},
	{#State 275
		DEFAULT => -136
	},
	{#State 276
		DEFAULT => -130
	},
	{#State 277
		ACTIONS => {
			'OP08_STRING_CAT' => 99,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_MATH_ADD_SUB' => 91,
			'OP15_LOGICAL_AND' => 101,
			'OP13_BITWISE_AND' => 92,
			'OP23_LOGICAL_AND' => 95,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => 94,
			"}" => -198,
			'OP04_MATH_POW' => 105,
			'OP21_LIST_COMMA' => -198,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107
		}
	},
	{#State 278
		DEFAULT => -202
	},
	{#State 279
		ACTIONS => {
			'KEYS_OR_VALUES' => 119,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			"{" => 67,
			"\@{" => 46,
			'LITERAL' => 47,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			"my" => 115,
			'WORD_SCOPED' => 12,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			"(" => 38
		},
		GOTOS => {
			'HashReference' => 66,
			'Operator' => 37,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 60,
			'ListElements' => 303,
			'Expression' => 122,
			'TypeInner' => 123,
			'ArrayReference' => 62,
			'WordScoped' => 44,
			'Variable' => 86,
			'ListElement' => 120
		}
	},
	{#State 280
		ACTIONS => {
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP23_LOGICAL_AND' => 95,
			".." => 304,
			'OP13_BITWISE_AND' => 92,
			'OP15_LOGICAL_AND' => 101,
			'OP08_STRING_CAT' => 99,
			'OP08_MATH_ADD_SUB' => 91,
			'OP11_COMPARE_LT_GT' => 100,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP06_REGEX_MATCH' => 96,
			'OP04_MATH_POW' => 105
		}
	},
	{#State 281
		DEFAULT => -170
	},
	{#State 282
		ACTIONS => {
			'OP20_HASH_FATARROW' => 305
		}
	},
	{#State 283
		DEFAULT => -31
	},
	{#State 284
		ACTIONS => {
			'LITERAL' => 306
		}
	},
	{#State 285
		DEFAULT => -30
	},
	{#State 286
		DEFAULT => -67
	},
	{#State 287
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 307
		}
	},
	{#State 288
		ACTIONS => {
			"%{" => 45,
			")" => 309,
			'WORD' => 310
		},
		GOTOS => {
			'HashEntryTyped' => 311,
			'HashDereferenced' => 308
		}
	},
	{#State 289
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 312
		}
	},
	{#State 290
		ACTIONS => {
			'VARIABLE_SYMBOL' => 313
		}
	},
	{#State 291
		DEFAULT => -51
	},
	{#State 292
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => 64,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"}" => 314,
			"my" => 58,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			"while (" => -152,
			"(" => 38,
			"if (" => 53,
			'OP19_LOOP_CONTROL' => 51,
			'OP05_MATH_NEG' => 75,
			'OP01_NAMED_VOID' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 73,
			'OP10_NAMED_UNARY' => 71,
			"undef" => 70,
			"foreach my" => -152,
			'OP22_LOGICAL_NOT' => 48,
			'LITERAL' => 47,
			"for my integer" => -152,
			"{" => 67,
			"\@{" => 46
		},
		GOTOS => {
			'OperatorVoid' => 39,
			'PAREN-46' => 40,
			'Operator' => 37,
			'Conditional' => 36,
			'VariableDeclaration' => 52,
			'Statement' => 54,
			'Expression' => 43,
			'ArrayReference' => 62,
			'Variable' => 63,
			'WordScoped' => 44,
			'VariableModification' => 65,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'Operation' => 315,
			'HashReference' => 66,
			'OPTIONAL-47' => 76,
			'LoopLabel' => 72
		}
	},
	{#State 293
		DEFAULT => -211
	},
	{#State 294
		DEFAULT => -173
	},
	{#State 295
		DEFAULT => -171
	},
	{#State 296
		DEFAULT => -159
	},
	{#State 297
		DEFAULT => -162
	},
	{#State 298
		ACTIONS => {
			"{" => 232
		},
		GOTOS => {
			'CodeBlock' => 316
		}
	},
	{#State 299
		DEFAULT => -164
	},
	{#State 300
		ACTIONS => {
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			"(" => 38,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47
		},
		GOTOS => {
			'WordScoped' => 44,
			'Variable' => 86,
			'Expression' => 317,
			'ArrayReference' => 62,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66
		}
	},
	{#State 301
		DEFAULT => -181
	},
	{#State 302
		DEFAULT => -148
	},
	{#State 303
		ACTIONS => {
			")" => 318
		}
	},
	{#State 304
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			'LITERAL' => 47,
			"\@{" => 46,
			"{" => 67,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 11,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP03_MATH_INC_DEC' => 57,
			"(" => 38,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41
		},
		GOTOS => {
			'Operator' => 37,
			'HashReference' => 66,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 60,
			'Variable' => 86,
			'WordScoped' => 44,
			'Expression' => 319,
			'ArrayReference' => 62
		}
	},
	{#State 305
		ACTIONS => {
			'LITERAL' => -39,
			"my" => 115
		},
		GOTOS => {
			'OPTIONAL-14' => 321,
			'TypeInner' => 320
		}
	},
	{#State 306
		DEFAULT => -37,
		GOTOS => {
			'STAR-13' => 322
		}
	},
	{#State 307
		ACTIONS => {
			"1;1;" => 323,
			"our" => 325
		},
		GOTOS => {
			'Method' => 324
		}
	},
	{#State 308
		DEFAULT => -201
	},
	{#State 309
		ACTIONS => {
			";" => 326
		}
	},
	{#State 310
		ACTIONS => {
			'OP20_HASH_FATARROW' => 327
		}
	},
	{#State 311
		DEFAULT => -79,
		GOTOS => {
			'STAR-33' => 328
		}
	},
	{#State 312
		ACTIONS => {
			'LITERAL' => 329
		}
	},
	{#State 313
		DEFAULT => -55,
		GOTOS => {
			'STAR-21' => 330
		}
	},
	{#State 314
		ACTIONS => {
			";" => 331
		}
	},
	{#State 315
		DEFAULT => -50
	},
	{#State 316
		DEFAULT => -161
	},
	{#State 317
		ACTIONS => {
			'OP04_MATH_POW' => 105,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP08_MATH_ADD_SUB' => 91,
			'OP08_STRING_CAT' => 99,
			")" => 332,
			'OP11_COMPARE_LT_GT' => 100,
			'OP15_LOGICAL_AND' => 101,
			'OP13_BITWISE_AND' => 92,
			'OP23_LOGICAL_AND' => 95,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93
		}
	},
	{#State 318
		ACTIONS => {
			"{" => 232
		},
		GOTOS => {
			'CodeBlock' => 333
		}
	},
	{#State 319
		ACTIONS => {
			'OP13_BITWISE_AND' => 92,
			'OP08_MATH_ADD_SUB' => 91,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_STRING_CAT' => 99,
			")" => 334,
			'OP15_LOGICAL_AND' => 101,
			'OP23_LOGICAL_AND' => 95,
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP18_TERNARY' => 103,
			'OP09_BITWISE_SHIFT' => 104,
			'OP04_MATH_POW' => 105,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP06_REGEX_MATCH' => 96,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106
		}
	},
	{#State 320
		DEFAULT => -38
	},
	{#State 321
		ACTIONS => {
			'LITERAL' => 335
		}
	},
	{#State 322
		ACTIONS => {
			'OP21_LIST_COMMA' => 338,
			"]" => 336
		},
		GOTOS => {
			'PAREN-12' => 337
		}
	},
	{#State 323
		ACTIONS => {
			"our" => 42,
			'' => -75,
			"package" => -75
		},
		GOTOS => {
			'Subroutine' => 342,
			'PLUS-29' => 339,
			'PAREN-30' => 341,
			'OPTIONAL-31' => 340
		}
	},
	{#State 324
		DEFAULT => -69
	},
	{#State 325
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 343
		}
	},
	{#State 326
		DEFAULT => -81
	},
	{#State 327
		ACTIONS => {
			"my" => 115
		},
		GOTOS => {
			'TypeInner' => 344
		}
	},
	{#State 328
		ACTIONS => {
			'OP21_LIST_COMMA' => 347,
			")" => 345
		},
		GOTOS => {
			'PAREN-32' => 346
		}
	},
	{#State 329
		ACTIONS => {
			";" => 348
		}
	},
	{#State 330
		ACTIONS => {
			'OP21_LIST_COMMA' => 349,
			")" => 351
		},
		GOTOS => {
			'PAREN-20' => 350
		}
	},
	{#State 331
		DEFAULT => -52
	},
	{#State 332
		ACTIONS => {
			"{" => 232
		},
		GOTOS => {
			'CodeBlock' => 352
		}
	},
	{#State 333
		DEFAULT => -169
	},
	{#State 334
		ACTIONS => {
			"{" => 232
		},
		GOTOS => {
			'CodeBlock' => 353
		}
	},
	{#State 335
		DEFAULT => -44,
		GOTOS => {
			'STAR-17' => 354
		}
	},
	{#State 336
		DEFAULT => -46
	},
	{#State 337
		DEFAULT => -36
	},
	{#State 338
		ACTIONS => {
			'LITERAL' => -34,
			"my" => 115
		},
		GOTOS => {
			'TypeInner' => 355,
			'OPTIONAL-11' => 356
		}
	},
	{#State 339
		ACTIONS => {
			"1;1;" => 357,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 358
		}
	},
	{#State 340
		DEFAULT => -76
	},
	{#State 341
		DEFAULT => -74
	},
	{#State 342
		DEFAULT => -72
	},
	{#State 343
		ACTIONS => {
			'VARIABLE_SYMBOL' => 359
		}
	},
	{#State 344
		ACTIONS => {
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			"(" => 38,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP03_MATH_INC_DEC' => 57
		},
		GOTOS => {
			'HashDereferenced' => 60,
			'WordScoped' => 44,
			'Variable' => 86,
			'ArrayReference' => 62,
			'Expression' => 360,
			'Operator' => 37,
			'HashReference' => 66,
			'ArrayDereferenced' => 68
		}
	},
	{#State 345
		ACTIONS => {
			";" => 361
		}
	},
	{#State 346
		DEFAULT => -78
	},
	{#State 347
		ACTIONS => {
			"%{" => 45,
			'WORD' => 310
		},
		GOTOS => {
			'HashDereferenced' => 308,
			'HashEntryTyped' => 362
		}
	},
	{#State 348
		ACTIONS => {
			"our" => 363
		}
	},
	{#State 349
		ACTIONS => {
			"my" => 364
		}
	},
	{#State 350
		DEFAULT => -54
	},
	{#State 351
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 365
		}
	},
	{#State 352
		DEFAULT => -158
	},
	{#State 353
		DEFAULT => -168
	},
	{#State 354
		ACTIONS => {
			"}" => 366,
			'OP21_LIST_COMMA' => 368
		},
		GOTOS => {
			'PAREN-16' => 367
		}
	},
	{#State 355
		DEFAULT => -33
	},
	{#State 356
		ACTIONS => {
			'LITERAL' => 369
		}
	},
	{#State 357
		DEFAULT => -73
	},
	{#State 358
		DEFAULT => -71
	},
	{#State 359
		ACTIONS => {
			"= sub {" => 370
		}
	},
	{#State 360
		ACTIONS => {
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP21_LIST_COMMA' => -200,
			'OP04_MATH_POW' => 105,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106,
			'OP12_COMPARE_EQ_NEQ' => 98,
			")" => -200,
			'OP08_MATH_ADD_SUB' => 91,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_STRING_CAT' => 99,
			'OP15_LOGICAL_AND' => 101,
			'OP13_BITWISE_AND' => 92,
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => 103,
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP23_LOGICAL_AND' => 95
		}
	},
	{#State 361
		DEFAULT => -80
	},
	{#State 362
		DEFAULT => -77
	},
	{#State 363
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 371
		}
	},
	{#State 364
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 372
		}
	},
	{#State 365
		ACTIONS => {
			"\@_;" => 373
		}
	},
	{#State 366
		DEFAULT => -47
	},
	{#State 367
		DEFAULT => -43
	},
	{#State 368
		ACTIONS => {
			'WORD' => 374
		}
	},
	{#State 369
		DEFAULT => -35
	},
	{#State 370
		ACTIONS => {
			'OP10_NAMED_UNARY' => -83,
			'WORD' => -83,
			'OP10_NAMED_UNARY_STRINGIFY' => -83,
			'OP01_NAMED_VOID' => -83,
			'OP19_LOOP_CONTROL' => -83,
			'OP05_MATH_NEG' => -83,
			'LITERAL' => -83,
			"for my integer" => -83,
			"\@{" => -83,
			"{" => -83,
			"foreach my" => -83,
			'OP22_LOGICAL_NOT' => -83,
			"undef" => -83,
			'WORD_SCOPED' => -83,
			"my" => -83,
			'OP01_NAMED' => -83,
			'VARIABLE_SYMBOL' => -83,
			'OP01_NAMED_VOID_PAREN' => -83,
			"%{" => -83,
			"if (" => -83,
			"( my" => 375,
			"while (" => -83,
			"(" => -83,
			'OP05_LOGICAL_NEG' => -83,
			"[" => -83,
			'OP03_MATH_INC_DEC' => -83
		},
		GOTOS => {
			'MethodArguments' => 376,
			'OPTIONAL-34' => 377
		}
	},
	{#State 371
		ACTIONS => {
			'OPS_SUB' => 378
		}
	},
	{#State 372
		ACTIONS => {
			'VARIABLE_SYMBOL' => 379
		}
	},
	{#State 373
		DEFAULT => -57,
		GOTOS => {
			'STAR-22' => 380
		}
	},
	{#State 374
		ACTIONS => {
			'OP20_HASH_FATARROW' => 381
		}
	},
	{#State 375
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 382
		}
	},
	{#State 376
		DEFAULT => -82
	},
	{#State 377
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			'OP03_MATH_INC_DEC' => 57,
			"if (" => 53,
			"while (" => -152,
			"(" => 38,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED_VOID_PAREN' => 64,
			"%{" => 45,
			'WORD_SCOPED' => 12,
			"my" => 58,
			'OP01_NAMED' => 41,
			'OP22_LOGICAL_NOT' => 48,
			"foreach my" => -152,
			"undef" => 70,
			"for my integer" => -152,
			'LITERAL' => 47,
			"{" => 67,
			"\@{" => 46,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP01_NAMED_VOID' => 49,
			'OP19_LOOP_CONTROL' => 51,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 73
		},
		GOTOS => {
			'OperatorVoid' => 39,
			'PAREN-46' => 40,
			'Operator' => 37,
			'Conditional' => 36,
			'VariableDeclaration' => 52,
			'Statement' => 54,
			'Expression' => 43,
			'ArrayReference' => 62,
			'WordScoped' => 44,
			'Variable' => 63,
			'VariableModification' => 65,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'Operation' => 384,
			'HashReference' => 66,
			'OPTIONAL-47' => 76,
			'PLUS-35' => 383,
			'LoopLabel' => 72
		}
	},
	{#State 378
		ACTIONS => {
			"= sub {" => 385
		},
		GOTOS => {
			'OpsTypesSub' => 386
		}
	},
	{#State 379
		DEFAULT => -53
	},
	{#State 380
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -58,
			'OP01_NAMED_VOID' => -58,
			'OP19_LOOP_CONTROL' => -58,
			'OP05_MATH_NEG' => -58,
			'OP10_NAMED_UNARY' => -58,
			'WORD' => -58,
			'OP22_LOGICAL_NOT' => -58,
			"foreach my" => -58,
			"undef" => -58,
			"for my integer" => -58,
			'LITERAL' => -58,
			"\@{" => -58,
			"{" => -58,
			'VARIABLE_SYMBOL' => -58,
			'OP01_NAMED_VOID_PAREN' => -58,
			"%{" => -58,
			'WORD_SCOPED' => -58,
			"my" => -58,
			'OP01_NAMED' => -58,
			'OP05_LOGICAL_NEG' => -58,
			'CHECK_OR_CHECKTRACE' => 388,
			"[" => -58,
			'OP03_MATH_INC_DEC' => -58,
			"if (" => -58,
			"while (" => -58,
			"(" => -58
		},
		GOTOS => {
			'ArgumentCheck' => 387
		}
	},
	{#State 381
		ACTIONS => {
			"my" => 115,
			'LITERAL' => -41
		},
		GOTOS => {
			'TypeInner' => 390,
			'OPTIONAL-15' => 389
		}
	},
	{#State 382
		DEFAULT => -89,
		GOTOS => {
			'STAR-37' => 391
		}
	},
	{#State 383
		ACTIONS => {
			'OP01_NAMED_VOID' => 49,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'OP05_MATH_NEG' => 75,
			'OP19_LOOP_CONTROL' => 51,
			'OP10_NAMED_UNARY' => 71,
			'WORD' => 73,
			"foreach my" => -152,
			'OP22_LOGICAL_NOT' => 48,
			"undef" => 70,
			"{" => 67,
			"\@{" => 46,
			"for my integer" => -152,
			'LITERAL' => 47,
			'VARIABLE_SYMBOL' => 61,
			"%{" => 45,
			'OP01_NAMED_VOID_PAREN' => 64,
			"}" => 393,
			"my" => 58,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 41,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			'OP03_MATH_INC_DEC' => 57,
			"if (" => 53,
			"(" => 38,
			"while (" => -152
		},
		GOTOS => {
			'Expression' => 43,
			'ArrayReference' => 62,
			'Variable' => 63,
			'WordScoped' => 44,
			'VariableModification' => 65,
			'HashDereferenced' => 60,
			'OperatorVoid' => 39,
			'PAREN-46' => 40,
			'Conditional' => 36,
			'Operator' => 37,
			'VariableDeclaration' => 52,
			'Statement' => 54,
			'OPTIONAL-47' => 76,
			'LoopLabel' => 72,
			'ArrayDereferenced' => 68,
			'Operation' => 392,
			'HashReference' => 66
		}
	},
	{#State 384
		DEFAULT => -85
	},
	{#State 385
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => 394
		}
	},
	{#State 386
		ACTIONS => {
			"our" => 395
		}
	},
	{#State 387
		DEFAULT => -56
	},
	{#State 388
		ACTIONS => {
			"(" => 396
		}
	},
	{#State 389
		ACTIONS => {
			'LITERAL' => 397
		}
	},
	{#State 390
		DEFAULT => -40
	},
	{#State 391
		ACTIONS => {
			")" => 398,
			'OP21_LIST_COMMA' => 400
		},
		GOTOS => {
			'PAREN-36' => 399
		}
	},
	{#State 392
		DEFAULT => -84
	},
	{#State 393
		ACTIONS => {
			";" => 401
		}
	},
	{#State 394
		ACTIONS => {
			'LITERAL' => 402
		}
	},
	{#State 395
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 403
		}
	},
	{#State 396
		ACTIONS => {
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			"(" => 38,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			"{" => 67,
			"\@{" => 46,
			'LITERAL' => 47
		},
		GOTOS => {
			'WordScoped' => 44,
			'Variable' => 86,
			'Expression' => 404,
			'ArrayReference' => 62,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'Operator' => 37,
			'HashReference' => 66
		}
	},
	{#State 397
		DEFAULT => -42
	},
	{#State 398
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 405
		}
	},
	{#State 399
		DEFAULT => -88
	},
	{#State 400
		ACTIONS => {
			"my" => 406
		}
	},
	{#State 401
		DEFAULT => -86
	},
	{#State 402
		ACTIONS => {
			")" => 407
		}
	},
	{#State 403
		ACTIONS => {
			'TYPES_SUB' => 408
		}
	},
	{#State 404
		ACTIONS => {
			'OP21_LIST_COMMA' => 411,
			'OP04_MATH_POW' => 105,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP06_REGEX_MATCH' => 96,
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP13_BITWISE_AND' => 92,
			'OP11_COMPARE_LT_GT' => 100,
			")" => -61,
			'OP08_MATH_ADD_SUB' => 91,
			'OP08_STRING_CAT' => 99,
			'OP15_LOGICAL_AND' => 101,
			'OP23_LOGICAL_AND' => 95,
			'OP17_LIST_RANGE' => 94,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => 103
		},
		GOTOS => {
			'OPTIONAL-24' => 410,
			'PAREN-23' => 409
		}
	},
	{#State 405
		ACTIONS => {
			"\@_;" => 412
		}
	},
	{#State 406
		ACTIONS => {
			'WORD' => 90
		},
		GOTOS => {
			'Type' => 413
		}
	},
	{#State 407
		ACTIONS => {
			";" => 414
		}
	},
	{#State 408
		ACTIONS => {
			"= sub {" => 385
		},
		GOTOS => {
			'OpsTypesSub' => 415
		}
	},
	{#State 409
		DEFAULT => -60
	},
	{#State 410
		ACTIONS => {
			")" => 416
		}
	},
	{#State 411
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 57,
			"[" => 55,
			'OP05_LOGICAL_NEG' => 56,
			"(" => 38,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			"\@{" => 46,
			"{" => 67,
			'LITERAL' => 47,
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71
		},
		GOTOS => {
			'ArrayReference' => 62,
			'Expression' => 417,
			'Variable' => 86,
			'WordScoped' => 44,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37
		}
	},
	{#State 412
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 418
		}
	},
	{#State 413
		ACTIONS => {
			'VARIABLE_SYMBOL' => 419
		}
	},
	{#State 414
		ACTIONS => {
			"}" => 420
		}
	},
	{#State 415
		DEFAULT => -24
	},
	{#State 416
		ACTIONS => {
			";" => 421
		}
	},
	{#State 417
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 98,
			'OP16_LOGICAL_OR' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP21_LIST_COMMA' => 422,
			'OP04_MATH_POW' => 105,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP23_LOGICAL_AND' => 95,
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => 103,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => 94,
			'OP15_LOGICAL_AND' => 101,
			'OP08_STRING_CAT' => 99,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_MATH_ADD_SUB' => 91,
			'OP13_BITWISE_AND' => 92
		}
	},
	{#State 418
		ACTIONS => {
			"undef" => -92,
			'OP22_LOGICAL_NOT' => -92,
			"foreach my" => -92,
			"\@{" => -92,
			"{" => -92,
			"for my integer" => -92,
			'LITERAL' => -92,
			'OP05_MATH_NEG' => -92,
			'OP19_LOOP_CONTROL' => -92,
			'OP10_NAMED_UNARY_STRINGIFY' => -92,
			'OP01_NAMED_VOID' => -92,
			'WORD' => -92,
			'OP10_NAMED_UNARY' => -92,
			'OP03_MATH_INC_DEC' => -92,
			"[" => -92,
			'CHECK_OR_CHECKTRACE' => 388,
			'OP05_LOGICAL_NEG' => -92,
			"(" => -92,
			"while (" => -92,
			"if (" => -92,
			"%{" => -92,
			'OP01_NAMED_VOID_PAREN' => -92,
			'VARIABLE_SYMBOL' => -92,
			'OP01_NAMED' => -92,
			"my" => -92,
			'WORD_SCOPED' => -92
		},
		GOTOS => {
			'ArgumentCheck' => 423
		}
	},
	{#State 419
		DEFAULT => -87
	},
	{#State 420
		ACTIONS => {
			";" => 424
		}
	},
	{#State 421
		DEFAULT => -62
	},
	{#State 422
		ACTIONS => {
			'OP05_MATH_NEG' => 75,
			'OP10_NAMED_UNARY_STRINGIFY' => 74,
			'WORD' => 11,
			'OP10_NAMED_UNARY' => 71,
			"undef" => 70,
			'OP22_LOGICAL_NOT' => 48,
			'LITERAL' => 47,
			"\@{" => 46,
			"{" => 67,
			"%{" => 45,
			'VARIABLE_SYMBOL' => 61,
			'OP01_NAMED' => 41,
			'WORD_SCOPED' => 12,
			'OP03_MATH_INC_DEC' => 57,
			'OP05_LOGICAL_NEG' => 56,
			"[" => 55,
			"(" => 38
		},
		GOTOS => {
			'ArrayReference' => 62,
			'Expression' => 425,
			'WordScoped' => 44,
			'Variable' => 86,
			'HashDereferenced' => 60,
			'ArrayDereferenced' => 68,
			'HashReference' => 66,
			'Operator' => 37
		}
	},
	{#State 423
		DEFAULT => -90
	},
	{#State 424
		DEFAULT => -25
	},
	{#State 425
		ACTIONS => {
			")" => -59,
			'OP08_MATH_ADD_SUB' => 91,
			'OP11_COMPARE_LT_GT' => 100,
			'OP08_STRING_CAT' => 99,
			'OP15_LOGICAL_AND' => 101,
			'OP13_BITWISE_AND' => 92,
			'OP09_BITWISE_SHIFT' => 104,
			'OP18_TERNARY' => 103,
			'OP14_BITWISE_OR_XOR' => 93,
			'OP17_LIST_RANGE' => 94,
			'OP23_LOGICAL_AND' => 95,
			'OP06_REGEX_MATCH' => 96,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP04_MATH_POW' => 105,
			'OP07_MATH_MULT_DIV_MOD' => 107,
			'OP16_LOGICAL_OR' => 106,
			'OP12_COMPARE_EQ_NEQ' => 98
		}
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
