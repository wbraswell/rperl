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
    our $VERSION = 0.000_702;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G(\s*(\#.+)*\s*)+/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|our\ \$VERSION\ \=|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\=\ sub\ \{|elsif\ \(|package|while\ \(|\$TYPED_|undef|1\,\ 1\;|\(\ my|if\ \(|else|qw\(|\@_\;|use|our|my|\%\{|\@\{|\.\.|\{\*|\}|\[|\]|\(|\/|\{|\;|\))}gc and return ($1, $1);

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
  [ 'Package_26' => 'Package', [ 'package', 'WordScoped', ';', 'Header', 'STAR-7', 'STAR-8', 'STAR-9', 'PLUS-10', '1, 1;' ], 0 ],
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
  [ '_PAREN' => 'PAREN-15', [ 'OP21_LIST_COMMA', 'OPTIONAL-14', 'LITERAL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-16', [ 'STAR-16', 'PAREN-15' ], 0 ],
  [ '_STAR_LIST' => 'STAR-16', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [  ], 0 ],
  [ '_PAREN' => 'PAREN-19', [ 'OP21_LIST_COMMA', 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-18', 'LITERAL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [ 'STAR-20', 'PAREN-19' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [  ], 0 ],
  [ 'ConstantValue_50' => 'ConstantValue', [ 'LITERAL' ], 0 ],
  [ 'ConstantValue_51' => 'ConstantValue', [ '[', 'OPTIONAL-13', 'LITERAL', 'STAR-16', ']' ], 0 ],
  [ 'ConstantValue_52' => 'ConstantValue', [ '{', 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-17', 'LITERAL', 'STAR-20', '}' ], 0 ],
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
  [ '_PAREN' => 'PAREN-33', [ 'PLUS-32', '1, 1;' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'PAREN-33' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ 'Class_81' => 'Class', [ 'package', 'WordScoped', ';', 'Header', 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-28', 'STAR-29', 'STAR-30', 'Properties', 'STAR-31', '1, 1;', 'OPTIONAL-34' ], 0 ],
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
  [ 'Expression_144' => 'Expression', [ 'LITERAL' ], 0 ],
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
  [ 'TypeInner_216' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Type_217' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_218' => 'LoopLabel', [ 'WORD' ], 0 ],
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
  'TypeInner_216' => 216,
  'Type_217' => 217,
  'LoopLabel_218' => 218,
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
	'1, 1;' => { ISSEMANTIC => 0 },
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
			'SHEBANG' => 7,
			"package" => 5
		},
		GOTOS => {
			'Module' => 2,
			'CompileUnit' => 8,
			'Package' => 3,
			'Program' => 6,
			'Class' => 4,
			'PLUS-1' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'' => -4,
			"package" => 5
		},
		GOTOS => {
			'Class' => 4,
			'Module' => 9,
			'Package' => 3
		}
	},
	{#State 2
		DEFAULT => -2
	},
	{#State 3
		DEFAULT => -16
	},
	{#State 4
		DEFAULT => -17
	},
	{#State 5
		ACTIONS => {
			'WORD_SCOPED' => 10,
			'WORD' => 11
		},
		GOTOS => {
			'WordScoped' => 12
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		ACTIONS => {
			"use strict;" => 14
		},
		GOTOS => {
			'Header' => 13
		}
	},
	{#State 8
		ACTIONS => {
			'' => 15
		}
	},
	{#State 9
		DEFAULT => -1
	},
	{#State 10
		DEFAULT => -214
	},
	{#State 11
		DEFAULT => -213
	},
	{#State 12
		ACTIONS => {
			";" => 16
		}
	},
	{#State 13
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 17
		}
	},
	{#State 14
		ACTIONS => {
			"use warnings;" => 18
		}
	},
	{#State 15
		DEFAULT => 0
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
			'OP01_NAMED_VOID' => -8,
			"undef" => -8,
			"use constant" => -8,
			'WORD_SCOPED' => -8,
			'WORD' => -8,
			'OP22_LOGICAL_NOT' => -8,
			"use" => -8,
			"{" => -8,
			'LITERAL' => -8,
			"\@{" => -8,
			"while (" => -8,
			"foreach my" => -8,
			'OP10_NAMED_UNARY' => -8,
			'VARIABLE_SYMBOL' => -8,
			'OP05_LOGICAL_NEG' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			"our" => -8,
			'OP05_MATH_NEG' => -8,
			"for my integer" => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"[" => -8,
			'OP03_MATH_INC_DEC' => -8,
			"(" => -8,
			"## no critic qw(" => 22,
			'OP01_NAMED' => -8,
			"%{" => -8,
			'OP19_LOOP_CONTROL' => -8,
			"my" => -8,
			"if (" => -8
		},
		GOTOS => {
			'STAR-3' => 21,
			'Critic' => 20
		}
	},
	{#State 18
		ACTIONS => {
			"use RPerl;" => 23
		}
	},
	{#State 19
		ACTIONS => {
			"use" => -19,
			"use constant" => -19,
			"our" => -19,
			"use parent qw(" => 25,
			"## no critic qw(" => -19
		},
		GOTOS => {
			'STAR-7' => 24
		}
	},
	{#State 20
		DEFAULT => -5
	},
	{#State 21
		ACTIONS => {
			"undef" => -10,
			'OP01_NAMED_VOID' => -10,
			'OP22_LOGICAL_NOT' => -10,
			"use constant" => -10,
			'WORD' => -10,
			'WORD_SCOPED' => -10,
			"use" => 26,
			"{" => -10,
			'LITERAL' => -10,
			"while (" => -10,
			"\@{" => -10,
			'OP10_NAMED_UNARY' => -10,
			"foreach my" => -10,
			'VARIABLE_SYMBOL' => -10,
			'OP05_MATH_NEG' => -10,
			"our" => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			'OP05_LOGICAL_NEG' => -10,
			"for my integer" => -10,
			'OP03_MATH_INC_DEC' => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"[" => -10,
			"(" => -10,
			"%{" => -10,
			'OP01_NAMED' => -10,
			"my" => -10,
			'OP19_LOOP_CONTROL' => -10,
			"if (" => -10
		},
		GOTOS => {
			'Include' => 28,
			'STAR-4' => 27
		}
	},
	{#State 22
		ACTIONS => {
			'WORD' => 29
		},
		GOTOS => {
			'PLUS-11' => 30
		}
	},
	{#State 23
		ACTIONS => {
			"our \$VERSION =" => 31
		}
	},
	{#State 24
		ACTIONS => {
			"use" => -21,
			"use constant" => -21,
			"our" => -21,
			"## no critic qw(" => 22
		},
		GOTOS => {
			'STAR-8' => 33,
			'Critic' => 32
		}
	},
	{#State 25
		ACTIONS => {
			'WORD' => 11,
			'WORD_SCOPED' => 10
		},
		GOTOS => {
			'WordScoped' => 34
		}
	},
	{#State 26
		ACTIONS => {
			'WORD_SCOPED' => 10,
			'WORD' => 11
		},
		GOTOS => {
			'WordScoped' => 35
		}
	},
	{#State 27
		ACTIONS => {
			'VARIABLE_SYMBOL' => -12,
			'OP05_LOGICAL_NEG' => -12,
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			"our" => -12,
			'OP05_MATH_NEG' => -12,
			"for my integer" => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			"[" => -12,
			'OP03_MATH_INC_DEC' => -12,
			"(" => -12,
			'OP01_NAMED' => -12,
			"%{" => -12,
			'OP19_LOOP_CONTROL' => -12,
			"my" => -12,
			"if (" => -12,
			'OP01_NAMED_VOID' => -12,
			"undef" => -12,
			'WORD' => -12,
			'WORD_SCOPED' => -12,
			"use constant" => 36,
			'OP22_LOGICAL_NOT' => -12,
			"{" => -12,
			'LITERAL' => -12,
			"\@{" => -12,
			"while (" => -12,
			'OP10_NAMED_UNARY' => -12,
			"foreach my" => -12
		},
		GOTOS => {
			'Constant' => 37,
			'STAR-5' => 38
		}
	},
	{#State 28
		DEFAULT => -7
	},
	{#State 29
		DEFAULT => -29
	},
	{#State 30
		ACTIONS => {
			")" => 39,
			'WORD' => 40
		}
	},
	{#State 31
		ACTIONS => {
			'VERSION_NUMBER' => 41
		}
	},
	{#State 32
		DEFAULT => -18
	},
	{#State 33
		ACTIONS => {
			"use constant" => -23,
			"use" => 26,
			"our" => -23
		},
		GOTOS => {
			'STAR-9' => 42,
			'Include' => 43
		}
	},
	{#State 34
		ACTIONS => {
			")" => 44
		}
	},
	{#State 35
		ACTIONS => {
			";" => 45,
			"qw(" => 46
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 47
		}
	},
	{#State 37
		DEFAULT => -9
	},
	{#State 38
		ACTIONS => {
			"while (" => -157,
			"\@{" => 52,
			"foreach my" => -157,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 72,
			"undef" => 67,
			'OP01_NAMED_VOID' => 70,
			"my" => 77,
			'OP19_LOOP_CONTROL' => 78,
			"if (" => 79,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"for my integer" => -157,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED_VOID_PAREN' => 62,
			"[" => 88,
			'VARIABLE_SYMBOL' => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"our" => 82,
			'OP05_MATH_NEG' => 58,
			'OP05_LOGICAL_NEG' => 60
		},
		GOTOS => {
			'Subroutine' => 53,
			'Statement' => 69,
			'VariableModification' => 68,
			'OPTIONAL-50' => 64,
			'Expression' => 48,
			'PLUS-6' => 63,
			'Conditional' => 65,
			'OperatorVoid' => 51,
			'Operation' => 81,
			'LoopLabel' => 80,
			'PAREN-49' => 83,
			'Operator' => 84,
			'Variable' => 85,
			'WordScoped' => 87,
			'HashReference' => 61,
			'HashDereferenced' => 74,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'VariableDeclaration' => 54
		}
	},
	{#State 39
		DEFAULT => -30
	},
	{#State 40
		DEFAULT => -28
	},
	{#State 41
		ACTIONS => {
			";" => 89
		}
	},
	{#State 42
		ACTIONS => {
			"use constant" => 36,
			"our" => 82
		},
		GOTOS => {
			'PLUS-10' => 91,
			'Constant' => 90,
			'Subroutine' => 92
		}
	},
	{#State 43
		DEFAULT => -20
	},
	{#State 44
		ACTIONS => {
			";" => 93
		}
	},
	{#State 45
		DEFAULT => -33
	},
	{#State 46
		ACTIONS => {
			'WORD' => 94
		},
		GOTOS => {
			'PLUS-12' => 95
		}
	},
	{#State 47
		ACTIONS => {
			'OP20_HASH_FATARROW' => 96
		}
	},
	{#State 48
		ACTIONS => {
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			";" => 105,
			'OP15_LOGICAL_AND' => 112,
			'OP08_MATH_ADD_SUB' => 106,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => 107,
			'OP08_STRING_CAT' => 113,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP17_LIST_RANGE' => 99,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP09_BITWISE_SHIFT' => 100,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP13_BITWISE_AND' => 101
		}
	},
	{#State 49
		ACTIONS => {
			"}" => 116,
			'WORD' => 117,
			"%{" => 75
		},
		GOTOS => {
			'HashEntry' => 114,
			'HashDereferenced' => 115
		}
	},
	{#State 50
		DEFAULT => -144
	},
	{#State 51
		DEFAULT => -160
	},
	{#State 52
		ACTIONS => {
			'VARIABLE_SYMBOL' => 57,
			"[" => 88
		},
		GOTOS => {
			'Variable' => 119,
			'ArrayReference' => 118
		}
	},
	{#State 53
		DEFAULT => -11
	},
	{#State 54
		DEFAULT => -161
	},
	{#State 55
		ACTIONS => {
			"(" => 120
		}
	},
	{#State 56
		DEFAULT => -146
	},
	{#State 57
		DEFAULT => -180,
		GOTOS => {
			'STAR-56' => 121
		}
	},
	{#State 58
		ACTIONS => {
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 57,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			"undef" => 67,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50
		},
		GOTOS => {
			'Operator' => 84,
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61,
			'HashDereferenced' => 74,
			'Expression' => 122,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76
		}
	},
	{#State 59
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'OP05_LOGICAL_NEG' => 60,
			'VARIABLE_SYMBOL' => 57,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"(" => 73,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52
		},
		GOTOS => {
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'Expression' => 124,
			'HashDereferenced' => 74,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Variable' => 123,
			'Operator' => 84
		}
	},
	{#State 60
		ACTIONS => {
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 60,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'VARIABLE_SYMBOL' => 57,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			"undef" => 67,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71
		},
		GOTOS => {
			'Operator' => 84,
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61,
			'HashDereferenced' => 74,
			'Expression' => 125,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76
		}
	},
	{#State 61
		DEFAULT => -148
	},
	{#State 62
		ACTIONS => {
			"undef" => 67,
			"{*" => 134,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			'VARIABLE_SYMBOL' => 57,
			'KEYS_OR_VALUES' => 132,
			'OP05_LOGICAL_NEG' => 60,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75,
			")" => -127,
			"my" => 131
		},
		GOTOS => {
			'Variable' => 123,
			'FileHandle' => 129,
			'HashReference' => 61,
			'WordScoped' => 87,
			'OPTIONAL-43' => 128,
			'ListElements' => 127,
			'Operator' => 84,
			'Expression' => 133,
			'ListElement' => 130,
			'HashDereferenced' => 74,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'TypeInner' => 126
		}
	},
	{#State 63
		ACTIONS => {
			'WORD_SCOPED' => 10,
			'WORD' => 72,
			'OP22_LOGICAL_NOT' => 71,
			'OP01_NAMED_VOID' => 70,
			"undef" => 67,
			"\@{" => 52,
			"while (" => -157,
			'OP10_NAMED_UNARY' => 66,
			"foreach my" => -157,
			"{" => 49,
			'LITERAL' => 50,
			"for my integer" => -157,
			"[" => 88,
			'OP01_NAMED_VOID_PAREN' => 62,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 57,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'OP19_LOOP_CONTROL' => 78,
			"my" => 77,
			'' => -15,
			"if (" => 79,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75
		},
		GOTOS => {
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 85,
			'PAREN-49' => 83,
			'Operator' => 84,
			'LoopLabel' => 80,
			'Operation' => 135,
			'ArrayReference' => 56,
			'VariableDeclaration' => 54,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'VariableModification' => 68,
			'Statement' => 69,
			'Conditional' => 65,
			'OperatorVoid' => 51,
			'OPTIONAL-50' => 64,
			'Expression' => 48
		}
	},
	{#State 64
		ACTIONS => {
			"while (" => 138,
			"for my integer" => 142,
			"foreach my" => 139
		},
		GOTOS => {
			'LoopFor' => 141,
			'Loop' => 136,
			'LoopWhile' => 140,
			'LoopForEach' => 137
		}
	},
	{#State 65
		DEFAULT => -158
	},
	{#State 66
		ACTIONS => {
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'VARIABLE_SYMBOL' => 57,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			"undef" => 67
		},
		GOTOS => {
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 143,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'Operator' => 84
		}
	},
	{#State 67
		DEFAULT => -143
	},
	{#State 68
		DEFAULT => -162
	},
	{#State 69
		DEFAULT => -99
	},
	{#State 70
		ACTIONS => {
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			"{*" => 134,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			";" => -131,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"(" => 73,
			"my" => 131,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'KEYS_OR_VALUES' => 132,
			'OP05_LOGICAL_NEG' => 60,
			'VARIABLE_SYMBOL' => 57,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88
		},
		GOTOS => {
			'OPTIONAL-45' => 146,
			'ArrayReference' => 56,
			'TypeInner' => 126,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'ListElement' => 130,
			'Expression' => 133,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'FileHandle' => 145,
			'Operator' => 84,
			'ListElements' => 144
		}
	},
	{#State 71
		ACTIONS => {
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 71,
			"undef" => 67,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 57,
			'OP05_LOGICAL_NEG' => 60,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75
		},
		GOTOS => {
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 147,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'Operator' => 84
		}
	},
	{#State 72
		ACTIONS => {
			"(" => -213,
			'COLON' => -218
		}
	},
	{#State 73
		ACTIONS => {
			"%{" => 75,
			'OP01_NAMED' => 55,
			"(" => 73,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			'VARIABLE_SYMBOL' => 57,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			'LITERAL' => 50,
			"{" => 49,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			"undef" => 67
		},
		GOTOS => {
			'Operator' => 84,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 148
		}
	},
	{#State 74
		DEFAULT => -149
	},
	{#State 75
		ACTIONS => {
			'VARIABLE_SYMBOL' => 57,
			"{" => 150
		},
		GOTOS => {
			'Variable' => 149,
			'HashReference' => 151
		}
	},
	{#State 76
		DEFAULT => -147
	},
	{#State 77
		ACTIONS => {
			'WORD' => 152
		},
		GOTOS => {
			'Type' => 153
		}
	},
	{#State 78
		ACTIONS => {
			'WORD' => 155
		},
		GOTOS => {
			'LoopLabel' => 154
		}
	},
	{#State 79
		ACTIONS => {
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			"undef" => 67,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'VARIABLE_SYMBOL' => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'OP05_LOGICAL_NEG' => 60
		},
		GOTOS => {
			'HashDereferenced' => 74,
			'Expression' => 156,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'Operator' => 84,
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61
		}
	},
	{#State 80
		ACTIONS => {
			'COLON' => 157
		}
	},
	{#State 81
		DEFAULT => -14
	},
	{#State 82
		ACTIONS => {
			'WORD' => 152
		},
		GOTOS => {
			'Type' => 158
		}
	},
	{#State 83
		DEFAULT => -156
	},
	{#State 84
		DEFAULT => -151
	},
	{#State 85
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP18_TERNARY' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP03_MATH_INC_DEC' => 159,
			'OP17_LIST_RANGE' => -145,
			'OP08_STRING_CAT' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 160,
			'OP11_COMPARE_LT_GT' => -145,
			'OP04_MATH_POW' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP19_VARIABLE_ASSIGN' => 161,
			'OP02_METHOD_THINARROW' => 162,
			";" => -145
		}
	},
	{#State 86
		ACTIONS => {
			'VARIABLE_SYMBOL' => 57
		},
		GOTOS => {
			'Variable' => 163
		}
	},
	{#State 87
		ACTIONS => {
			"(" => 164
		}
	},
	{#State 88
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 60,
			'KEYS_OR_VALUES' => 132,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'VARIABLE_SYMBOL' => 57,
			"]" => -197,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73,
			"my" => 131,
			"undef" => 67,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52
		},
		GOTOS => {
			'ListElements' => 166,
			'Operator' => 84,
			'Variable' => 123,
			'HashReference' => 61,
			'WordScoped' => 87,
			'ListElement' => 130,
			'Expression' => 133,
			'HashDereferenced' => 74,
			'ArrayDereferenced' => 76,
			'OPTIONAL-59' => 165,
			'ArrayReference' => 56,
			'TypeInner' => 126
		}
	},
	{#State 89
		DEFAULT => -27
	},
	{#State 90
		DEFAULT => -22
	},
	{#State 91
		ACTIONS => {
			"1, 1;" => 168,
			"our" => 82
		},
		GOTOS => {
			'Subroutine' => 167
		}
	},
	{#State 92
		DEFAULT => -25
	},
	{#State 93
		ACTIONS => {
			"use" => 26
		},
		GOTOS => {
			'Include' => 169
		}
	},
	{#State 94
		DEFAULT => -32
	},
	{#State 95
		ACTIONS => {
			'WORD' => 170,
			")" => 171
		}
	},
	{#State 96
		ACTIONS => {
			"my" => 131
		},
		GOTOS => {
			'TypeInner' => 172
		}
	},
	{#State 97
		ACTIONS => {
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			"undef" => 67,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'VARIABLE_SYMBOL' => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'OP05_LOGICAL_NEG' => 60
		},
		GOTOS => {
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 173,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'Operator' => 84
		}
	},
	{#State 98
		ACTIONS => {
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 57,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 71,
			"undef" => 67
		},
		GOTOS => {
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Operator' => 84,
			'HashDereferenced' => 74,
			'Expression' => 174,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76
		}
	},
	{#State 99
		ACTIONS => {
			'VARIABLE_SYMBOL' => 57,
			'OP05_LOGICAL_NEG' => 60,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"undef" => 67,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'HashDereferenced' => 74,
			'Expression' => 175,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Operator' => 84
		}
	},
	{#State 100
		ACTIONS => {
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			"undef" => 67,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 57,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75
		},
		GOTOS => {
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 176,
			'Operator' => 84,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123
		}
	},
	{#State 101
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 60,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'VARIABLE_SYMBOL' => 57,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73,
			"undef" => 67,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52
		},
		GOTOS => {
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 177,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'Operator' => 84
		}
	},
	{#State 102
		ACTIONS => {
			"undef" => 67,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'VARIABLE_SYMBOL' => 57,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73
		},
		GOTOS => {
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'Expression' => 178,
			'HashDereferenced' => 74,
			'Operator' => 84,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Variable' => 123
		}
	},
	{#State 103
		ACTIONS => {
			"%{" => 75,
			'OP01_NAMED' => 55,
			"(" => 73,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'OP05_LOGICAL_NEG' => 60,
			'VARIABLE_SYMBOL' => 57,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			'LITERAL' => 50,
			"{" => 49,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			"undef" => 67
		},
		GOTOS => {
			'Operator' => 84,
			'Variable' => 123,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Expression' => 179,
			'HashDereferenced' => 74,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56
		}
	},
	{#State 104
		ACTIONS => {
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			"undef" => 67,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 60,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'VARIABLE_SYMBOL' => 57,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86
		},
		GOTOS => {
			'HashReference' => 61,
			'WordScoped' => 87,
			'Variable' => 123,
			'Operator' => 84,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'Expression' => 180,
			'HashDereferenced' => 74
		}
	},
	{#State 105
		DEFAULT => -98
	},
	{#State 106
		ACTIONS => {
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			'VARIABLE_SYMBOL' => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'OP05_LOGICAL_NEG' => 60,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 11
		},
		GOTOS => {
			'Expression' => 181,
			'HashDereferenced' => 74,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'Operator' => 84,
			'Variable' => 123,
			'HashReference' => 61,
			'WordScoped' => 87
		}
	},
	{#State 107
		ACTIONS => {
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			'VARIABLE_SYMBOL' => 57,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10
		},
		GOTOS => {
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'Expression' => 182,
			'HashDereferenced' => 74,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Variable' => 123,
			'Operator' => 84
		}
	},
	{#State 108
		ACTIONS => {
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			'VARIABLE_SYMBOL' => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'OP05_LOGICAL_NEG' => 60,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10
		},
		GOTOS => {
			'Operator' => 84,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 183
		}
	},
	{#State 109
		ACTIONS => {
			'VARIABLE_SYMBOL' => 57
		},
		GOTOS => {
			'Variable' => 184
		}
	},
	{#State 110
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			'LITERAL' => 50,
			"{" => 49,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			"undef" => 67,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"(" => 73,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			'VARIABLE_SYMBOL' => 57
		},
		GOTOS => {
			'Expression' => 185,
			'HashDereferenced' => 74,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'Variable' => 123,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Operator' => 84
		}
	},
	{#State 111
		ACTIONS => {
			"/" => 186
		}
	},
	{#State 112
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'VARIABLE_SYMBOL' => 57,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73,
			"undef" => 67,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52
		},
		GOTOS => {
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'Operator' => 84,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 187
		}
	},
	{#State 113
		ACTIONS => {
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'VARIABLE_SYMBOL' => 57,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			'LITERAL' => 50,
			"{" => 49,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 71,
			"undef" => 67
		},
		GOTOS => {
			'Expression' => 188,
			'HashDereferenced' => 74,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'Operator' => 84,
			'Variable' => 123,
			'HashReference' => 61,
			'WordScoped' => 87
		}
	},
	{#State 114
		DEFAULT => -209,
		GOTOS => {
			'STAR-62' => 189
		}
	},
	{#State 115
		DEFAULT => -204
	},
	{#State 116
		DEFAULT => -150
	},
	{#State 117
		ACTIONS => {
			'OP20_HASH_FATARROW' => 190
		}
	},
	{#State 118
		ACTIONS => {
			"}" => 191
		}
	},
	{#State 119
		ACTIONS => {
			"}" => 192
		}
	},
	{#State 120
		ACTIONS => {
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73,
			"my" => 131,
			")" => -101,
			'KEYS_OR_VALUES' => 132,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'VARIABLE_SYMBOL' => 57,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			"undef" => 67,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71
		},
		GOTOS => {
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'OPTIONAL-42' => 193,
			'Operator' => 84,
			'ListElements' => 194,
			'ArrayReference' => 56,
			'TypeInner' => 126,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'ListElement' => 130,
			'Expression' => 133
		}
	},
	{#State 121
		ACTIONS => {
			'OP02_METHOD_THINARROW' => -181,
			";" => -181,
			'OP19_VARIABLE_ASSIGN' => -181,
			'OP15_LOGICAL_AND' => -181,
			'OP04_MATH_POW' => -181,
			'OP11_COMPARE_LT_GT' => -181,
			"}" => -181,
			'OP19_VARIABLE_ASSIGN_BY' => -181,
			'OP08_MATH_ADD_SUB' => -181,
			'OP14_BITWISE_OR_XOR' => -181,
			'OP23_LOGICAL_AND' => -181,
			'OP08_STRING_CAT' => -181,
			'OP17_LIST_RANGE' => -181,
			'OP03_MATH_INC_DEC' => -181,
			'OP16_LOGICAL_OR' => -181,
			'OP07_MATH_MULT_DIV_MOD' => -181,
			"]" => -181,
			'OP18_TERNARY' => -181,
			'OP24_LOGICAL_OR_XOR' => -181,
			'OP02_HASH_THINARROW' => 195,
			".." => -181,
			'OP06_REGEX_MATCH' => -181,
			")" => -181,
			'OP12_COMPARE_EQ_NEQ' => -181,
			'OP13_BITWISE_AND' => -181,
			'OP09_BITWISE_SHIFT' => -181,
			'COLON' => -181,
			'OP21_LIST_COMMA' => -181,
			'OP02_ARRAY_THINARROW' => 196
		},
		GOTOS => {
			'VariableRetrieval' => 197
		}
	},
	{#State 122
		ACTIONS => {
			'OP15_LOGICAL_AND' => 112,
			'OP11_COMPARE_LT_GT' => 103,
			'OP04_MATH_POW' => 104,
			'OP08_STRING_CAT' => 113,
			'OP08_MATH_ADD_SUB' => 106,
			'OP23_LOGICAL_AND' => 107,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP17_LIST_RANGE' => 99,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP18_TERNARY' => 109,
			'OP13_BITWISE_AND' => 101,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP06_REGEX_MATCH' => 111,
			")" => 198,
			'OP09_BITWISE_SHIFT' => 100
		}
	},
	{#State 123
		ACTIONS => {
			'OP04_MATH_POW' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			";" => -145,
			'OP02_METHOD_THINARROW' => 162,
			'OP15_LOGICAL_AND' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP08_STRING_CAT' => -145,
			"}" => -145,
			'OP18_TERNARY' => -145,
			"]" => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP03_MATH_INC_DEC' => 159,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP21_LIST_COMMA' => -145,
			".." => -145,
			'OP06_REGEX_MATCH' => -145,
			")" => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP13_BITWISE_AND' => -145
		}
	},
	{#State 124
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => -114,
			'OP13_BITWISE_AND' => -114,
			".." => -114,
			")" => -114,
			'OP12_COMPARE_EQ_NEQ' => -114,
			'OP06_REGEX_MATCH' => 111,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP18_TERNARY' => -114,
			"]" => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP17_LIST_RANGE' => -114,
			'OP08_STRING_CAT' => 113,
			'OP08_MATH_ADD_SUB' => 106,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP23_LOGICAL_AND' => -114,
			"}" => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP04_MATH_POW' => 104,
			'OP15_LOGICAL_AND' => -114,
			";" => -114
		}
	},
	{#State 125
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP18_TERNARY' => -106,
			"]" => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP13_BITWISE_AND' => -106,
			".." => -106,
			")" => -106,
			'OP06_REGEX_MATCH' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP04_MATH_POW' => 104,
			'OP15_LOGICAL_AND' => -106,
			";" => -106,
			'OP08_STRING_CAT' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP23_LOGICAL_AND' => -106,
			"}" => -106
		}
	},
	{#State 126
		ACTIONS => {
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			'VARIABLE_SYMBOL' => 57,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88
		},
		GOTOS => {
			'HashDereferenced' => 74,
			'Expression' => 199,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'Operator' => 84,
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61
		}
	},
	{#State 127
		DEFAULT => -126
	},
	{#State 128
		ACTIONS => {
			")" => 200
		}
	},
	{#State 129
		ACTIONS => {
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			"undef" => 67,
			")" => -129,
			"my" => 131,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 57,
			'KEYS_OR_VALUES' => 132,
			'OP05_LOGICAL_NEG' => 60,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59
		},
		GOTOS => {
			'Variable' => 123,
			'OPTIONAL-44' => 202,
			'HashReference' => 61,
			'WordScoped' => 87,
			'ListElements' => 201,
			'Operator' => 84,
			'Expression' => 133,
			'ListElement' => 130,
			'HashDereferenced' => 74,
			'ArrayDereferenced' => 76,
			'TypeInner' => 126,
			'ArrayReference' => 56
		}
	},
	{#State 130
		DEFAULT => -191,
		GOTOS => {
			'STAR-58' => 203
		}
	},
	{#State 131
		ACTIONS => {
			'WORD' => 152
		},
		GOTOS => {
			'Type' => 204
		}
	},
	{#State 132
		ACTIONS => {
			"%{" => 75
		},
		GOTOS => {
			'HashDereferenced' => 205
		}
	},
	{#State 133
		ACTIONS => {
			'OP17_LIST_RANGE' => 99,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP18_TERNARY' => 109,
			"]" => -193,
			'OP24_LOGICAL_OR_XOR' => 97,
			")" => -193,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP06_REGEX_MATCH' => 111,
			'OP13_BITWISE_AND' => 101,
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => -193,
			";" => -193,
			'OP15_LOGICAL_AND' => 112,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			'OP08_MATH_ADD_SUB' => 106,
			'OP23_LOGICAL_AND' => 107,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP08_STRING_CAT' => 113
		}
	},
	{#State 134
		ACTIONS => {
			'WORD' => 206
		}
	},
	{#State 135
		DEFAULT => -13
	},
	{#State 136
		DEFAULT => -159
	},
	{#State 137
		DEFAULT => -171
	},
	{#State 138
		ACTIONS => {
			'VARIABLE_SYMBOL' => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'OP05_LOGICAL_NEG' => 60,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'Expression' => 207,
			'HashDereferenced' => 74,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'Variable' => 123,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Operator' => 84
		}
	},
	{#State 139
		ACTIONS => {
			'WORD' => 152
		},
		GOTOS => {
			'Type' => 208
		}
	},
	{#State 140
		DEFAULT => -172
	},
	{#State 141
		DEFAULT => -170
	},
	{#State 142
		ACTIONS => {
			'VARIABLE_SYMBOL' => 209
		}
	},
	{#State 143
		ACTIONS => {
			'OP17_LIST_RANGE' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP18_TERNARY' => -113,
			"]" => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			")" => -113,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => -113,
			".." => -113,
			'OP13_BITWISE_AND' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP09_BITWISE_SHIFT' => 100,
			";" => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => -113,
			"}" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP08_MATH_ADD_SUB' => 106,
			'OP08_STRING_CAT' => 113
		}
	},
	{#State 144
		DEFAULT => -130
	},
	{#State 145
		ACTIONS => {
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			";" => -133,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			'KEYS_OR_VALUES' => 132,
			'VARIABLE_SYMBOL' => 57,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"(" => 73,
			"my" => 131
		},
		GOTOS => {
			'ListElements' => 210,
			'Operator' => 84,
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61,
			'HashDereferenced' => 74,
			'Expression' => 133,
			'ListElement' => 130,
			'TypeInner' => 126,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'OPTIONAL-46' => 211
		}
	},
	{#State 146
		ACTIONS => {
			";" => 212
		}
	},
	{#State 147
		ACTIONS => {
			"}" => -123,
			'OP08_MATH_ADD_SUB' => 106,
			'OP23_LOGICAL_AND' => -123,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP08_STRING_CAT' => 113,
			";" => -123,
			'OP15_LOGICAL_AND' => 112,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			".." => -123,
			")" => -123,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP06_REGEX_MATCH' => 111,
			'OP13_BITWISE_AND' => 101,
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => -123,
			'OP17_LIST_RANGE' => 99,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP18_TERNARY' => 109,
			"]" => -123,
			'OP24_LOGICAL_OR_XOR' => -123
		}
	},
	{#State 148
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 100,
			'OP06_REGEX_MATCH' => 111,
			")" => 213,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP13_BITWISE_AND' => 101,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP17_LIST_RANGE' => 99,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP23_LOGICAL_AND' => 107,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP08_MATH_ADD_SUB' => 106,
			'OP08_STRING_CAT' => 113,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			'OP15_LOGICAL_AND' => 112
		}
	},
	{#State 149
		ACTIONS => {
			"}" => 214
		}
	},
	{#State 150
		ACTIONS => {
			'WORD' => 117,
			"%{" => 75
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'HashEntry' => 114
		}
	},
	{#State 151
		ACTIONS => {
			"}" => 215
		}
	},
	{#State 152
		DEFAULT => -217
	},
	{#State 153
		ACTIONS => {
			'VARIABLE_SYMBOL' => 216
		}
	},
	{#State 154
		ACTIONS => {
			";" => 217
		}
	},
	{#State 155
		DEFAULT => -218
	},
	{#State 156
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => 107,
			'OP08_MATH_ADD_SUB' => 106,
			'OP08_STRING_CAT' => 113,
			'OP15_LOGICAL_AND' => 112,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			")" => 218,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP13_BITWISE_AND' => 101,
			'OP09_BITWISE_SHIFT' => 100,
			'OP17_LIST_RANGE' => 99,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => 98,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97
		}
	},
	{#State 157
		DEFAULT => -155
	},
	{#State 158
		ACTIONS => {
			'VARIABLE_SYMBOL' => 219
		}
	},
	{#State 159
		DEFAULT => -104
	},
	{#State 160
		ACTIONS => {
			'VARIABLE_SYMBOL' => 57,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Operator' => 84,
			'HashDereferenced' => 74,
			'Expression' => 220,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76
		}
	},
	{#State 161
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'OP05_LOGICAL_NEG' => 60,
			'VARIABLE_SYMBOL' => 57,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"(" => 73,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			"undef" => 67,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			'LITERAL' => 50,
			"{" => 49
		},
		GOTOS => {
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 221,
			'Operator' => 84,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123
		}
	},
	{#State 162
		ACTIONS => {
			'WORD' => 222
		}
	},
	{#State 163
		DEFAULT => -103
	},
	{#State 164
		ACTIONS => {
			")" => -140,
			"my" => 131,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 57,
			'KEYS_OR_VALUES' => 132,
			'OP05_LOGICAL_NEG' => 60,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 71,
			"undef" => 67
		},
		GOTOS => {
			'OPTIONAL-47' => 223,
			'Operator' => 84,
			'ListElements' => 224,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'TypeInner' => 126,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'ListElement' => 130,
			'Expression' => 133
		}
	},
	{#State 165
		ACTIONS => {
			"]" => 225
		}
	},
	{#State 166
		DEFAULT => -196
	},
	{#State 167
		DEFAULT => -24
	},
	{#State 168
		DEFAULT => -26
	},
	{#State 169
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 226
		}
	},
	{#State 170
		DEFAULT => -31
	},
	{#State 171
		ACTIONS => {
			";" => 227
		}
	},
	{#State 172
		ACTIONS => {
			"[" => 230,
			'LITERAL' => 228,
			"{" => 229
		},
		GOTOS => {
			'ConstantValue' => 231
		}
	},
	{#State 173
		ACTIONS => {
			'OP08_STRING_CAT' => 113,
			'OP08_MATH_ADD_SUB' => 106,
			'OP23_LOGICAL_AND' => 107,
			'OP14_BITWISE_OR_XOR' => 108,
			"}" => -125,
			'OP11_COMPARE_LT_GT' => 103,
			'OP04_MATH_POW' => 104,
			'OP15_LOGICAL_AND' => 112,
			";" => -125,
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => -125,
			'OP13_BITWISE_AND' => 101,
			".." => -125,
			")" => -125,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP24_LOGICAL_OR_XOR' => -125,
			"]" => -125,
			'OP18_TERNARY' => 109,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP17_LIST_RANGE' => 99
		}
	},
	{#State 174
		ACTIONS => {
			"}" => -120,
			'OP08_MATH_ADD_SUB' => 106,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => -120,
			'OP08_STRING_CAT' => 113,
			";" => -120,
			'OP15_LOGICAL_AND' => 112,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			".." => -120,
			")" => -120,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP06_REGEX_MATCH' => 111,
			'OP13_BITWISE_AND' => 101,
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => -120,
			'OP17_LIST_RANGE' => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			"]" => -120,
			'OP18_TERNARY' => -120,
			'OP24_LOGICAL_OR_XOR' => -120
		}
	},
	{#State 175
		ACTIONS => {
			'OP08_STRING_CAT' => 113,
			'OP08_MATH_ADD_SUB' => 106,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => -121,
			"}" => -121,
			'OP11_COMPARE_LT_GT' => 103,
			'OP04_MATH_POW' => 104,
			'OP15_LOGICAL_AND' => 112,
			";" => -121,
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => -121,
			'OP13_BITWISE_AND' => 101,
			".." => -121,
			")" => -121,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP18_TERNARY' => -121,
			"]" => -121,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP17_LIST_RANGE' => undef
		}
	},
	{#State 176
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP18_TERNARY' => -112,
			"]" => -112,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP13_BITWISE_AND' => -112,
			".." => -112,
			")" => -112,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP06_REGEX_MATCH' => 111,
			'OP11_COMPARE_LT_GT' => -112,
			'OP04_MATH_POW' => 104,
			'OP15_LOGICAL_AND' => -112,
			";" => -112,
			'OP08_STRING_CAT' => 113,
			'OP08_MATH_ADD_SUB' => 106,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP23_LOGICAL_AND' => -112,
			"}" => -112
		}
	},
	{#State 177
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 106,
			'OP23_LOGICAL_AND' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP08_STRING_CAT' => 113,
			"}" => -117,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			";" => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => -117,
			".." => -117,
			'OP06_REGEX_MATCH' => 111,
			")" => -117,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP13_BITWISE_AND' => -117,
			"]" => -117,
			'OP18_TERNARY' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP17_LIST_RANGE' => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 110
		}
	},
	{#State 178
		ACTIONS => {
			'OP17_LIST_RANGE' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => -116,
			'OP18_TERNARY' => -116,
			"]" => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			".." => -116,
			")" => -116,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP06_REGEX_MATCH' => 111,
			'OP13_BITWISE_AND' => -116,
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => -116,
			";" => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			"}" => -116,
			'OP08_MATH_ADD_SUB' => 106,
			'OP23_LOGICAL_AND' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP08_STRING_CAT' => 113
		}
	},
	{#State 179
		ACTIONS => {
			'OP17_LIST_RANGE' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			"]" => -115,
			'OP18_TERNARY' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			")" => -115,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => -115,
			".." => -115,
			'OP13_BITWISE_AND' => -115,
			'OP21_LIST_COMMA' => -115,
			'OP09_BITWISE_SHIFT' => 100,
			";" => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => undef,
			"}" => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP08_MATH_ADD_SUB' => 106,
			'OP08_STRING_CAT' => 113
		}
	},
	{#State 180
		ACTIONS => {
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => -105,
			";" => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP08_STRING_CAT' => -105,
			"}" => -105,
			'OP18_TERNARY' => -105,
			"]" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP06_REGEX_MATCH' => -105,
			")" => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			".." => -105,
			'OP13_BITWISE_AND' => -105
		}
	},
	{#State 181
		ACTIONS => {
			"}" => -110,
			'OP08_STRING_CAT' => -110,
			'OP08_MATH_ADD_SUB' => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP15_LOGICAL_AND' => -110,
			";" => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP04_MATH_POW' => 104,
			'OP13_BITWISE_AND' => -110,
			".." => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			")" => -110,
			'OP06_REGEX_MATCH' => 111,
			'OP09_BITWISE_SHIFT' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => -110,
			'OP17_LIST_RANGE' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP18_TERNARY' => -110,
			"]" => -110
		}
	},
	{#State 182
		ACTIONS => {
			"]" => -124,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP17_LIST_RANGE' => 99,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => 98,
			'OP21_LIST_COMMA' => -124,
			'OP09_BITWISE_SHIFT' => 100,
			'OP12_COMPARE_EQ_NEQ' => 102,
			")" => -124,
			'OP06_REGEX_MATCH' => 111,
			".." => -124,
			'OP13_BITWISE_AND' => 101,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			";" => -124,
			'OP15_LOGICAL_AND' => 112,
			'OP23_LOGICAL_AND' => -124,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP08_MATH_ADD_SUB' => 106,
			'OP08_STRING_CAT' => 113,
			"}" => -124
		}
	},
	{#State 183
		ACTIONS => {
			'OP17_LIST_RANGE' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			"]" => -118,
			'OP18_TERNARY' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			".." => -118,
			")" => -118,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP13_BITWISE_AND' => 101,
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => -118,
			";" => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			"}" => -118,
			'OP08_MATH_ADD_SUB' => 106,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP08_STRING_CAT' => 113
		}
	},
	{#State 184
		ACTIONS => {
			'COLON' => 232
		}
	},
	{#State 185
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -109,
			'OP04_MATH_POW' => 104,
			'OP15_LOGICAL_AND' => -109,
			";" => -109,
			'OP08_STRING_CAT' => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP08_MATH_ADD_SUB' => -109,
			"}" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP18_TERNARY' => -109,
			"]" => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP13_BITWISE_AND' => -109,
			")" => -109,
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP06_REGEX_MATCH' => 111,
			".." => -109
		}
	},
	{#State 186
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 233
		}
	},
	{#State 187
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP18_TERNARY' => -119,
			"]" => -119,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => -119,
			'OP17_LIST_RANGE' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP09_BITWISE_SHIFT' => 100,
			'OP13_BITWISE_AND' => 101,
			")" => -119,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP06_REGEX_MATCH' => 111,
			".." => -119,
			'OP11_COMPARE_LT_GT' => 103,
			'OP04_MATH_POW' => 104,
			'OP15_LOGICAL_AND' => -119,
			";" => -119,
			'OP08_STRING_CAT' => 113,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => -119,
			'OP08_MATH_ADD_SUB' => 106,
			"}" => -119
		}
	},
	{#State 188
		ACTIONS => {
			";" => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => -111,
			"}" => -111,
			'OP08_MATH_ADD_SUB' => 106,
			'OP23_LOGICAL_AND' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP08_STRING_CAT' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => -111,
			"]" => -111,
			'OP18_TERNARY' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			".." => -111,
			")" => -111,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP13_BITWISE_AND' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP21_LIST_COMMA' => -111
		}
	},
	{#State 189
		ACTIONS => {
			'OP21_LIST_COMMA' => 234,
			"}" => 235
		},
		GOTOS => {
			'PAREN-61' => 236
		}
	},
	{#State 190
		ACTIONS => {
			'OP01_NAMED' => -202,
			"%{" => -202,
			"(" => -202,
			"my" => 131,
			'OP05_LOGICAL_NEG' => -202,
			'OP05_MATH_NEG' => -202,
			'OP10_NAMED_UNARY_STRINGIFY' => -202,
			'VARIABLE_SYMBOL' => -202,
			"[" => -202,
			'OP03_MATH_INC_DEC' => -202,
			'LITERAL' => -202,
			"{" => -202,
			'OP10_NAMED_UNARY' => -202,
			"\@{" => -202,
			"undef" => -202,
			'WORD' => -202,
			'WORD_SCOPED' => -202,
			'OP22_LOGICAL_NOT' => -202
		},
		GOTOS => {
			'OPTIONAL-60' => 238,
			'TypeInner' => 237
		}
	},
	{#State 191
		DEFAULT => -200
	},
	{#State 192
		DEFAULT => -199
	},
	{#State 193
		ACTIONS => {
			")" => 239
		}
	},
	{#State 194
		DEFAULT => -100
	},
	{#State 195
		ACTIONS => {
			"undef" => 67,
			'WORD' => 241,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'VARIABLE_SYMBOL' => 57,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73
		},
		GOTOS => {
			'Operator' => 84,
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61,
			'HashDereferenced' => 74,
			'Expression' => 240,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76
		}
	},
	{#State 196
		ACTIONS => {
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"undef" => 67,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'OP22_LOGICAL_NOT' => 71,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75,
			'VARIABLE_SYMBOL' => 57,
			'OP05_LOGICAL_NEG' => 60,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86
		},
		GOTOS => {
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Operator' => 84,
			'HashDereferenced' => 74,
			'Expression' => 242,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76
		}
	},
	{#State 197
		DEFAULT => -179
	},
	{#State 198
		DEFAULT => -107
	},
	{#State 199
		ACTIONS => {
			'OP18_TERNARY' => 109,
			"]" => -194,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP17_LIST_RANGE' => 99,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => -194,
			'OP12_COMPARE_EQ_NEQ' => 102,
			")" => -194,
			'OP06_REGEX_MATCH' => 111,
			'OP13_BITWISE_AND' => 101,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			";" => -194,
			'OP15_LOGICAL_AND' => 112,
			'OP08_MATH_ADD_SUB' => 106,
			'OP23_LOGICAL_AND' => 107,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP08_STRING_CAT' => 113
		}
	},
	{#State 200
		ACTIONS => {
			";" => 243
		}
	},
	{#State 201
		DEFAULT => -128
	},
	{#State 202
		ACTIONS => {
			")" => 244
		}
	},
	{#State 203
		ACTIONS => {
			"]" => -192,
			'OP21_LIST_COMMA' => 245,
			";" => -192,
			")" => -192
		},
		GOTOS => {
			'PAREN-57' => 246
		}
	},
	{#State 204
		ACTIONS => {
			"\$TYPED_" => 247
		}
	},
	{#State 205
		DEFAULT => -195
	},
	{#State 206
		ACTIONS => {
			"}" => 248
		}
	},
	{#State 207
		ACTIONS => {
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP17_LIST_RANGE' => 99,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP09_BITWISE_SHIFT' => 100,
			")" => 249,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP13_BITWISE_AND' => 101,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			'OP15_LOGICAL_AND' => 112,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => 107,
			'OP08_MATH_ADD_SUB' => 106,
			'OP08_STRING_CAT' => 113
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
		DEFAULT => -132
	},
	{#State 211
		ACTIONS => {
			";" => 252
		}
	},
	{#State 212
		DEFAULT => -136
	},
	{#State 213
		DEFAULT => -154
	},
	{#State 214
		DEFAULT => -211
	},
	{#State 215
		DEFAULT => -212
	},
	{#State 216
		ACTIONS => {
			";" => 253,
			'OP19_VARIABLE_ASSIGN' => 254
		}
	},
	{#State 217
		DEFAULT => -138
	},
	{#State 218
		ACTIONS => {
			"{" => 256
		},
		GOTOS => {
			'CodeBlock' => 255
		}
	},
	{#State 219
		ACTIONS => {
			"= sub {" => 257
		}
	},
	{#State 220
		ACTIONS => {
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP17_LIST_RANGE' => 99,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP18_TERNARY' => 109,
			'OP13_BITWISE_AND' => 101,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP06_REGEX_MATCH' => 111,
			'OP09_BITWISE_SHIFT' => 100,
			'OP15_LOGICAL_AND' => 112,
			";" => 258,
			'OP11_COMPARE_LT_GT' => 103,
			'OP04_MATH_POW' => 104,
			'OP08_STRING_CAT' => 113,
			'OP08_MATH_ADD_SUB' => 106,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => 107
		}
	},
	{#State 221
		ACTIONS => {
			";" => 259,
			'OP15_LOGICAL_AND' => 112,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			'OP08_MATH_ADD_SUB' => 106,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => 107,
			'OP08_STRING_CAT' => 113,
			'OP17_LIST_RANGE' => 99,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP13_BITWISE_AND' => 101,
			'OP09_BITWISE_SHIFT' => 100
		}
	},
	{#State 222
		ACTIONS => {
			"(" => 260
		}
	},
	{#State 223
		ACTIONS => {
			")" => 261
		}
	},
	{#State 224
		DEFAULT => -139
	},
	{#State 225
		DEFAULT => -198
	},
	{#State 226
		ACTIONS => {
			"our %properties = (" => -71,
			"use constant" => -71,
			"use" => -71,
			"## no critic qw(" => 22
		},
		GOTOS => {
			'STAR-29' => 262,
			'Critic' => 263
		}
	},
	{#State 227
		DEFAULT => -34
	},
	{#State 228
		DEFAULT => -50
	},
	{#State 229
		ACTIONS => {
			'WORD' => 264
		}
	},
	{#State 230
		ACTIONS => {
			"my" => 131,
			'LITERAL' => -37
		},
		GOTOS => {
			'TypeInner' => 265,
			'OPTIONAL-13' => 266
		}
	},
	{#State 231
		ACTIONS => {
			";" => 267
		}
	},
	{#State 232
		ACTIONS => {
			'VARIABLE_SYMBOL' => 57
		},
		GOTOS => {
			'Variable' => 268
		}
	},
	{#State 233
		ACTIONS => {
			"/" => 269
		}
	},
	{#State 234
		ACTIONS => {
			'WORD' => 117,
			"%{" => 75
		},
		GOTOS => {
			'HashDereferenced' => 115,
			'HashEntry' => 270
		}
	},
	{#State 235
		DEFAULT => -210
	},
	{#State 236
		DEFAULT => -208
	},
	{#State 237
		DEFAULT => -201
	},
	{#State 238
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'OP05_LOGICAL_NEG' => 60,
			'VARIABLE_SYMBOL' => 57,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"(" => 73,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52
		},
		GOTOS => {
			'HashDereferenced' => 74,
			'Expression' => 271,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'Operator' => 84,
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61
		}
	},
	{#State 239
		DEFAULT => -102
	},
	{#State 240
		ACTIONS => {
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			'OP15_LOGICAL_AND' => 112,
			'OP08_MATH_ADD_SUB' => 106,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => 107,
			'OP08_STRING_CAT' => 113,
			"}" => 272,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP17_LIST_RANGE' => 99,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP09_BITWISE_SHIFT' => 100,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP06_REGEX_MATCH' => 111,
			'OP13_BITWISE_AND' => 101
		}
	},
	{#State 241
		ACTIONS => {
			"}" => 273,
			"(" => -213
		}
	},
	{#State 242
		ACTIONS => {
			'OP15_LOGICAL_AND' => 112,
			'OP11_COMPARE_LT_GT' => 103,
			'OP04_MATH_POW' => 104,
			'OP08_STRING_CAT' => 113,
			'OP08_MATH_ADD_SUB' => 106,
			'OP23_LOGICAL_AND' => 107,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP17_LIST_RANGE' => 99,
			'OP24_LOGICAL_OR_XOR' => 97,
			"]" => 274,
			'OP18_TERNARY' => 109,
			'OP13_BITWISE_AND' => 101,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP09_BITWISE_SHIFT' => 100
		}
	},
	{#State 243
		DEFAULT => -134
	},
	{#State 244
		ACTIONS => {
			";" => 275
		}
	},
	{#State 245
		ACTIONS => {
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			"undef" => 67,
			"my" => 131,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 57,
			'OP05_LOGICAL_NEG' => 60,
			'KEYS_OR_VALUES' => 132,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59
		},
		GOTOS => {
			'Operator' => 84,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'TypeInner' => 126,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 133,
			'ListElement' => 276
		}
	},
	{#State 246
		DEFAULT => -190
	},
	{#State 247
		ACTIONS => {
			'WORD' => 277
		}
	},
	{#State 248
		DEFAULT => -215
	},
	{#State 249
		ACTIONS => {
			"{" => 256
		},
		GOTOS => {
			'CodeBlock' => 278
		}
	},
	{#State 250
		ACTIONS => {
			"(" => 279
		}
	},
	{#State 251
		ACTIONS => {
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75,
			'VARIABLE_SYMBOL' => 57,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"undef" => 67,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71
		},
		GOTOS => {
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'Expression' => 280,
			'HashDereferenced' => 74,
			'Operator' => 84,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Variable' => 123
		}
	},
	{#State 252
		DEFAULT => -137
	},
	{#State 253
		DEFAULT => -185
	},
	{#State 254
		ACTIONS => {
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			'VARIABLE_SYMBOL' => 57,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"(" => 73
		},
		GOTOS => {
			'HashDereferenced' => 74,
			'Expression' => 281,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'Operator' => 84,
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61
		}
	},
	{#State 255
		DEFAULT => -165,
		GOTOS => {
			'STAR-52' => 282
		}
	},
	{#State 256
		ACTIONS => {
			"for my integer" => -157,
			"[" => 88,
			'OP01_NAMED_VOID_PAREN' => 62,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 57,
			'OP05_LOGICAL_NEG' => 60,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP19_LOOP_CONTROL' => 78,
			"my" => 77,
			"if (" => 79,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75,
			'WORD_SCOPED' => 10,
			'WORD' => 72,
			'OP22_LOGICAL_NOT' => 71,
			'OP01_NAMED_VOID' => 70,
			"undef" => 67,
			"\@{" => 52,
			"while (" => -157,
			"foreach my" => -157,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50
		},
		GOTOS => {
			'ArrayDereferenced' => 76,
			'VariableDeclaration' => 54,
			'ArrayReference' => 56,
			'HashDereferenced' => 74,
			'PAREN-49' => 83,
			'Operator' => 84,
			'LoopLabel' => 80,
			'Operation' => 283,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Variable' => 85,
			'OperatorVoid' => 51,
			'Conditional' => 65,
			'Expression' => 48,
			'OPTIONAL-50' => 64,
			'PLUS-55' => 284,
			'VariableModification' => 68,
			'Statement' => 69
		}
	},
	{#State 257
		ACTIONS => {
			'LITERAL' => -54,
			"{" => -54,
			"foreach my" => -54,
			'OP10_NAMED_UNARY' => -54,
			"while (" => -54,
			"\@{" => -54,
			"undef" => -54,
			'OP01_NAMED_VOID' => -54,
			'OP22_LOGICAL_NOT' => -54,
			'WORD' => -54,
			'WORD_SCOPED' => -54,
			"%{" => -54,
			'OP01_NAMED' => -54,
			"(" => -54,
			"if (" => -54,
			"my" => -54,
			'OP19_LOOP_CONTROL' => -54,
			'OP05_MATH_NEG' => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			'OP05_LOGICAL_NEG' => -54,
			'VARIABLE_SYMBOL' => -54,
			'OP03_MATH_INC_DEC' => -54,
			"[" => -54,
			"( my" => 287,
			'OP01_NAMED_VOID_PAREN' => -54,
			"for my integer" => -54
		},
		GOTOS => {
			'SubroutineArguments' => 286,
			'OPTIONAL-21' => 285
		}
	},
	{#State 258
		DEFAULT => -188
	},
	{#State 259
		DEFAULT => -187
	},
	{#State 260
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'VARIABLE_SYMBOL' => 57,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'KEYS_OR_VALUES' => 132,
			'OP05_LOGICAL_NEG' => 60,
			")" => -142,
			"my" => 131,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			"undef" => 67,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50
		},
		GOTOS => {
			'TypeInner' => 126,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'ListElement' => 130,
			'Expression' => 133,
			'Operator' => 84,
			'ListElements' => 289,
			'WordScoped' => 87,
			'OPTIONAL-48' => 288,
			'HashReference' => 61,
			'Variable' => 123
		}
	},
	{#State 261
		DEFAULT => -152
	},
	{#State 262
		ACTIONS => {
			"use constant" => -73,
			"our %properties = (" => -73,
			"use" => 26
		},
		GOTOS => {
			'Include' => 291,
			'STAR-30' => 290
		}
	},
	{#State 263
		DEFAULT => -68
	},
	{#State 264
		ACTIONS => {
			'OP20_HASH_FATARROW' => 292
		}
	},
	{#State 265
		DEFAULT => -36
	},
	{#State 266
		ACTIONS => {
			'LITERAL' => 293
		}
	},
	{#State 267
		DEFAULT => -35
	},
	{#State 268
		DEFAULT => -122
	},
	{#State 269
		DEFAULT => -108
	},
	{#State 270
		DEFAULT => -207
	},
	{#State 271
		ACTIONS => {
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			'OP15_LOGICAL_AND' => 112,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => 107,
			'OP08_MATH_ADD_SUB' => 106,
			'OP08_STRING_CAT' => 113,
			"}" => -203,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP17_LIST_RANGE' => 99,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP21_LIST_COMMA' => -203,
			'OP09_BITWISE_SHIFT' => 100,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP13_BITWISE_AND' => 101
		}
	},
	{#State 272
		DEFAULT => -183
	},
	{#State 273
		DEFAULT => -184
	},
	{#State 274
		DEFAULT => -182
	},
	{#State 275
		DEFAULT => -135
	},
	{#State 276
		DEFAULT => -189
	},
	{#State 277
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 294
		}
	},
	{#State 278
		DEFAULT => -175
	},
	{#State 279
		ACTIONS => {
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			"undef" => 67,
			"my" => 131,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'VARIABLE_SYMBOL' => 57,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'KEYS_OR_VALUES' => 132,
			'OP05_LOGICAL_NEG' => 60
		},
		GOTOS => {
			'ArrayReference' => 56,
			'TypeInner' => 126,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'ListElement' => 130,
			'Expression' => 133,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'Operator' => 84,
			'ListElements' => 295
		}
	},
	{#State 280
		ACTIONS => {
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			'OP15_LOGICAL_AND' => 112,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => 107,
			'OP08_MATH_ADD_SUB' => 106,
			'OP08_STRING_CAT' => 113,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP17_LIST_RANGE' => 99,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => 98,
			'OP09_BITWISE_SHIFT' => 100,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP06_REGEX_MATCH' => 111,
			".." => 296,
			'OP13_BITWISE_AND' => 101
		}
	},
	{#State 281
		ACTIONS => {
			'OP23_LOGICAL_AND' => 107,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP08_MATH_ADD_SUB' => 106,
			'OP08_STRING_CAT' => 113,
			";" => 297,
			'OP15_LOGICAL_AND' => 112,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP13_BITWISE_AND' => 101,
			'OP09_BITWISE_SHIFT' => 100,
			'OP17_LIST_RANGE' => 99,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97
		}
	},
	{#State 282
		ACTIONS => {
			'' => -168,
			"if (" => -168,
			'OP19_LOOP_CONTROL' => -168,
			"my" => -168,
			'OP01_NAMED' => -168,
			"%{" => -168,
			"else" => 302,
			"(" => -168,
			'OP01_NAMED_VOID_PAREN' => -168,
			"[" => -168,
			'OP03_MATH_INC_DEC' => -168,
			"for my integer" => -168,
			'OP05_LOGICAL_NEG' => -168,
			'OP10_NAMED_UNARY_STRINGIFY' => -168,
			'OP05_MATH_NEG' => -168,
			'VARIABLE_SYMBOL' => -168,
			"foreach my" => -168,
			'OP10_NAMED_UNARY' => -168,
			"\@{" => -168,
			"}" => -168,
			"while (" => -168,
			'LITERAL' => -168,
			"{" => -168,
			'WORD' => -168,
			"elsif (" => 299,
			'WORD_SCOPED' => -168,
			'OP22_LOGICAL_NOT' => -168,
			'OP01_NAMED_VOID' => -168,
			"undef" => -168
		},
		GOTOS => {
			'OPTIONAL-54' => 301,
			'PAREN-51' => 300,
			'PAREN-53' => 298
		}
	},
	{#State 283
		DEFAULT => -177
	},
	{#State 284
		ACTIONS => {
			"while (" => -157,
			"}" => 303,
			"\@{" => 52,
			"foreach my" => -157,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 72,
			'WORD_SCOPED' => 10,
			"undef" => 67,
			'OP01_NAMED_VOID' => 70,
			"my" => 77,
			'OP19_LOOP_CONTROL' => 78,
			"if (" => 79,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"for my integer" => -157,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'OP01_NAMED_VOID_PAREN' => 62,
			'VARIABLE_SYMBOL' => 57,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60
		},
		GOTOS => {
			'Operation' => 304,
			'LoopLabel' => 80,
			'PAREN-49' => 83,
			'Operator' => 84,
			'Variable' => 85,
			'WordScoped' => 87,
			'HashReference' => 61,
			'HashDereferenced' => 74,
			'ArrayReference' => 56,
			'VariableDeclaration' => 54,
			'ArrayDereferenced' => 76,
			'VariableModification' => 68,
			'Statement' => 69,
			'OPTIONAL-50' => 64,
			'Expression' => 48,
			'Conditional' => 65,
			'OperatorVoid' => 51
		}
	},
	{#State 285
		ACTIONS => {
			"undef" => 67,
			'OP01_NAMED_VOID' => 70,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 72,
			"{" => 49,
			'LITERAL' => 50,
			"while (" => -157,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"foreach my" => -157,
			'VARIABLE_SYMBOL' => 57,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			"for my integer" => -157,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'OP01_NAMED_VOID_PAREN' => 62,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"my" => 77,
			'OP19_LOOP_CONTROL' => 78,
			"if (" => 79
		},
		GOTOS => {
			'Variable' => 85,
			'HashReference' => 61,
			'WordScoped' => 87,
			'LoopLabel' => 80,
			'Operation' => 305,
			'PAREN-49' => 83,
			'Operator' => 84,
			'HashDereferenced' => 74,
			'ArrayDereferenced' => 76,
			'VariableDeclaration' => 54,
			'ArrayReference' => 56,
			'Statement' => 69,
			'VariableModification' => 68,
			'PLUS-22' => 306,
			'Expression' => 48,
			'OPTIONAL-50' => 64,
			'OperatorVoid' => 51,
			'Conditional' => 65
		}
	},
	{#State 286
		DEFAULT => -53
	},
	{#State 287
		ACTIONS => {
			'WORD' => 152
		},
		GOTOS => {
			'Type' => 307
		}
	},
	{#State 288
		ACTIONS => {
			")" => 308
		}
	},
	{#State 289
		DEFAULT => -141
	},
	{#State 290
		ACTIONS => {
			"use constant" => 36,
			"our %properties = (" => 309
		},
		GOTOS => {
			'Properties' => 310,
			'Constant' => 311
		}
	},
	{#State 291
		DEFAULT => -70
	},
	{#State 292
		ACTIONS => {
			"my" => 131,
			'LITERAL' => -44
		},
		GOTOS => {
			'OPTIONAL-17' => 313,
			'TypeInner' => 312
		}
	},
	{#State 293
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 314
		}
	},
	{#State 294
		DEFAULT => -216
	},
	{#State 295
		ACTIONS => {
			")" => 315
		}
	},
	{#State 296
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			'VARIABLE_SYMBOL' => 57,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			"undef" => 67,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50
		},
		GOTOS => {
			'Operator' => 84,
			'Variable' => 123,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Expression' => 316,
			'HashDereferenced' => 74,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56
		}
	},
	{#State 297
		DEFAULT => -186
	},
	{#State 298
		DEFAULT => -167
	},
	{#State 299
		ACTIONS => {
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			'VARIABLE_SYMBOL' => 57,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 11
		},
		GOTOS => {
			'Operator' => 84,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 317
		}
	},
	{#State 300
		DEFAULT => -164
	},
	{#State 301
		DEFAULT => -169
	},
	{#State 302
		ACTIONS => {
			"{" => 256
		},
		GOTOS => {
			'CodeBlock' => 318
		}
	},
	{#State 303
		DEFAULT => -178
	},
	{#State 304
		DEFAULT => -176
	},
	{#State 305
		DEFAULT => -56
	},
	{#State 306
		ACTIONS => {
			'LITERAL' => 50,
			"{" => 49,
			"foreach my" => -157,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			"}" => 319,
			"while (" => -157,
			'OP01_NAMED_VOID' => 70,
			"undef" => 67,
			'WORD' => 72,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73,
			"if (" => 79,
			'OP19_LOOP_CONTROL' => 78,
			"my" => 77,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'VARIABLE_SYMBOL' => 57,
			'OP01_NAMED_VOID_PAREN' => 62,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			"for my integer" => -157
		},
		GOTOS => {
			'HashDereferenced' => 74,
			'ArrayDereferenced' => 76,
			'VariableDeclaration' => 54,
			'ArrayReference' => 56,
			'Operation' => 320,
			'LoopLabel' => 80,
			'PAREN-49' => 83,
			'Operator' => 84,
			'Variable' => 85,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Expression' => 48,
			'OPTIONAL-50' => 64,
			'OperatorVoid' => 51,
			'Conditional' => 65,
			'VariableModification' => 68,
			'Statement' => 69
		}
	},
	{#State 307
		ACTIONS => {
			'VARIABLE_SYMBOL' => 321
		}
	},
	{#State 308
		DEFAULT => -153
	},
	{#State 309
		ACTIONS => {
			'WORD' => 323,
			")" => 325,
			"%{" => 75
		},
		GOTOS => {
			'HashEntryTyped' => 324,
			'HashDereferenced' => 322
		}
	},
	{#State 310
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 326
		}
	},
	{#State 311
		DEFAULT => -72
	},
	{#State 312
		DEFAULT => -43
	},
	{#State 313
		ACTIONS => {
			'LITERAL' => 327
		}
	},
	{#State 314
		ACTIONS => {
			"]" => 330,
			'OP21_LIST_COMMA' => 329
		},
		GOTOS => {
			'PAREN-15' => 328
		}
	},
	{#State 315
		ACTIONS => {
			"{" => 256
		},
		GOTOS => {
			'CodeBlock' => 331
		}
	},
	{#State 316
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 100,
			'OP12_COMPARE_EQ_NEQ' => 102,
			")" => 332,
			'OP06_REGEX_MATCH' => 111,
			'OP13_BITWISE_AND' => 101,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP17_LIST_RANGE' => 99,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => 98,
			'OP23_LOGICAL_AND' => 107,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP08_MATH_ADD_SUB' => 106,
			'OP08_STRING_CAT' => 113,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			'OP15_LOGICAL_AND' => 112
		}
	},
	{#State 317
		ACTIONS => {
			'OP15_LOGICAL_AND' => 112,
			'OP11_COMPARE_LT_GT' => 103,
			'OP04_MATH_POW' => 104,
			'OP08_STRING_CAT' => 113,
			'OP23_LOGICAL_AND' => 107,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP08_MATH_ADD_SUB' => 106,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => 98,
			'OP17_LIST_RANGE' => 99,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP18_TERNARY' => 109,
			'OP13_BITWISE_AND' => 101,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP06_REGEX_MATCH' => 111,
			")" => 333,
			'OP09_BITWISE_SHIFT' => 100
		}
	},
	{#State 318
		DEFAULT => -166
	},
	{#State 319
		ACTIONS => {
			";" => 334
		}
	},
	{#State 320
		DEFAULT => -55
	},
	{#State 321
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 335
		}
	},
	{#State 322
		DEFAULT => -206
	},
	{#State 323
		ACTIONS => {
			'OP20_HASH_FATARROW' => 336
		}
	},
	{#State 324
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 337
		}
	},
	{#State 325
		ACTIONS => {
			";" => 338
		}
	},
	{#State 326
		ACTIONS => {
			"1, 1;" => 340,
			"our" => 341
		},
		GOTOS => {
			'Method' => 339
		}
	},
	{#State 327
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 342
		}
	},
	{#State 328
		DEFAULT => -41
	},
	{#State 329
		ACTIONS => {
			'LITERAL' => -39,
			"my" => 131
		},
		GOTOS => {
			'TypeInner' => 343,
			'OPTIONAL-14' => 344
		}
	},
	{#State 330
		DEFAULT => -51
	},
	{#State 331
		DEFAULT => -174
	},
	{#State 332
		ACTIONS => {
			"{" => 256
		},
		GOTOS => {
			'CodeBlock' => 345
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
			")" => 347,
			'OP21_LIST_COMMA' => 349
		},
		GOTOS => {
			'PAREN-23' => 348
		}
	},
	{#State 336
		ACTIONS => {
			"my" => 131
		},
		GOTOS => {
			'TypeInner' => 350
		}
	},
	{#State 337
		ACTIONS => {
			'OP21_LIST_COMMA' => 353,
			")" => 352
		},
		GOTOS => {
			'PAREN-35' => 351
		}
	},
	{#State 338
		DEFAULT => -86
	},
	{#State 339
		DEFAULT => -74
	},
	{#State 340
		ACTIONS => {
			"our" => 82,
			"package" => -80,
			'' => -80
		},
		GOTOS => {
			'PAREN-33' => 355,
			'PLUS-32' => 354,
			'OPTIONAL-34' => 356,
			'Subroutine' => 357
		}
	},
	{#State 341
		ACTIONS => {
			'WORD' => 152
		},
		GOTOS => {
			'Type' => 358
		}
	},
	{#State 342
		ACTIONS => {
			'OP21_LIST_COMMA' => 360,
			"}" => 359
		},
		GOTOS => {
			'PAREN-19' => 361
		}
	},
	{#State 343
		DEFAULT => -38
	},
	{#State 344
		ACTIONS => {
			'LITERAL' => 362
		}
	},
	{#State 345
		DEFAULT => -173
	},
	{#State 346
		DEFAULT => -163
	},
	{#State 347
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 363
		}
	},
	{#State 348
		DEFAULT => -59
	},
	{#State 349
		ACTIONS => {
			"my" => 364
		}
	},
	{#State 350
		ACTIONS => {
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"(" => 73,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			'VARIABLE_SYMBOL' => 57,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88
		},
		GOTOS => {
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 123,
			'Operator' => 84,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'HashDereferenced' => 74,
			'Expression' => 365
		}
	},
	{#State 351
		DEFAULT => -83
	},
	{#State 352
		ACTIONS => {
			";" => 366
		}
	},
	{#State 353
		ACTIONS => {
			"%{" => 75,
			'WORD' => 323
		},
		GOTOS => {
			'HashEntryTyped' => 367,
			'HashDereferenced' => 322
		}
	},
	{#State 354
		ACTIONS => {
			"our" => 82,
			"1, 1;" => 368
		},
		GOTOS => {
			'Subroutine' => 369
		}
	},
	{#State 355
		DEFAULT => -79
	},
	{#State 356
		DEFAULT => -81
	},
	{#State 357
		DEFAULT => -77
	},
	{#State 358
		ACTIONS => {
			'VARIABLE_SYMBOL' => 370
		}
	},
	{#State 359
		DEFAULT => -52
	},
	{#State 360
		ACTIONS => {
			'WORD' => 371
		}
	},
	{#State 361
		DEFAULT => -48
	},
	{#State 362
		DEFAULT => -40
	},
	{#State 363
		ACTIONS => {
			"\@_;" => 372
		}
	},
	{#State 364
		ACTIONS => {
			'WORD' => 152
		},
		GOTOS => {
			'Type' => 373
		}
	},
	{#State 365
		ACTIONS => {
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			'OP15_LOGICAL_AND' => 112,
			'OP08_MATH_ADD_SUB' => 106,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => 107,
			'OP08_STRING_CAT' => 113,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP17_LIST_RANGE' => 99,
			'OP16_LOGICAL_OR' => 98,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => -205,
			'OP12_COMPARE_EQ_NEQ' => 102,
			")" => -205,
			'OP06_REGEX_MATCH' => 111,
			'OP13_BITWISE_AND' => 101
		}
	},
	{#State 366
		DEFAULT => -85
	},
	{#State 367
		DEFAULT => -82
	},
	{#State 368
		DEFAULT => -78
	},
	{#State 369
		DEFAULT => -76
	},
	{#State 370
		ACTIONS => {
			"= sub {" => 374
		}
	},
	{#State 371
		ACTIONS => {
			'OP20_HASH_FATARROW' => 375
		}
	},
	{#State 372
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 376
		}
	},
	{#State 373
		ACTIONS => {
			'VARIABLE_SYMBOL' => 377
		}
	},
	{#State 374
		ACTIONS => {
			'VARIABLE_SYMBOL' => -88,
			'OP05_LOGICAL_NEG' => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			'OP05_MATH_NEG' => -88,
			"for my integer" => -88,
			"[" => -88,
			'OP01_NAMED_VOID_PAREN' => -88,
			"( my" => 379,
			'OP03_MATH_INC_DEC' => -88,
			"(" => -88,
			'OP01_NAMED' => -88,
			"%{" => -88,
			'OP19_LOOP_CONTROL' => -88,
			"my" => -88,
			"if (" => -88,
			'OP01_NAMED_VOID' => -88,
			"undef" => -88,
			'WORD' => -88,
			'WORD_SCOPED' => -88,
			'OP22_LOGICAL_NOT' => -88,
			"{" => -88,
			'LITERAL' => -88,
			"\@{" => -88,
			"while (" => -88,
			"foreach my" => -88,
			'OP10_NAMED_UNARY' => -88
		},
		GOTOS => {
			'OPTIONAL-37' => 378,
			'MethodArguments' => 380
		}
	},
	{#State 375
		ACTIONS => {
			"my" => 131,
			'LITERAL' => -46
		},
		GOTOS => {
			'OPTIONAL-18' => 382,
			'TypeInner' => 381
		}
	},
	{#State 376
		ACTIONS => {
			'OP01_NAMED' => -63,
			"%{" => -63,
			"(" => -63,
			"if (" => -63,
			'OP19_LOOP_CONTROL' => -63,
			"my" => -63,
			'OP05_LOGICAL_NEG' => -63,
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			'OP05_MATH_NEG' => -63,
			'VARIABLE_SYMBOL' => -63,
			"[" => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			'OP03_MATH_INC_DEC' => -63,
			"for my integer" => -63,
			'LITERAL' => -63,
			"{" => -63,
			"foreach my" => -63,
			'CHECK_OR_CHECKTRACE' => 383,
			'OP10_NAMED_UNARY' => -63,
			"\@{" => -63,
			"while (" => -63,
			'OP01_NAMED_VOID' => -63,
			"undef" => -63,
			'WORD_SCOPED' => -63,
			'WORD' => -63,
			'OP22_LOGICAL_NOT' => -63
		},
		GOTOS => {
			'ArgumentCheck' => 384
		}
	},
	{#State 377
		DEFAULT => -58
	},
	{#State 378
		ACTIONS => {
			'OP10_NAMED_UNARY' => 66,
			"foreach my" => -157,
			"\@{" => 52,
			"while (" => -157,
			'LITERAL' => 50,
			"{" => 49,
			'WORD_SCOPED' => 10,
			'WORD' => 72,
			'OP22_LOGICAL_NOT' => 71,
			'OP01_NAMED_VOID' => 70,
			"undef" => 67,
			"if (" => 79,
			'OP19_LOOP_CONTROL' => 78,
			"my" => 77,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73,
			"[" => 88,
			'OP01_NAMED_VOID_PAREN' => 62,
			'OP03_MATH_INC_DEC' => 86,
			"for my integer" => -157,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'VARIABLE_SYMBOL' => 57
		},
		GOTOS => {
			'PLUS-38' => 385,
			'VariableModification' => 68,
			'Statement' => 69,
			'OPTIONAL-50' => 64,
			'Expression' => 48,
			'Conditional' => 65,
			'OperatorVoid' => 51,
			'Variable' => 85,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Operation' => 386,
			'LoopLabel' => 80,
			'Operator' => 84,
			'PAREN-49' => 83,
			'HashDereferenced' => 74,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'VariableDeclaration' => 54
		}
	},
	{#State 379
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 387
		}
	},
	{#State 380
		DEFAULT => -87
	},
	{#State 381
		DEFAULT => -45
	},
	{#State 382
		ACTIONS => {
			'LITERAL' => 388
		}
	},
	{#State 383
		ACTIONS => {
			"(" => 389
		}
	},
	{#State 384
		DEFAULT => -61
	},
	{#State 385
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 78,
			"my" => 77,
			"if (" => 79,
			"(" => 73,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"for my integer" => -157,
			'OP01_NAMED_VOID_PAREN' => 62,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 57,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			"\@{" => 52,
			"}" => 391,
			"while (" => -157,
			"foreach my" => -157,
			'OP10_NAMED_UNARY' => 66,
			"{" => 49,
			'LITERAL' => 50,
			'WORD' => 72,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			'OP01_NAMED_VOID' => 70,
			"undef" => 67
		},
		GOTOS => {
			'Conditional' => 65,
			'OperatorVoid' => 51,
			'OPTIONAL-50' => 64,
			'Expression' => 48,
			'Statement' => 69,
			'VariableModification' => 68,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76,
			'VariableDeclaration' => 54,
			'HashDereferenced' => 74,
			'WordScoped' => 87,
			'HashReference' => 61,
			'Variable' => 85,
			'Operator' => 84,
			'PAREN-49' => 83,
			'LoopLabel' => 80,
			'Operation' => 390
		}
	},
	{#State 386
		DEFAULT => -90
	},
	{#State 387
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 392
		}
	},
	{#State 388
		DEFAULT => -47
	},
	{#State 389
		ACTIONS => {
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			'OP05_MATH_NEG' => 58,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_LOGICAL_NEG' => 60,
			'VARIABLE_SYMBOL' => 57,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"(" => 73
		},
		GOTOS => {
			'Operator' => 84,
			'Variable' => 123,
			'WordScoped' => 87,
			'HashReference' => 61,
			'HashDereferenced' => 74,
			'Expression' => 393,
			'ArrayReference' => 56,
			'ArrayDereferenced' => 76
		}
	},
	{#State 390
		DEFAULT => -89
	},
	{#State 391
		ACTIONS => {
			";" => 394
		}
	},
	{#State 392
		ACTIONS => {
			")" => 397,
			'OP21_LIST_COMMA' => 395
		},
		GOTOS => {
			'PAREN-39' => 396
		}
	},
	{#State 393
		ACTIONS => {
			'OP15_LOGICAL_AND' => 112,
			'OP11_COMPARE_LT_GT' => 103,
			'OP04_MATH_POW' => 104,
			'OP08_STRING_CAT' => 113,
			'OP08_MATH_ADD_SUB' => 106,
			'OP23_LOGICAL_AND' => 107,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => 98,
			'OP17_LIST_RANGE' => 99,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP18_TERNARY' => 109,
			'OP13_BITWISE_AND' => 101,
			'OP12_COMPARE_EQ_NEQ' => 102,
			")" => -66,
			'OP06_REGEX_MATCH' => 111,
			'OP09_BITWISE_SHIFT' => 100,
			'OP21_LIST_COMMA' => 398
		},
		GOTOS => {
			'OPTIONAL-27' => 400,
			'PAREN-26' => 399
		}
	},
	{#State 394
		DEFAULT => -91
	},
	{#State 395
		ACTIONS => {
			"my" => 401
		}
	},
	{#State 396
		DEFAULT => -93
	},
	{#State 397
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 402
		}
	},
	{#State 398
		ACTIONS => {
			'VARIABLE_SYMBOL' => 57,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'OP05_LOGICAL_NEG' => 60,
			'OP03_MATH_INC_DEC' => 86,
			"[" => 88,
			"(" => 73,
			"%{" => 75,
			'OP01_NAMED' => 55,
			"undef" => 67,
			'OP22_LOGICAL_NOT' => 71,
			'WORD_SCOPED' => 10,
			'WORD' => 11,
			"{" => 49,
			'LITERAL' => 50,
			"\@{" => 52,
			'OP10_NAMED_UNARY' => 66
		},
		GOTOS => {
			'Operator' => 84,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Variable' => 123,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'Expression' => 403,
			'HashDereferenced' => 74
		}
	},
	{#State 399
		DEFAULT => -65
	},
	{#State 400
		ACTIONS => {
			")" => 404
		}
	},
	{#State 401
		ACTIONS => {
			'WORD' => 152
		},
		GOTOS => {
			'Type' => 405
		}
	},
	{#State 402
		ACTIONS => {
			"\@_;" => 406
		}
	},
	{#State 403
		ACTIONS => {
			'OP23_LOGICAL_AND' => 107,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP08_MATH_ADD_SUB' => 106,
			'OP08_STRING_CAT' => 113,
			'OP04_MATH_POW' => 104,
			'OP11_COMPARE_LT_GT' => 103,
			'OP15_LOGICAL_AND' => 112,
			'OP21_LIST_COMMA' => 407,
			'OP09_BITWISE_SHIFT' => 100,
			'OP06_REGEX_MATCH' => 111,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP13_BITWISE_AND' => 101,
			'OP18_TERNARY' => 109,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP17_LIST_RANGE' => 99,
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => 98
		}
	},
	{#State 404
		ACTIONS => {
			";" => 408
		}
	},
	{#State 405
		ACTIONS => {
			'VARIABLE_SYMBOL' => 409
		}
	},
	{#State 406
		DEFAULT => -96,
		GOTOS => {
			'STAR-41' => 410
		}
	},
	{#State 407
		ACTIONS => {
			'LITERAL' => 50,
			"{" => 49,
			'OP10_NAMED_UNARY' => 66,
			"\@{" => 52,
			"undef" => 67,
			'WORD' => 11,
			'WORD_SCOPED' => 10,
			'OP22_LOGICAL_NOT' => 71,
			'OP01_NAMED' => 55,
			"%{" => 75,
			"(" => 73,
			'OP05_LOGICAL_NEG' => 60,
			'OP10_NAMED_UNARY_STRINGIFY' => 59,
			'OP05_MATH_NEG' => 58,
			'VARIABLE_SYMBOL' => 57,
			"[" => 88,
			'OP03_MATH_INC_DEC' => 86
		},
		GOTOS => {
			'Operator' => 84,
			'HashReference' => 61,
			'WordScoped' => 87,
			'Variable' => 123,
			'ArrayDereferenced' => 76,
			'ArrayReference' => 56,
			'Expression' => 411,
			'HashDereferenced' => 74
		}
	},
	{#State 408
		DEFAULT => -67
	},
	{#State 409
		DEFAULT => -92
	},
	{#State 410
		ACTIONS => {
			'WORD' => -97,
			'WORD_SCOPED' => -97,
			'OP22_LOGICAL_NOT' => -97,
			'OP01_NAMED_VOID' => -97,
			"undef" => -97,
			"foreach my" => -97,
			'OP10_NAMED_UNARY' => -97,
			'CHECK_OR_CHECKTRACE' => 383,
			"\@{" => -97,
			"while (" => -97,
			'LITERAL' => -97,
			"{" => -97,
			"[" => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			'OP03_MATH_INC_DEC' => -97,
			"for my integer" => -97,
			'OP05_LOGICAL_NEG' => -97,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			'OP05_MATH_NEG' => -97,
			'VARIABLE_SYMBOL' => -97,
			"if (" => -97,
			'OP19_LOOP_CONTROL' => -97,
			"my" => -97,
			'OP01_NAMED' => -97,
			"%{" => -97,
			"(" => -97
		},
		GOTOS => {
			'ArgumentCheck' => 412
		}
	},
	{#State 411
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 110,
			'OP16_LOGICAL_OR' => 98,
			'OP17_LIST_RANGE' => 99,
			'OP24_LOGICAL_OR_XOR' => 97,
			'OP18_TERNARY' => 109,
			'OP13_BITWISE_AND' => 101,
			'OP06_REGEX_MATCH' => 111,
			")" => -64,
			'OP12_COMPARE_EQ_NEQ' => 102,
			'OP09_BITWISE_SHIFT' => 100,
			'OP15_LOGICAL_AND' => 112,
			'OP11_COMPARE_LT_GT' => 103,
			'OP04_MATH_POW' => 104,
			'OP08_STRING_CAT' => 113,
			'OP08_MATH_ADD_SUB' => 106,
			'OP14_BITWISE_OR_XOR' => 108,
			'OP23_LOGICAL_AND' => 107
		}
	},
	{#State 412
		DEFAULT => -95
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5386 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 107 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5393 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 107 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5400 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5411 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5422 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5429 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5436 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5443 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5450 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5457 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5464 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5471 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5478 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5485 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5492 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5503 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5514 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5525 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5532 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5539 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5546 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5553 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5560 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5567 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5574 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5581 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 9,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5592 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5603 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5610 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5617 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5628 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5635 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5642 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5653 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5664 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5675 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5682 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5689 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5696 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5703 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5710 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5717 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 116 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5724 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5731 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5738 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5745 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5752 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5759 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5766 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5773 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5784 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5795 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5806 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5813 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5820 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5845 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5852 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5859 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5866 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5873 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5880 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5891 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5898 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5905 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5912 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5923 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5930 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5937 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5944 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5951 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5958 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5965 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5972 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5979 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5986 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5993 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6000 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6007 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6014 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 16,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6025 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6032 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6039 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6046 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6057 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6068 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6075 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6082 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6089 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6096 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6107 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6114 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6121 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6128 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6135 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6142 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6153 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6164 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6175 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6182 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 128 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6189 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6200 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6211 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6222 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6233 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6244 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6255 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6266 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6277 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6288 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6299 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6310 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6321 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6332 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6343 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6354 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6365 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6376 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6387 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6398 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6409 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6420 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6431 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6442 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6453 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6460 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6467 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6474 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6481 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6495 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6502 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6509 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6520 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6531 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6542 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6553 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6564 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6571 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6585 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6592 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6603 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6614 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6625 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6636 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6647 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6658 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6669 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6680 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6691 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6713 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6724 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6731 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6738 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6745 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_158
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6756 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_159
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6767 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6778 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6789 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6800 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6814 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6821 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6828 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6835 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6842 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_169
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6853 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_170
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6864 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_171
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6875 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6886 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_173
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6897 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_174
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_175
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6919 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6926 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_178
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6944 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6951 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_181
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_182
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_183
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_185
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_186
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_187
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7035 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_188
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7046 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7053 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7060 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7067 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_192
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7089 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_194
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_195
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_198
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7136 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_199
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_200
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7158 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7165 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_205
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_206
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-61', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7223 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7230 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7237 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_210
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7248 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_211
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7259 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_212
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7270 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_213
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7281 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_214
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_215
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7303 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_216
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7314 lib/RPerl/Grammar.pm
	],
	[#Rule Type_217
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7325 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_218
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7336 lib/RPerl/Grammar.pm
	]
],
#line 7339 lib/RPerl/Grammar.pm
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
         'TypeInner_216', 
         'Type_217', 
         'LoopLabel_218', );
  $self;
}

#line 170 "lib/RPerl/Grammar.eyp"


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


#line 7605 lib/RPerl/Grammar.pm



1;
