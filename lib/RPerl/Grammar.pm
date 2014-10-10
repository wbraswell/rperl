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

      m{\G(our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|filehandle_ref|our\ \$VERSION\ \=|use\ parent\ qw\(|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|elsif\ \(|\$TYPED_|while\ \(|package|\=\ sub\ \{|undef|if\ \(|else|\(\ my|qw\(|\@_\;|our|use|\%\{|1\;|my|\.\.|\@\{|\{\*|\;|\)|\}|\]|\/|\[|\(|\{)}gc and return ($1, $1);

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
			"package" => 4,
			'SHEBANG' => 5
		},
		GOTOS => {
			'Program' => 8,
			'PLUS-1' => 3,
			'Module' => 7,
			'Package' => 2,
			'Class' => 6,
			'CompileUnit' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'' => 9
		}
	},
	{#State 2
		DEFAULT => -16
	},
	{#State 3
		ACTIONS => {
			'' => -4,
			"package" => 4
		},
		GOTOS => {
			'Module' => 10,
			'Class' => 6,
			'Package' => 2
		}
	},
	{#State 4
		ACTIONS => {
			'WORD' => 13,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'WordScoped' => 11
		}
	},
	{#State 5
		ACTIONS => {
			"use strict;" => 15
		},
		GOTOS => {
			'Header' => 14
		}
	},
	{#State 6
		DEFAULT => -17
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
			";" => 16
		}
	},
	{#State 12
		DEFAULT => -214
	},
	{#State 13
		DEFAULT => -213
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
			"if (" => -8,
			'LITERAL' => -8,
			'OP19_LOOP_CONTROL' => -8,
			"my" => -8,
			"## no critic qw(" => 22,
			"foreach my" => -8,
			"\@{" => -8,
			'OP05_MATH_NEG' => -8,
			'WORD' => -8,
			"%{" => -8,
			'VARIABLE_SYMBOL' => -8,
			'OP10_NAMED_UNARY' => -8,
			"use" => -8,
			'OP03_MATH_INC_DEC' => -8,
			'OP10_NAMED_UNARY_STRINGIFY' => -8,
			"{" => -8,
			'OP01_NAMED_VOID' => -8,
			'OP05_LOGICAL_NEG' => -8,
			'OP01_NAMED_VOID_PAREN' => -8,
			"[" => -8,
			'OP22_LOGICAL_NOT' => -8,
			'OP01_NAMED' => -8,
			"use constant" => -8,
			'WORD_SCOPED' => -8,
			"undef" => -8,
			"(" => -8,
			"while (" => -8,
			"for my integer" => -8,
			"our" => -8
		},
		GOTOS => {
			'Critic' => 20,
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
			"use parent qw(" => 24,
			"use" => -19,
			"our" => -19,
			"use constant" => -19
		},
		GOTOS => {
			'STAR-7' => 25
		}
	},
	{#State 20
		DEFAULT => -5
	},
	{#State 21
		ACTIONS => {
			"use" => 27,
			'OP03_MATH_INC_DEC' => -10,
			'OP10_NAMED_UNARY_STRINGIFY' => -10,
			"{" => -10,
			'OP01_NAMED_VOID' => -10,
			'OP05_LOGICAL_NEG' => -10,
			"%{" => -10,
			'OP10_NAMED_UNARY' => -10,
			'VARIABLE_SYMBOL' => -10,
			"\@{" => -10,
			'WORD' => -10,
			'OP05_MATH_NEG' => -10,
			"if (" => -10,
			'LITERAL' => -10,
			'OP19_LOOP_CONTROL' => -10,
			"my" => -10,
			"foreach my" => -10,
			"(" => -10,
			"while (" => -10,
			"for my integer" => -10,
			"our" => -10,
			'WORD_SCOPED' => -10,
			"undef" => -10,
			'OP22_LOGICAL_NOT' => -10,
			'OP01_NAMED' => -10,
			"use constant" => -10,
			'OP01_NAMED_VOID_PAREN' => -10,
			"[" => -10
		},
		GOTOS => {
			'STAR-4' => 28,
			'Include' => 26
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
			'WORD_SCOPED' => 12,
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 25
		ACTIONS => {
			"## no critic qw(" => 22,
			"our" => -21,
			"use constant" => -21,
			"use" => -21
		},
		GOTOS => {
			'STAR-8' => 33,
			'Critic' => 34
		}
	},
	{#State 26
		DEFAULT => -7
	},
	{#State 27
		ACTIONS => {
			'WORD' => 13,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'WordScoped' => 35
		}
	},
	{#State 28
		ACTIONS => {
			'OP10_NAMED_UNARY' => -12,
			'VARIABLE_SYMBOL' => -12,
			"%{" => -12,
			'OP05_LOGICAL_NEG' => -12,
			'OP01_NAMED_VOID' => -12,
			"{" => -12,
			'OP03_MATH_INC_DEC' => -12,
			'OP10_NAMED_UNARY_STRINGIFY' => -12,
			"foreach my" => -12,
			"my" => -12,
			'OP19_LOOP_CONTROL' => -12,
			'LITERAL' => -12,
			"if (" => -12,
			'OP05_MATH_NEG' => -12,
			'WORD' => -12,
			"\@{" => -12,
			'WORD_SCOPED' => -12,
			"undef" => -12,
			"for my integer" => -12,
			"our" => -12,
			"while (" => -12,
			"(" => -12,
			'OP01_NAMED_VOID_PAREN' => -12,
			"[" => -12,
			"use constant" => 36,
			'OP01_NAMED' => -12,
			'OP22_LOGICAL_NOT' => -12
		},
		GOTOS => {
			'STAR-5' => 38,
			'Constant' => 37
		}
	},
	{#State 29
		DEFAULT => -29
	},
	{#State 30
		ACTIONS => {
			")" => 40,
			'WORD' => 39
		}
	},
	{#State 31
		ACTIONS => {
			'VERSION_NUMBER' => 41
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
			"use" => 27
		},
		GOTOS => {
			'STAR-9' => 43,
			'Include' => 44
		}
	},
	{#State 34
		DEFAULT => -18
	},
	{#State 35
		ACTIONS => {
			"qw(" => 45,
			";" => 46
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
			"foreach my" => -157,
			"my" => 61,
			'OP19_LOOP_CONTROL' => 63,
			"if (" => 80,
			'LITERAL' => 81,
			'OP05_MATH_NEG' => 60,
			'WORD' => 75,
			"\@{" => 78,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP01_NAMED_VOID' => 64,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			"[" => 51,
			'OP01_NAMED_VOID_PAREN' => 69,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"our" => 53,
			"for my integer" => -157,
			"while (" => -157,
			"(" => 54
		},
		GOTOS => {
			'Operator' => 74,
			'Subroutine' => 59,
			'PLUS-6' => 58,
			'HashReference' => 57,
			'PAREN-49' => 77,
			'Statement' => 76,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'VariableModification' => 82,
			'Expression' => 85,
			'LoopLabel' => 86,
			'Variable' => 48,
			'OPTIONAL-50' => 52,
			'ArrayDereferenced' => 68,
			'VariableDeclaration' => 70,
			'WordScoped' => 55,
			'OperatorVoid' => 72,
			'Operation' => 73,
			'Conditional' => 56
		}
	},
	{#State 39
		DEFAULT => -28
	},
	{#State 40
		DEFAULT => -30
	},
	{#State 41
		ACTIONS => {
			";" => 89
		}
	},
	{#State 42
		ACTIONS => {
			";" => 90
		}
	},
	{#State 43
		ACTIONS => {
			"our" => 53,
			"use constant" => 36
		},
		GOTOS => {
			'PLUS-10' => 92,
			'Constant' => 93,
			'Subroutine' => 91
		}
	},
	{#State 44
		DEFAULT => -20
	},
	{#State 45
		ACTIONS => {
			'WORD' => 94
		},
		GOTOS => {
			'PLUS-12' => 95
		}
	},
	{#State 46
		DEFAULT => -33
	},
	{#State 47
		ACTIONS => {
			'OP20_HASH_FATARROW' => 96
		}
	},
	{#State 48
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP04_MATH_POW' => -145,
			'OP19_VARIABLE_ASSIGN_BY' => 98,
			'OP02_METHOD_THINARROW' => 97,
			'OP13_BITWISE_AND' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP19_VARIABLE_ASSIGN' => 99,
			'OP09_BITWISE_SHIFT' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			";" => -145,
			'OP06_REGEX_MATCH' => -145,
			'OP23_LOGICAL_AND' => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP18_TERNARY' => -145,
			'OP08_STRING_CAT' => -145,
			'OP03_MATH_INC_DEC' => 100
		}
	},
	{#State 49
		ACTIONS => {
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"(" => 54,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'LITERAL' => 81,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 102,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'HashReference' => 57,
			'Operator' => 74,
			'Variable' => 101
		}
	},
	{#State 50
		ACTIONS => {
			"(" => 103
		}
	},
	{#State 51
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"\@{" => 78,
			"my" => 106,
			"]" => -197,
			'LITERAL' => 81,
			'KEYS_OR_VALUES' => 108,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51
		},
		GOTOS => {
			'ListElement' => 105,
			'Expression' => 104,
			'WordScoped' => 55,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68,
			'TypeInner' => 109,
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57,
			'ListElements' => 107,
			'OPTIONAL-59' => 110
		}
	},
	{#State 52
		ACTIONS => {
			"for my integer" => 116,
			"while (" => 114,
			"foreach my" => 112
		},
		GOTOS => {
			'LoopForEach' => 115,
			'Loop' => 113,
			'LoopWhile' => 117,
			'LoopFor' => 111
		}
	},
	{#State 53
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 119
		}
	},
	{#State 54
		ACTIONS => {
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'LITERAL' => 81,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 120,
			'HashReference' => 57,
			'Operator' => 74,
			'Variable' => 101,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashDereferenced' => 62
		}
	},
	{#State 55
		ACTIONS => {
			"(" => 121
		}
	},
	{#State 56
		DEFAULT => -158
	},
	{#State 57
		DEFAULT => -148
	},
	{#State 58
		ACTIONS => {
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'OP05_LOGICAL_NEG' => 65,
			'OP01_NAMED_VOID' => 64,
			"{" => 83,
			'OP19_LOOP_CONTROL' => 63,
			"if (" => 80,
			'LITERAL' => 81,
			"foreach my" => -157,
			"my" => 61,
			"\@{" => 78,
			'WORD' => 75,
			'OP05_MATH_NEG' => 60,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54,
			"for my integer" => -157,
			"while (" => -157,
			'OP01_NAMED_VOID_PAREN' => 69,
			"[" => 51,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			'' => -15
		},
		GOTOS => {
			'Expression' => 85,
			'LoopLabel' => 86,
			'PAREN-49' => 77,
			'Statement' => 76,
			'HashReference' => 57,
			'Operator' => 74,
			'VariableModification' => 82,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'WordScoped' => 55,
			'Operation' => 122,
			'Conditional' => 56,
			'OperatorVoid' => 72,
			'Variable' => 48,
			'VariableDeclaration' => 70,
			'ArrayDereferenced' => 68,
			'OPTIONAL-50' => 52
		}
	},
	{#State 59
		DEFAULT => -11
	},
	{#State 60
		ACTIONS => {
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"\@{" => 78,
			'LITERAL' => 81,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			"(" => 54,
			'WORD_SCOPED' => 12,
			"undef" => 71
		},
		GOTOS => {
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57,
			'Expression' => 123,
			'WordScoped' => 55
		}
	},
	{#State 61
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 124
		}
	},
	{#State 62
		DEFAULT => -149
	},
	{#State 63
		ACTIONS => {
			'WORD' => 125
		},
		GOTOS => {
			'LoopLabel' => 126
		}
	},
	{#State 64
		ACTIONS => {
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'KEYS_OR_VALUES' => 108,
			"(" => 54,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			";" => -131,
			"%{" => 67,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"my" => 127,
			'LITERAL' => 81,
			"{*" => 131,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"\@{" => 78
		},
		GOTOS => {
			'FileHandle' => 128,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'ListElements' => 130,
			'HashReference' => 57,
			'OPTIONAL-45' => 129,
			'TypeInner' => 109,
			'Operator' => 74,
			'Variable' => 101,
			'ListElement' => 105,
			'WordScoped' => 55,
			'Expression' => 104
		}
	},
	{#State 65
		ACTIONS => {
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			'LITERAL' => 81,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 132,
			'HashReference' => 57,
			'Variable' => 101,
			'Operator' => 74,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68
		}
	},
	{#State 66
		ACTIONS => {
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'Variable' => 133
		}
	},
	{#State 67
		ACTIONS => {
			"{" => 134,
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'HashReference' => 135,
			'Variable' => 136
		}
	},
	{#State 68
		DEFAULT => -147
	},
	{#State 69
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"[" => 51,
			'KEYS_OR_VALUES' => 108,
			"(" => 54,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			"my" => 127,
			'LITERAL' => 81,
			"{*" => 131,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'OP03_MATH_INC_DEC' => 66,
			")" => -127,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"%{" => 67
		},
		GOTOS => {
			'FileHandle' => 137,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'ListElements' => 138,
			'HashReference' => 57,
			'Operator' => 74,
			'Variable' => 101,
			'TypeInner' => 109,
			'ListElement' => 105,
			'WordScoped' => 55,
			'Expression' => 104,
			'OPTIONAL-43' => 139
		}
	},
	{#State 70
		DEFAULT => -161
	},
	{#State 71
		DEFAULT => -143
	},
	{#State 72
		DEFAULT => -160
	},
	{#State 73
		DEFAULT => -14
	},
	{#State 74
		DEFAULT => -151
	},
	{#State 75
		ACTIONS => {
			"(" => -213,
			'COLON' => -219
		}
	},
	{#State 76
		DEFAULT => -99
	},
	{#State 77
		DEFAULT => -156
	},
	{#State 78
		ACTIONS => {
			"[" => 51,
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'ArrayReference' => 140,
			'Variable' => 141
		}
	},
	{#State 79
		DEFAULT => -146
	},
	{#State 80
		ACTIONS => {
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'LITERAL' => 81,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54,
			"[" => 51,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49
		},
		GOTOS => {
			'Expression' => 142,
			'WordScoped' => 55,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'Variable' => 101,
			'Operator' => 74,
			'HashReference' => 57
		}
	},
	{#State 81
		DEFAULT => -144
	},
	{#State 82
		DEFAULT => -162
	},
	{#State 83
		ACTIONS => {
			"}" => 143,
			"%{" => 67,
			'WORD' => 145
		},
		GOTOS => {
			'HashEntry' => 144,
			'HashDereferenced' => 146
		}
	},
	{#State 84
		ACTIONS => {
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'LITERAL' => 81,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"\@{" => 78,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54,
			"[" => 51,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49
		},
		GOTOS => {
			'HashReference' => 57,
			'Variable' => 101,
			'Operator' => 74,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'WordScoped' => 55,
			'Expression' => 147
		}
	},
	{#State 85
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 158,
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP06_REGEX_MATCH' => 154,
			";" => 161,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164
		}
	},
	{#State 86
		ACTIONS => {
			'COLON' => 165
		}
	},
	{#State 87
		DEFAULT => -180,
		GOTOS => {
			'STAR-56' => 166
		}
	},
	{#State 88
		ACTIONS => {
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"%{" => 67,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"\@{" => 78,
			'LITERAL' => 81,
			"(" => 54,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"[" => 51
		},
		GOTOS => {
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'Expression' => 167,
			'WordScoped' => 55
		}
	},
	{#State 89
		DEFAULT => -27
	},
	{#State 90
		ACTIONS => {
			"use" => 27
		},
		GOTOS => {
			'Include' => 168
		}
	},
	{#State 91
		DEFAULT => -25
	},
	{#State 92
		ACTIONS => {
			"our" => 53,
			"1;" => 170
		},
		GOTOS => {
			'Subroutine' => 169
		}
	},
	{#State 93
		DEFAULT => -22
	},
	{#State 94
		DEFAULT => -32
	},
	{#State 95
		ACTIONS => {
			")" => 171,
			'WORD' => 172
		}
	},
	{#State 96
		ACTIONS => {
			"my" => 106
		},
		GOTOS => {
			'TypeInner' => 173
		}
	},
	{#State 97
		ACTIONS => {
			'WORD' => 174
		}
	},
	{#State 98
		ACTIONS => {
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"%{" => 67,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LITERAL' => 81,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"(" => 54,
			"[" => 51,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49
		},
		GOTOS => {
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'Variable' => 101,
			'Operator' => 74,
			'HashReference' => 57,
			'Expression' => 175,
			'WordScoped' => 55
		}
	},
	{#State 99
		ACTIONS => {
			'LITERAL' => 81,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54
		},
		GOTOS => {
			'HashReference' => 57,
			'Operator' => 74,
			'Variable' => 101,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'WordScoped' => 55,
			'Expression' => 176
		}
	},
	{#State 100
		DEFAULT => -104
	},
	{#State 101
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -145,
			'OP17_LIST_RANGE' => -145,
			'OP12_COMPARE_EQ_NEQ' => -145,
			'OP07_MATH_MULT_DIV_MOD' => -145,
			'OP08_MATH_ADD_SUB' => -145,
			'OP14_BITWISE_OR_XOR' => -145,
			'OP04_MATH_POW' => -145,
			'OP21_LIST_COMMA' => -145,
			'OP13_BITWISE_AND' => -145,
			'OP15_LOGICAL_AND' => -145,
			'OP02_METHOD_THINARROW' => 97,
			"}" => -145,
			'OP09_BITWISE_SHIFT' => -145,
			'OP11_COMPARE_LT_GT' => -145,
			"]" => -145,
			'OP18_TERNARY' => -145,
			")" => -145,
			'OP03_MATH_INC_DEC' => 100,
			'OP08_STRING_CAT' => -145,
			".." => -145,
			'OP06_REGEX_MATCH' => -145,
			";" => -145,
			'OP16_LOGICAL_OR' => -145,
			'OP23_LOGICAL_AND' => -145
		}
	},
	{#State 102
		ACTIONS => {
			'OP18_TERNARY' => 163,
			'OP08_STRING_CAT' => 162,
			")" => -123,
			".." => -123,
			'OP06_REGEX_MATCH' => 154,
			";" => -123,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => -123,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			"]" => -123,
			'OP08_MATH_ADD_SUB' => 158,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP13_BITWISE_AND' => 156,
			'OP21_LIST_COMMA' => -123,
			'OP15_LOGICAL_AND' => 148,
			"}" => -123,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 150
		}
	},
	{#State 103
		ACTIONS => {
			'KEYS_OR_VALUES' => 108,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"[" => 51,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'OP03_MATH_INC_DEC' => 66,
			")" => -101,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			"my" => 106,
			'LITERAL' => 81
		},
		GOTOS => {
			'ListElements' => 177,
			'Operator' => 74,
			'TypeInner' => 109,
			'Variable' => 101,
			'HashReference' => 57,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'Expression' => 104,
			'WordScoped' => 55,
			'OPTIONAL-42' => 178,
			'ListElement' => 105
		}
	},
	{#State 104
		ACTIONS => {
			"]" => -193,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP06_REGEX_MATCH' => 154,
			";" => -193,
			")" => -193,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP15_LOGICAL_AND' => 148,
			'OP21_LIST_COMMA' => -193,
			'OP13_BITWISE_AND' => 156,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP08_MATH_ADD_SUB' => 158
		}
	},
	{#State 105
		DEFAULT => -191,
		GOTOS => {
			'STAR-58' => 179
		}
	},
	{#State 106
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 180
		}
	},
	{#State 107
		DEFAULT => -196
	},
	{#State 108
		ACTIONS => {
			"%{" => 67
		},
		GOTOS => {
			'HashDereferenced' => 181
		}
	},
	{#State 109
		ACTIONS => {
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"(" => 54,
			"[" => 51,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'LITERAL' => 81,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13
		},
		GOTOS => {
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'Expression' => 182,
			'WordScoped' => 55
		}
	},
	{#State 110
		ACTIONS => {
			"]" => 183
		}
	},
	{#State 111
		DEFAULT => -170
	},
	{#State 112
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 184
		}
	},
	{#State 113
		DEFAULT => -159
	},
	{#State 114
		ACTIONS => {
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"%{" => 67,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'LITERAL' => 81,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78
		},
		GOTOS => {
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68,
			'HashReference' => 57,
			'Operator' => 74,
			'Variable' => 101,
			'WordScoped' => 55,
			'Expression' => 185
		}
	},
	{#State 115
		DEFAULT => -171
	},
	{#State 116
		ACTIONS => {
			'VARIABLE_SYMBOL' => 186
		}
	},
	{#State 117
		DEFAULT => -172
	},
	{#State 118
		DEFAULT => -218
	},
	{#State 119
		ACTIONS => {
			'VARIABLE_SYMBOL' => 187
		}
	},
	{#State 120
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 158,
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			")" => 188,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP06_REGEX_MATCH' => 154,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164
		}
	},
	{#State 121
		ACTIONS => {
			"%{" => 67,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			")" => -140,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'LITERAL' => 81,
			"my" => 106,
			"\@{" => 78,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54,
			'KEYS_OR_VALUES' => 108,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50
		},
		GOTOS => {
			'Expression' => 104,
			'WordScoped' => 55,
			'OPTIONAL-47' => 189,
			'ListElement' => 105,
			'Operator' => 74,
			'Variable' => 101,
			'TypeInner' => 109,
			'HashReference' => 57,
			'ListElements' => 190,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68
		}
	},
	{#State 122
		DEFAULT => -13
	},
	{#State 123
		ACTIONS => {
			")" => 191,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP23_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP06_REGEX_MATCH' => 154,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164,
			'OP08_MATH_ADD_SUB' => 158,
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => 159
		}
	},
	{#State 124
		ACTIONS => {
			'VARIABLE_SYMBOL' => 192
		}
	},
	{#State 125
		DEFAULT => -219
	},
	{#State 126
		ACTIONS => {
			";" => 193
		}
	},
	{#State 127
		ACTIONS => {
			'WORD' => 118,
			"filehandle_ref" => 194
		},
		GOTOS => {
			'Type' => 180
		}
	},
	{#State 128
		ACTIONS => {
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"\@{" => 78,
			"my" => 106,
			'LITERAL' => 81,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			";" => -133,
			"%{" => 67,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"[" => 51,
			'KEYS_OR_VALUES' => 108,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'ListElements' => 196,
			'Operator' => 74,
			'Variable' => 101,
			'TypeInner' => 109,
			'HashReference' => 57,
			'ListElement' => 105,
			'Expression' => 104,
			'WordScoped' => 55,
			'OPTIONAL-46' => 195
		}
	},
	{#State 129
		ACTIONS => {
			";" => 197
		}
	},
	{#State 130
		DEFAULT => -130
	},
	{#State 131
		ACTIONS => {
			'WORD' => 198
		}
	},
	{#State 132
		ACTIONS => {
			"}" => -106,
			'OP13_BITWISE_AND' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP04_MATH_POW' => 157,
			'OP08_MATH_ADD_SUB' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP12_COMPARE_EQ_NEQ' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP16_LOGICAL_OR' => -106,
			";" => -106,
			'OP06_REGEX_MATCH' => -106,
			")" => -106,
			'OP08_STRING_CAT' => -106,
			".." => -106,
			'OP18_TERNARY' => -106,
			"]" => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP09_BITWISE_SHIFT' => -106
		}
	},
	{#State 133
		DEFAULT => -103
	},
	{#State 134
		ACTIONS => {
			"%{" => 67,
			'WORD' => 145
		},
		GOTOS => {
			'HashDereferenced' => 146,
			'HashEntry' => 144
		}
	},
	{#State 135
		ACTIONS => {
			"}" => 199
		}
	},
	{#State 136
		ACTIONS => {
			"}" => 200
		}
	},
	{#State 137
		ACTIONS => {
			'LITERAL' => 81,
			"my" => 106,
			"\@{" => 78,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			")" => -129,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"(" => 54,
			'KEYS_OR_VALUES' => 108
		},
		GOTOS => {
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'Variable' => 101,
			'Operator' => 74,
			'OPTIONAL-44' => 201,
			'TypeInner' => 109,
			'HashReference' => 57,
			'ListElements' => 202,
			'ListElement' => 105,
			'Expression' => 104,
			'WordScoped' => 55
		}
	},
	{#State 138
		DEFAULT => -126
	},
	{#State 139
		ACTIONS => {
			")" => 203
		}
	},
	{#State 140
		ACTIONS => {
			"}" => 204
		}
	},
	{#State 141
		ACTIONS => {
			"}" => 205
		}
	},
	{#State 142
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			'OP08_MATH_ADD_SUB' => 158,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP06_REGEX_MATCH' => 154,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP18_TERNARY' => 163,
			'OP08_STRING_CAT' => 162,
			")" => 206,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155
		}
	},
	{#State 143
		DEFAULT => -150
	},
	{#State 144
		DEFAULT => -209,
		GOTOS => {
			'STAR-62' => 207
		}
	},
	{#State 145
		ACTIONS => {
			'OP20_HASH_FATARROW' => 208
		}
	},
	{#State 146
		DEFAULT => -204
	},
	{#State 147
		ACTIONS => {
			"]" => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP09_BITWISE_SHIFT' => 164,
			'OP16_LOGICAL_OR' => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP06_REGEX_MATCH' => 154,
			";" => -114,
			")" => -114,
			'OP08_STRING_CAT' => 162,
			".." => -114,
			'OP18_TERNARY' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP17_LIST_RANGE' => -114,
			'OP12_COMPARE_EQ_NEQ' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP13_BITWISE_AND' => -114,
			'OP15_LOGICAL_AND' => -114,
			"}" => -114,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP08_MATH_ADD_SUB' => 158
		}
	},
	{#State 148
		ACTIONS => {
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'LITERAL' => 81,
			"\@{" => 78,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 209,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'HashReference' => 57,
			'Variable' => 101,
			'Operator' => 74
		}
	},
	{#State 149
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"\@{" => 78,
			'LITERAL' => 81,
			"(" => 54,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51
		},
		GOTOS => {
			'Expression' => 210,
			'WordScoped' => 55,
			'Variable' => 101,
			'Operator' => 74,
			'HashReference' => 57,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68
		}
	},
	{#State 150
		ACTIONS => {
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			"(" => 54,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			'LITERAL' => 81,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'Expression' => 211,
			'WordScoped' => 55,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57
		}
	},
	{#State 151
		ACTIONS => {
			'LITERAL' => 81,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57,
			'Expression' => 212,
			'WordScoped' => 55
		}
	},
	{#State 152
		ACTIONS => {
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			'LITERAL' => 81
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57,
			'Expression' => 213,
			'WordScoped' => 55
		}
	},
	{#State 153
		ACTIONS => {
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"(" => 54,
			"[" => 51,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'LITERAL' => 81,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 214,
			'HashReference' => 57,
			'Variable' => 101,
			'Operator' => 74,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashDereferenced' => 62
		}
	},
	{#State 154
		ACTIONS => {
			"/" => 215
		}
	},
	{#State 155
		ACTIONS => {
			'LITERAL' => 81,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"%{" => 67,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			"[" => 51,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54
		},
		GOTOS => {
			'HashReference' => 57,
			'Variable' => 101,
			'Operator' => 74,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'WordScoped' => 55,
			'Expression' => 216
		}
	},
	{#State 156
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"[" => 51,
			"(" => 54,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			'LITERAL' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'Expression' => 217,
			'WordScoped' => 55,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57
		}
	},
	{#State 157
		ACTIONS => {
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"\@{" => 78,
			'LITERAL' => 81,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 218,
			'HashReference' => 57,
			'Operator' => 74,
			'Variable' => 101,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashDereferenced' => 62
		}
	},
	{#State 158
		ACTIONS => {
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			"%{" => 67,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"\@{" => 78,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			'LITERAL' => 81
		},
		GOTOS => {
			'Expression' => 219,
			'WordScoped' => 55,
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashDereferenced' => 62
		}
	},
	{#State 159
		ACTIONS => {
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"%{" => 67,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			'LITERAL' => 81
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 220,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'HashReference' => 57,
			'Variable' => 101,
			'Operator' => 74
		}
	},
	{#State 160
		ACTIONS => {
			"\@{" => 78,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			'LITERAL' => 81,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			"(" => 54,
			'WORD_SCOPED' => 12,
			"undef" => 71
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 221,
			'HashReference' => 57,
			'Operator' => 74,
			'Variable' => 101,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79
		}
	},
	{#State 161
		DEFAULT => -98
	},
	{#State 162
		ACTIONS => {
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			'LITERAL' => 81,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 222,
			'HashReference' => 57,
			'Operator' => 74,
			'Variable' => 101,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79
		}
	},
	{#State 163
		ACTIONS => {
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'Variable' => 223
		}
	},
	{#State 164
		ACTIONS => {
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"%{" => 67,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'LITERAL' => 81,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"\@{" => 78,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54,
			"[" => 51,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49
		},
		GOTOS => {
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68,
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57,
			'Expression' => 224,
			'WordScoped' => 55
		}
	},
	{#State 165
		DEFAULT => -155
	},
	{#State 166
		ACTIONS => {
			'OP18_TERNARY' => -181,
			'OP02_HASH_THINARROW' => 227,
			")" => -181,
			'OP08_STRING_CAT' => -181,
			".." => -181,
			'OP03_MATH_INC_DEC' => -181,
			'OP06_REGEX_MATCH' => -181,
			";" => -181,
			'OP16_LOGICAL_OR' => -181,
			'COLON' => -181,
			'OP23_LOGICAL_AND' => -181,
			'OP09_BITWISE_SHIFT' => -181,
			'OP11_COMPARE_LT_GT' => -181,
			"]" => -181,
			'OP19_VARIABLE_ASSIGN' => -181,
			'OP02_ARRAY_THINARROW' => 226,
			'OP08_MATH_ADD_SUB' => -181,
			'OP19_VARIABLE_ASSIGN_BY' => -181,
			'OP14_BITWISE_OR_XOR' => -181,
			'OP04_MATH_POW' => -181,
			'OP21_LIST_COMMA' => -181,
			'OP15_LOGICAL_AND' => -181,
			'OP13_BITWISE_AND' => -181,
			"}" => -181,
			'OP02_METHOD_THINARROW' => -181,
			'OP24_LOGICAL_OR_XOR' => -181,
			'OP17_LIST_RANGE' => -181,
			'OP12_COMPARE_EQ_NEQ' => -181,
			'OP07_MATH_MULT_DIV_MOD' => -181
		},
		GOTOS => {
			'VariableRetrieval' => 225
		}
	},
	{#State 167
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 158,
			'OP21_LIST_COMMA' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP15_LOGICAL_AND' => -113,
			"}" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP17_LIST_RANGE' => -113,
			'OP12_COMPARE_EQ_NEQ' => -113,
			")" => -113,
			'OP08_STRING_CAT' => 162,
			".." => -113,
			'OP18_TERNARY' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP06_REGEX_MATCH' => 154,
			";" => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP09_BITWISE_SHIFT' => 164,
			"]" => -113
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
		ACTIONS => {
			"1;" => 229
		}
	},
	{#State 171
		ACTIONS => {
			";" => 230
		}
	},
	{#State 172
		DEFAULT => -31
	},
	{#State 173
		ACTIONS => {
			"[" => 234,
			'LITERAL' => 232,
			"{" => 231
		},
		GOTOS => {
			'ConstantValue' => 233
		}
	},
	{#State 174
		ACTIONS => {
			"(" => 235
		}
	},
	{#State 175
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP06_REGEX_MATCH' => 154,
			";" => 236,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP15_LOGICAL_AND' => 148,
			'OP13_BITWISE_AND' => 156,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP08_MATH_ADD_SUB' => 158
		}
	},
	{#State 176
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP15_LOGICAL_AND' => 148,
			'OP13_BITWISE_AND' => 156,
			'OP08_MATH_ADD_SUB' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			";" => 237,
			'OP06_REGEX_MATCH' => 154,
			'OP23_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 163,
			'OP08_STRING_CAT' => 162
		}
	},
	{#State 177
		DEFAULT => -100
	},
	{#State 178
		ACTIONS => {
			")" => 238
		}
	},
	{#State 179
		ACTIONS => {
			";" => -192,
			"]" => -192,
			'OP21_LIST_COMMA' => 240,
			")" => -192
		},
		GOTOS => {
			'PAREN-57' => 239
		}
	},
	{#State 180
		ACTIONS => {
			"\$TYPED_" => 241
		}
	},
	{#State 181
		DEFAULT => -195
	},
	{#State 182
		ACTIONS => {
			"]" => -194,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164,
			'OP23_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			";" => -194,
			'OP06_REGEX_MATCH' => 154,
			")" => -194,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => 159,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP21_LIST_COMMA' => -194,
			'OP15_LOGICAL_AND' => 148,
			'OP13_BITWISE_AND' => 156,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP08_MATH_ADD_SUB' => 158
		}
	},
	{#State 183
		DEFAULT => -198
	},
	{#State 184
		ACTIONS => {
			'VARIABLE_SYMBOL' => 242
		}
	},
	{#State 185
		ACTIONS => {
			'OP23_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP06_REGEX_MATCH' => 154,
			")" => 243,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164,
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP08_MATH_ADD_SUB' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => 159,
			'OP24_LOGICAL_OR_XOR' => 151
		}
	},
	{#State 186
		ACTIONS => {
			"(" => 244
		}
	},
	{#State 187
		ACTIONS => {
			"= sub {" => 245
		}
	},
	{#State 188
		DEFAULT => -154
	},
	{#State 189
		ACTIONS => {
			")" => 246
		}
	},
	{#State 190
		DEFAULT => -139
	},
	{#State 191
		DEFAULT => -107
	},
	{#State 192
		ACTIONS => {
			";" => 248,
			'OP19_VARIABLE_ASSIGN' => 247
		}
	},
	{#State 193
		DEFAULT => -138
	},
	{#State 194
		ACTIONS => {
			'VARIABLE_SYMBOL' => 249
		}
	},
	{#State 195
		ACTIONS => {
			";" => 250
		}
	},
	{#State 196
		DEFAULT => -132
	},
	{#State 197
		DEFAULT => -136
	},
	{#State 198
		ACTIONS => {
			"}" => 251
		}
	},
	{#State 199
		DEFAULT => -212
	},
	{#State 200
		DEFAULT => -211
	},
	{#State 201
		ACTIONS => {
			")" => 252
		}
	},
	{#State 202
		DEFAULT => -128
	},
	{#State 203
		ACTIONS => {
			";" => 253
		}
	},
	{#State 204
		DEFAULT => -200
	},
	{#State 205
		DEFAULT => -199
	},
	{#State 206
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 255
		}
	},
	{#State 207
		ACTIONS => {
			"}" => 258,
			'OP21_LIST_COMMA' => 257
		},
		GOTOS => {
			'PAREN-61' => 256
		}
	},
	{#State 208
		ACTIONS => {
			'OP05_MATH_NEG' => -202,
			'WORD' => -202,
			"\@{" => -202,
			"my" => 106,
			'LITERAL' => -202,
			"{" => -202,
			'OP05_LOGICAL_NEG' => -202,
			'OP03_MATH_INC_DEC' => -202,
			'OP10_NAMED_UNARY_STRINGIFY' => -202,
			'OP10_NAMED_UNARY' => -202,
			'VARIABLE_SYMBOL' => -202,
			"%{" => -202,
			'OP22_LOGICAL_NOT' => -202,
			'OP01_NAMED' => -202,
			"[" => -202,
			"(" => -202,
			"undef" => -202,
			'WORD_SCOPED' => -202
		},
		GOTOS => {
			'OPTIONAL-60' => 259,
			'TypeInner' => 260
		}
	},
	{#State 209
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 158,
			"}" => -119,
			'OP21_LIST_COMMA' => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP13_BITWISE_AND' => 156,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => -119,
			")" => -119,
			".." => -119,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => -119,
			'OP23_LOGICAL_AND' => -119,
			'OP16_LOGICAL_OR' => -119,
			";" => -119,
			'OP06_REGEX_MATCH' => 154,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164,
			"]" => -119
		}
	},
	{#State 210
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP04_MATH_POW' => 157,
			"}" => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP21_LIST_COMMA' => -118,
			'OP13_BITWISE_AND' => 156,
			'OP08_MATH_ADD_SUB' => 158,
			"]" => -118,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			";" => -118,
			'OP06_REGEX_MATCH' => 154,
			'OP23_LOGICAL_AND' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP18_TERNARY' => -118,
			'OP08_STRING_CAT' => 162,
			")" => -118,
			".." => -118
		}
	},
	{#State 211
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP04_MATH_POW' => 157,
			"}" => -109,
			'OP21_LIST_COMMA' => -109,
			'OP13_BITWISE_AND' => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP08_MATH_ADD_SUB' => -109,
			"]" => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			";" => -109,
			'OP06_REGEX_MATCH' => 154,
			'OP23_LOGICAL_AND' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP18_TERNARY' => -109,
			'OP08_STRING_CAT' => -109,
			")" => -109,
			".." => -109
		}
	},
	{#State 212
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			"]" => -125,
			'OP18_TERNARY' => 163,
			".." => -125,
			")" => -125,
			'OP08_STRING_CAT' => 162,
			";" => -125,
			'OP06_REGEX_MATCH' => 154,
			'OP23_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP08_MATH_ADD_SUB' => 158,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			"}" => -125,
			'OP13_BITWISE_AND' => 156,
			'OP21_LIST_COMMA' => -125,
			'OP15_LOGICAL_AND' => 148
		}
	},
	{#State 213
		ACTIONS => {
			"]" => -120,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			'OP06_REGEX_MATCH' => 154,
			";" => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP23_LOGICAL_AND' => -120,
			'OP18_TERNARY' => -120,
			".." => -120,
			")" => -120,
			'OP08_STRING_CAT' => 162,
			'OP17_LIST_RANGE' => -120,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP13_BITWISE_AND' => 156,
			'OP21_LIST_COMMA' => -120,
			'OP15_LOGICAL_AND' => 148,
			"}" => -120,
			'OP08_MATH_ADD_SUB' => 158
		}
	},
	{#State 214
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 158,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP15_LOGICAL_AND' => 148,
			'OP21_LIST_COMMA' => -124,
			'OP13_BITWISE_AND' => 156,
			"}" => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP18_TERNARY' => 163,
			".." => -124,
			")" => -124,
			'OP08_STRING_CAT' => 162,
			'OP06_REGEX_MATCH' => 154,
			";" => -124,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => -124,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			"]" => -124
		}
	},
	{#State 215
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 261
		}
	},
	{#State 216
		ACTIONS => {
			'OP18_TERNARY' => -115,
			'OP08_STRING_CAT' => 162,
			")" => -115,
			".." => -115,
			'OP06_REGEX_MATCH' => 154,
			";" => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => undef,
			"]" => -115,
			'OP08_MATH_ADD_SUB' => 158,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP04_MATH_POW' => 157,
			'OP15_LOGICAL_AND' => -115,
			'OP21_LIST_COMMA' => -115,
			'OP13_BITWISE_AND' => -115,
			"}" => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP17_LIST_RANGE' => -115,
			'OP12_COMPARE_EQ_NEQ' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 150
		}
	},
	{#State 217
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -117,
			'OP04_MATH_POW' => 157,
			"}" => -117,
			'OP21_LIST_COMMA' => -117,
			'OP13_BITWISE_AND' => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP08_MATH_ADD_SUB' => 158,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => -117,
			";" => -117,
			'OP06_REGEX_MATCH' => 154,
			'OP23_LOGICAL_AND' => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP18_TERNARY' => -117,
			'OP08_STRING_CAT' => 162,
			")" => -117,
			".." => -117,
			"]" => -117,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155
		}
	},
	{#State 218
		ACTIONS => {
			"]" => -105,
			'OP11_COMPARE_LT_GT' => -105,
			'OP09_BITWISE_SHIFT' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP16_LOGICAL_OR' => -105,
			";" => -105,
			'OP06_REGEX_MATCH' => -105,
			")" => -105,
			".." => -105,
			'OP08_STRING_CAT' => -105,
			'OP18_TERNARY' => -105,
			'OP07_MATH_MULT_DIV_MOD' => -105,
			'OP12_COMPARE_EQ_NEQ' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			"}" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP13_BITWISE_AND' => -105,
			'OP15_LOGICAL_AND' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP04_MATH_POW' => 157,
			'OP08_MATH_ADD_SUB' => -105
		}
	},
	{#State 219
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP17_LIST_RANGE' => -110,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP08_MATH_ADD_SUB' => -110,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => -110,
			"}" => -110,
			'OP21_LIST_COMMA' => -110,
			'OP13_BITWISE_AND' => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			"]" => -110,
			'OP18_TERNARY' => -110,
			".." => -110,
			")" => -110,
			'OP08_STRING_CAT' => -110,
			";" => -110,
			'OP06_REGEX_MATCH' => 154,
			'OP23_LOGICAL_AND' => -110,
			'OP16_LOGICAL_OR' => -110
		}
	},
	{#State 220
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP08_MATH_ADD_SUB' => 158,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP13_BITWISE_AND' => 156,
			'OP21_LIST_COMMA' => -121,
			'OP15_LOGICAL_AND' => 148,
			"}" => -121,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			"]" => -121,
			'OP18_TERNARY' => -121,
			'OP08_STRING_CAT' => 162,
			")" => -121,
			".." => -121,
			'OP06_REGEX_MATCH' => 154,
			";" => -121,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => -121
		}
	},
	{#State 221
		ACTIONS => {
			'OP06_REGEX_MATCH' => 154,
			";" => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP18_TERNARY' => -116,
			'OP08_STRING_CAT' => 162,
			")" => -116,
			".." => -116,
			"]" => -116,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP04_MATH_POW' => 157,
			'OP13_BITWISE_AND' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP15_LOGICAL_AND' => -116,
			"}" => -116,
			'OP08_MATH_ADD_SUB' => 158,
			'OP17_LIST_RANGE' => -116,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => -116
		}
	},
	{#State 222
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			"]" => -111,
			'OP18_TERNARY' => -111,
			".." => -111,
			")" => -111,
			'OP08_STRING_CAT' => -111,
			'OP06_REGEX_MATCH' => 154,
			";" => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP08_MATH_ADD_SUB' => 158,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP13_BITWISE_AND' => -111,
			'OP15_LOGICAL_AND' => -111,
			"}" => -111
		}
	},
	{#State 223
		ACTIONS => {
			'COLON' => 262
		}
	},
	{#State 224
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			"}" => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP08_MATH_ADD_SUB' => 158,
			"]" => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP16_LOGICAL_OR' => -112,
			";" => -112,
			'OP06_REGEX_MATCH' => 154,
			")" => -112,
			".." => -112,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => -112
		}
	},
	{#State 225
		DEFAULT => -179
	},
	{#State 226
		ACTIONS => {
			'LITERAL' => 81,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			"[" => 51,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'HashReference' => 57,
			'Variable' => 101,
			'Operator' => 74,
			'WordScoped' => 55,
			'Expression' => 263
		}
	},
	{#State 227
		ACTIONS => {
			'LITERAL' => 81,
			'WORD' => 264,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"%{" => 67,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"(" => 54
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'Variable' => 101,
			'Operator' => 74,
			'HashReference' => 57,
			'Expression' => 265,
			'WordScoped' => 55
		}
	},
	{#State 228
		ACTIONS => {
			"use" => -71,
			"our %properties = (" => -71,
			"use constant" => -71,
			"## no critic qw(" => 22
		},
		GOTOS => {
			'STAR-29' => 266,
			'Critic' => 267
		}
	},
	{#State 229
		DEFAULT => -26
	},
	{#State 230
		DEFAULT => -34
	},
	{#State 231
		ACTIONS => {
			'WORD' => 268
		}
	},
	{#State 232
		DEFAULT => -50
	},
	{#State 233
		ACTIONS => {
			";" => 269
		}
	},
	{#State 234
		ACTIONS => {
			"my" => 106,
			'LITERAL' => -37
		},
		GOTOS => {
			'TypeInner' => 270,
			'OPTIONAL-13' => 271
		}
	},
	{#State 235
		ACTIONS => {
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			'LITERAL' => 81,
			"my" => 106,
			")" => -142,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			"%{" => 67,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			"(" => 54,
			'KEYS_OR_VALUES' => 108,
			'WORD_SCOPED' => 12,
			"undef" => 71
		},
		GOTOS => {
			'OPTIONAL-48' => 273,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'TypeInner' => 109,
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57,
			'ListElements' => 272,
			'ListElement' => 105,
			'Expression' => 104,
			'WordScoped' => 55
		}
	},
	{#State 236
		DEFAULT => -188
	},
	{#State 237
		DEFAULT => -187
	},
	{#State 238
		DEFAULT => -102
	},
	{#State 239
		DEFAULT => -190
	},
	{#State 240
		ACTIONS => {
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			'KEYS_OR_VALUES' => 108,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"\@{" => 78,
			"my" => 106,
			'LITERAL' => 81,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67
		},
		GOTOS => {
			'TypeInner' => 109,
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'Expression' => 104,
			'WordScoped' => 55,
			'ListElement' => 274
		}
	},
	{#State 241
		ACTIONS => {
			'WORD' => 275
		}
	},
	{#State 242
		ACTIONS => {
			"(" => 276
		}
	},
	{#State 243
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 277
		}
	},
	{#State 244
		ACTIONS => {
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'LITERAL' => 81,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 278,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'HashReference' => 57,
			'Operator' => 74,
			'Variable' => 101
		}
	},
	{#State 245
		ACTIONS => {
			"undef" => -54,
			'WORD_SCOPED' => -54,
			"(" => -54,
			"while (" => -54,
			"for my integer" => -54,
			"[" => -54,
			'OP01_NAMED_VOID_PAREN' => -54,
			'OP22_LOGICAL_NOT' => -54,
			'OP01_NAMED' => -54,
			"%{" => -54,
			'OP10_NAMED_UNARY' => -54,
			'VARIABLE_SYMBOL' => -54,
			'OP03_MATH_INC_DEC' => -54,
			'OP10_NAMED_UNARY_STRINGIFY' => -54,
			"{" => -54,
			'OP01_NAMED_VOID' => -54,
			"( my" => 279,
			'OP05_LOGICAL_NEG' => -54,
			"if (" => -54,
			'LITERAL' => -54,
			'OP19_LOOP_CONTROL' => -54,
			"my" => -54,
			"foreach my" => -54,
			"\@{" => -54,
			'WORD' => -54,
			'OP05_MATH_NEG' => -54
		},
		GOTOS => {
			'SubroutineArguments' => 281,
			'OPTIONAL-21' => 280
		}
	},
	{#State 246
		DEFAULT => -152
	},
	{#State 247
		ACTIONS => {
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"(" => 54,
			'LITERAL' => 81,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"%{" => 67,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66
		},
		GOTOS => {
			'Variable' => 101,
			'Operator' => 74,
			'HashReference' => 57,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'Expression' => 282,
			'WordScoped' => 55
		}
	},
	{#State 248
		DEFAULT => -185
	},
	{#State 249
		DEFAULT => -216
	},
	{#State 250
		DEFAULT => -137
	},
	{#State 251
		DEFAULT => -215
	},
	{#State 252
		ACTIONS => {
			";" => 283
		}
	},
	{#State 253
		DEFAULT => -134
	},
	{#State 254
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 63,
			"if (" => 80,
			'LITERAL' => 81,
			"foreach my" => -157,
			"my" => 61,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 75,
			"%{" => 67,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP01_NAMED_VOID' => 64,
			"[" => 51,
			'OP01_NAMED_VOID_PAREN' => 69,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54,
			"for my integer" => -157,
			"while (" => -157
		},
		GOTOS => {
			'WordScoped' => 55,
			'OperatorVoid' => 72,
			'Operation' => 284,
			'Conditional' => 56,
			'Variable' => 48,
			'OPTIONAL-50' => 52,
			'ArrayDereferenced' => 68,
			'PLUS-55' => 285,
			'VariableDeclaration' => 70,
			'Expression' => 85,
			'LoopLabel' => 86,
			'Operator' => 74,
			'HashReference' => 57,
			'Statement' => 76,
			'PAREN-49' => 77,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'VariableModification' => 82
		}
	},
	{#State 255
		DEFAULT => -165,
		GOTOS => {
			'STAR-52' => 286
		}
	},
	{#State 256
		DEFAULT => -208
	},
	{#State 257
		ACTIONS => {
			"%{" => 67,
			'WORD' => 145
		},
		GOTOS => {
			'HashDereferenced' => 146,
			'HashEntry' => 287
		}
	},
	{#State 258
		DEFAULT => -210
	},
	{#State 259
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"[" => 51,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			'LITERAL' => 81,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"%{" => 67
		},
		GOTOS => {
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'Variable' => 101,
			'Operator' => 74,
			'HashReference' => 57,
			'Expression' => 288,
			'WordScoped' => 55
		}
	},
	{#State 260
		DEFAULT => -201
	},
	{#State 261
		ACTIONS => {
			"/" => 289
		}
	},
	{#State 262
		ACTIONS => {
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'Variable' => 290
		}
	},
	{#State 263
		ACTIONS => {
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP08_MATH_ADD_SUB' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => 159,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP23_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP06_REGEX_MATCH' => 154,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			"]" => 291,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164
		}
	},
	{#State 264
		ACTIONS => {
			"}" => 292,
			"(" => -213
		}
	},
	{#State 265
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			'OP18_TERNARY' => 163,
			'OP08_STRING_CAT' => 162,
			'OP06_REGEX_MATCH' => 154,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP08_MATH_ADD_SUB' => 158,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP15_LOGICAL_AND' => 148,
			'OP13_BITWISE_AND' => 156,
			"}" => 293
		}
	},
	{#State 266
		ACTIONS => {
			"use constant" => -73,
			"use" => 27,
			"our %properties = (" => -73
		},
		GOTOS => {
			'Include' => 294,
			'STAR-30' => 295
		}
	},
	{#State 267
		DEFAULT => -68
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
		DEFAULT => -36
	},
	{#State 271
		ACTIONS => {
			'LITERAL' => 297
		}
	},
	{#State 272
		DEFAULT => -141
	},
	{#State 273
		ACTIONS => {
			")" => 298
		}
	},
	{#State 274
		DEFAULT => -189
	},
	{#State 275
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 276
		ACTIONS => {
			'KEYS_OR_VALUES' => 108,
			"(" => 54,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"%{" => 67,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			"my" => 106,
			'LITERAL' => 81
		},
		GOTOS => {
			'HashReference' => 57,
			'Operator' => 74,
			'Variable' => 101,
			'TypeInner' => 109,
			'ListElements' => 300,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'WordScoped' => 55,
			'Expression' => 104,
			'ListElement' => 105
		}
	},
	{#State 277
		DEFAULT => -175
	},
	{#State 278
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP06_REGEX_MATCH' => 154,
			'OP08_STRING_CAT' => 162,
			".." => 301,
			'OP18_TERNARY' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP08_MATH_ADD_SUB' => 158
		}
	},
	{#State 279
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 302
		}
	},
	{#State 280
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"[" => 51,
			'OP01_NAMED_VOID_PAREN' => 69,
			"(" => 54,
			"while (" => -157,
			"for my integer" => -157,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 75,
			"if (" => 80,
			'LITERAL' => 81,
			'OP19_LOOP_CONTROL' => 63,
			"my" => 61,
			"foreach my" => -157,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			"{" => 83,
			'OP01_NAMED_VOID' => 64,
			'OP05_LOGICAL_NEG' => 65,
			"%{" => 67,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88
		},
		GOTOS => {
			'HashReference' => 57,
			'Operator' => 74,
			'Statement' => 76,
			'PLUS-22' => 303,
			'PAREN-49' => 77,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'VariableModification' => 82,
			'Expression' => 85,
			'LoopLabel' => 86,
			'Variable' => 48,
			'ArrayDereferenced' => 68,
			'OPTIONAL-50' => 52,
			'VariableDeclaration' => 70,
			'WordScoped' => 55,
			'OperatorVoid' => 72,
			'Conditional' => 56,
			'Operation' => 304
		}
	},
	{#State 281
		DEFAULT => -53
	},
	{#State 282
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP06_REGEX_MATCH' => 154,
			";" => 305,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP08_MATH_ADD_SUB' => 158
		}
	},
	{#State 283
		DEFAULT => -135
	},
	{#State 284
		DEFAULT => -177
	},
	{#State 285
		ACTIONS => {
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 75,
			"if (" => 80,
			'LITERAL' => 81,
			'OP19_LOOP_CONTROL' => 63,
			"my" => 61,
			"foreach my" => -157,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"{" => 83,
			'OP01_NAMED_VOID' => 64,
			'OP05_LOGICAL_NEG' => 65,
			"%{" => 67,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			'OP01_NAMED_VOID_PAREN' => 69,
			"[" => 51,
			"(" => 54,
			"while (" => -157,
			"for my integer" => -157,
			"}" => 306,
			'WORD_SCOPED' => 12,
			"undef" => 71
		},
		GOTOS => {
			'VariableModification' => 82,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'Statement' => 76,
			'PAREN-49' => 77,
			'Operator' => 74,
			'HashReference' => 57,
			'LoopLabel' => 86,
			'Expression' => 85,
			'VariableDeclaration' => 70,
			'OPTIONAL-50' => 52,
			'ArrayDereferenced' => 68,
			'Variable' => 48,
			'Operation' => 307,
			'Conditional' => 56,
			'OperatorVoid' => 72,
			'WordScoped' => 55
		}
	},
	{#State 286
		ACTIONS => {
			"}" => -168,
			'WORD_SCOPED' => -168,
			"undef" => -168,
			"(" => -168,
			"while (" => -168,
			"elsif (" => 311,
			"for my integer" => -168,
			"[" => -168,
			'OP01_NAMED_VOID_PAREN' => -168,
			'OP22_LOGICAL_NOT' => -168,
			'OP01_NAMED' => -168,
			'' => -168,
			"else" => 312,
			"%{" => -168,
			'OP10_NAMED_UNARY' => -168,
			'VARIABLE_SYMBOL' => -168,
			'OP10_NAMED_UNARY_STRINGIFY' => -168,
			'OP03_MATH_INC_DEC' => -168,
			'OP01_NAMED_VOID' => -168,
			"{" => -168,
			'OP05_LOGICAL_NEG' => -168,
			"if (" => -168,
			'LITERAL' => -168,
			'OP19_LOOP_CONTROL' => -168,
			"my" => -168,
			"foreach my" => -168,
			"\@{" => -168,
			'OP05_MATH_NEG' => -168,
			'WORD' => -168
		},
		GOTOS => {
			'PAREN-51' => 309,
			'PAREN-53' => 308,
			'OPTIONAL-54' => 310
		}
	},
	{#State 287
		DEFAULT => -207
	},
	{#State 288
		ACTIONS => {
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP06_REGEX_MATCH' => 154,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164,
			'OP21_LIST_COMMA' => -203,
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			"}" => -203,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP08_MATH_ADD_SUB' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP24_LOGICAL_OR_XOR' => 151
		}
	},
	{#State 289
		DEFAULT => -108
	},
	{#State 290
		DEFAULT => -122
	},
	{#State 291
		DEFAULT => -182
	},
	{#State 292
		DEFAULT => -184
	},
	{#State 293
		DEFAULT => -183
	},
	{#State 294
		DEFAULT => -70
	},
	{#State 295
		ACTIONS => {
			"use constant" => 36,
			"our %properties = (" => 314
		},
		GOTOS => {
			'Properties' => 313,
			'Constant' => 315
		}
	},
	{#State 296
		ACTIONS => {
			"my" => 106,
			'LITERAL' => -44
		},
		GOTOS => {
			'TypeInner' => 317,
			'OPTIONAL-17' => 316
		}
	},
	{#State 297
		DEFAULT => -42,
		GOTOS => {
			'STAR-16' => 318
		}
	},
	{#State 298
		DEFAULT => -153
	},
	{#State 299
		DEFAULT => -217
	},
	{#State 300
		ACTIONS => {
			")" => 319
		}
	},
	{#State 301
		ACTIONS => {
			'LITERAL' => 81,
			"\@{" => 78,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			"[" => 51,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"(" => 54
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 320,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79,
			'HashReference' => 57,
			'Variable' => 101,
			'Operator' => 74
		}
	},
	{#State 302
		ACTIONS => {
			'VARIABLE_SYMBOL' => 321
		}
	},
	{#State 303
		ACTIONS => {
			"(" => 54,
			"for my integer" => -157,
			"while (" => -157,
			"}" => 323,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51,
			'OP01_NAMED_VOID_PAREN' => 69,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP05_LOGICAL_NEG' => 65,
			'OP01_NAMED_VOID' => 64,
			"{" => 83,
			"%{" => 67,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"\@{" => 78,
			'WORD' => 75,
			'OP05_MATH_NEG' => 60,
			'OP19_LOOP_CONTROL' => 63,
			"if (" => 80,
			'LITERAL' => 81,
			"foreach my" => -157,
			"my" => 61
		},
		GOTOS => {
			'Variable' => 48,
			'VariableDeclaration' => 70,
			'OPTIONAL-50' => 52,
			'ArrayDereferenced' => 68,
			'WordScoped' => 55,
			'Conditional' => 56,
			'Operation' => 322,
			'OperatorVoid' => 72,
			'Statement' => 76,
			'PAREN-49' => 77,
			'Operator' => 74,
			'HashReference' => 57,
			'VariableModification' => 82,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'Expression' => 85,
			'LoopLabel' => 86
		}
	},
	{#State 304
		DEFAULT => -56
	},
	{#State 305
		DEFAULT => -186
	},
	{#State 306
		DEFAULT => -178
	},
	{#State 307
		DEFAULT => -176
	},
	{#State 308
		DEFAULT => -167
	},
	{#State 309
		DEFAULT => -164
	},
	{#State 310
		DEFAULT => -169
	},
	{#State 311
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP03_MATH_INC_DEC' => 66,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			'LITERAL' => 81,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51
		},
		GOTOS => {
			'WordScoped' => 55,
			'Expression' => 324,
			'HashReference' => 57,
			'Variable' => 101,
			'Operator' => 74,
			'HashDereferenced' => 62,
			'ArrayDereferenced' => 68,
			'ArrayReference' => 79
		}
	},
	{#State 312
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 325
		}
	},
	{#State 313
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 326
		}
	},
	{#State 314
		ACTIONS => {
			"%{" => 67,
			")" => 329,
			'WORD' => 328
		},
		GOTOS => {
			'HashEntryTyped' => 330,
			'HashDereferenced' => 327
		}
	},
	{#State 315
		DEFAULT => -72
	},
	{#State 316
		ACTIONS => {
			'LITERAL' => 331
		}
	},
	{#State 317
		DEFAULT => -43
	},
	{#State 318
		ACTIONS => {
			'OP21_LIST_COMMA' => 333,
			"]" => 332
		},
		GOTOS => {
			'PAREN-15' => 334
		}
	},
	{#State 319
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 335
		}
	},
	{#State 320
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => 159,
			'OP08_MATH_ADD_SUB' => 158,
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164,
			")" => 336,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP23_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP06_REGEX_MATCH' => 154
		}
	},
	{#State 321
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 337
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
		ACTIONS => {
			'OP06_REGEX_MATCH' => 154,
			'OP23_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP18_TERNARY' => 163,
			")" => 339,
			'OP08_STRING_CAT' => 162,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP15_LOGICAL_AND' => 148,
			'OP13_BITWISE_AND' => 156,
			'OP08_MATH_ADD_SUB' => 158,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => 151
		}
	},
	{#State 325
		DEFAULT => -166
	},
	{#State 326
		ACTIONS => {
			"1;" => 342,
			"our" => 340
		},
		GOTOS => {
			'Method' => 341
		}
	},
	{#State 327
		DEFAULT => -206
	},
	{#State 328
		ACTIONS => {
			'OP20_HASH_FATARROW' => 343
		}
	},
	{#State 329
		ACTIONS => {
			";" => 344
		}
	},
	{#State 330
		DEFAULT => -84,
		GOTOS => {
			'STAR-36' => 345
		}
	},
	{#State 331
		DEFAULT => -49,
		GOTOS => {
			'STAR-20' => 346
		}
	},
	{#State 332
		DEFAULT => -51
	},
	{#State 333
		ACTIONS => {
			"my" => 106,
			'LITERAL' => -39
		},
		GOTOS => {
			'OPTIONAL-14' => 347,
			'TypeInner' => 348
		}
	},
	{#State 334
		DEFAULT => -41
	},
	{#State 335
		DEFAULT => -174
	},
	{#State 336
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 349
		}
	},
	{#State 337
		ACTIONS => {
			'OP21_LIST_COMMA' => 350,
			")" => 351
		},
		GOTOS => {
			'PAREN-23' => 352
		}
	},
	{#State 338
		DEFAULT => -57
	},
	{#State 339
		ACTIONS => {
			"{" => 254
		},
		GOTOS => {
			'CodeBlock' => 353
		}
	},
	{#State 340
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 354
		}
	},
	{#State 341
		DEFAULT => -74
	},
	{#State 342
		ACTIONS => {
			"1;" => 355
		}
	},
	{#State 343
		ACTIONS => {
			"my" => 106
		},
		GOTOS => {
			'TypeInner' => 356
		}
	},
	{#State 344
		DEFAULT => -86
	},
	{#State 345
		ACTIONS => {
			")" => 359,
			'OP21_LIST_COMMA' => 358
		},
		GOTOS => {
			'PAREN-35' => 357
		}
	},
	{#State 346
		ACTIONS => {
			"}" => 361,
			'OP21_LIST_COMMA' => 362
		},
		GOTOS => {
			'PAREN-19' => 360
		}
	},
	{#State 347
		ACTIONS => {
			'LITERAL' => 363
		}
	},
	{#State 348
		DEFAULT => -38
	},
	{#State 349
		DEFAULT => -173
	},
	{#State 350
		ACTIONS => {
			"my" => 364
		}
	},
	{#State 351
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 365
		}
	},
	{#State 352
		DEFAULT => -59
	},
	{#State 353
		DEFAULT => -163
	},
	{#State 354
		ACTIONS => {
			'VARIABLE_SYMBOL' => 366
		}
	},
	{#State 355
		ACTIONS => {
			'' => -80,
			"our" => 53,
			"package" => -80
		},
		GOTOS => {
			'PAREN-33' => 367,
			'PLUS-32' => 368,
			'Subroutine' => 370,
			'OPTIONAL-34' => 369
		}
	},
	{#State 356
		ACTIONS => {
			'LITERAL' => 81,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			"%{" => 67,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			"[" => 51,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"(" => 54
		},
		GOTOS => {
			'Expression' => 371,
			'WordScoped' => 55,
			'Operator' => 74,
			'Variable' => 101,
			'HashReference' => 57,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'ArrayReference' => 79
		}
	},
	{#State 357
		DEFAULT => -83
	},
	{#State 358
		ACTIONS => {
			'WORD' => 328,
			"%{" => 67
		},
		GOTOS => {
			'HashDereferenced' => 327,
			'HashEntryTyped' => 372
		}
	},
	{#State 359
		ACTIONS => {
			";" => 373
		}
	},
	{#State 360
		DEFAULT => -48
	},
	{#State 361
		DEFAULT => -52
	},
	{#State 362
		ACTIONS => {
			'WORD' => 374
		}
	},
	{#State 363
		DEFAULT => -40
	},
	{#State 364
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 375
		}
	},
	{#State 365
		ACTIONS => {
			"\@_;" => 376
		}
	},
	{#State 366
		ACTIONS => {
			"= sub {" => 377
		}
	},
	{#State 367
		DEFAULT => -79
	},
	{#State 368
		ACTIONS => {
			"1;" => 379,
			"our" => 53
		},
		GOTOS => {
			'Subroutine' => 378
		}
	},
	{#State 369
		DEFAULT => -81
	},
	{#State 370
		DEFAULT => -77
	},
	{#State 371
		ACTIONS => {
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP13_BITWISE_AND' => 156,
			'OP21_LIST_COMMA' => -205,
			'OP15_LOGICAL_AND' => 148,
			'OP08_MATH_ADD_SUB' => 158,
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			'OP06_REGEX_MATCH' => 154,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP18_TERNARY' => 163,
			'OP08_STRING_CAT' => 162,
			")" => -205
		}
	},
	{#State 372
		DEFAULT => -82
	},
	{#State 373
		DEFAULT => -85
	},
	{#State 374
		ACTIONS => {
			'OP20_HASH_FATARROW' => 380
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
			"[" => -88,
			'OP01_NAMED_VOID_PAREN' => -88,
			'OP22_LOGICAL_NOT' => -88,
			'OP01_NAMED' => -88,
			'WORD_SCOPED' => -88,
			"undef" => -88,
			"(" => -88,
			"while (" => -88,
			"for my integer" => -88,
			"if (" => -88,
			'LITERAL' => -88,
			'OP19_LOOP_CONTROL' => -88,
			"my" => -88,
			"foreach my" => -88,
			"\@{" => -88,
			'WORD' => -88,
			'OP05_MATH_NEG' => -88,
			"%{" => -88,
			'VARIABLE_SYMBOL' => -88,
			'OP10_NAMED_UNARY' => -88,
			'OP03_MATH_INC_DEC' => -88,
			'OP10_NAMED_UNARY_STRINGIFY' => -88,
			"( my" => 385,
			"{" => -88,
			'OP01_NAMED_VOID' => -88,
			'OP05_LOGICAL_NEG' => -88
		},
		GOTOS => {
			'MethodArguments' => 384,
			'OPTIONAL-37' => 383
		}
	},
	{#State 378
		DEFAULT => -76
	},
	{#State 379
		ACTIONS => {
			"1;" => 386
		}
	},
	{#State 380
		ACTIONS => {
			'LITERAL' => -46,
			"my" => 106
		},
		GOTOS => {
			'OPTIONAL-18' => 388,
			'TypeInner' => 387
		}
	},
	{#State 381
		DEFAULT => -58
	},
	{#State 382
		ACTIONS => {
			'WORD' => -63,
			'OP05_MATH_NEG' => -63,
			"\@{" => -63,
			"foreach my" => -63,
			"my" => -63,
			'CHECK_OR_CHECKTRACE' => 389,
			'OP19_LOOP_CONTROL' => -63,
			'LITERAL' => -63,
			"if (" => -63,
			'OP05_LOGICAL_NEG' => -63,
			"{" => -63,
			'OP01_NAMED_VOID' => -63,
			'OP10_NAMED_UNARY_STRINGIFY' => -63,
			'OP03_MATH_INC_DEC' => -63,
			'OP10_NAMED_UNARY' => -63,
			'VARIABLE_SYMBOL' => -63,
			"%{" => -63,
			'OP01_NAMED' => -63,
			'OP22_LOGICAL_NOT' => -63,
			'OP01_NAMED_VOID_PAREN' => -63,
			"[" => -63,
			"for my integer" => -63,
			"while (" => -63,
			"(" => -63,
			"undef" => -63,
			'WORD_SCOPED' => -63
		},
		GOTOS => {
			'ArgumentCheck' => 390
		}
	},
	{#State 383
		ACTIONS => {
			'WORD' => 75,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			"foreach my" => -157,
			"my" => 61,
			'OP19_LOOP_CONTROL' => 63,
			"if (" => 80,
			'LITERAL' => 81,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP01_NAMED_VOID' => 64,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED_VOID_PAREN' => 69,
			"[" => 51,
			"for my integer" => -157,
			"while (" => -157,
			"(" => 54,
			'WORD_SCOPED' => 12,
			"undef" => 71
		},
		GOTOS => {
			'Expression' => 85,
			'LoopLabel' => 86,
			'Statement' => 76,
			'PAREN-49' => 77,
			'Operator' => 74,
			'HashReference' => 57,
			'VariableModification' => 82,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'WordScoped' => 55,
			'Operation' => 392,
			'Conditional' => 56,
			'OperatorVoid' => 72,
			'Variable' => 48,
			'PLUS-38' => 391,
			'VariableDeclaration' => 70,
			'OPTIONAL-50' => 52,
			'ArrayDereferenced' => 68
		}
	},
	{#State 384
		DEFAULT => -87
	},
	{#State 385
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 393
		}
	},
	{#State 386
		DEFAULT => -78
	},
	{#State 387
		DEFAULT => -45
	},
	{#State 388
		ACTIONS => {
			'LITERAL' => 394
		}
	},
	{#State 389
		ACTIONS => {
			"(" => 395
		}
	},
	{#State 390
		DEFAULT => -61
	},
	{#State 391
		ACTIONS => {
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED_VOID_PAREN' => 69,
			"[" => 51,
			"for my integer" => -157,
			"while (" => -157,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"}" => 396,
			'OP05_MATH_NEG' => 60,
			'WORD' => 75,
			"\@{" => 78,
			"foreach my" => -157,
			"my" => 61,
			'OP19_LOOP_CONTROL' => 63,
			'LITERAL' => 81,
			"if (" => 80,
			'OP05_LOGICAL_NEG' => 65,
			'OP01_NAMED_VOID' => 64,
			"{" => 83,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"%{" => 67
		},
		GOTOS => {
			'LoopLabel' => 86,
			'Expression' => 85,
			'ArrayReference' => 79,
			'HashDereferenced' => 62,
			'VariableModification' => 82,
			'HashReference' => 57,
			'Operator' => 74,
			'Statement' => 76,
			'PAREN-49' => 77,
			'OperatorVoid' => 72,
			'Conditional' => 56,
			'Operation' => 397,
			'WordScoped' => 55,
			'ArrayDereferenced' => 68,
			'OPTIONAL-50' => 52,
			'VariableDeclaration' => 70,
			'Variable' => 48
		}
	},
	{#State 392
		DEFAULT => -90
	},
	{#State 393
		DEFAULT => -94,
		GOTOS => {
			'STAR-40' => 398
		}
	},
	{#State 394
		DEFAULT => -47
	},
	{#State 395
		ACTIONS => {
			'LITERAL' => 81,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			"\@{" => 78,
			'VARIABLE_SYMBOL' => 87,
			'OP10_NAMED_UNARY' => 88,
			"%{" => 67,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"[" => 51,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			'WORD_SCOPED' => 12,
			"undef" => 71,
			"(" => 54
		},
		GOTOS => {
			'Variable' => 101,
			'Operator' => 74,
			'HashReference' => 57,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'Expression' => 399,
			'WordScoped' => 55
		}
	},
	{#State 396
		ACTIONS => {
			";" => 400
		}
	},
	{#State 397
		DEFAULT => -89
	},
	{#State 398
		ACTIONS => {
			")" => 403,
			'OP21_LIST_COMMA' => 401
		},
		GOTOS => {
			'PAREN-39' => 402
		}
	},
	{#State 399
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 164,
			'OP11_COMPARE_LT_GT' => 155,
			'OP06_REGEX_MATCH' => 154,
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP18_TERNARY' => 163,
			'OP08_STRING_CAT' => 162,
			")" => -66,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			'OP21_LIST_COMMA' => 406,
			'OP08_MATH_ADD_SUB' => 158
		},
		GOTOS => {
			'OPTIONAL-27' => 405,
			'PAREN-26' => 404
		}
	},
	{#State 400
		DEFAULT => -91
	},
	{#State 401
		ACTIONS => {
			"my" => 407
		}
	},
	{#State 402
		DEFAULT => -93
	},
	{#State 403
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 408
		}
	},
	{#State 404
		DEFAULT => -65
	},
	{#State 405
		ACTIONS => {
			")" => 409
		}
	},
	{#State 406
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 49,
			'OP01_NAMED' => 50,
			"[" => 51,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			"\@{" => 78,
			'OP05_MATH_NEG' => 60,
			'WORD' => 13,
			'LITERAL' => 81,
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			"{" => 83,
			'OP05_LOGICAL_NEG' => 65,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87
		},
		GOTOS => {
			'HashReference' => 57,
			'Variable' => 101,
			'Operator' => 74,
			'ArrayReference' => 79,
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'WordScoped' => 55,
			'Expression' => 410
		}
	},
	{#State 407
		ACTIONS => {
			'WORD' => 118
		},
		GOTOS => {
			'Type' => 411
		}
	},
	{#State 408
		ACTIONS => {
			"\@_;" => 412
		}
	},
	{#State 409
		ACTIONS => {
			";" => 413
		}
	},
	{#State 410
		ACTIONS => {
			'OP16_LOGICAL_OR' => 152,
			'OP23_LOGICAL_AND' => 153,
			'OP06_REGEX_MATCH' => 154,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164,
			'OP21_LIST_COMMA' => 414,
			'OP15_LOGICAL_AND' => 148,
			'OP13_BITWISE_AND' => 156,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP04_MATH_POW' => 157,
			'OP08_MATH_ADD_SUB' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP17_LIST_RANGE' => 159,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP24_LOGICAL_OR_XOR' => 151
		}
	},
	{#State 411
		ACTIONS => {
			'VARIABLE_SYMBOL' => 415
		}
	},
	{#State 412
		DEFAULT => -96,
		GOTOS => {
			'STAR-41' => 416
		}
	},
	{#State 413
		DEFAULT => -67
	},
	{#State 414
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 66,
			'OP10_NAMED_UNARY_STRINGIFY' => 84,
			'OP05_LOGICAL_NEG' => 65,
			"{" => 83,
			"%{" => 67,
			'OP10_NAMED_UNARY' => 88,
			'VARIABLE_SYMBOL' => 87,
			"\@{" => 78,
			'WORD' => 13,
			'OP05_MATH_NEG' => 60,
			'LITERAL' => 81,
			"(" => 54,
			"undef" => 71,
			'WORD_SCOPED' => 12,
			'OP01_NAMED' => 50,
			'OP22_LOGICAL_NOT' => 49,
			"[" => 51
		},
		GOTOS => {
			'ArrayDereferenced' => 68,
			'HashDereferenced' => 62,
			'ArrayReference' => 79,
			'HashReference' => 57,
			'Operator' => 74,
			'Variable' => 101,
			'WordScoped' => 55,
			'Expression' => 417
		}
	},
	{#State 415
		DEFAULT => -92
	},
	{#State 416
		ACTIONS => {
			"(" => -97,
			"for my integer" => -97,
			"while (" => -97,
			'WORD_SCOPED' => -97,
			"undef" => -97,
			'OP01_NAMED' => -97,
			'OP22_LOGICAL_NOT' => -97,
			'OP01_NAMED_VOID_PAREN' => -97,
			"[" => -97,
			'OP10_NAMED_UNARY_STRINGIFY' => -97,
			'OP03_MATH_INC_DEC' => -97,
			'OP05_LOGICAL_NEG' => -97,
			"{" => -97,
			'OP01_NAMED_VOID' => -97,
			"%{" => -97,
			'VARIABLE_SYMBOL' => -97,
			'OP10_NAMED_UNARY' => -97,
			"\@{" => -97,
			'OP05_MATH_NEG' => -97,
			'WORD' => -97,
			'OP19_LOOP_CONTROL' => -97,
			'CHECK_OR_CHECKTRACE' => 389,
			"if (" => -97,
			'LITERAL' => -97,
			"foreach my" => -97,
			"my" => -97
		},
		GOTOS => {
			'ArgumentCheck' => 418
		}
	},
	{#State 417
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 158,
			'OP13_BITWISE_AND' => 156,
			'OP15_LOGICAL_AND' => 148,
			'OP04_MATH_POW' => 157,
			'OP14_BITWISE_OR_XOR' => 149,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 150,
			'OP12_COMPARE_EQ_NEQ' => 160,
			'OP17_LIST_RANGE' => 159,
			")" => -64,
			'OP08_STRING_CAT' => 162,
			'OP18_TERNARY' => 163,
			'OP23_LOGICAL_AND' => 153,
			'OP16_LOGICAL_OR' => 152,
			'OP06_REGEX_MATCH' => 154,
			'OP11_COMPARE_LT_GT' => 155,
			'OP09_BITWISE_SHIFT' => 164
		}
	},
	{#State 418
		DEFAULT => -95
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
#line 111 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5428 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 111 "lib/RPerl/Grammar.eyp"
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
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5464 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5471 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5478 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-3', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5485 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5492 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5499 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5506 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5513 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 2,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5520 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-6', 1,
sub {
#line 112 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5527 lib/RPerl/Grammar.pm
	],
	[#Rule Program_15
		 'Program', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5538 lib/RPerl/Grammar.pm
	],
	[#Rule Module_16
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5549 lib/RPerl/Grammar.pm
	],
	[#Rule Module_17
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5560 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5567 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5574 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5581 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-8', 0,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5588 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5595 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5602 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 2,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5609 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-10', 1,
sub {
#line 115 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5616 lib/RPerl/Grammar.pm
	],
	[#Rule Package_26
		 'Package', 10,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5627 lib/RPerl/Grammar.pm
	],
	[#Rule Header_27
		 'Header', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5638 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 2,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5645 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-11', 1,
sub {
#line 117 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5652 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_30
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5663 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5670 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-12', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5677 lib/RPerl/Grammar.pm
	],
	[#Rule Include_33
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5688 lib/RPerl/Grammar.pm
	],
	[#Rule Include_34
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5699 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_35
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5710 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5717 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-13', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5724 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5731 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-14', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5738 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-15', 3,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5745 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5752 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-16', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5759 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5766 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5773 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5780 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5787 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 5,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5794 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5801 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5808 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_50
		 'ConstantValue', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5819 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_51
		 'ConstantValue', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5830 lib/RPerl/Grammar.pm
	],
	[#Rule ConstantValue_52
		 'ConstantValue', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5841 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5862 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-22', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5869 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_57
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5880 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-23', 4,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5887 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5894 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5901 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5908 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_63
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5926 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5933 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5940 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5947 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_67
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5958 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5965 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5972 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5979 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5986 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5993 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6000 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6007 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6014 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6021 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-32', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6028 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 3,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6035 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6042 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6049 lib/RPerl/Grammar.pm
	],
	[#Rule Class_81
		 'Class', 17,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6060 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6067 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6074 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6081 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_85
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6092 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_86
		 'Properties', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6103 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6110 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6117 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6124 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-38', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6131 lib/RPerl/Grammar.pm
	],
	[#Rule Method_91
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6142 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 4,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6149 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6156 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6163 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6170 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6177 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_97
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6188 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6199 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_99
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6210 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6217 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6224 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6235 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6246 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6257 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6268 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6279 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6290 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6301 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6312 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6323 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6334 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6345 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6356 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6367 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6378 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6389 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6400 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6411 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6422 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6433 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6444 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6455 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6466 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6477 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6495 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6502 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6509 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6516 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6523 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6530 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6537 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6544 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6555 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6566 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6577 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6588 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6599 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6606 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6613 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6620 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6627 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6638 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6649 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6660 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6671 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6682 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6693 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6704 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6715 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6726 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6748 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6759 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6766 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6773 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6780 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_158
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6791 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_159
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6802 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6813 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6824 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6835 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 4,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6842 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6849 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6856 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6863 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6870 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-54', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6877 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_169
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6888 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_170
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6899 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_171
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6910 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6921 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_173
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6932 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_174
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6943 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_175
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6954 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6961 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6968 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_178
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6979 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6993 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_181
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7004 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_182
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7015 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_183
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7026 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7037 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_185
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7048 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_186
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7059 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_187
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7070 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_188
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7081 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7088 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7095 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7102 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_192
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7113 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7124 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_194
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7135 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_195
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7146 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7160 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_198
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7171 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_199
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7182 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_200
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7193 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7200 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7207 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7218 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7229 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_205
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7240 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_206
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7251 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-61', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7258 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7265 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7272 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_210
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7283 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_211
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7294 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_212
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_213
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7316 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_214
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_215
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_216
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7349 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_217
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7360 lib/RPerl/Grammar.pm
	],
	[#Rule Type_218
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7371 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_219
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7382 lib/RPerl/Grammar.pm
	]
],
#line 7385 lib/RPerl/Grammar.pm
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

#line 177 "lib/RPerl/Grammar.eyp"


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


#line 7652 lib/RPerl/Grammar.pm



1;
