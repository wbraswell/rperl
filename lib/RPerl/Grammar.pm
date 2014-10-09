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

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|filehandle_ref|for\ my\ integer|use\ parent\ qw\(|our\ \$VERSION\ \=|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|while\ \(|package|\$TYPED_|\=\ sub\ \{|elsif\ \(|1\,\ 1\;|undef|else|if\ \(|\(\ my|our|qw\(|\@_\;|use|\{\*|\%\{|my|\.\.|\@\{|\[|\]|\{|\;|\}|\)|\(|\/)}gc and return ($1, $1);

      /\G(^(\#\!\/[\w\/]*\/perl)$)/gc and return ('SHEBANG', $1);
      /\G(\d\d?\.\d{3}\_\d{3})/gc and return ('VERSION_NUMBER', $1);
      /\G((-?(((\3_)*\d{3})|(\d{1,2}))(\.((\d{3}(_\8)*)|(\d{1,2})))?)|('[^']*')|("[^"]*"))/gc and return ('LITERAL', $1);
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
  [ 'FileHandle_216' => 'FileHandle', [ 'my', 'filehandle_ref', 'VARIABLE_SYMBOL' ], 0 ],
  [ 'TypeInner_217' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Type_218' => 'Type', [ 'WORD' ], 0 ],
  [ 'LoopLabel_219' => 'LoopLabel', [ 'WORD' ], 0 ],
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
			"package" => 1,
			'SHEBANG' => 7
		},
		GOTOS => {
			'PLUS-1' => 3,
			'Program' => 2,
			'Package' => 5,
			'Module' => 4,
			'Class' => 8,
			'CompileUnit' => 6
		}
	},
	{#State 1
		ACTIONS => {
			'WORD_SCOPED' => 11,
			'WORD' => 9
		},
		GOTOS => {
			'WordScoped' => 10
		}
	},
	{#State 2
		DEFAULT => -3
	},
	{#State 3
		ACTIONS => {
			'' => -4,
			"package" => 1
		},
		GOTOS => {
			'Class' => 8,
			'Module' => 12,
			'Package' => 5
		}
	},
	{#State 4
		DEFAULT => -2
	},
	{#State 5
		DEFAULT => -16
	},
	{#State 6
		ACTIONS => {
			'' => 13
		}
	},
	{#State 7
		ACTIONS => {
			"use strict;" => 14
		},
		GOTOS => {
			'Header' => 15
		}
	},
	{#State 8
		DEFAULT => -17
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
			"use RPerl;" => 20
		}
	},
	{#State 18
		ACTIONS => {
			'VARIABLE_SYMBOL' => -8,
			"%{" => -8,
			'WORD' => -8,
			'OP01_NAMED_VOID' => -8,
			"my" => -8,
			'OP10_NAMED_UNARY' => -8,
			"(" => -8,
			"for my integer" => -8,
			'OP01_NAMED' => -8,
			"[" => -8,
			"if (" => -8,
			"{" => -8,
			"our" => -8,
			'OP05_LOGICAL_NEG' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			"use constant" => -8,
			'LITERAL' => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			'OP03_MATH_INC_DEC' => -8,
			'OP22_LOGICAL_NOT' => -8,
			'OP19_LOOP_CONTROL' => -8,
			"use" => -8,
			"while (" => -8,
			'WORD_SCOPED' => -8,
			"foreach my" => -8,
			"\@{" => -8,
			"undef" => -8,
			"## no critic qw(" => 21,
			'OP05_MATH_NEG' => -8
		},
		GOTOS => {
			'Critic' => 22,
			'STAR-3' => 23
		}
	},
	{#State 19
		ACTIONS => {
			"use" => -19,
			"use parent qw(" => 24,
			"our" => -19,
			"## no critic qw(" => -19,
			"use constant" => -19
		},
		GOTOS => {
			'STAR-7' => 25
		}
	},
	{#State 20
		ACTIONS => {
			"our \$VERSION =" => 26
		}
	},
	{#State 21
		ACTIONS => {
			'WORD' => 28
		},
		GOTOS => {
			'PLUS-11' => 27
		}
	},
	{#State 22
		DEFAULT => -5
	},
	{#State 23
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			"use constant" => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			'LITERAL' => -10,
			"{" => -10,
			"our" => -10,
			'OP05_LOGICAL_NEG' => -10,
			'OP05_MATH_NEG' => -10,
			"undef" => -10,
			'OP03_MATH_INC_DEC' => -10,
			'OP22_LOGICAL_NOT' => -10,
			"foreach my" => -10,
			"\@{" => -10,
			"use" => 31,
			'WORD_SCOPED' => -10,
			'OP19_LOOP_CONTROL' => -10,
			"while (" => -10,
			'WORD' => -10,
			'OP01_NAMED_VOID' => -10,
			"%{" => -10,
			'VARIABLE_SYMBOL' => -10,
			"[" => -10,
			"if (" => -10,
			"for my integer" => -10,
			'OP10_NAMED_UNARY' => -10,
			"(" => -10,
			"my" => -10,
			'OP01_NAMED' => -10
		},
		GOTOS => {
			'STAR-4' => 29,
			'Include' => 30
		}
	},
	{#State 24
		ACTIONS => {
			'WORD' => 9,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 25
		ACTIONS => {
			"our" => -21,
			"use" => -21,
			"use constant" => -21,
			"## no critic qw(" => 21
		},
		GOTOS => {
			'Critic' => 34,
			'STAR-8' => 33
		}
	},
	{#State 26
		ACTIONS => {
			'VERSION_NUMBER' => 35
		}
	},
	{#State 27
		ACTIONS => {
			")" => 36,
			'WORD' => 37
		}
	},
	{#State 28
		DEFAULT => -29
	},
	{#State 29
		ACTIONS => {
			"foreach my" => -12,
			"\@{" => -12,
			"while (" => -12,
			'WORD_SCOPED' => -12,
			'OP19_LOOP_CONTROL' => -12,
			'OP22_LOGICAL_NOT' => -12,
			'OP03_MATH_INC_DEC' => -12,
			'OP05_MATH_NEG' => -12,
			"undef" => -12,
			'OP05_LOGICAL_NEG' => -12,
			"{" => -12,
			"our" => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			'LITERAL' => -12,
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			"use constant" => 39,
			'OP01_NAMED' => -12,
			'OP10_NAMED_UNARY' => -12,
			"(" => -12,
			"for my integer" => -12,
			"my" => -12,
			"if (" => -12,
			"[" => -12,
			'VARIABLE_SYMBOL' => -12,
			'OP01_NAMED_VOID' => -12,
			'WORD' => -12,
			"%{" => -12
		},
		GOTOS => {
			'STAR-5' => 38,
			'Constant' => 40
		}
	},
	{#State 30
		DEFAULT => -7
	},
	{#State 31
		ACTIONS => {
			'WORD_SCOPED' => 11,
			'WORD' => 9
		},
		GOTOS => {
			'WordScoped' => 41
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
			"our" => -23,
			"use" => 31
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
		ACTIONS => {
			";" => 45
		}
	},
	{#State 36
		DEFAULT => -30
	},
	{#State 37
		DEFAULT => -28
	},
	{#State 38
		ACTIONS => {
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"foreach my" => -157,
			"\@{" => 61,
			"while (" => -157,
			'WORD_SCOPED' => 11,
			'OP19_LOOP_CONTROL' => 82,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP01_NAMED_VOID_PAREN' => 66,
			'LITERAL' => 68,
			"our" => 69,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			"[" => 76,
			"if (" => 77,
			"(" => 50,
			"for my integer" => -157,
			'OP10_NAMED_UNARY' => 48,
			"my" => 49,
			'OP01_NAMED' => 78,
			"%{" => 53,
			'WORD' => 52,
			'OP01_NAMED_VOID' => 51,
			'VARIABLE_SYMBOL' => 56
		},
		GOTOS => {
			'Variable' => 55,
			'Subroutine' => 79,
			'Statement' => 54,
			'WordScoped' => 75,
			'Expression' => 74,
			'OperatorVoid' => 46,
			'HashDereferenced' => 47,
			'ArrayReference' => 85,
			'LoopLabel' => 71,
			'Conditional' => 86,
			'PLUS-6' => 73,
			'Operator' => 63,
			'VariableModification' => 65,
			'VariableDeclaration' => 84,
			'PAREN-49' => 64,
			'ArrayDereferenced' => 67,
			'HashReference' => 81,
			'OPTIONAL-50' => 62,
			'Operation' => 57
		}
	},
	{#State 39
		ACTIONS => {
			'WORD' => 87
		}
	},
	{#State 40
		DEFAULT => -9
	},
	{#State 41
		ACTIONS => {
			"qw(" => 88,
			";" => 89
		}
	},
	{#State 42
		ACTIONS => {
			";" => 90
		}
	},
	{#State 43
		DEFAULT => -20
	},
	{#State 44
		ACTIONS => {
			"use constant" => 39,
			"our" => 69
		},
		GOTOS => {
			'Subroutine' => 92,
			'PLUS-10' => 91,
			'Constant' => 93
		}
	},
	{#State 45
		DEFAULT => -27
	},
	{#State 46
		DEFAULT => -160
	},
	{#State 47
		DEFAULT => -149
	},
	{#State 48
		ACTIONS => {
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			'OP01_NAMED' => 78,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60
		},
		GOTOS => {
			'HashDereferenced' => 47,
			'WordScoped' => 75,
			'Expression' => 95,
			'HashReference' => 81,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'ArrayReference' => 85,
			'Variable' => 94
		}
	},
	{#State 49
		ACTIONS => {
			'WORD' => 97
		},
		GOTOS => {
			'Type' => 96
		}
	},
	{#State 50
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56,
			"%{" => 53,
			'WORD' => 9,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			"[" => 76,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			"undef" => 58,
			'OP05_MATH_NEG' => 59
		},
		GOTOS => {
			'HashReference' => 81,
			'Expression' => 98,
			'WordScoped' => 75,
			'HashDereferenced' => 47,
			'ArrayReference' => 85,
			'Variable' => 94,
			'Operator' => 63,
			'ArrayDereferenced' => 67
		}
	},
	{#State 51
		ACTIONS => {
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			"{*" => 101,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP05_LOGICAL_NEG' => 72,
			'KEYS_OR_VALUES' => 103,
			"{" => 70,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP01_NAMED' => 78,
			"my" => 105,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			"[" => 76,
			";" => -131,
			'VARIABLE_SYMBOL' => 56,
			"%{" => 53,
			'WORD' => 9
		},
		GOTOS => {
			'OPTIONAL-45' => 106,
			'ListElements' => 104,
			'HashDereferenced' => 47,
			'WordScoped' => 75,
			'Expression' => 99,
			'ListElement' => 102,
			'HashReference' => 81,
			'TypeInner' => 107,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'ArrayReference' => 85,
			'FileHandle' => 100,
			'Variable' => 94
		}
	},
	{#State 52
		ACTIONS => {
			"(" => -213,
			'COLON' => -219
		}
	},
	{#State 53
		ACTIONS => {
			"{" => 109,
			'VARIABLE_SYMBOL' => 56
		},
		GOTOS => {
			'Variable' => 108,
			'HashReference' => 110
		}
	},
	{#State 54
		DEFAULT => -99
	},
	{#State 55
		ACTIONS => {
			'OP23_LOGICAL_AND' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP02_METHOD_THINARROW' => 112,
			'OP18_TERNARY' => -145,
			'OP19_VARIABLE_ASSIGN' => 113,
			";" => -145,
			'OP13_BITWISE_AND' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP04_MATH_POW' => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 111,
			'OP06_REGEX_MATCH' => -145,
			'OP03_MATH_INC_DEC' => 114,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP08_STRING_CAT' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145
		}
	},
	{#State 56
		DEFAULT => -180,
		GOTOS => {
			'STAR-56' => 115
		}
	},
	{#State 57
		DEFAULT => -14
	},
	{#State 58
		DEFAULT => -143
	},
	{#State 59
		ACTIONS => {
			"[" => 76,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72
		},
		GOTOS => {
			'HashDereferenced' => 47,
			'WordScoped' => 75,
			'Expression' => 116,
			'HashReference' => 81,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'ArrayReference' => 85,
			'Variable' => 94
		}
	},
	{#State 60
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'ArrayReference' => 85,
			'Variable' => 94,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'Expression' => 117,
			'WordScoped' => 75
		}
	},
	{#State 61
		ACTIONS => {
			"[" => 76,
			'VARIABLE_SYMBOL' => 56
		},
		GOTOS => {
			'ArrayReference' => 119,
			'Variable' => 118
		}
	},
	{#State 62
		ACTIONS => {
			"foreach my" => 122,
			"while (" => 125,
			"for my integer" => 123
		},
		GOTOS => {
			'LoopWhile' => 120,
			'Loop' => 124,
			'LoopFor' => 121,
			'LoopForEach' => 126
		}
	},
	{#State 63
		DEFAULT => -151
	},
	{#State 64
		DEFAULT => -156
	},
	{#State 65
		DEFAULT => -162
	},
	{#State 66
		ACTIONS => {
			"{*" => 101,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'KEYS_OR_VALUES' => 103,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY' => 48,
			")" => -127,
			"my" => 105,
			"(" => 50,
			'OP01_NAMED' => 78,
			"[" => 76,
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 9,
			"%{" => 53
		},
		GOTOS => {
			'ArrayReference' => 85,
			'FileHandle' => 127,
			'Variable' => 94,
			'Operator' => 63,
			'TypeInner' => 107,
			'ArrayDereferenced' => 67,
			'HashReference' => 81,
			'OPTIONAL-43' => 128,
			'ListElement' => 102,
			'WordScoped' => 75,
			'Expression' => 99,
			'HashDereferenced' => 47,
			'ListElements' => 129
		}
	},
	{#State 67
		DEFAULT => -147
	},
	{#State 68
		DEFAULT => -144
	},
	{#State 69
		ACTIONS => {
			'WORD' => 97
		},
		GOTOS => {
			'Type' => 130
		}
	},
	{#State 70
		ACTIONS => {
			"%{" => 53,
			"}" => 133,
			'WORD' => 131
		},
		GOTOS => {
			'HashEntry' => 134,
			'HashDereferenced' => 132
		}
	},
	{#State 71
		ACTIONS => {
			'COLON' => 135
		}
	},
	{#State 72
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56,
			"%{" => 53,
			'WORD' => 9,
			'OP01_NAMED' => 78,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			"[" => 76,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_MATH_NEG' => 59
		},
		GOTOS => {
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'Variable' => 94,
			'ArrayReference' => 85,
			'Expression' => 136,
			'WordScoped' => 75,
			'HashDereferenced' => 47,
			'HashReference' => 81
		}
	},
	{#State 73
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP01_NAMED_VOID_PAREN' => 66,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'' => -15,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 61,
			"foreach my" => -157,
			'WORD_SCOPED' => 11,
			"while (" => -157,
			'OP19_LOOP_CONTROL' => 82,
			'OP01_NAMED_VOID' => 51,
			"%{" => 53,
			'WORD' => 52,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			"if (" => 77,
			"my" => 49,
			"for my integer" => -157,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'Variable' => 55,
			'Statement' => 54,
			'HashDereferenced' => 47,
			'Expression' => 74,
			'OperatorVoid' => 46,
			'WordScoped' => 75,
			'Conditional' => 86,
			'LoopLabel' => 71,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'VariableDeclaration' => 84,
			'VariableModification' => 65,
			'PAREN-49' => 64,
			'OPTIONAL-50' => 62,
			'HashReference' => 81,
			'Operation' => 137
		}
	},
	{#State 74
		ACTIONS => {
			'OP15_LOGICAL_AND' => 151,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP11_COMPARE_LT_GT' => 142,
			'OP23_LOGICAL_AND' => 144,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP13_BITWISE_AND' => 138,
			";" => 139,
			'OP18_TERNARY' => 141,
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP17_LIST_RANGE' => 152,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP14_BITWISE_OR_XOR' => 153
		}
	},
	{#State 75
		ACTIONS => {
			"(" => 155
		}
	},
	{#State 76
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56,
			"%{" => 53,
			'WORD' => 9,
			"(" => 50,
			"my" => 158,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			"[" => 76,
			'KEYS_OR_VALUES' => 103,
			"{" => 70,
			"]" => -197,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			"undef" => 58,
			'OP05_MATH_NEG' => 59
		},
		GOTOS => {
			'ListElement' => 102,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'ListElements' => 156,
			'OPTIONAL-59' => 157,
			'Expression' => 99,
			'WordScoped' => 75,
			'Variable' => 94,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'TypeInner' => 107,
			'Operator' => 63
		}
	},
	{#State 77
		ACTIONS => {
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			'OP01_NAMED' => 78,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60
		},
		GOTOS => {
			'HashReference' => 81,
			'WordScoped' => 75,
			'Expression' => 159,
			'HashDereferenced' => 47,
			'Variable' => 94,
			'ArrayReference' => 85,
			'Operator' => 63,
			'ArrayDereferenced' => 67
		}
	},
	{#State 78
		ACTIONS => {
			"(" => 160
		}
	},
	{#State 79
		DEFAULT => -11
	},
	{#State 80
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56
		},
		GOTOS => {
			'Variable' => 161
		}
	},
	{#State 81
		DEFAULT => -148
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
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 9,
			"%{" => 53,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78,
			"[" => 76,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			"undef" => 58,
			'OP05_MATH_NEG' => 59
		},
		GOTOS => {
			'Variable' => 94,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'Expression' => 164,
			'WordScoped' => 75
		}
	},
	{#State 84
		DEFAULT => -161
	},
	{#State 85
		DEFAULT => -146
	},
	{#State 86
		DEFAULT => -158
	},
	{#State 87
		ACTIONS => {
			'OP20_HASH_FATARROW' => 165
		}
	},
	{#State 88
		ACTIONS => {
			'WORD' => 166
		},
		GOTOS => {
			'PLUS-12' => 167
		}
	},
	{#State 89
		DEFAULT => -33
	},
	{#State 90
		ACTIONS => {
			"use" => 31
		},
		GOTOS => {
			'Include' => 168
		}
	},
	{#State 91
		ACTIONS => {
			"our" => 69,
			"1, 1;" => 170
		},
		GOTOS => {
			'Subroutine' => 169
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
			'OP03_MATH_INC_DEC' => 114,
			'OP06_REGEX_MATCH' => -145,
			".." => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP08_STRING_CAT' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			"]" => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			")" => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP02_METHOD_THINARROW' => 112,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			"}" => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP04_MATH_POW' => -145,
			";" => -145,
			'OP13_BITWISE_AND' => -145,
			'OP18_TERNARY' => -145,
			'OP21_LIST_COMMA' => -145
		}
	},
	{#State 95
		ACTIONS => {
			"]" => -113,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_MATH_ADD_SUB' => 146,
			'OP08_STRING_CAT' => 145,
			'OP17_LIST_RANGE' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP09_BITWISE_SHIFT' => 154,
			".." => -113,
			'OP06_REGEX_MATCH' => 149,
			'OP13_BITWISE_AND' => -113,
			";" => -113,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP18_TERNARY' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP12_COMPARE_EQ_NEQ' => -113,
			'OP15_LOGICAL_AND' => -113,
			")" => -113,
			'OP23_LOGICAL_AND' => -113,
			"}" => -113
		}
	},
	{#State 96
		ACTIONS => {
			'VARIABLE_SYMBOL' => 171
		}
	},
	{#State 97
		DEFAULT => -218
	},
	{#State 98
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP17_LIST_RANGE' => 152,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP23_LOGICAL_AND' => 144,
			'OP11_COMPARE_LT_GT' => 142,
			'OP15_LOGICAL_AND' => 151,
			'OP12_COMPARE_EQ_NEQ' => 143,
			")" => 172,
			'OP18_TERNARY' => 141,
			'OP13_BITWISE_AND' => 138,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150
		}
	},
	{#State 99
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 146,
			'OP08_STRING_CAT' => 145,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			"]" => -193,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 140,
			";" => -193,
			'OP13_BITWISE_AND' => 138,
			'OP18_TERNARY' => 141,
			'OP21_LIST_COMMA' => -193,
			")" => -193,
			'OP15_LOGICAL_AND' => 151,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP11_COMPARE_LT_GT' => 142,
			'OP23_LOGICAL_AND' => 144
		}
	},
	{#State 100
		ACTIONS => {
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			'KEYS_OR_VALUES' => 103,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			"[" => 76,
			"my" => 158,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78,
			"%{" => 53,
			'WORD' => 9,
			'VARIABLE_SYMBOL' => 56,
			";" => -133
		},
		GOTOS => {
			'ListElement' => 102,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'ListElements' => 173,
			'WordScoped' => 75,
			'Expression' => 99,
			'OPTIONAL-46' => 174,
			'Variable' => 94,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'TypeInner' => 107,
			'Operator' => 63
		}
	},
	{#State 101
		ACTIONS => {
			'WORD' => 175
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
			"%{" => 53
		},
		GOTOS => {
			'HashDereferenced' => 177
		}
	},
	{#State 104
		DEFAULT => -130
	},
	{#State 105
		ACTIONS => {
			"filehandle_ref" => 178,
			'WORD' => 97
		},
		GOTOS => {
			'Type' => 179
		}
	},
	{#State 106
		ACTIONS => {
			";" => 180
		}
	},
	{#State 107
		ACTIONS => {
			"[" => 76,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78,
			"%{" => 53,
			'WORD' => 9,
			'VARIABLE_SYMBOL' => 56,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72
		},
		GOTOS => {
			'ArrayReference' => 85,
			'Variable' => 94,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'Expression' => 181,
			'WordScoped' => 75
		}
	},
	{#State 108
		ACTIONS => {
			"}" => 182
		}
	},
	{#State 109
		ACTIONS => {
			'WORD' => 131,
			"%{" => 53
		},
		GOTOS => {
			'HashDereferenced' => 132,
			'HashEntry' => 134
		}
	},
	{#State 110
		ACTIONS => {
			"}" => 183
		}
	},
	{#State 111
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			"[" => 76,
			'VARIABLE_SYMBOL' => 56,
			"%{" => 53,
			'WORD' => 9
		},
		GOTOS => {
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'Variable' => 94,
			'ArrayReference' => 85,
			'WordScoped' => 75,
			'Expression' => 184,
			'HashDereferenced' => 47,
			'HashReference' => 81
		}
	},
	{#State 112
		ACTIONS => {
			'WORD' => 185
		}
	},
	{#State 113
		ACTIONS => {
			"%{" => 53,
			'WORD' => 9,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			'OP01_NAMED' => 78,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60
		},
		GOTOS => {
			'WordScoped' => 75,
			'Expression' => 186,
			'HashDereferenced' => 47,
			'HashReference' => 81,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'ArrayReference' => 85,
			'Variable' => 94
		}
	},
	{#State 114
		DEFAULT => -104
	},
	{#State 115
		ACTIONS => {
			'OP18_TERNARY' => -181,
			'COLON' => -181,
			'OP21_LIST_COMMA' => -181,
			'OP16_LOGICAL_OR' => -181,
			'OP04_MATH_POW' => -181,
			";" => -181,
			'OP13_BITWISE_AND' => -181,
			'OP19_VARIABLE_ASSIGN' => -181,
			'OP02_ARRAY_THINARROW' => 187,
			"}" => -181,
			'OP23_LOGICAL_AND' => -181,
			")" => -181,
			'OP15_LOGICAL_AND' => -181,
			'OP12_COMPARE_EQ_NEQ' => -181,
			'OP02_METHOD_THINARROW' => -181,
			'OP11_COMPARE_LT_GT' => -181,
			'OP24_LOGICAL_OR_XOR' => -181,
			'OP14_BITWISE_OR_XOR' => -181,
			'OP08_MATH_ADD_SUB' => -181,
			'OP17_LIST_RANGE' => -181,
			'OP08_STRING_CAT' => -181,
			'OP07_MATH_MULT_DIV_MOD' => -181,
			"]" => -181,
			'OP02_HASH_THINARROW' => 188,
			'OP19_VARIABLE_ASSIGN_BY' => -181,
			'OP06_REGEX_MATCH' => -181,
			'OP09_BITWISE_SHIFT' => -181,
			".." => -181,
			'OP03_MATH_INC_DEC' => -181
		},
		GOTOS => {
			'VariableRetrieval' => 189
		}
	},
	{#State 116
		ACTIONS => {
			'OP18_TERNARY' => 141,
			'OP13_BITWISE_AND' => 138,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 140,
			'OP23_LOGICAL_AND' => 144,
			'OP11_COMPARE_LT_GT' => 142,
			")" => 190,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 117
		ACTIONS => {
			'OP23_LOGICAL_AND' => -123,
			"}" => -123,
			'OP11_COMPARE_LT_GT' => 142,
			")" => -123,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP21_LIST_COMMA' => -123,
			'OP18_TERNARY' => 141,
			'OP13_BITWISE_AND' => 138,
			";" => -123,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 140,
			'OP09_BITWISE_SHIFT' => 154,
			".." => -123,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => -123,
			"]" => -123,
			'OP08_MATH_ADD_SUB' => 146,
			'OP08_STRING_CAT' => 145,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 147
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
		DEFAULT => -172
	},
	{#State 121
		DEFAULT => -170
	},
	{#State 122
		ACTIONS => {
			'WORD' => 97
		},
		GOTOS => {
			'Type' => 193
		}
	},
	{#State 123
		ACTIONS => {
			'VARIABLE_SYMBOL' => 194
		}
	},
	{#State 124
		DEFAULT => -159
	},
	{#State 125
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			"[" => 76,
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 9,
			"%{" => 53
		},
		GOTOS => {
			'ArrayReference' => 85,
			'Variable' => 94,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'HashReference' => 81,
			'Expression' => 195,
			'WordScoped' => 75,
			'HashDereferenced' => 47
		}
	},
	{#State 126
		DEFAULT => -171
	},
	{#State 127
		ACTIONS => {
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'KEYS_OR_VALUES' => 103,
			'OP05_LOGICAL_NEG' => 72,
			"[" => 76,
			"my" => 158,
			")" => -129,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			"%{" => 53,
			'WORD' => 9,
			'VARIABLE_SYMBOL' => 56
		},
		GOTOS => {
			'ArrayReference' => 85,
			'Variable' => 94,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'TypeInner' => 107,
			'HashReference' => 81,
			'OPTIONAL-44' => 196,
			'ListElement' => 102,
			'WordScoped' => 75,
			'Expression' => 99,
			'ListElements' => 197,
			'HashDereferenced' => 47
		}
	},
	{#State 128
		ACTIONS => {
			")" => 198
		}
	},
	{#State 129
		DEFAULT => -126
	},
	{#State 130
		ACTIONS => {
			'VARIABLE_SYMBOL' => 199
		}
	},
	{#State 131
		ACTIONS => {
			'OP20_HASH_FATARROW' => 200
		}
	},
	{#State 132
		DEFAULT => -204
	},
	{#State 133
		DEFAULT => -150
	},
	{#State 134
		DEFAULT => -209,
		GOTOS => {
			'STAR-62' => 201
		}
	},
	{#State 135
		DEFAULT => -155
	},
	{#State 136
		ACTIONS => {
			'OP15_LOGICAL_AND' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			")" => -106,
			'OP11_COMPARE_LT_GT' => -106,
			"}" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => -106,
			";" => -106,
			'OP13_BITWISE_AND' => -106,
			'OP18_TERNARY' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP06_REGEX_MATCH' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			".." => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP08_STRING_CAT' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			"]" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP14_BITWISE_OR_XOR' => -106
		}
	},
	{#State 137
		DEFAULT => -13
	},
	{#State 138
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78,
			"[" => 76,
			'VARIABLE_SYMBOL' => 56,
			"%{" => 53,
			'WORD' => 9
		},
		GOTOS => {
			'Expression' => 202,
			'WordScoped' => 75,
			'HashDereferenced' => 47,
			'HashReference' => 81,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'Variable' => 94,
			'ArrayReference' => 85
		}
	},
	{#State 139
		DEFAULT => -98
	},
	{#State 140
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 9,
			"%{" => 53,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78,
			"[" => 76,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP05_MATH_NEG' => 59,
			"undef" => 58
		},
		GOTOS => {
			'Variable' => 94,
			'ArrayReference' => 85,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'HashReference' => 81,
			'Expression' => 203,
			'WordScoped' => 75,
			'HashDereferenced' => 47
		}
	},
	{#State 141
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56
		},
		GOTOS => {
			'Variable' => 204
		}
	},
	{#State 142
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 9,
			"%{" => 53,
			'OP01_NAMED' => 78,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			"[" => 76,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_MATH_NEG' => 59
		},
		GOTOS => {
			'WordScoped' => 75,
			'Expression' => 205,
			'HashDereferenced' => 47,
			'HashReference' => 81,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'ArrayReference' => 85,
			'Variable' => 94
		}
	},
	{#State 143
		ACTIONS => {
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 61,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'ArrayReference' => 85,
			'Variable' => 94,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'HashReference' => 81,
			'WordScoped' => 75,
			'Expression' => 206,
			'HashDereferenced' => 47
		}
	},
	{#State 144
		ACTIONS => {
			"[" => 76,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72
		},
		GOTOS => {
			'HashReference' => 81,
			'Expression' => 207,
			'WordScoped' => 75,
			'HashDereferenced' => 47,
			'ArrayReference' => 85,
			'Variable' => 94,
			'Operator' => 63,
			'ArrayDereferenced' => 67
		}
	},
	{#State 145
		ACTIONS => {
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP01_NAMED' => 78,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			"[" => 76,
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 9,
			"%{" => 53
		},
		GOTOS => {
			'ArrayReference' => 85,
			'Variable' => 94,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'Expression' => 208,
			'WordScoped' => 75
		}
	},
	{#State 146
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78,
			"[" => 76,
			'VARIABLE_SYMBOL' => 56,
			"%{" => 53,
			'WORD' => 9
		},
		GOTOS => {
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'ArrayReference' => 85,
			'Variable' => 94,
			'HashDereferenced' => 47,
			'WordScoped' => 75,
			'Expression' => 209,
			'HashReference' => 81
		}
	},
	{#State 147
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'ArrayReference' => 85,
			'Variable' => 94,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'Expression' => 210,
			'WordScoped' => 75
		}
	},
	{#State 148
		ACTIONS => {
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"%{" => 53,
			'WORD' => 9,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			'OP01_NAMED' => 78,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50
		},
		GOTOS => {
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'Variable' => 94,
			'ArrayReference' => 85,
			'Expression' => 211,
			'WordScoped' => 75,
			'HashDereferenced' => 47,
			'HashReference' => 81
		}
	},
	{#State 149
		ACTIONS => {
			"/" => 212
		}
	},
	{#State 150
		ACTIONS => {
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			'OP01_NAMED' => 78,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48
		},
		GOTOS => {
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'Expression' => 213,
			'WordScoped' => 75,
			'Variable' => 94,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'Operator' => 63
		}
	},
	{#State 151
		ACTIONS => {
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			"[" => 76,
			'OP01_NAMED' => 78,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 53,
			'WORD' => 9,
			'VARIABLE_SYMBOL' => 56
		},
		GOTOS => {
			'ArrayReference' => 85,
			'Variable' => 94,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'Expression' => 214,
			'WordScoped' => 75
		}
	},
	{#State 152
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'HashReference' => 81,
			'Expression' => 215,
			'WordScoped' => 75,
			'HashDereferenced' => 47,
			'Variable' => 94,
			'ArrayReference' => 85,
			'Operator' => 63,
			'ArrayDereferenced' => 67
		}
	},
	{#State 153
		ACTIONS => {
			"[" => 76,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72
		},
		GOTOS => {
			'WordScoped' => 75,
			'Expression' => 216,
			'HashDereferenced' => 47,
			'HashReference' => 81,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'ArrayReference' => 85,
			'Variable' => 94
		}
	},
	{#State 154
		ACTIONS => {
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			"[" => 76,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56
		},
		GOTOS => {
			'Variable' => 94,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'WordScoped' => 75,
			'Expression' => 217
		}
	},
	{#State 155
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'KEYS_OR_VALUES' => 103,
			'OP05_LOGICAL_NEG' => 72,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			"%{" => 53,
			'WORD' => 9,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			"(" => 50,
			")" => -140,
			"my" => 158,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'ArrayReference' => 85,
			'OPTIONAL-47' => 218,
			'Variable' => 94,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'TypeInner' => 107,
			'HashReference' => 81,
			'ListElement' => 102,
			'WordScoped' => 75,
			'Expression' => 99,
			'ListElements' => 219,
			'HashDereferenced' => 47
		}
	},
	{#State 156
		DEFAULT => -196
	},
	{#State 157
		ACTIONS => {
			"]" => 220
		}
	},
	{#State 158
		ACTIONS => {
			'WORD' => 97
		},
		GOTOS => {
			'Type' => 179
		}
	},
	{#State 159
		ACTIONS => {
			'OP13_BITWISE_AND' => 138,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			")" => 221,
			'OP23_LOGICAL_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP17_LIST_RANGE' => 152,
			'OP08_MATH_ADD_SUB' => 146,
			'OP08_STRING_CAT' => 145,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 160
		ACTIONS => {
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'OP05_LOGICAL_NEG' => 72,
			'KEYS_OR_VALUES' => 103,
			"{" => 70,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP01_NAMED' => 78,
			")" => -101,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			"my" => 158,
			"[" => 76,
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 9,
			"%{" => 53
		},
		GOTOS => {
			'Operator' => 63,
			'TypeInner' => 107,
			'ArrayDereferenced' => 67,
			'ArrayReference' => 85,
			'Variable' => 94,
			'WordScoped' => 75,
			'Expression' => 99,
			'OPTIONAL-42' => 223,
			'HashDereferenced' => 47,
			'ListElements' => 222,
			'HashReference' => 81,
			'ListElement' => 102
		}
	},
	{#State 161
		DEFAULT => -103
	},
	{#State 162
		ACTIONS => {
			";" => 224
		}
	},
	{#State 163
		DEFAULT => -219
	},
	{#State 164
		ACTIONS => {
			'OP23_LOGICAL_AND' => -114,
			"}" => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP12_COMPARE_EQ_NEQ' => -114,
			'OP15_LOGICAL_AND' => -114,
			")" => -114,
			'OP21_LIST_COMMA' => -114,
			'OP18_TERNARY' => -114,
			'OP13_BITWISE_AND' => -114,
			";" => -114,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => -114,
			".." => -114,
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			"]" => -114,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => -114
		}
	},
	{#State 165
		ACTIONS => {
			"my" => 158
		},
		GOTOS => {
			'TypeInner' => 225
		}
	},
	{#State 166
		DEFAULT => -32
	},
	{#State 167
		ACTIONS => {
			")" => 226,
			'WORD' => 227
		}
	},
	{#State 168
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 228
		}
	},
	{#State 169
		DEFAULT => -24
	},
	{#State 170
		DEFAULT => -26
	},
	{#State 171
		ACTIONS => {
			";" => 230,
			'OP19_VARIABLE_ASSIGN' => 229
		}
	},
	{#State 172
		DEFAULT => -154
	},
	{#State 173
		DEFAULT => -132
	},
	{#State 174
		ACTIONS => {
			";" => 231
		}
	},
	{#State 175
		ACTIONS => {
			"}" => 232
		}
	},
	{#State 176
		ACTIONS => {
			'OP21_LIST_COMMA' => 234,
			")" => -192,
			"]" => -192,
			";" => -192
		},
		GOTOS => {
			'PAREN-57' => 233
		}
	},
	{#State 177
		DEFAULT => -195
	},
	{#State 178
		ACTIONS => {
			'VARIABLE_SYMBOL' => 235
		}
	},
	{#State 179
		ACTIONS => {
			"\$TYPED_" => 236
		}
	},
	{#State 180
		DEFAULT => -136
	},
	{#State 181
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149,
			"]" => -194,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP17_LIST_RANGE' => 152,
			'OP08_MATH_ADD_SUB' => 146,
			'OP08_STRING_CAT' => 145,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 142,
			'OP15_LOGICAL_AND' => 151,
			'OP12_COMPARE_EQ_NEQ' => 143,
			")" => -194,
			'OP23_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 138,
			";" => -194,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP21_LIST_COMMA' => -194,
			'OP18_TERNARY' => 141
		}
	},
	{#State 182
		DEFAULT => -211
	},
	{#State 183
		DEFAULT => -212
	},
	{#State 184
		ACTIONS => {
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP13_BITWISE_AND' => 138,
			";" => 237,
			'OP18_TERNARY' => 141,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 142,
			'OP23_LOGICAL_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => 152,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154
		}
	},
	{#State 185
		ACTIONS => {
			"(" => 238
		}
	},
	{#State 186
		ACTIONS => {
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154,
			'OP17_LIST_RANGE' => 152,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 142,
			'OP23_LOGICAL_AND' => 144,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 140,
			'OP13_BITWISE_AND' => 138,
			";" => 239,
			'OP18_TERNARY' => 141
		}
	},
	{#State 187
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 9,
			"%{" => 53,
			'OP01_NAMED' => 78,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			"[" => 76,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'OP05_MATH_NEG' => 59,
			"undef" => 58
		},
		GOTOS => {
			'Variable' => 94,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'Expression' => 240,
			'WordScoped' => 75
		}
	},
	{#State 188
		ACTIONS => {
			"[" => 76,
			'OP01_NAMED' => 78,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'WORD' => 241,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70
		},
		GOTOS => {
			'HashDereferenced' => 47,
			'WordScoped' => 75,
			'Expression' => 242,
			'HashReference' => 81,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'ArrayReference' => 85,
			'Variable' => 94
		}
	},
	{#State 189
		DEFAULT => -179
	},
	{#State 190
		DEFAULT => -107
	},
	{#State 191
		DEFAULT => -199
	},
	{#State 192
		DEFAULT => -200
	},
	{#State 193
		ACTIONS => {
			'VARIABLE_SYMBOL' => 243
		}
	},
	{#State 194
		ACTIONS => {
			"(" => 244
		}
	},
	{#State 195
		ACTIONS => {
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154,
			'OP08_STRING_CAT' => 145,
			'OP17_LIST_RANGE' => 152,
			'OP08_MATH_ADD_SUB' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP14_BITWISE_OR_XOR' => 153,
			")" => 245,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 142,
			'OP23_LOGICAL_AND' => 144,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 140,
			'OP13_BITWISE_AND' => 138,
			'OP18_TERNARY' => 141
		}
	},
	{#State 196
		ACTIONS => {
			")" => 246
		}
	},
	{#State 197
		DEFAULT => -128
	},
	{#State 198
		ACTIONS => {
			";" => 247
		}
	},
	{#State 199
		ACTIONS => {
			"= sub {" => 248
		}
	},
	{#State 200
		ACTIONS => {
			'VARIABLE_SYMBOL' => -202,
			"%{" => -202,
			'WORD' => -202,
			"my" => 158,
			'OP10_NAMED_UNARY' => -202,
			"(" => -202,
			'OP01_NAMED' => -202,
			"[" => -202,
			"{" => -202,
			'OP05_LOGICAL_NEG' => -202,
			'OP10_NAMED_UNARY_STRINGIFY' => -202,
			'LITERAL' => -202,
			'OP03_MATH_INC_DEC' => -202,
			'OP22_LOGICAL_NOT' => -202,
			'WORD_SCOPED' => -202,
			"\@{" => -202,
			"undef" => -202,
			'OP05_MATH_NEG' => -202
		},
		GOTOS => {
			'OPTIONAL-60' => 249,
			'TypeInner' => 250
		}
	},
	{#State 201
		ACTIONS => {
			"}" => 253,
			'OP21_LIST_COMMA' => 252
		},
		GOTOS => {
			'PAREN-61' => 251
		}
	},
	{#State 202
		ACTIONS => {
			'OP08_STRING_CAT' => 145,
			'OP17_LIST_RANGE' => -117,
			'OP08_MATH_ADD_SUB' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			"]" => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP06_REGEX_MATCH' => 149,
			".." => -117,
			'OP09_BITWISE_SHIFT' => 154,
			'OP16_LOGICAL_OR' => -117,
			'OP04_MATH_POW' => 140,
			'OP13_BITWISE_AND' => -117,
			";" => -117,
			'OP18_TERNARY' => -117,
			'OP21_LIST_COMMA' => -117,
			")" => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP11_COMPARE_LT_GT' => 142,
			"}" => -117,
			'OP23_LOGICAL_AND' => -117
		}
	},
	{#State 203
		ACTIONS => {
			".." => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP06_REGEX_MATCH' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			"]" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP08_STRING_CAT' => -105,
			'OP08_MATH_ADD_SUB' => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP23_LOGICAL_AND' => -105,
			"}" => -105,
			'OP11_COMPARE_LT_GT' => -105,
			")" => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP18_TERNARY' => -105,
			'OP13_BITWISE_AND' => -105,
			";" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP04_MATH_POW' => 140
		}
	},
	{#State 204
		ACTIONS => {
			'COLON' => 254
		}
	},
	{#State 205
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			"]" => -115,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			".." => -115,
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -115,
			'OP18_TERNARY' => -115,
			";" => -115,
			'OP13_BITWISE_AND' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP04_MATH_POW' => 140,
			'OP23_LOGICAL_AND' => -115,
			"}" => -115,
			'OP11_COMPARE_LT_GT' => undef,
			")" => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP12_COMPARE_EQ_NEQ' => -115
		}
	},
	{#State 206
		ACTIONS => {
			'OP21_LIST_COMMA' => -116,
			'OP18_TERNARY' => -116,
			";" => -116,
			'OP13_BITWISE_AND' => -116,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => -116,
			'OP23_LOGICAL_AND' => -116,
			"}" => -116,
			'OP11_COMPARE_LT_GT' => 142,
			'OP15_LOGICAL_AND' => -116,
			'OP12_COMPARE_EQ_NEQ' => undef,
			")" => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			"]" => -116,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => -116,
			'OP08_STRING_CAT' => 145,
			'OP09_BITWISE_SHIFT' => 154,
			".." => -116,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 207
		ACTIONS => {
			"]" => -124,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_MATH_ADD_SUB' => 146,
			'OP08_STRING_CAT' => 145,
			'OP17_LIST_RANGE' => 152,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP09_BITWISE_SHIFT' => 154,
			".." => -124,
			'OP06_REGEX_MATCH' => 149,
			'OP13_BITWISE_AND' => 138,
			";" => -124,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP21_LIST_COMMA' => -124,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 142,
			'OP15_LOGICAL_AND' => 151,
			'OP12_COMPARE_EQ_NEQ' => 143,
			")" => -124,
			'OP23_LOGICAL_AND' => -124,
			"}" => -124
		}
	},
	{#State 208
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			"]" => -111,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP17_LIST_RANGE' => -111,
			'OP08_STRING_CAT' => -111,
			'OP08_MATH_ADD_SUB' => 146,
			".." => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -111,
			'OP18_TERNARY' => -111,
			";" => -111,
			'OP13_BITWISE_AND' => -111,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => -111,
			'OP23_LOGICAL_AND' => -111,
			"}" => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP15_LOGICAL_AND' => -111,
			")" => -111
		}
	},
	{#State 209
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			"]" => -110,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_MATH_ADD_SUB' => -110,
			'OP17_LIST_RANGE' => -110,
			'OP08_STRING_CAT' => -110,
			".." => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -110,
			'OP18_TERNARY' => -110,
			";" => -110,
			'OP13_BITWISE_AND' => -110,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => -110,
			'OP23_LOGICAL_AND' => -110,
			"}" => -110,
			'OP11_COMPARE_LT_GT' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP15_LOGICAL_AND' => -110,
			")" => -110
		}
	},
	{#State 210
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP08_STRING_CAT' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP08_MATH_ADD_SUB' => -109,
			"]" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP06_REGEX_MATCH' => 149,
			".." => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => -109,
			'OP13_BITWISE_AND' => -109,
			";" => -109,
			'OP18_TERNARY' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP12_COMPARE_EQ_NEQ' => -109,
			")" => -109,
			'OP11_COMPARE_LT_GT' => -109,
			"}" => -109,
			'OP23_LOGICAL_AND' => -109
		}
	},
	{#State 211
		ACTIONS => {
			'OP18_TERNARY' => 141,
			'OP21_LIST_COMMA' => -125,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP13_BITWISE_AND' => 138,
			";" => -125,
			"}" => -125,
			'OP23_LOGICAL_AND' => 144,
			'OP15_LOGICAL_AND' => 151,
			'OP12_COMPARE_EQ_NEQ' => 143,
			")" => -125,
			'OP11_COMPARE_LT_GT' => 142,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP17_LIST_RANGE' => 152,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			"]" => -125,
			'OP06_REGEX_MATCH' => 149,
			".." => -125,
			'OP09_BITWISE_SHIFT' => 154
		}
	},
	{#State 212
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 255
		}
	},
	{#State 213
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => -120,
			'OP08_STRING_CAT' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			"]" => -120,
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154,
			".." => -120,
			'OP18_TERNARY' => -120,
			'OP21_LIST_COMMA' => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP04_MATH_POW' => 140,
			'OP13_BITWISE_AND' => 138,
			";" => -120,
			"}" => -120,
			'OP23_LOGICAL_AND' => -120,
			")" => -120,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 142
		}
	},
	{#State 214
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 142,
			")" => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP23_LOGICAL_AND' => -119,
			"}" => -119,
			";" => -119,
			'OP13_BITWISE_AND' => 138,
			'OP16_LOGICAL_OR' => -119,
			'OP04_MATH_POW' => 140,
			'OP21_LIST_COMMA' => -119,
			'OP18_TERNARY' => -119,
			".." => -119,
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149,
			"]" => -119,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => -119,
			'OP08_STRING_CAT' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => -119
		}
	},
	{#State 215
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => undef,
			'OP08_STRING_CAT' => 145,
			"]" => -121,
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154,
			".." => -121,
			'OP18_TERNARY' => -121,
			'OP21_LIST_COMMA' => -121,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP13_BITWISE_AND' => 138,
			";" => -121,
			"}" => -121,
			'OP23_LOGICAL_AND' => -121,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			")" => -121,
			'OP11_COMPARE_LT_GT' => 142
		}
	},
	{#State 216
		ACTIONS => {
			'OP18_TERNARY' => -118,
			'OP21_LIST_COMMA' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP04_MATH_POW' => 140,
			'OP13_BITWISE_AND' => 138,
			";" => -118,
			"}" => -118,
			'OP23_LOGICAL_AND' => -118,
			")" => -118,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => -118,
			'OP11_COMPARE_LT_GT' => 142,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP17_LIST_RANGE' => -118,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			"]" => -118,
			'OP06_REGEX_MATCH' => 149,
			".." => -118,
			'OP09_BITWISE_SHIFT' => 154
		}
	},
	{#State 217
		ACTIONS => {
			"]" => -112,
			'OP17_LIST_RANGE' => -112,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			".." => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP06_REGEX_MATCH' => 149,
			'OP13_BITWISE_AND' => -112,
			";" => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP04_MATH_POW' => 140,
			'OP21_LIST_COMMA' => -112,
			'OP18_TERNARY' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			")" => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP23_LOGICAL_AND' => -112,
			"}" => -112
		}
	},
	{#State 218
		ACTIONS => {
			")" => 256
		}
	},
	{#State 219
		DEFAULT => -139
	},
	{#State 220
		DEFAULT => -198
	},
	{#State 221
		ACTIONS => {
			"{" => 257
		},
		GOTOS => {
			'CodeBlock' => 258
		}
	},
	{#State 222
		DEFAULT => -100
	},
	{#State 223
		ACTIONS => {
			")" => 259
		}
	},
	{#State 224
		DEFAULT => -138
	},
	{#State 225
		ACTIONS => {
			"[" => 263,
			'LITERAL' => 260,
			"{" => 261
		},
		GOTOS => {
			'ConstantValue' => 262
		}
	},
	{#State 226
		ACTIONS => {
			";" => 264
		}
	},
	{#State 227
		DEFAULT => -31
	},
	{#State 228
		ACTIONS => {
			"use" => -71,
			"our %properties = (" => -71,
			"## no critic qw(" => 21,
			"use constant" => -71
		},
		GOTOS => {
			'STAR-29' => 266,
			'Critic' => 265
		}
	},
	{#State 229
		ACTIONS => {
			"[" => 76,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72
		},
		GOTOS => {
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'ArrayReference' => 85,
			'Variable' => 94,
			'WordScoped' => 75,
			'Expression' => 267,
			'HashDereferenced' => 47,
			'HashReference' => 81
		}
	},
	{#State 230
		DEFAULT => -185
	},
	{#State 231
		DEFAULT => -137
	},
	{#State 232
		DEFAULT => -215
	},
	{#State 233
		DEFAULT => -190
	},
	{#State 234
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'KEYS_OR_VALUES' => 103,
			'OP05_LOGICAL_NEG' => 72,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			"my" => 158,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'ArrayReference' => 85,
			'Variable' => 94,
			'ArrayDereferenced' => 67,
			'TypeInner' => 107,
			'Operator' => 63,
			'ListElement' => 268,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'Expression' => 99,
			'WordScoped' => 75
		}
	},
	{#State 235
		DEFAULT => -216
	},
	{#State 236
		ACTIONS => {
			'WORD' => 269
		}
	},
	{#State 237
		DEFAULT => -188
	},
	{#State 238
		ACTIONS => {
			"[" => 76,
			'OP01_NAMED' => 78,
			")" => -142,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			"my" => 158,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			'KEYS_OR_VALUES' => 103,
			"{" => 70
		},
		GOTOS => {
			'OPTIONAL-48' => 271,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'TypeInner' => 107,
			'ArrayReference' => 85,
			'Variable' => 94,
			'Expression' => 99,
			'WordScoped' => 75,
			'ListElements' => 270,
			'HashDereferenced' => 47,
			'HashReference' => 81,
			'ListElement' => 102
		}
	},
	{#State 239
		DEFAULT => -187
	},
	{#State 240
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => 152,
			"]" => 272,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP13_BITWISE_AND' => 138,
			'OP18_TERNARY' => 141,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 142,
			'OP23_LOGICAL_AND' => 144
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
			'OP18_TERNARY' => 141,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP13_BITWISE_AND' => 138,
			"}" => 274,
			'OP23_LOGICAL_AND' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 142,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => 152,
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154
		}
	},
	{#State 243
		ACTIONS => {
			"(" => 275
		}
	},
	{#State 244
		ACTIONS => {
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			'OP01_NAMED' => 78,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50
		},
		GOTOS => {
			'HashReference' => 81,
			'Expression' => 276,
			'WordScoped' => 75,
			'HashDereferenced' => 47,
			'Variable' => 94,
			'ArrayReference' => 85,
			'Operator' => 63,
			'ArrayDereferenced' => 67
		}
	},
	{#State 245
		ACTIONS => {
			"{" => 257
		},
		GOTOS => {
			'CodeBlock' => 277
		}
	},
	{#State 246
		ACTIONS => {
			";" => 278
		}
	},
	{#State 247
		DEFAULT => -134
	},
	{#State 248
		ACTIONS => {
			"%{" => -54,
			'WORD' => -54,
			'OP01_NAMED_VOID' => -54,
			'VARIABLE_SYMBOL' => -54,
			"if (" => -54,
			"[" => -54,
			'OP01_NAMED' => -54,
			'OP10_NAMED_UNARY' => -54,
			"(" => -54,
			"for my integer" => -54,
			"my" => -54,
			'LITERAL' => -54,
			'OP01_NAMED_VOID_PAREN' => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			'OP05_LOGICAL_NEG' => -54,
			"{" => -54,
			'OP05_MATH_NEG' => -54,
			"undef" => -54,
			'WORD_SCOPED' => -54,
			'OP19_LOOP_CONTROL' => -54,
			"while (" => -54,
			"foreach my" => -54,
			"\@{" => -54,
			"( my" => 281,
			'OP22_LOGICAL_NOT' => -54,
			'OP03_MATH_INC_DEC' => -54
		},
		GOTOS => {
			'OPTIONAL-21' => 280,
			'SubroutineArguments' => 279
		}
	},
	{#State 249
		ACTIONS => {
			"[" => 76,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72
		},
		GOTOS => {
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'Variable' => 94,
			'ArrayReference' => 85,
			'Expression' => 282,
			'WordScoped' => 75,
			'HashDereferenced' => 47,
			'HashReference' => 81
		}
	},
	{#State 250
		DEFAULT => -201
	},
	{#State 251
		DEFAULT => -208
	},
	{#State 252
		ACTIONS => {
			'WORD' => 131,
			"%{" => 53
		},
		GOTOS => {
			'HashDereferenced' => 132,
			'HashEntry' => 283
		}
	},
	{#State 253
		DEFAULT => -210
	},
	{#State 254
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56
		},
		GOTOS => {
			'Variable' => 284
		}
	},
	{#State 255
		ACTIONS => {
			"/" => 285
		}
	},
	{#State 256
		DEFAULT => -152
	},
	{#State 257
		ACTIONS => {
			"[" => 76,
			"if (" => 77,
			'OP10_NAMED_UNARY' => 48,
			"for my integer" => -157,
			"(" => 50,
			"my" => 49,
			'OP01_NAMED' => 78,
			'OP01_NAMED_VOID' => 51,
			"%{" => 53,
			'WORD' => 52,
			'VARIABLE_SYMBOL' => 56,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"foreach my" => -157,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			"while (" => -157,
			'OP19_LOOP_CONTROL' => 82,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP01_NAMED_VOID_PAREN' => 66,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72
		},
		GOTOS => {
			'Variable' => 55,
			'Statement' => 54,
			'HashDereferenced' => 47,
			'OperatorVoid' => 46,
			'WordScoped' => 75,
			'Expression' => 74,
			'Conditional' => 86,
			'LoopLabel' => 71,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'PLUS-55' => 286,
			'VariableModification' => 65,
			'PAREN-49' => 64,
			'VariableDeclaration' => 84,
			'OPTIONAL-50' => 62,
			'HashReference' => 81,
			'Operation' => 287
		}
	},
	{#State 258
		DEFAULT => -165,
		GOTOS => {
			'STAR-52' => 288
		}
	},
	{#State 259
		DEFAULT => -102
	},
	{#State 260
		DEFAULT => -50
	},
	{#State 261
		ACTIONS => {
			'WORD' => 289
		}
	},
	{#State 262
		ACTIONS => {
			";" => 290
		}
	},
	{#State 263
		ACTIONS => {
			"my" => 158,
			'LITERAL' => -37
		},
		GOTOS => {
			'OPTIONAL-13' => 291,
			'TypeInner' => 292
		}
	},
	{#State 264
		DEFAULT => -34
	},
	{#State 265
		DEFAULT => -68
	},
	{#State 266
		ACTIONS => {
			"use constant" => -73,
			"our %properties = (" => -73,
			"use" => 31
		},
		GOTOS => {
			'Include' => 294,
			'STAR-30' => 293
		}
	},
	{#State 267
		ACTIONS => {
			'OP13_BITWISE_AND' => 138,
			";" => 295,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 140,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 142,
			'OP15_LOGICAL_AND' => 151,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP23_LOGICAL_AND' => 144,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 268
		DEFAULT => -189
	},
	{#State 269
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 296
		}
	},
	{#State 270
		DEFAULT => -141
	},
	{#State 271
		ACTIONS => {
			")" => 297
		}
	},
	{#State 272
		DEFAULT => -182
	},
	{#State 273
		DEFAULT => -184
	},
	{#State 274
		DEFAULT => -183
	},
	{#State 275
		ACTIONS => {
			"[" => 76,
			'OP01_NAMED' => 78,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			"my" => 158,
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			"\@{" => 61,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			'KEYS_OR_VALUES' => 103
		},
		GOTOS => {
			'ListElements' => 298,
			'HashDereferenced' => 47,
			'Expression' => 99,
			'WordScoped' => 75,
			'ListElement' => 102,
			'HashReference' => 81,
			'ArrayDereferenced' => 67,
			'TypeInner' => 107,
			'Operator' => 63,
			'ArrayReference' => 85,
			'Variable' => 94
		}
	},
	{#State 276
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 142,
			'OP15_LOGICAL_AND' => 151,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP23_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 138,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 140,
			'OP18_TERNARY' => 141,
			".." => 299,
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149,
			'OP08_STRING_CAT' => 145,
			'OP17_LIST_RANGE' => 152,
			'OP08_MATH_ADD_SUB' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => 148
		}
	},
	{#State 277
		DEFAULT => -175
	},
	{#State 278
		DEFAULT => -135
	},
	{#State 279
		DEFAULT => -53
	},
	{#State 280
		ACTIONS => {
			"[" => 76,
			"if (" => 77,
			"(" => 50,
			"for my integer" => -157,
			'OP10_NAMED_UNARY' => 48,
			"my" => 49,
			'OP01_NAMED' => 78,
			'WORD' => 52,
			"%{" => 53,
			'OP01_NAMED_VOID' => 51,
			'VARIABLE_SYMBOL' => 56,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			"while (" => -157,
			'OP19_LOOP_CONTROL' => 82,
			'WORD_SCOPED' => 11,
			"foreach my" => -157,
			"\@{" => 61,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			'OP01_NAMED_VOID_PAREN' => 66,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72
		},
		GOTOS => {
			'Statement' => 54,
			'Variable' => 55,
			'OperatorVoid' => 46,
			'Expression' => 74,
			'WordScoped' => 75,
			'HashDereferenced' => 47,
			'Operator' => 63,
			'VariableModification' => 65,
			'VariableDeclaration' => 84,
			'PAREN-49' => 64,
			'ArrayDereferenced' => 67,
			'ArrayReference' => 85,
			'LoopLabel' => 71,
			'Conditional' => 86,
			'PLUS-22' => 300,
			'Operation' => 301,
			'HashReference' => 81,
			'OPTIONAL-50' => 62
		}
	},
	{#State 281
		ACTIONS => {
			'WORD' => 97
		},
		GOTOS => {
			'Type' => 302
		}
	},
	{#State 282
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => 152,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149,
			'OP13_BITWISE_AND' => 138,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP21_LIST_COMMA' => -203,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP23_LOGICAL_AND' => 144,
			"}" => -203
		}
	},
	{#State 283
		DEFAULT => -207
	},
	{#State 284
		DEFAULT => -122
	},
	{#State 285
		DEFAULT => -108
	},
	{#State 286
		ACTIONS => {
			'OP01_NAMED' => 78,
			"for my integer" => -157,
			'OP10_NAMED_UNARY' => 48,
			"my" => 49,
			"(" => 50,
			"if (" => 77,
			"}" => 303,
			"[" => 76,
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 52,
			"%{" => 53,
			'OP01_NAMED_VOID' => 51,
			"foreach my" => -157,
			"\@{" => 61,
			"while (" => -157,
			'OP19_LOOP_CONTROL' => 82,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			'OP01_NAMED_VOID_PAREN' => 66,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83
		},
		GOTOS => {
			'Variable' => 55,
			'Statement' => 54,
			'WordScoped' => 75,
			'OperatorVoid' => 46,
			'Expression' => 74,
			'HashDereferenced' => 47,
			'ArrayReference' => 85,
			'LoopLabel' => 71,
			'Conditional' => 86,
			'VariableModification' => 65,
			'PAREN-49' => 64,
			'VariableDeclaration' => 84,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'HashReference' => 81,
			'OPTIONAL-50' => 62,
			'Operation' => 304
		}
	},
	{#State 287
		DEFAULT => -177
	},
	{#State 288
		ACTIONS => {
			'WORD' => -168,
			'OP01_NAMED_VOID' => -168,
			"%{" => -168,
			"else" => 309,
			'VARIABLE_SYMBOL' => -168,
			"if (" => -168,
			"}" => -168,
			"elsif (" => 305,
			"[" => -168,
			'OP01_NAMED' => -168,
			'OP10_NAMED_UNARY' => -168,
			"my" => -168,
			"(" => -168,
			"for my integer" => -168,
			'LITERAL' => -168,
			'OP01_NAMED_VOID_PAREN' => -168,
			'OP10_NAMED_UNARY_STRINGIFY' => -168,
			'OP05_LOGICAL_NEG' => -168,
			"{" => -168,
			'' => -168,
			"undef" => -168,
			'OP05_MATH_NEG' => -168,
			'WORD_SCOPED' => -168,
			'OP19_LOOP_CONTROL' => -168,
			"while (" => -168,
			"foreach my" => -168,
			"\@{" => -168,
			'OP22_LOGICAL_NOT' => -168,
			'OP03_MATH_INC_DEC' => -168
		},
		GOTOS => {
			'PAREN-51' => 306,
			'OPTIONAL-54' => 307,
			'PAREN-53' => 308
		}
	},
	{#State 289
		ACTIONS => {
			'OP20_HASH_FATARROW' => 310
		}
	},
	{#State 290
		DEFAULT => -35
	},
	{#State 291
		ACTIONS => {
			'LITERAL' => 311
		}
	},
	{#State 292
		DEFAULT => -36
	},
	{#State 293
		ACTIONS => {
			"use constant" => 39,
			"our %properties = (" => 312
		},
		GOTOS => {
			'Properties' => 313,
			'Constant' => 314
		}
	},
	{#State 294
		DEFAULT => -70
	},
	{#State 295
		DEFAULT => -186
	},
	{#State 296
		DEFAULT => -217
	},
	{#State 297
		DEFAULT => -153
	},
	{#State 298
		ACTIONS => {
			")" => 315
		}
	},
	{#State 299
		ACTIONS => {
			'WORD' => 9,
			"%{" => 53,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 61,
			'WORD_SCOPED' => 11
		},
		GOTOS => {
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'ArrayReference' => 85,
			'Variable' => 94,
			'HashDereferenced' => 47,
			'Expression' => 316,
			'WordScoped' => 75,
			'HashReference' => 81
		}
	},
	{#State 300
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56,
			"%{" => 53,
			'OP01_NAMED_VOID' => 51,
			'WORD' => 52,
			'OP01_NAMED' => 78,
			"for my integer" => -157,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			"my" => 49,
			"if (" => 77,
			"[" => 76,
			"}" => 317,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			'LITERAL' => 68,
			'OP01_NAMED_VOID_PAREN' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP19_LOOP_CONTROL' => 82,
			"while (" => -157,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			"foreach my" => -157,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'OP05_MATH_NEG' => 59,
			"undef" => 58
		},
		GOTOS => {
			'Variable' => 55,
			'Statement' => 54,
			'HashDereferenced' => 47,
			'OperatorVoid' => 46,
			'WordScoped' => 75,
			'Expression' => 74,
			'LoopLabel' => 71,
			'Conditional' => 86,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'VariableModification' => 65,
			'PAREN-49' => 64,
			'VariableDeclaration' => 84,
			'Operator' => 63,
			'OPTIONAL-50' => 62,
			'HashReference' => 81,
			'Operation' => 318
		}
	},
	{#State 301
		DEFAULT => -56
	},
	{#State 302
		ACTIONS => {
			'VARIABLE_SYMBOL' => 319
		}
	},
	{#State 303
		DEFAULT => -178
	},
	{#State 304
		DEFAULT => -176
	},
	{#State 305
		ACTIONS => {
			"%{" => 53,
			'WORD' => 9,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			'OP01_NAMED' => 78,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80
		},
		GOTOS => {
			'Variable' => 94,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'WordScoped' => 75,
			'Expression' => 320
		}
	},
	{#State 306
		DEFAULT => -164
	},
	{#State 307
		DEFAULT => -169
	},
	{#State 308
		DEFAULT => -167
	},
	{#State 309
		ACTIONS => {
			"{" => 257
		},
		GOTOS => {
			'CodeBlock' => 321
		}
	},
	{#State 310
		ACTIONS => {
			'LITERAL' => -44,
			"my" => 158
		},
		GOTOS => {
			'OPTIONAL-17' => 323,
			'TypeInner' => 322
		}
	},
	{#State 311
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 324
		}
	},
	{#State 312
		ACTIONS => {
			")" => 327,
			"%{" => 53,
			'WORD' => 328
		},
		GOTOS => {
			'HashEntryTyped' => 326,
			'HashDereferenced' => 325
		}
	},
	{#State 313
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 329
		}
	},
	{#State 314
		DEFAULT => -72
	},
	{#State 315
		ACTIONS => {
			"{" => 257
		},
		GOTOS => {
			'CodeBlock' => 330
		}
	},
	{#State 316
		ACTIONS => {
			'OP23_LOGICAL_AND' => 144,
			'OP15_LOGICAL_AND' => 151,
			'OP12_COMPARE_EQ_NEQ' => 143,
			")" => 331,
			'OP11_COMPARE_LT_GT' => 142,
			'OP18_TERNARY' => 141,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP13_BITWISE_AND' => 138,
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_STRING_CAT' => 145,
			'OP17_LIST_RANGE' => 152,
			'OP08_MATH_ADD_SUB' => 146
		}
	},
	{#State 317
		ACTIONS => {
			";" => 332
		}
	},
	{#State 318
		DEFAULT => -55
	},
	{#State 319
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 333
		}
	},
	{#State 320
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154,
			'OP18_TERNARY' => 141,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 140,
			'OP13_BITWISE_AND' => 138,
			'OP23_LOGICAL_AND' => 144,
			")" => 334,
			'OP15_LOGICAL_AND' => 151,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP11_COMPARE_LT_GT' => 142
		}
	},
	{#State 321
		DEFAULT => -166
	},
	{#State 322
		DEFAULT => -43
	},
	{#State 323
		ACTIONS => {
			'LITERAL' => 335
		}
	},
	{#State 324
		ACTIONS => {
			'OP21_LIST_COMMA' => 336,
			"]" => 338
		},
		GOTOS => {
			'PAREN-15' => 337
		}
	},
	{#State 325
		DEFAULT => -206
	},
	{#State 326
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 339
		}
	},
	{#State 327
		ACTIONS => {
			";" => 340
		}
	},
	{#State 328
		ACTIONS => {
			'OP20_HASH_FATARROW' => 341
		}
	},
	{#State 329
		ACTIONS => {
			"1, 1;" => 343,
			"our" => 344
		},
		GOTOS => {
			'Method' => 342
		}
	},
	{#State 330
		DEFAULT => -174
	},
	{#State 331
		ACTIONS => {
			"{" => 257
		},
		GOTOS => {
			'CodeBlock' => 345
		}
	},
	{#State 332
		DEFAULT => -57
	},
	{#State 333
		ACTIONS => {
			")" => 347,
			'OP21_LIST_COMMA' => 346
		},
		GOTOS => {
			'PAREN-23' => 348
		}
	},
	{#State 334
		ACTIONS => {
			"{" => 257
		},
		GOTOS => {
			'CodeBlock' => 349
		}
	},
	{#State 335
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 350
		}
	},
	{#State 336
		ACTIONS => {
			"my" => 158,
			'LITERAL' => -39
		},
		GOTOS => {
			'OPTIONAL-14' => 351,
			'TypeInner' => 352
		}
	},
	{#State 337
		DEFAULT => -41
	},
	{#State 338
		DEFAULT => -51
	},
	{#State 339
		ACTIONS => {
			")" => 353,
			'OP21_LIST_COMMA' => 355
		},
		GOTOS => {
			'PAREN-35' => 354
		}
	},
	{#State 340
		DEFAULT => -86
	},
	{#State 341
		ACTIONS => {
			"my" => 158
		},
		GOTOS => {
			'TypeInner' => 356
		}
	},
	{#State 342
		DEFAULT => -74
	},
	{#State 343
		ACTIONS => {
			"our" => 69,
			"package" => -80,
			'' => -80
		},
		GOTOS => {
			'Subroutine' => 357,
			'PAREN-33' => 359,
			'OPTIONAL-34' => 358,
			'PLUS-32' => 360
		}
	},
	{#State 344
		ACTIONS => {
			'WORD' => 97
		},
		GOTOS => {
			'Type' => 361
		}
	},
	{#State 345
		DEFAULT => -173
	},
	{#State 346
		ACTIONS => {
			"my" => 362
		}
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
		DEFAULT => -163
	},
	{#State 350
		ACTIONS => {
			'OP21_LIST_COMMA' => 365,
			"}" => 364
		},
		GOTOS => {
			'PAREN-19' => 366
		}
	},
	{#State 351
		ACTIONS => {
			'LITERAL' => 367
		}
	},
	{#State 352
		DEFAULT => -38
	},
	{#State 353
		ACTIONS => {
			";" => 368
		}
	},
	{#State 354
		DEFAULT => -83
	},
	{#State 355
		ACTIONS => {
			'WORD' => 328,
			"%{" => 53
		},
		GOTOS => {
			'HashEntryTyped' => 369,
			'HashDereferenced' => 325
		}
	},
	{#State 356
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			"%{" => 53,
			'WORD' => 9,
			'VARIABLE_SYMBOL' => 56,
			"[" => 76,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78
		},
		GOTOS => {
			'Expression' => 370,
			'WordScoped' => 75,
			'HashDereferenced' => 47,
			'HashReference' => 81,
			'Operator' => 63,
			'ArrayDereferenced' => 67,
			'ArrayReference' => 85,
			'Variable' => 94
		}
	},
	{#State 357
		DEFAULT => -77
	},
	{#State 358
		DEFAULT => -81
	},
	{#State 359
		DEFAULT => -79
	},
	{#State 360
		ACTIONS => {
			"1, 1;" => 371,
			"our" => 69
		},
		GOTOS => {
			'Subroutine' => 372
		}
	},
	{#State 361
		ACTIONS => {
			'VARIABLE_SYMBOL' => 373
		}
	},
	{#State 362
		ACTIONS => {
			'WORD' => 97
		},
		GOTOS => {
			'Type' => 374
		}
	},
	{#State 363
		ACTIONS => {
			"\@_;" => 375
		}
	},
	{#State 364
		DEFAULT => -52
	},
	{#State 365
		ACTIONS => {
			'WORD' => 376
		}
	},
	{#State 366
		DEFAULT => -48
	},
	{#State 367
		DEFAULT => -40
	},
	{#State 368
		DEFAULT => -85
	},
	{#State 369
		DEFAULT => -82
	},
	{#State 370
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 142,
			")" => -205,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP23_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 138,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 140,
			'OP21_LIST_COMMA' => -205,
			'OP18_TERNARY' => 141,
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149,
			'OP08_STRING_CAT' => 145,
			'OP17_LIST_RANGE' => 152,
			'OP08_MATH_ADD_SUB' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => 148
		}
	},
	{#State 371
		DEFAULT => -78
	},
	{#State 372
		DEFAULT => -76
	},
	{#State 373
		ACTIONS => {
			"= sub {" => 377
		}
	},
	{#State 374
		ACTIONS => {
			'VARIABLE_SYMBOL' => 378
		}
	},
	{#State 375
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 379
		}
	},
	{#State 376
		ACTIONS => {
			'OP20_HASH_FATARROW' => 380
		}
	},
	{#State 377
		ACTIONS => {
			'OP01_NAMED_VOID_PAREN' => -88,
			'LITERAL' => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			'OP05_LOGICAL_NEG' => -88,
			"{" => -88,
			"undef" => -88,
			'OP05_MATH_NEG' => -88,
			"foreach my" => -88,
			"( my" => 383,
			"\@{" => -88,
			'WORD_SCOPED' => -88,
			'OP19_LOOP_CONTROL' => -88,
			"while (" => -88,
			'OP03_MATH_INC_DEC' => -88,
			'OP22_LOGICAL_NOT' => -88,
			'WORD' => -88,
			"%{" => -88,
			'OP01_NAMED_VOID' => -88,
			'VARIABLE_SYMBOL' => -88,
			"if (" => -88,
			"[" => -88,
			'OP01_NAMED' => -88,
			'OP10_NAMED_UNARY' => -88,
			"(" => -88,
			"my" => -88,
			"for my integer" => -88
		},
		GOTOS => {
			'MethodArguments' => 381,
			'OPTIONAL-37' => 382
		}
	},
	{#State 378
		DEFAULT => -58
	},
	{#State 379
		ACTIONS => {
			"[" => -63,
			"if (" => -63,
			"(" => -63,
			'OP10_NAMED_UNARY' => -63,
			"for my integer" => -63,
			"my" => -63,
			'OP01_NAMED' => -63,
			"%{" => -63,
			'WORD' => -63,
			'OP01_NAMED_VOID' => -63,
			'VARIABLE_SYMBOL' => -63,
			'CHECK_OR_CHECKTRACE' => 385,
			"undef" => -63,
			'OP05_MATH_NEG' => -63,
			'OP03_MATH_INC_DEC' => -63,
			'OP22_LOGICAL_NOT' => -63,
			"foreach my" => -63,
			"\@{" => -63,
			'OP19_LOOP_CONTROL' => -63,
			"while (" => -63,
			'WORD_SCOPED' => -63,
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			'LITERAL' => -63,
			"{" => -63,
			'OP05_LOGICAL_NEG' => -63
		},
		GOTOS => {
			'ArgumentCheck' => 384
		}
	},
	{#State 380
		ACTIONS => {
			'LITERAL' => -46,
			"my" => 158
		},
		GOTOS => {
			'OPTIONAL-18' => 387,
			'TypeInner' => 386
		}
	},
	{#State 381
		DEFAULT => -87
	},
	{#State 382
		ACTIONS => {
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 52,
			"%{" => 53,
			'OP01_NAMED_VOID' => 51,
			'OP10_NAMED_UNARY' => 48,
			"for my integer" => -157,
			"my" => 49,
			"(" => 50,
			'OP01_NAMED' => 78,
			"[" => 76,
			"if (" => 77,
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP01_NAMED_VOID_PAREN' => 66,
			'LITERAL' => 68,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 61,
			"foreach my" => -157,
			'WORD_SCOPED' => 11,
			"while (" => -157,
			'OP19_LOOP_CONTROL' => 82,
			"undef" => 58,
			'OP05_MATH_NEG' => 59
		},
		GOTOS => {
			'LoopLabel' => 71,
			'Conditional' => 86,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'PAREN-49' => 64,
			'VariableModification' => 65,
			'VariableDeclaration' => 84,
			'Operator' => 63,
			'OPTIONAL-50' => 62,
			'HashReference' => 81,
			'Operation' => 389,
			'Variable' => 55,
			'Statement' => 54,
			'PLUS-38' => 388,
			'HashDereferenced' => 47,
			'Expression' => 74,
			'OperatorVoid' => 46,
			'WordScoped' => 75
		}
	},
	{#State 383
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 390
		}
	},
	{#State 384
		DEFAULT => -61
	},
	{#State 385
		ACTIONS => {
			"(" => 391
		}
	},
	{#State 386
		DEFAULT => -45
	},
	{#State 387
		ACTIONS => {
			'LITERAL' => 392
		}
	},
	{#State 388
		ACTIONS => {
			'OP01_NAMED' => 78,
			"for my integer" => -157,
			'OP10_NAMED_UNARY' => 48,
			"(" => 50,
			"my" => 49,
			"if (" => 77,
			"[" => 76,
			"}" => 393,
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 52,
			"%{" => 53,
			'OP01_NAMED_VOID' => 51,
			"foreach my" => -157,
			"\@{" => 61,
			"while (" => -157,
			'OP19_LOOP_CONTROL' => 82,
			'WORD_SCOPED' => 11,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'OP05_MATH_NEG' => 59,
			"undef" => 58,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70,
			'OP01_NAMED_VOID_PAREN' => 66,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83
		},
		GOTOS => {
			'OPTIONAL-50' => 62,
			'HashReference' => 81,
			'Operation' => 394,
			'Conditional' => 86,
			'LoopLabel' => 71,
			'ArrayReference' => 85,
			'ArrayDereferenced' => 67,
			'VariableDeclaration' => 84,
			'VariableModification' => 65,
			'PAREN-49' => 64,
			'Operator' => 63,
			'HashDereferenced' => 47,
			'Expression' => 74,
			'WordScoped' => 75,
			'OperatorVoid' => 46,
			'Variable' => 55,
			'Statement' => 54
		}
	},
	{#State 389
		DEFAULT => -90
	},
	{#State 390
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 395
		}
	},
	{#State 391
		ACTIONS => {
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			'OP22_LOGICAL_NOT' => 60,
			'OP03_MATH_INC_DEC' => 80,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 9,
			"%{" => 53,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			"[" => 76
		},
		GOTOS => {
			'HashDereferenced' => 47,
			'Expression' => 396,
			'WordScoped' => 75,
			'HashReference' => 81,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'Variable' => 94,
			'ArrayReference' => 85
		}
	},
	{#State 392
		DEFAULT => -47
	},
	{#State 393
		ACTIONS => {
			";" => 397
		}
	},
	{#State 394
		DEFAULT => -89
	},
	{#State 395
		ACTIONS => {
			")" => 399,
			'OP21_LIST_COMMA' => 400
		},
		GOTOS => {
			'PAREN-39' => 398
		}
	},
	{#State 396
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154,
			'OP18_TERNARY' => 141,
			'OP21_LIST_COMMA' => 403,
			'OP16_LOGICAL_OR' => 150,
			'OP04_MATH_POW' => 140,
			'OP13_BITWISE_AND' => 138,
			'OP23_LOGICAL_AND' => 144,
			")" => -66,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 142
		},
		GOTOS => {
			'OPTIONAL-27' => 401,
			'PAREN-26' => 402
		}
	},
	{#State 397
		DEFAULT => -91
	},
	{#State 398
		DEFAULT => -93
	},
	{#State 399
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 404
		}
	},
	{#State 400
		ACTIONS => {
			"my" => 405
		}
	},
	{#State 401
		ACTIONS => {
			")" => 406
		}
	},
	{#State 402
		DEFAULT => -65
	},
	{#State 403
		ACTIONS => {
			"[" => 76,
			'OP01_NAMED' => 78,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			"%{" => 53,
			'WORD' => 9,
			'VARIABLE_SYMBOL' => 56,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			'LITERAL' => 68,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'OP05_LOGICAL_NEG' => 72,
			"{" => 70
		},
		GOTOS => {
			'ArrayReference' => 85,
			'Variable' => 94,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'HashReference' => 81,
			'HashDereferenced' => 47,
			'Expression' => 407,
			'WordScoped' => 75
		}
	},
	{#State 404
		ACTIONS => {
			"\@_;" => 408
		}
	},
	{#State 405
		ACTIONS => {
			'WORD' => 97
		},
		GOTOS => {
			'Type' => 409
		}
	},
	{#State 406
		ACTIONS => {
			";" => 410
		}
	},
	{#State 407
		ACTIONS => {
			'OP13_BITWISE_AND' => 138,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP21_LIST_COMMA' => 411,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 142,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			'OP23_LOGICAL_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_STRING_CAT' => 145,
			'OP08_MATH_ADD_SUB' => 146,
			'OP17_LIST_RANGE' => 152,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP09_BITWISE_SHIFT' => 154,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 408
		DEFAULT => -96,
		GOTOS => {
			'STAR-41' => 412
		}
	},
	{#State 409
		ACTIONS => {
			'VARIABLE_SYMBOL' => 413
		}
	},
	{#State 410
		DEFAULT => -67
	},
	{#State 411
		ACTIONS => {
			"{" => 70,
			'OP05_LOGICAL_NEG' => 72,
			'OP10_NAMED_UNARY_STRINGIFY' => 83,
			'LITERAL' => 68,
			'OP03_MATH_INC_DEC' => 80,
			'OP22_LOGICAL_NOT' => 60,
			'WORD_SCOPED' => 11,
			"\@{" => 61,
			"undef" => 58,
			'OP05_MATH_NEG' => 59,
			'VARIABLE_SYMBOL' => 56,
			'WORD' => 9,
			"%{" => 53,
			"(" => 50,
			'OP10_NAMED_UNARY' => 48,
			'OP01_NAMED' => 78,
			"[" => 76
		},
		GOTOS => {
			'HashDereferenced' => 47,
			'Expression' => 414,
			'WordScoped' => 75,
			'HashReference' => 81,
			'ArrayDereferenced' => 67,
			'Operator' => 63,
			'Variable' => 94,
			'ArrayReference' => 85
		}
	},
	{#State 412
		ACTIONS => {
			"foreach my" => -97,
			"\@{" => -97,
			'OP19_LOOP_CONTROL' => -97,
			"while (" => -97,
			'WORD_SCOPED' => -97,
			'OP22_LOGICAL_NOT' => -97,
			'OP03_MATH_INC_DEC' => -97,
			"undef" => -97,
			'OP05_MATH_NEG' => -97,
			'OP05_LOGICAL_NEG' => -97,
			"{" => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			'LITERAL' => -97,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			'OP01_NAMED' => -97,
			'OP10_NAMED_UNARY' => -97,
			"(" => -97,
			"for my integer" => -97,
			"my" => -97,
			"if (" => -97,
			"[" => -97,
			'CHECK_OR_CHECKTRACE' => 385,
			'VARIABLE_SYMBOL' => -97,
			'WORD' => -97,
			"%{" => -97,
			'OP01_NAMED_VOID' => -97
		},
		GOTOS => {
			'ArgumentCheck' => 415
		}
	},
	{#State 413
		DEFAULT => -92
	},
	{#State 414
		ACTIONS => {
			'OP18_TERNARY' => 141,
			'OP04_MATH_POW' => 140,
			'OP16_LOGICAL_OR' => 150,
			'OP13_BITWISE_AND' => 138,
			'OP23_LOGICAL_AND' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP15_LOGICAL_AND' => 151,
			")" => -64,
			'OP11_COMPARE_LT_GT' => 142,
			'OP24_LOGICAL_OR_XOR' => 148,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 147,
			'OP08_STRING_CAT' => 145,
			'OP17_LIST_RANGE' => 152,
			'OP08_MATH_ADD_SUB' => 146,
			'OP06_REGEX_MATCH' => 149,
			'OP09_BITWISE_SHIFT' => 154
		}
	},
	{#State 415
		DEFAULT => -95
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5406 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5413 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 108 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5420 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5431 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5442 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5449 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5456 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5463 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5470 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5477 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5484 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5491 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5498 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5505 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 109 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5512 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5523 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5534 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5545 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5552 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5559 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5566 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5573 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5580 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5587 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5594 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5601 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 9,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5612 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5623 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5630 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 113 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5637 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5648 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5655 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 114 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5662 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5673 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5684 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5695 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5702 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5709 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5716 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5723 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5730 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5737 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5744 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5751 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5758 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5765 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5772 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5779 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5786 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5793 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5804 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5815 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5826 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5833 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5840 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5847 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5854 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5865 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5872 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5879 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5886 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5893 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5900 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5911 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5918 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5925 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5932 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5943 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5992 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6006 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6013 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6027 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6034 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 16,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6045 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6052 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6059 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6066 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6077 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6088 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6095 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6102 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6109 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6116 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6127 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6134 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6141 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6148 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6155 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6162 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6173 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6184 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6195 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6202 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6209 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6220 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6231 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6242 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6253 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6264 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6275 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6286 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6297 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6319 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6330 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6341 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6352 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6363 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6374 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6385 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6396 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6407 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6418 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6429 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6440 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6451 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6462 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6473 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6480 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6487 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6494 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6501 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6508 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6515 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6522 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6529 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6540 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6551 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6562 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6573 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6584 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6591 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6598 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6605 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6612 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6623 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6634 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6645 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6656 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6667 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6678 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6689 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6700 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6711 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6722 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6733 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_158
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6776 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_159
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6787 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6798 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6809 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6820 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6827 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6834 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6841 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6848 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6855 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6862 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_169
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6873 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_170
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6884 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_171
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6895 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6906 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_173
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6917 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_174
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6928 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_175
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6939 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6946 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6953 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_178
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6964 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6971 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6978 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_181
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6989 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_182
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7000 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_183
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7011 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7022 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_185
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7033 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_186
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7044 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_187
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7055 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_188
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7066 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7073 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7080 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7087 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_192
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7098 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7109 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_194
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7120 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_195
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7131 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7138 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7145 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_198
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7156 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_199
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_200
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7178 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7185 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7192 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7203 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7214 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_205
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7225 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_206
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7236 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-61', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7243 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7250 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7257 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_210
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7268 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_211
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7279 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_212
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7290 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_213
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7301 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_214
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7312 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_215
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7323 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_216
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7334 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_217
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7345 lib/RPerl/Grammar.pm
	],
	[#Rule Type_218
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7356 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_219
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7367 lib/RPerl/Grammar.pm
	]
],
#line 7370 lib/RPerl/Grammar.pm
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
         'LoopLabel_219', );
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


#line 7637 lib/RPerl/Grammar.pm



1;
