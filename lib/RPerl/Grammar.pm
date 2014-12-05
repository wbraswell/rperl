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
    our $VERSION = 0.000_751;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|__method|\<STDIN\>|elsif\ \(|while\ \(|package|\$TYPED_|\=\ sub\ \{|undef|if\ \(|else|\(\ my|use|our|\@_\;|qw\(|my|\{\*|\.\.|\%\{|\@\{|\[|\(|\]|\{|\/|\)|\;|\})}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
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
      /\G(scalar[^t])/gc and return ('OP10_NAMED_UNARY', $1);
      /\G(::[a-zA-Z]\w*__stringify)/gc and return ('OP10_NAMED_UNARY_STRINGIFY', $1);
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\*|\/|\%)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(m\/.*\/xms)/gc and return ('OP06_REGEX_PATTERN', $1);
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
      /\G(print\s*\()/gc and return ('OP01_PRINT_VOID_PAREN', $1);
      /\G(print)/gc and return ('OP01_PRINT_VOID', $1);
      /\G((croak|return|exit)\s*\()/gc and return ('OP01_NAMED_VOID_PAREN', $1);
      /\G(croak|return|exit)/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw)/gc and return ('OP01_QW', $1);
      /\G((open|close)\s*\()/gc and return ('OP01_OPEN_CLOSE_PAREN', $1);
      /\G(open|close)/gc and return ('OP01_OPEN_CLOSE', $1);
      /\G(sin|cos|tan)/gc and return ('OP01_NAMED', $1);
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


#line 119 lib/RPerl/Grammar.pm

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
  [ '_PAREN' => 'PAREN-1', [ 'ModuleHeader', 'Module' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-2', [ 'PLUS-2', 'PAREN-1' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-2', [ 'PAREN-1' ], 0 ],
  [ 'CompileUnit_4' => 'CompileUnit', [ 'Program' ], 0 ],
  [ 'CompileUnit_5' => 'CompileUnit', [ 'PLUS-2' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ 'Critic' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [ 'STAR-4', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [ 'STAR-5', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [ 'STAR-6', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-7', [ 'STAR-7', 'Subroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-7', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-8', [ 'PLUS-8', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-8', [ 'Operation' ], 0 ],
  [ 'Program_18' => 'Program', [ 'SHEBANG', 'OPTIONAL-3', 'Header', 'STAR-4', 'STAR-5', 'STAR-6', 'STAR-7', 'PLUS-8' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [ 'Critic' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [  ], 0 ],
  [ 'ModuleHeader_21' => 'ModuleHeader', [ 'OPTIONAL-9', 'package', 'WordScoped', ';', 'Header' ], 0 ],
  [ 'Module_22' => 'Module', [ 'Package' ], 0 ],
  [ 'Module_23' => 'Module', [ 'Class' ], 0 ],
  [ '_STAR_LIST' => 'STAR-10', [ 'STAR-10', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-10', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [ 'STAR-11', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-12', [ 'STAR-12', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-12', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'PLUS-13', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'Subroutine' ], 0 ],
  [ 'Package_32' => 'Package', [ 'STAR-10', 'STAR-11', 'STAR-12', 'PLUS-13', 'LITERAL_NUMBER', ';' ], 0 ],
  [ 'Header_33' => 'Header', [ 'use strict;', 'use warnings;', 'use RPerl;', 'our', 'VERSION_NUMBER_ASSIGN' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-14', [ 'PLUS-14', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-14', [ 'WORD' ], 0 ],
  [ 'Critic_36' => 'Critic', [ '## no critic qw(', 'PLUS-14', ')' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-15', [ 'PLUS-15', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-15', [ 'WORD' ], 0 ],
  [ 'Include_39' => 'Include', [ 'use', 'WordScoped', ';' ], 0 ],
  [ 'Include_40' => 'Include', [ 'use', 'WordScoped', 'qw(', 'PLUS-15', ')', ';' ], 0 ],
  [ 'Constant_41' => 'Constant', [ 'use constant', 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'PLUS-17', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'Operation' ], 0 ],
  [ 'Subroutine_46' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-16', 'PLUS-17', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-18', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [ 'STAR-19', 'PAREN-18' ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [ 'STAR-20', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [  ], 0 ],
  [ 'SubroutineArguments_52' => 'SubroutineArguments', [ '( my', 'Type', 'VARIABLE_SYMBOL', 'STAR-19', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-20' ], 0 ],
  [ '_PAREN' => 'PAREN-21', [ 'OP21_LIST_COMMA', 'Expression', 'OP21_LIST_COMMA', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-22', [ 'PAREN-21' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-22', [  ], 0 ],
  [ 'ArgumentCheck_56' => 'ArgumentCheck', [ 'CHECK_OR_CHECKTRACE', '(', 'Expression', 'OPTIONAL-22', ')', ';' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [ 'STAR-23', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [ 'STAR-24', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-26', [ 'PropertiesClass' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-26', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'MethodOrSubroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ 'Class_67' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-23', 'STAR-24', 'STAR-25', 'Properties', 'OPTIONAL-26', 'STAR-27', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-28', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [ 'STAR-29', 'PAREN-28' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [  ], 0 ],
  [ 'Properties_71' => 'Properties', [ 'our %properties = (', 'Critic', 'HashEntryTyped', 'STAR-29', ')', ';' ], 0 ],
  [ 'Properties_72' => 'Properties', [ 'our %properties = (', ')', ';', 'Critic' ], 0 ],
  [ '_PAREN' => 'PAREN-30', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [ 'STAR-31', 'PAREN-30' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [  ], 0 ],
  [ 'PropertiesClass_76' => 'PropertiesClass', [ 'our %properties_class = (', 'Critic', 'HashEntryTyped', 'STAR-31', ')', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-33', [ 'PLUS-33', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-33', [ 'Operation' ], 0 ],
  [ 'Method_81' => 'Method', [ 'our', 'TypeMethod', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-32', 'PLUS-33', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-34', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [ 'STAR-35', 'PAREN-34' ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [ 'STAR-36', 'ArgumentCheck' ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [  ], 0 ],
  [ 'MethodArguments_87' => 'MethodArguments', [ '( my', 'TYPE_CLASS_OR_SELF', 'STAR-35', ')', 'OP19_VARIABLE_ASSIGN', '@_;', 'STAR-36' ], 0 ],
  [ 'MethodOrSubroutine_88' => 'MethodOrSubroutine', [ 'Method' ], 0 ],
  [ 'MethodOrSubroutine_89' => 'MethodOrSubroutine', [ 'Subroutine' ], 0 ],
  [ 'Operation_90' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_91' => 'Operation', [ 'Statement' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'OP01_NAMED', '(', 'OPTIONAL-37', ')' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'OP01_OPEN_CLOSE_PAREN', 'FileHandle', 'OPTIONAL-38', ')', ';' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP01_OPEN_CLOSE', 'FileHandle', 'OPTIONAL-39', ';' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'Expression', 'OP04_MATH_POW', 'Expression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'OP05_LOGICAL_NEG', 'Expression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'OP05_MATH_NEG', 'Expression', ')' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'Expression', 'OP06_REGEX_MATCH', '/', 'OP06_REGEX_PATTERN', '/' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'Expression', 'OP07_MATH_MULT_DIV_MOD', 'Expression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'Expression', 'OP08_MATH_ADD_SUB', 'Expression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'Expression', 'OP08_STRING_CAT', 'Expression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'Expression', 'OP09_BITWISE_SHIFT', 'Expression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'OP10_NAMED_UNARY', 'Expression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'OP10_NAMED_UNARY_STRINGIFY', 'Expression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'Expression', 'OP11_COMPARE_LT_GT', 'Expression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'Expression', 'OP12_COMPARE_EQ_NEQ', 'Expression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'Expression', 'OP13_BITWISE_AND', 'Expression' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'Expression', 'OP14_BITWISE_OR_XOR', 'Expression' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'Expression', 'OP15_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_118' => 'Operator', [ 'Expression', 'OP16_LOGICAL_OR', 'Expression' ], 0 ],
  [ 'Operator_119' => 'Operator', [ 'Expression', 'OP17_LIST_RANGE', 'Expression' ], 0 ],
  [ 'Operator_120' => 'Operator', [ 'Expression', 'OP18_TERNARY', 'Variable', 'COLON', 'Variable' ], 0 ],
  [ 'Operator_121' => 'Operator', [ 'OP22_LOGICAL_NOT', 'Expression' ], 0 ],
  [ 'Operator_122' => 'Operator', [ 'Expression', 'OP23_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_123' => 'Operator', [ 'Expression', 'OP24_LOGICAL_OR_XOR', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'OperatorVoid_132' => 'OperatorVoid', [ 'OP01_NAMED_VOID_PAREN', 'OPTIONAL-40', ')', ';' ], 0 ],
  [ 'OperatorVoid_133' => 'OperatorVoid', [ 'OP01_PRINT_VOID_PAREN', 'FileHandle', 'OPTIONAL-41', ')', ';' ], 0 ],
  [ 'OperatorVoid_134' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-42', ';' ], 0 ],
  [ 'OperatorVoid_135' => 'OperatorVoid', [ 'OP01_PRINT_VOID', 'FileHandle', 'OPTIONAL-43', ';' ], 0 ],
  [ 'OperatorVoid_136' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'Expression_141' => 'Expression', [ 'undef' ], 0 ],
  [ 'Expression_142' => 'Expression', [ 'Literal' ], 0 ],
  [ 'Expression_143' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_144' => 'Expression', [ 'ArrayReference' ], 0 ],
  [ 'Expression_145' => 'Expression', [ 'ArrayDereferenced' ], 0 ],
  [ 'Expression_146' => 'Expression', [ 'HashReference' ], 0 ],
  [ 'Expression_147' => 'Expression', [ 'HashDereferenced' ], 0 ],
  [ 'Expression_148' => 'Expression', [ '{', '}' ], 0 ],
  [ 'Expression_149' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_150' => 'Expression', [ 'WordScoped', '(', 'OPTIONAL-44', ')' ], 0 ],
  [ 'Expression_151' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-45', ')' ], 0 ],
  [ 'Expression_152' => 'Expression', [ '(', 'Expression', ')' ], 0 ],
  [ 'ExpressionOrStdin_153' => 'ExpressionOrStdin', [ 'Expression' ], 0 ],
  [ 'ExpressionOrStdin_154' => 'ExpressionOrStdin', [ '<STDIN>' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'PAREN-46' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'Statement_158' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_159' => 'Statement', [ 'OPTIONAL-47', 'Loop' ], 0 ],
  [ 'Statement_160' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_161' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_162' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-48', [ 'elsif (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [ 'STAR-49', 'PAREN-48' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [  ], 0 ],
  [ '_PAREN' => 'PAREN-50', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'PAREN-50' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'Conditional_169' => 'Conditional', [ 'if (', 'Expression', ')', 'CodeBlock', 'STAR-49', 'OPTIONAL-51' ], 0 ],
  [ 'Loop_170' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_171' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_172' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_173' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_174' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_175' => 'LoopWhile', [ 'while (', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'PLUS-52', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'Operation' ], 0 ],
  [ 'CodeBlock_178' => 'CodeBlock', [ '{', 'PLUS-52', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [ 'STAR-53', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-53', [  ], 0 ],
  [ 'Variable_181' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-53' ], 0 ],
  [ 'VariableRetrieval_182' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_183' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableRetrieval_184' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_185' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_186' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_187' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'ExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_188' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-54', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-55', [ 'STAR-55', 'PAREN-54' ], 0 ],
  [ '_STAR_LIST' => 'STAR-55', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-56', [ 'PLUS-56', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-56', [ 'WORD' ], 0 ],
  [ 'ListElements_194' => 'ListElements', [ 'ListElement', 'STAR-55' ], 0 ],
  [ 'ListElements_195' => 'ListElements', [ 'OP01_QW', '(', 'PLUS-56', ')' ], 0 ],
  [ 'ListElement_196' => 'ListElement', [ 'Expression' ], 0 ],
  [ 'ListElement_197' => 'ListElement', [ 'TypeInner', 'Expression' ], 0 ],
  [ 'ListElement_198' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [  ], 0 ],
  [ 'ArrayReference_201' => 'ArrayReference', [ '[', 'OPTIONAL-57', ']' ], 0 ],
  [ 'ArrayDereferenced_202' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_203' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [  ], 0 ],
  [ 'HashEntry_206' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-58', 'Expression' ], 0 ],
  [ 'HashEntry_207' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_208' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'Expression' ], 0 ],
  [ 'HashEntryTyped_209' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-59', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-60', [ 'STAR-60', 'PAREN-59' ], 0 ],
  [ '_STAR_LIST' => 'STAR-60', [  ], 0 ],
  [ 'HashReference_213' => 'HashReference', [ '{', 'HashEntry', 'STAR-60', '}' ], 0 ],
  [ 'HashDereferenced_214' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_215' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_216' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_217' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_218' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_219' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeMethod_220' => 'TypeMethod', [ 'WORD', '__method' ], 0 ],
  [ 'TypeInner_221' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'FileHandle_222' => 'FileHandle', [ '{*', 'WORD', '}' ], 0 ],
  [ 'FileHandle_223' => 'FileHandle', [ 'my', 'filehandle_ref', 'VARIABLE_SYMBOL' ], 0 ],
  [ 'Literal_224' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_225' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  '_PAREN' => 1,
  '_PLUS_LIST' => 2,
  '_PLUS_LIST' => 3,
  'CompileUnit_4' => 4,
  'CompileUnit_5' => 5,
  '_OPTIONAL' => 6,
  '_OPTIONAL' => 7,
  '_STAR_LIST' => 8,
  '_STAR_LIST' => 9,
  '_STAR_LIST' => 10,
  '_STAR_LIST' => 11,
  '_STAR_LIST' => 12,
  '_STAR_LIST' => 13,
  '_STAR_LIST' => 14,
  '_STAR_LIST' => 15,
  '_PLUS_LIST' => 16,
  '_PLUS_LIST' => 17,
  'Program_18' => 18,
  '_OPTIONAL' => 19,
  '_OPTIONAL' => 20,
  'ModuleHeader_21' => 21,
  'Module_22' => 22,
  'Module_23' => 23,
  '_STAR_LIST' => 24,
  '_STAR_LIST' => 25,
  '_STAR_LIST' => 26,
  '_STAR_LIST' => 27,
  '_STAR_LIST' => 28,
  '_STAR_LIST' => 29,
  '_PLUS_LIST' => 30,
  '_PLUS_LIST' => 31,
  'Package_32' => 32,
  'Header_33' => 33,
  '_PLUS_LIST' => 34,
  '_PLUS_LIST' => 35,
  'Critic_36' => 36,
  '_PLUS_LIST' => 37,
  '_PLUS_LIST' => 38,
  'Include_39' => 39,
  'Include_40' => 40,
  'Constant_41' => 41,
  '_OPTIONAL' => 42,
  '_OPTIONAL' => 43,
  '_PLUS_LIST' => 44,
  '_PLUS_LIST' => 45,
  'Subroutine_46' => 46,
  '_PAREN' => 47,
  '_STAR_LIST' => 48,
  '_STAR_LIST' => 49,
  '_STAR_LIST' => 50,
  '_STAR_LIST' => 51,
  'SubroutineArguments_52' => 52,
  '_PAREN' => 53,
  '_OPTIONAL' => 54,
  '_OPTIONAL' => 55,
  'ArgumentCheck_56' => 56,
  '_STAR_LIST' => 57,
  '_STAR_LIST' => 58,
  '_STAR_LIST' => 59,
  '_STAR_LIST' => 60,
  '_STAR_LIST' => 61,
  '_STAR_LIST' => 62,
  '_OPTIONAL' => 63,
  '_OPTIONAL' => 64,
  '_STAR_LIST' => 65,
  '_STAR_LIST' => 66,
  'Class_67' => 67,
  '_PAREN' => 68,
  '_STAR_LIST' => 69,
  '_STAR_LIST' => 70,
  'Properties_71' => 71,
  'Properties_72' => 72,
  '_PAREN' => 73,
  '_STAR_LIST' => 74,
  '_STAR_LIST' => 75,
  'PropertiesClass_76' => 76,
  '_OPTIONAL' => 77,
  '_OPTIONAL' => 78,
  '_PLUS_LIST' => 79,
  '_PLUS_LIST' => 80,
  'Method_81' => 81,
  '_PAREN' => 82,
  '_STAR_LIST' => 83,
  '_STAR_LIST' => 84,
  '_STAR_LIST' => 85,
  '_STAR_LIST' => 86,
  'MethodArguments_87' => 87,
  'MethodOrSubroutine_88' => 88,
  'MethodOrSubroutine_89' => 89,
  'Operation_90' => 90,
  'Operation_91' => 91,
  '_OPTIONAL' => 92,
  '_OPTIONAL' => 93,
  '_OPTIONAL' => 94,
  '_OPTIONAL' => 95,
  '_OPTIONAL' => 96,
  '_OPTIONAL' => 97,
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
  'Operator_121' => 121,
  'Operator_122' => 122,
  'Operator_123' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  '_OPTIONAL' => 128,
  '_OPTIONAL' => 129,
  '_OPTIONAL' => 130,
  '_OPTIONAL' => 131,
  'OperatorVoid_132' => 132,
  'OperatorVoid_133' => 133,
  'OperatorVoid_134' => 134,
  'OperatorVoid_135' => 135,
  'OperatorVoid_136' => 136,
  '_OPTIONAL' => 137,
  '_OPTIONAL' => 138,
  '_OPTIONAL' => 139,
  '_OPTIONAL' => 140,
  'Expression_141' => 141,
  'Expression_142' => 142,
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
  'ExpressionOrStdin_153' => 153,
  'ExpressionOrStdin_154' => 154,
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
  '_PLUS_LIST' => 192,
  '_PLUS_LIST' => 193,
  'ListElements_194' => 194,
  'ListElements_195' => 195,
  'ListElement_196' => 196,
  'ListElement_197' => 197,
  'ListElement_198' => 198,
  '_OPTIONAL' => 199,
  '_OPTIONAL' => 200,
  'ArrayReference_201' => 201,
  'ArrayDereferenced_202' => 202,
  'ArrayDereferenced_203' => 203,
  '_OPTIONAL' => 204,
  '_OPTIONAL' => 205,
  'HashEntry_206' => 206,
  'HashEntry_207' => 207,
  'HashEntryTyped_208' => 208,
  'HashEntryTyped_209' => 209,
  '_PAREN' => 210,
  '_STAR_LIST' => 211,
  '_STAR_LIST' => 212,
  'HashReference_213' => 213,
  'HashDereferenced_214' => 214,
  'HashDereferenced_215' => 215,
  'WordScoped_216' => 216,
  'WordScoped_217' => 217,
  'LoopLabel_218' => 218,
  'Type_219' => 219,
  'TypeMethod_220' => 220,
  'TypeInner_221' => 221,
  'FileHandle_222' => 222,
  'FileHandle_223' => 223,
  'Literal_224' => 224,
  'Literal_225' => 225,
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
	';' => { ISSEMANTIC => 0 },
	'<STDIN>' => { ISSEMANTIC => 0 },
	'= sub {' => { ISSEMANTIC => 0 },
	'@_;' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	'[' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'__method' => { ISSEMANTIC => 0 },
	'else' => { ISSEMANTIC => 0 },
	'elsif (' => { ISSEMANTIC => 0 },
	'filehandle_ref' => { ISSEMANTIC => 0 },
	'for my integer' => { ISSEMANTIC => 0 },
	'foreach my' => { ISSEMANTIC => 0 },
	'if (' => { ISSEMANTIC => 0 },
	'my' => { ISSEMANTIC => 0 },
	'our %properties = (' => { ISSEMANTIC => 0 },
	'our %properties_class = (' => { ISSEMANTIC => 0 },
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
	OP01_OPEN_CLOSE => { ISSEMANTIC => 1 },
	OP01_OPEN_CLOSE_PAREN => { ISSEMANTIC => 1 },
	OP01_PRINT_VOID => { ISSEMANTIC => 1 },
	OP01_PRINT_VOID_PAREN => { ISSEMANTIC => 1 },
	OP01_QW => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 9,
			"package" => -20,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Program' => 7,
			'OPTIONAL-9' => 3,
			'ModuleHeader' => 4,
			'CompileUnit' => 6,
			'PLUS-2' => 5,
			'PAREN-1' => 1,
			'Critic' => 2
		}
	},
	{#State 1
		DEFAULT => -3
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 4
		ACTIONS => {
			"use parent qw(" => 11,
			"## no critic qw(" => -25,
			"our" => -25,
			"use" => -25,
			"use constant" => -25
		},
		GOTOS => {
			'Package' => 12,
			'STAR-10' => 13,
			'Class' => 14,
			'Module' => 15
		}
	},
	{#State 5
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 8,
			'' => -5
		},
		GOTOS => {
			'PAREN-1' => 16,
			'ModuleHeader' => 4,
			'Critic' => 2,
			'OPTIONAL-9' => 3
		}
	},
	{#State 6
		ACTIONS => {
			'' => 17
		}
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			'WORD' => 18
		},
		GOTOS => {
			'PLUS-14' => 19
		}
	},
	{#State 9
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 20,
			'OPTIONAL-3' => 21
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 22
		}
	},
	{#State 11
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 12
		DEFAULT => -22
	},
	{#State 13
		ACTIONS => {
			"## no critic qw(" => 8,
			"use" => -27,
			"our" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'STAR-11' => 26,
			'Critic' => 27
		}
	},
	{#State 14
		DEFAULT => -23
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		DEFAULT => -2
	},
	{#State 17
		DEFAULT => 0
	},
	{#State 18
		DEFAULT => -35
	},
	{#State 19
		ACTIONS => {
			'WORD' => 28,
			")" => 29
		}
	},
	{#State 20
		DEFAULT => -6
	},
	{#State 21
		ACTIONS => {
			"use strict;" => 31
		},
		GOTOS => {
			'Header' => 30
		}
	},
	{#State 22
		ACTIONS => {
			";" => 32
		}
	},
	{#State 23
		DEFAULT => -217
	},
	{#State 24
		DEFAULT => -216
	},
	{#State 25
		ACTIONS => {
			")" => 33
		}
	},
	{#State 26
		ACTIONS => {
			"use" => 34,
			"our" => -29,
			"use constant" => -29
		},
		GOTOS => {
			'Include' => 36,
			'STAR-12' => 35
		}
	},
	{#State 27
		DEFAULT => -24
	},
	{#State 28
		DEFAULT => -34
	},
	{#State 29
		DEFAULT => -36
	},
	{#State 30
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 37
		}
	},
	{#State 31
		ACTIONS => {
			"use warnings;" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use strict;" => 31
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		ACTIONS => {
			";" => 40
		}
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 41
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 44,
			"our" => 42
		},
		GOTOS => {
			'PLUS-13' => 43,
			'Subroutine' => 46,
			'Constant' => 45
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => -11,
			'OP05_MATH_NEG' => -11,
			'OP01_OPEN_CLOSE' => -11,
			"## no critic qw(" => 8,
			"for my integer" => -11,
			'OP19_LOOP_CONTROL' => -11,
			"our" => -11,
			'LITERAL_NUMBER' => -11,
			"foreach my" => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_PRINT_VOID' => -11,
			"(" => -11,
			"use constant" => -11,
			'OP01_NAMED' => -11,
			'OP22_LOGICAL_NOT' => -11,
			'OP01_NAMED_VOID' => -11,
			"while (" => -11,
			"undef" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"\@{" => -11,
			"%{" => -11,
			"if (" => -11,
			"{" => -11,
			'OP01_NAMED_VOID_PAREN' => -11,
			"[" => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			'WORD' => -11,
			'WORD_SCOPED' => -11,
			'OP01_PRINT_VOID_PAREN' => -11,
			'OP10_NAMED_UNARY' => -11,
			"my" => -11,
			'LITERAL_STRING' => -11,
			"use" => -11
		},
		GOTOS => {
			'Critic' => 47,
			'STAR-5' => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use RPerl;" => 49
		}
	},
	{#State 39
		DEFAULT => -21
	},
	{#State 40
		ACTIONS => {
			"use" => 34
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 41
		ACTIONS => {
			"qw(" => 52,
			";" => 51
		}
	},
	{#State 42
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 43
		ACTIONS => {
			"our" => 42,
			'LITERAL_NUMBER' => 56
		},
		GOTOS => {
			'Subroutine' => 55
		}
	},
	{#State 44
		ACTIONS => {
			'WORD' => 57
		}
	},
	{#State 45
		DEFAULT => -28
	},
	{#State 46
		DEFAULT => -31
	},
	{#State 47
		DEFAULT => -8
	},
	{#State 48
		ACTIONS => {
			"[" => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			'OP01_NAMED_VOID_PAREN' => -13,
			"{" => -13,
			"use" => 34,
			'LITERAL_STRING' => -13,
			"my" => -13,
			'OP01_PRINT_VOID_PAREN' => -13,
			'OP10_NAMED_UNARY' => -13,
			'WORD' => -13,
			'WORD_SCOPED' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_PRINT_VOID' => -13,
			'LITERAL_NUMBER' => -13,
			"foreach my" => -13,
			"our" => -13,
			'OP19_LOOP_CONTROL' => -13,
			"for my integer" => -13,
			'OP01_OPEN_CLOSE' => -13,
			'OP01_OPEN_CLOSE_PAREN' => -13,
			'OP05_MATH_NEG' => -13,
			"%{" => -13,
			"if (" => -13,
			"\@{" => -13,
			"undef" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP22_LOGICAL_NOT' => -13,
			"while (" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_NAMED' => -13,
			"(" => -13,
			"use constant" => -13
		},
		GOTOS => {
			'STAR-6' => 58,
			'Include' => 59
		}
	},
	{#State 49
		ACTIONS => {
			"our" => 60
		}
	},
	{#State 50
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 61
		}
	},
	{#State 51
		DEFAULT => -39
	},
	{#State 52
		ACTIONS => {
			'WORD' => 63
		},
		GOTOS => {
			'PLUS-15' => 62
		}
	},
	{#State 53
		ACTIONS => {
			'VARIABLE_SYMBOL' => 64
		}
	},
	{#State 54
		DEFAULT => -219
	},
	{#State 55
		DEFAULT => -30
	},
	{#State 56
		ACTIONS => {
			";" => 65
		}
	},
	{#State 57
		ACTIONS => {
			'OP20_HASH_FATARROW' => 66
		}
	},
	{#State 58
		ACTIONS => {
			'WORD' => -15,
			'WORD_SCOPED' => -15,
			"my" => -15,
			'LITERAL_STRING' => -15,
			'OP01_PRINT_VOID_PAREN' => -15,
			'OP10_NAMED_UNARY' => -15,
			"{" => -15,
			'OP01_NAMED_VOID_PAREN' => -15,
			"[" => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			'OP01_NAMED' => -15,
			"(" => -15,
			"use constant" => 44,
			"undef" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP22_LOGICAL_NOT' => -15,
			'OP01_NAMED_VOID' => -15,
			"while (" => -15,
			"\@{" => -15,
			"%{" => -15,
			"if (" => -15,
			'OP01_OPEN_CLOSE_PAREN' => -15,
			'OP05_MATH_NEG' => -15,
			"for my integer" => -15,
			'OP01_OPEN_CLOSE' => -15,
			"our" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_PRINT_VOID' => -15,
			'LITERAL_NUMBER' => -15,
			"foreach my" => -15
		},
		GOTOS => {
			'STAR-7' => 68,
			'Constant' => 67
		}
	},
	{#State 59
		DEFAULT => -10
	},
	{#State 60
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 69
		}
	},
	{#State 61
		ACTIONS => {
			"## no critic qw(" => 8,
			"use constant" => -60,
			"use" => -60,
			"our %properties = (" => -60
		},
		GOTOS => {
			'Critic' => 70,
			'STAR-24' => 71
		}
	},
	{#State 62
		ACTIONS => {
			'WORD' => 72,
			")" => 73
		}
	},
	{#State 63
		DEFAULT => -38
	},
	{#State 64
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 65
		DEFAULT => -32
	},
	{#State 66
		ACTIONS => {
			"my" => 76
		},
		GOTOS => {
			'TypeInner' => 75
		}
	},
	{#State 67
		DEFAULT => -12
	},
	{#State 68
		ACTIONS => {
			"my" => 115,
			'LITERAL_STRING' => 114,
			'OP10_NAMED_UNARY' => 117,
			'OP01_PRINT_VOID_PAREN' => 118,
			'WORD_SCOPED' => 23,
			'WORD' => 122,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'OP01_NAMED_VOID_PAREN' => 108,
			"{" => 111,
			"if (" => 86,
			"%{" => 87,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			"while (" => -157,
			'OP01_NAMED_VOID' => 95,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_NAMED' => 97,
			"(" => 102,
			'VARIABLE_SYMBOL' => 78,
			'OP01_PRINT_VOID' => 77,
			"foreach my" => -157,
			'LITERAL_NUMBER' => 79,
			"our" => 42,
			'OP19_LOOP_CONTROL' => 80,
			"for my integer" => -157,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85
		},
		GOTOS => {
			'Variable' => 89,
			'WordScoped' => 90,
			'PLUS-8' => 113,
			'Expression' => 120,
			'LoopLabel' => 98,
			'VariableModification' => 119,
			'ArrayReference' => 103,
			'Conditional' => 121,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Subroutine' => 93,
			'Operation' => 116,
			'VariableDeclaration' => 106,
			'HashReference' => 110,
			'PAREN-46' => 83,
			'Operator' => 109,
			'OperatorVoid' => 112,
			'OPTIONAL-47' => 107,
			'Statement' => 81
		}
	},
	{#State 69
		DEFAULT => -33
	},
	{#State 70
		DEFAULT => -57
	},
	{#State 71
		ACTIONS => {
			"use constant" => -62,
			"our %properties = (" => -62,
			"use" => 34
		},
		GOTOS => {
			'Include' => 124,
			'STAR-25' => 123
		}
	},
	{#State 72
		DEFAULT => -37
	},
	{#State 73
		ACTIONS => {
			";" => 125
		}
	},
	{#State 74
		ACTIONS => {
			"{" => -43,
			'OP01_NAMED_VOID_PAREN' => -43,
			"( my" => 127,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			"[" => -43,
			'WORD_SCOPED' => -43,
			'WORD' => -43,
			"my" => -43,
			'LITERAL_STRING' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP01_PRINT_VOID_PAREN' => -43,
			'OP05_MATH_NEG' => -43,
			'OP01_OPEN_CLOSE_PAREN' => -43,
			"for my integer" => -43,
			'OP01_OPEN_CLOSE' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP01_PRINT_VOID' => -43,
			'VARIABLE_SYMBOL' => -43,
			"foreach my" => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_NAMED' => -43,
			"(" => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP05_LOGICAL_NEG' => -43,
			"undef" => -43,
			'OP01_NAMED_VOID' => -43,
			"while (" => -43,
			'OP22_LOGICAL_NOT' => -43,
			"\@{" => -43,
			"if (" => -43,
			"%{" => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 126,
			'SubroutineArguments' => 128
		}
	},
	{#State 75
		ACTIONS => {
			'LITERAL_STRING' => 114,
			'LITERAL_NUMBER' => 79
		},
		GOTOS => {
			'Literal' => 129
		}
	},
	{#State 76
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 130
		}
	},
	{#State 77
		ACTIONS => {
			"{*" => 132,
			"my" => 131
		},
		GOTOS => {
			'FileHandle' => 133
		}
	},
	{#State 78
		DEFAULT => -180,
		GOTOS => {
			'STAR-53' => 134
		}
	},
	{#State 79
		DEFAULT => -225
	},
	{#State 80
		ACTIONS => {
			'WORD' => 136
		},
		GOTOS => {
			'LoopLabel' => 135
		}
	},
	{#State 81
		DEFAULT => -91
	},
	{#State 82
		ACTIONS => {
			"{*" => 132,
			"my" => 131
		},
		GOTOS => {
			'FileHandle' => 137
		}
	},
	{#State 83
		DEFAULT => -156
	},
	{#State 84
		ACTIONS => {
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'VARIABLE_SYMBOL' => 78,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 97,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			"\@{" => 88,
			"%{" => 87
		},
		GOTOS => {
			'ArrayReference' => 103,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'HashReference' => 110,
			'Expression' => 138,
			'Operator' => 109,
			'Variable' => 139,
			'WordScoped' => 90
		}
	},
	{#State 85
		ACTIONS => {
			"my" => 131,
			"{*" => 132
		},
		GOTOS => {
			'FileHandle' => 140
		}
	},
	{#State 86
		ACTIONS => {
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			"\@{" => 88,
			"%{" => 87,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP01_OPEN_CLOSE' => 82,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79
		},
		GOTOS => {
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'ArrayReference' => 103,
			'Operator' => 109,
			'HashReference' => 110,
			'Expression' => 141,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 87
		ACTIONS => {
			"{" => 143,
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'HashReference' => 144,
			'Variable' => 142
		}
	},
	{#State 88
		ACTIONS => {
			"[" => 105,
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'ArrayReference' => 146,
			'Variable' => 145
		}
	},
	{#State 89
		ACTIONS => {
			'OP04_MATH_POW' => -143,
			'OP18_TERNARY' => -143,
			'OP14_BITWISE_OR_XOR' => -143,
			";" => -143,
			'OP15_LOGICAL_AND' => -143,
			'OP24_LOGICAL_OR_XOR' => -143,
			'OP11_COMPARE_LT_GT' => -143,
			'OP19_VARIABLE_ASSIGN' => 149,
			'OP03_MATH_INC_DEC' => 148,
			'OP16_LOGICAL_OR' => -143,
			'OP06_REGEX_MATCH' => -143,
			'OP08_STRING_CAT' => -143,
			'OP07_MATH_MULT_DIV_MOD' => -143,
			'OP19_VARIABLE_ASSIGN_BY' => 147,
			'OP23_LOGICAL_AND' => -143,
			'OP13_BITWISE_AND' => -143,
			'OP09_BITWISE_SHIFT' => -143,
			'OP02_METHOD_THINARROW' => 150,
			'OP17_LIST_RANGE' => -143,
			'OP12_COMPARE_EQ_NEQ' => -143,
			'OP08_MATH_ADD_SUB' => -143
		}
	},
	{#State 90
		ACTIONS => {
			"(" => 151
		}
	},
	{#State 91
		ACTIONS => {
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'VARIABLE_SYMBOL' => 78,
			'OP01_OPEN_CLOSE' => 82,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP05_MATH_NEG' => 84,
			"%{" => 87,
			"\@{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 97
		},
		GOTOS => {
			'HashDereferenced' => 99,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'ArrayReference' => 103,
			'Operator' => 109,
			'HashReference' => 110,
			'Expression' => 152,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 92
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'Variable' => 153
		}
	},
	{#State 93
		DEFAULT => -14
	},
	{#State 94
		DEFAULT => -141
	},
	{#State 95
		ACTIONS => {
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 97,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			'KEYS_OR_VALUES' => 159,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			"my" => 76,
			"\@{" => 88,
			"%{" => 87,
			";" => -129,
			'OP01_QW' => 157,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'TypeInner' => 154,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'Expression' => 155,
			'HashReference' => 110,
			'Operator' => 109,
			'ListElement' => 160,
			'OPTIONAL-42' => 156,
			'WordScoped' => 90,
			'Variable' => 139,
			'ListElements' => 158
		}
	},
	{#State 96
		ACTIONS => {
			'OP01_NAMED' => 97,
			'WORD' => 24,
			"(" => 102,
			'WORD_SCOPED' => 23,
			"undef" => 94,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"\@{" => 88,
			"%{" => 87,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82,
			'VARIABLE_SYMBOL' => 78,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 104
		},
		GOTOS => {
			'Variable' => 139,
			'WordScoped' => 90,
			'HashReference' => 110,
			'Expression' => 161,
			'Operator' => 109,
			'ArrayReference' => 103,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100
		}
	},
	{#State 97
		ACTIONS => {
			"(" => 162
		}
	},
	{#State 98
		ACTIONS => {
			'COLON' => 163
		}
	},
	{#State 99
		DEFAULT => -147
	},
	{#State 100
		DEFAULT => -145
	},
	{#State 101
		DEFAULT => -142
	},
	{#State 102
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP01_OPEN_CLOSE' => 82,
			"\@{" => 88,
			"%{" => 87,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'Variable' => 139,
			'WordScoped' => 90,
			'ArrayReference' => 103,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Expression' => 164,
			'HashReference' => 110,
			'Operator' => 109
		}
	},
	{#State 103
		DEFAULT => -144
	},
	{#State 104
		ACTIONS => {
			"\@{" => 88,
			"%{" => 87,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP01_OPEN_CLOSE' => 82
		},
		GOTOS => {
			'Operator' => 109,
			'HashReference' => 110,
			'Expression' => 165,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'ArrayReference' => 103,
			'Variable' => 139,
			'WordScoped' => 90
		}
	},
	{#State 105
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP01_QW' => 157,
			"%{" => 87,
			"\@{" => 88,
			'OP03_MATH_INC_DEC' => 92,
			"my" => 76,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			'KEYS_OR_VALUES' => 159,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_NAMED' => 97,
			"]" => -200,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24
		},
		GOTOS => {
			'ArrayReference' => 103,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Expression' => 155,
			'HashReference' => 110,
			'Operator' => 109,
			'OPTIONAL-57' => 167,
			'TypeInner' => 154,
			'WordScoped' => 90,
			'Variable' => 139,
			'ListElements' => 166,
			'ListElement' => 160
		}
	},
	{#State 106
		DEFAULT => -161
	},
	{#State 107
		ACTIONS => {
			"for my integer" => 171,
			"while (" => 174,
			"foreach my" => 170
		},
		GOTOS => {
			'LoopWhile' => 172,
			'Loop' => 168,
			'LoopFor' => 169,
			'LoopForEach' => 173
		}
	},
	{#State 108
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			'KEYS_OR_VALUES' => 159,
			"undef" => 94,
			"my" => 76,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			")" => -125,
			'WORD' => 24,
			"(" => 102,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 97,
			"%{" => 87,
			'OP01_QW' => 157,
			"\@{" => 88,
			'OP01_OPEN_CLOSE' => 82,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'ArrayReference' => 103,
			'Operator' => 109,
			'Expression' => 155,
			'HashReference' => 110,
			'TypeInner' => 154,
			'WordScoped' => 90,
			'Variable' => 139,
			'ListElements' => 176,
			'ListElement' => 160,
			'OPTIONAL-40' => 175
		}
	},
	{#State 109
		DEFAULT => -149
	},
	{#State 110
		DEFAULT => -146
	},
	{#State 111
		ACTIONS => {
			"%{" => 87,
			'WORD' => 177,
			"}" => 180
		},
		GOTOS => {
			'HashDereferenced' => 179,
			'HashEntry' => 178
		}
	},
	{#State 112
		DEFAULT => -160
	},
	{#State 113
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 122,
			'LITERAL_STRING' => 114,
			"my" => 115,
			'OP10_NAMED_UNARY' => 117,
			'OP01_PRINT_VOID_PAREN' => 118,
			"{" => 111,
			'' => -18,
			'OP01_NAMED_VOID_PAREN' => 108,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'OP01_NAMED' => 97,
			"(" => 102,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			"while (" => -157,
			'OP01_NAMED_VOID' => 95,
			'OP22_LOGICAL_NOT' => 96,
			"\@{" => 88,
			"if (" => 86,
			"%{" => 87,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"for my integer" => -157,
			'OP01_OPEN_CLOSE' => 82,
			'OP19_LOOP_CONTROL' => 80,
			'OP01_PRINT_VOID' => 77,
			'VARIABLE_SYMBOL' => 78,
			"foreach my" => -157,
			'LITERAL_NUMBER' => 79
		},
		GOTOS => {
			'Operation' => 181,
			'Expression' => 120,
			'LoopLabel' => 98,
			'VariableModification' => 119,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 100,
			'Conditional' => 121,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'Variable' => 89,
			'WordScoped' => 90,
			'OPTIONAL-47' => 107,
			'Statement' => 81,
			'HashReference' => 110,
			'PAREN-46' => 83,
			'Operator' => 109,
			'OperatorVoid' => 112,
			'VariableDeclaration' => 106
		}
	},
	{#State 114
		DEFAULT => -224
	},
	{#State 115
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 182
		}
	},
	{#State 116
		DEFAULT => -17
	},
	{#State 117
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 82,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP05_MATH_NEG' => 84,
			'VARIABLE_SYMBOL' => 78,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 97,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			"%{" => 87,
			"\@{" => 88
		},
		GOTOS => {
			'WordScoped' => 90,
			'Variable' => 139,
			'Operator' => 109,
			'HashReference' => 110,
			'Expression' => 183,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'ArrayReference' => 103
		}
	},
	{#State 118
		ACTIONS => {
			"my" => 131,
			"{*" => 132
		},
		GOTOS => {
			'FileHandle' => 184
		}
	},
	{#State 119
		DEFAULT => -162
	},
	{#State 120
		ACTIONS => {
			'OP13_BITWISE_AND' => 194,
			'OP09_BITWISE_SHIFT' => 189,
			'OP17_LIST_RANGE' => 197,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => 186,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => 188,
			'OP15_LOGICAL_AND' => 199,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP11_COMPARE_LT_GT' => 200,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => 192,
			";" => 191,
			'OP14_BITWISE_OR_XOR' => 198
		}
	},
	{#State 121
		DEFAULT => -158
	},
	{#State 122
		ACTIONS => {
			'COLON' => -218,
			"(" => -216
		}
	},
	{#State 123
		ACTIONS => {
			"our %properties = (" => 204,
			"use constant" => 44
		},
		GOTOS => {
			'Properties' => 202,
			'Constant' => 203
		}
	},
	{#State 124
		DEFAULT => -59
	},
	{#State 125
		DEFAULT => -40
	},
	{#State 126
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78,
			'OP01_PRINT_VOID' => 77,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"foreach my" => -157,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP19_LOOP_CONTROL' => 80,
			"for my integer" => -157,
			'OP01_OPEN_CLOSE' => 82,
			'OP01_NAMED_VOID_PAREN' => 108,
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"if (" => 86,
			"%{" => 87,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 91,
			"my" => 115,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			"undef" => 94,
			'OP01_NAMED_VOID' => 95,
			"while (" => -157,
			'OP10_NAMED_UNARY' => 117,
			'OP01_PRINT_VOID_PAREN' => 118,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 122
		},
		GOTOS => {
			'VariableDeclaration' => 106,
			'OPTIONAL-47' => 107,
			'Statement' => 81,
			'HashReference' => 110,
			'PAREN-46' => 83,
			'Operator' => 109,
			'OperatorVoid' => 112,
			'WordScoped' => 90,
			'Variable' => 89,
			'PLUS-17' => 205,
			'Operation' => 206,
			'Expression' => 120,
			'LoopLabel' => 98,
			'VariableModification' => 119,
			'ArrayReference' => 103,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'Conditional' => 121,
			'HashDereferenced' => 99
		}
	},
	{#State 127
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 207
		}
	},
	{#State 128
		DEFAULT => -42
	},
	{#State 129
		ACTIONS => {
			";" => 208
		}
	},
	{#State 130
		ACTIONS => {
			"\$TYPED_" => 209
		}
	},
	{#State 131
		ACTIONS => {
			"filehandle_ref" => 210
		}
	},
	{#State 132
		ACTIONS => {
			'WORD' => 211
		}
	},
	{#State 133
		ACTIONS => {
			'OP01_QW' => 157,
			";" => -131,
			"%{" => 87,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			"my" => 76,
			'OP03_MATH_INC_DEC' => 92,
			'KEYS_OR_VALUES' => 159,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			"(" => 102,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111
		},
		GOTOS => {
			'TypeInner' => 154,
			'Operator' => 109,
			'OPTIONAL-43' => 212,
			'HashReference' => 110,
			'Expression' => 155,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'ArrayReference' => 103,
			'ListElement' => 160,
			'ListElements' => 213,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 134
		ACTIONS => {
			")" => -181,
			'OP21_LIST_COMMA' => -181,
			"]" => -181,
			'OP15_LOGICAL_AND' => -181,
			'OP24_LOGICAL_OR_XOR' => -181,
			'OP11_COMPARE_LT_GT' => -181,
			'OP03_MATH_INC_DEC' => -181,
			'OP19_VARIABLE_ASSIGN' => -181,
			'OP02_HASH_THINARROW' => 216,
			'OP04_MATH_POW' => -181,
			".." => -181,
			'OP18_TERNARY' => -181,
			'COLON' => -181,
			";" => -181,
			'OP14_BITWISE_OR_XOR' => -181,
			'OP13_BITWISE_AND' => -181,
			"}" => -181,
			'OP02_METHOD_THINARROW' => -181,
			'OP09_BITWISE_SHIFT' => -181,
			'OP17_LIST_RANGE' => -181,
			'OP08_MATH_ADD_SUB' => -181,
			'OP12_COMPARE_EQ_NEQ' => -181,
			'OP08_STRING_CAT' => -181,
			'OP06_REGEX_MATCH' => -181,
			'OP16_LOGICAL_OR' => -181,
			'OP02_ARRAY_THINARROW' => 214,
			'OP07_MATH_MULT_DIV_MOD' => -181,
			'OP23_LOGICAL_AND' => -181,
			'OP19_VARIABLE_ASSIGN_BY' => -181
		},
		GOTOS => {
			'VariableRetrieval' => 215
		}
	},
	{#State 135
		ACTIONS => {
			";" => 217
		}
	},
	{#State 136
		DEFAULT => -218
	},
	{#State 137
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 82,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'VARIABLE_SYMBOL' => 78,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 94,
			'KEYS_OR_VALUES' => 159,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			"my" => 76,
			'WORD' => 24,
			"(" => 102,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 97,
			"%{" => 87,
			";" => -97,
			'OP01_QW' => 157,
			"\@{" => 88
		},
		GOTOS => {
			'TypeInner' => 154,
			'OPTIONAL-39' => 219,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'HashReference' => 110,
			'Expression' => 155,
			'Operator' => 109,
			'ListElement' => 160,
			'WordScoped' => 90,
			'Variable' => 139,
			'ListElements' => 218
		}
	},
	{#State 138
		ACTIONS => {
			'OP04_MATH_POW' => 190,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP18_TERNARY' => 192,
			'OP15_LOGICAL_AND' => 199,
			")" => 220,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP08_STRING_CAT' => 185,
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP17_LIST_RANGE' => 197
		}
	},
	{#State 139
		ACTIONS => {
			")" => -143,
			'OP15_LOGICAL_AND' => -143,
			'OP21_LIST_COMMA' => -143,
			"]" => -143,
			'OP24_LOGICAL_OR_XOR' => -143,
			'OP03_MATH_INC_DEC' => 148,
			'OP11_COMPARE_LT_GT' => -143,
			'OP04_MATH_POW' => -143,
			".." => -143,
			'OP18_TERNARY' => -143,
			";" => -143,
			'OP14_BITWISE_OR_XOR' => -143,
			'OP13_BITWISE_AND' => -143,
			"}" => -143,
			'OP02_METHOD_THINARROW' => 150,
			'OP09_BITWISE_SHIFT' => -143,
			'OP17_LIST_RANGE' => -143,
			'OP08_MATH_ADD_SUB' => -143,
			'OP12_COMPARE_EQ_NEQ' => -143,
			'OP16_LOGICAL_OR' => -143,
			'OP08_STRING_CAT' => -143,
			'OP06_REGEX_MATCH' => -143,
			'OP07_MATH_MULT_DIV_MOD' => -143,
			'OP23_LOGICAL_AND' => -143
		}
	},
	{#State 140
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'VARIABLE_SYMBOL' => 78,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"%{" => 87,
			'OP01_QW' => 157,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			"my" => 76,
			'LITERAL_STRING' => 114,
			'KEYS_OR_VALUES' => 159,
			"undef" => 94,
			'WORD_SCOPED' => 23,
			")" => -95,
			"(" => 102,
			'WORD' => 24,
			'OP01_NAMED' => 97
		},
		GOTOS => {
			'TypeInner' => 154,
			'HashReference' => 110,
			'Expression' => 155,
			'Operator' => 109,
			'ArrayReference' => 103,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'ListElement' => 160,
			'ListElements' => 221,
			'OPTIONAL-38' => 222,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 141
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 199,
			")" => 223,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP18_TERNARY' => 192,
			'OP04_MATH_POW' => 190,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP17_LIST_RANGE' => 197,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194,
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP08_STRING_CAT' => 185,
			'OP16_LOGICAL_OR' => 186,
			'OP06_REGEX_MATCH' => 187
		}
	},
	{#State 142
		ACTIONS => {
			"}" => 224
		}
	},
	{#State 143
		ACTIONS => {
			"%{" => 87,
			'WORD' => 177
		},
		GOTOS => {
			'HashEntry' => 178,
			'HashDereferenced' => 179
		}
	},
	{#State 144
		ACTIONS => {
			"}" => 225
		}
	},
	{#State 145
		ACTIONS => {
			"}" => 226
		}
	},
	{#State 146
		ACTIONS => {
			"}" => 227
		}
	},
	{#State 147
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 94,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			'WORD' => 24,
			"(" => 102,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 97,
			"%{" => 87,
			"\@{" => 88,
			'OP01_OPEN_CLOSE' => 82,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'ArrayReference' => 103,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'Expression' => 228,
			'HashReference' => 110,
			'Operator' => 109,
			'Variable' => 139,
			'WordScoped' => 90
		}
	},
	{#State 148
		DEFAULT => -102
	},
	{#State 149
		ACTIONS => {
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			"<STDIN>" => 230,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			"(" => 102,
			"%{" => 87,
			"\@{" => 88
		},
		GOTOS => {
			'ArrayReference' => 103,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'Expression' => 231,
			'HashReference' => 110,
			'Operator' => 109,
			'ExpressionOrStdin' => 229,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 150
		ACTIONS => {
			'WORD' => 232
		}
	},
	{#State 151
		ACTIONS => {
			"%{" => 87,
			'OP01_QW' => 157,
			"\@{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 94,
			'KEYS_OR_VALUES' => 159,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			"my" => 76,
			")" => -138,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 97,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'VARIABLE_SYMBOL' => 78,
			'OP01_OPEN_CLOSE' => 82,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP05_MATH_NEG' => 84
		},
		GOTOS => {
			'ListElements' => 233,
			'Variable' => 139,
			'OPTIONAL-44' => 234,
			'WordScoped' => 90,
			'ListElement' => 160,
			'HashReference' => 110,
			'Expression' => 155,
			'Operator' => 109,
			'ArrayReference' => 103,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'TypeInner' => 154
		}
	},
	{#State 152
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -104,
			";" => -104,
			'OP18_TERNARY' => -104,
			'OP04_MATH_POW' => 190,
			".." => -104,
			'OP11_COMPARE_LT_GT' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP21_LIST_COMMA' => -104,
			"]" => -104,
			'OP15_LOGICAL_AND' => -104,
			")" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP07_MATH_MULT_DIV_MOD' => -104,
			'OP06_REGEX_MATCH' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP08_STRING_CAT' => -104,
			'OP08_MATH_ADD_SUB' => -104,
			'OP12_COMPARE_EQ_NEQ' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP09_BITWISE_SHIFT' => -104,
			'OP13_BITWISE_AND' => -104,
			"}" => -104
		}
	},
	{#State 153
		DEFAULT => -101
	},
	{#State 154
		ACTIONS => {
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'VARIABLE_SYMBOL' => 78,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 97,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 94,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			"\@{" => 88,
			"%{" => 87
		},
		GOTOS => {
			'Variable' => 139,
			'WordScoped' => 90,
			'ArrayReference' => 103,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Expression' => 235,
			'HashReference' => 110,
			'Operator' => 109
		}
	},
	{#State 155
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP11_COMPARE_LT_GT' => 200,
			")" => -196,
			'OP21_LIST_COMMA' => -196,
			"]" => -196,
			'OP15_LOGICAL_AND' => 199,
			'OP18_TERNARY' => 192,
			";" => -196,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP04_MATH_POW' => 190,
			'OP17_LIST_RANGE' => 197,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP13_BITWISE_AND' => 194,
			'OP09_BITWISE_SHIFT' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => 188,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => 186
		}
	},
	{#State 156
		ACTIONS => {
			";" => 236
		}
	},
	{#State 157
		ACTIONS => {
			"(" => 237
		}
	},
	{#State 158
		DEFAULT => -128
	},
	{#State 159
		ACTIONS => {
			"%{" => 87
		},
		GOTOS => {
			'HashDereferenced' => 238
		}
	},
	{#State 160
		DEFAULT => -191,
		GOTOS => {
			'STAR-55' => 239
		}
	},
	{#State 161
		ACTIONS => {
			'OP17_LIST_RANGE' => 197,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP13_BITWISE_AND' => 194,
			"}" => -121,
			'OP09_BITWISE_SHIFT' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => -121,
			'OP16_LOGICAL_OR' => 186,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP11_COMPARE_LT_GT' => 200,
			")" => -121,
			'OP15_LOGICAL_AND' => 199,
			'OP21_LIST_COMMA' => -121,
			"]" => -121,
			'OP18_TERNARY' => 192,
			'OP14_BITWISE_OR_XOR' => 198,
			";" => -121,
			'OP04_MATH_POW' => 190,
			".." => -121
		}
	},
	{#State 162
		ACTIONS => {
			'OP01_NAMED' => 97,
			'WORD' => 24,
			")" => -93,
			"(" => 102,
			'WORD_SCOPED' => 23,
			'KEYS_OR_VALUES' => 159,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			"my" => 76,
			'LITERAL_STRING' => 114,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"\@{" => 88,
			'OP01_QW' => 157,
			"%{" => 87,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82,
			'VARIABLE_SYMBOL' => 78,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104
		},
		GOTOS => {
			'Operator' => 109,
			'HashReference' => 110,
			'Expression' => 155,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'ArrayReference' => 103,
			'TypeInner' => 154,
			'ListElements' => 240,
			'Variable' => 139,
			'WordScoped' => 90,
			'OPTIONAL-37' => 241,
			'ListElement' => 160
		}
	},
	{#State 163
		DEFAULT => -155
	},
	{#State 164
		ACTIONS => {
			'OP04_MATH_POW' => 190,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP18_TERNARY' => 192,
			'OP15_LOGICAL_AND' => 199,
			")" => 242,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP17_LIST_RANGE' => 197
		}
	},
	{#State 165
		ACTIONS => {
			'OP23_LOGICAL_AND' => -112,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => -112,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => -112,
			"}" => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			";" => -112,
			'OP18_TERNARY' => -112,
			'OP04_MATH_POW' => 190,
			".." => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP15_LOGICAL_AND' => -112,
			"]" => -112,
			")" => -112
		}
	},
	{#State 166
		DEFAULT => -199
	},
	{#State 167
		ACTIONS => {
			"]" => 243
		}
	},
	{#State 168
		DEFAULT => -159
	},
	{#State 169
		DEFAULT => -170
	},
	{#State 170
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 244
		}
	},
	{#State 171
		ACTIONS => {
			'VARIABLE_SYMBOL' => 245
		}
	},
	{#State 172
		DEFAULT => -172
	},
	{#State 173
		DEFAULT => -171
	},
	{#State 174
		ACTIONS => {
			"\@{" => 88,
			"%{" => 87,
			'OP01_NAMED' => 97,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			'VARIABLE_SYMBOL' => 78,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82
		},
		GOTOS => {
			'WordScoped' => 90,
			'Variable' => 139,
			'ArrayReference' => 103,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'HashReference' => 110,
			'Expression' => 246,
			'Operator' => 109
		}
	},
	{#State 175
		ACTIONS => {
			")" => 247
		}
	},
	{#State 176
		DEFAULT => -124
	},
	{#State 177
		ACTIONS => {
			'OP20_HASH_FATARROW' => 248
		}
	},
	{#State 178
		DEFAULT => -212,
		GOTOS => {
			'STAR-60' => 249
		}
	},
	{#State 179
		DEFAULT => -207
	},
	{#State 180
		DEFAULT => -148
	},
	{#State 181
		DEFAULT => -16
	},
	{#State 182
		ACTIONS => {
			'VARIABLE_SYMBOL' => 250
		}
	},
	{#State 183
		ACTIONS => {
			'OP06_REGEX_MATCH' => 187,
			'OP08_STRING_CAT' => 185,
			'OP16_LOGICAL_OR' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP09_BITWISE_SHIFT' => 189,
			"}" => -111,
			'OP13_BITWISE_AND' => -111,
			'OP12_COMPARE_EQ_NEQ' => -111,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => -111,
			".." => -111,
			'OP04_MATH_POW' => 190,
			";" => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP18_TERNARY' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP21_LIST_COMMA' => -111,
			"]" => -111,
			")" => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP24_LOGICAL_OR_XOR' => -111
		}
	},
	{#State 184
		ACTIONS => {
			'KEYS_OR_VALUES' => 159,
			"undef" => 94,
			'OP03_MATH_INC_DEC' => 92,
			"my" => 76,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 97,
			"(" => 102,
			")" => -127,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP01_QW' => 157,
			"%{" => 87,
			"\@{" => 88,
			'OP01_OPEN_CLOSE' => 82,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP05_MATH_NEG' => 84,
			'VARIABLE_SYMBOL' => 78,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104
		},
		GOTOS => {
			'TypeInner' => 154,
			'Operator' => 109,
			'Expression' => 155,
			'HashReference' => 110,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'ArrayReference' => 103,
			'OPTIONAL-41' => 251,
			'ListElement' => 160,
			'ListElements' => 252,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 185
		ACTIONS => {
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'VARIABLE_SYMBOL' => 78,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 97,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 94,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			"\@{" => 88,
			"%{" => 87
		},
		GOTOS => {
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'ArrayReference' => 103,
			'Operator' => 109,
			'HashReference' => 110,
			'Expression' => 253,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 186
		ACTIONS => {
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			"%{" => 87,
			"\@{" => 88,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79
		},
		GOTOS => {
			'Variable' => 139,
			'WordScoped' => 90,
			'HashReference' => 110,
			'Expression' => 254,
			'Operator' => 109,
			'ArrayReference' => 103,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99
		}
	},
	{#State 187
		ACTIONS => {
			"/" => 255
		}
	},
	{#State 188
		ACTIONS => {
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 97,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			"%{" => 87,
			"\@{" => 88,
			'OP01_OPEN_CLOSE' => 82,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP05_MATH_NEG' => 84,
			'VARIABLE_SYMBOL' => 78,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 104
		},
		GOTOS => {
			'WordScoped' => 90,
			'Variable' => 139,
			'HashReference' => 110,
			'Expression' => 256,
			'Operator' => 109,
			'ArrayReference' => 103,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99
		}
	},
	{#State 189
		ACTIONS => {
			"\@{" => 88,
			"%{" => 87,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP01_OPEN_CLOSE' => 82
		},
		GOTOS => {
			'Variable' => 139,
			'WordScoped' => 90,
			'Operator' => 109,
			'Expression' => 257,
			'HashReference' => 110,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayReference' => 103
		}
	},
	{#State 190
		ACTIONS => {
			"\@{" => 88,
			"%{" => 87,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP01_OPEN_CLOSE' => 82
		},
		GOTOS => {
			'WordScoped' => 90,
			'Variable' => 139,
			'ArrayReference' => 103,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Expression' => 258,
			'HashReference' => 110,
			'Operator' => 109
		}
	},
	{#State 191
		DEFAULT => -90
	},
	{#State 192
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'Variable' => 259
		}
	},
	{#State 193
		ACTIONS => {
			'OP01_NAMED' => 97,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			"undef" => 94,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"\@{" => 88,
			"%{" => 87,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82,
			'VARIABLE_SYMBOL' => 78,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 104
		},
		GOTOS => {
			'HashReference' => 110,
			'Expression' => 260,
			'Operator' => 109,
			'ArrayReference' => 103,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 194
		ACTIONS => {
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82,
			'VARIABLE_SYMBOL' => 78,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'OP01_NAMED' => 97,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			"undef" => 94,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"\@{" => 88,
			"%{" => 87
		},
		GOTOS => {
			'WordScoped' => 90,
			'Variable' => 139,
			'Expression' => 261,
			'HashReference' => 110,
			'Operator' => 109,
			'ArrayReference' => 103,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100
		}
	},
	{#State 195
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP01_OPEN_CLOSE' => 82,
			"\@{" => 88,
			"%{" => 87,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'ArrayReference' => 103,
			'Operator' => 109,
			'HashReference' => 110,
			'Expression' => 262,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 196
		ACTIONS => {
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			"undef" => 94,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			"(" => 102,
			'OP01_NAMED' => 97,
			"%{" => 87,
			"\@{" => 88,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'Expression' => 263,
			'HashReference' => 110,
			'Operator' => 109,
			'ArrayReference' => 103,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 197
		ACTIONS => {
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'OP01_NAMED' => 97,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			"\@{" => 88,
			"%{" => 87,
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP01_OPEN_CLOSE' => 82,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'Variable' => 139,
			'WordScoped' => 90,
			'ArrayReference' => 103,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'Expression' => 264,
			'HashReference' => 110,
			'Operator' => 109
		}
	},
	{#State 198
		ACTIONS => {
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP01_OPEN_CLOSE' => 82,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'VARIABLE_SYMBOL' => 78,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			"(" => 102,
			'OP01_NAMED' => 97,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			"undef" => 94,
			"\@{" => 88,
			"%{" => 87
		},
		GOTOS => {
			'Variable' => 139,
			'WordScoped' => 90,
			'Operator' => 109,
			'Expression' => 265,
			'HashReference' => 110,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'ArrayReference' => 103
		}
	},
	{#State 199
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP01_OPEN_CLOSE' => 82,
			"\@{" => 88,
			"%{" => 87,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			"(" => 102,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96
		},
		GOTOS => {
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayReference' => 103,
			'Operator' => 109,
			'HashReference' => 110,
			'Expression' => 266,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 200
		ACTIONS => {
			"\@{" => 88,
			"%{" => 87,
			'OP01_NAMED' => 97,
			'WORD' => 24,
			"(" => 102,
			'WORD_SCOPED' => 23,
			"undef" => 94,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			'VARIABLE_SYMBOL' => 78,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82
		},
		GOTOS => {
			'Variable' => 139,
			'WordScoped' => 90,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'ArrayReference' => 103,
			'Operator' => 109,
			'Expression' => 267,
			'HashReference' => 110
		}
	},
	{#State 201
		ACTIONS => {
			'OP01_NAMED' => 97,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"\@{" => 88,
			"%{" => 87,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82,
			'VARIABLE_SYMBOL' => 78,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104
		},
		GOTOS => {
			'Expression' => 268,
			'HashReference' => 110,
			'Operator' => 109,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 202
		ACTIONS => {
			"our" => -64,
			'LITERAL_NUMBER' => -64,
			"our %properties_class = (" => 271
		},
		GOTOS => {
			'PropertiesClass' => 269,
			'OPTIONAL-26' => 270
		}
	},
	{#State 203
		DEFAULT => -61
	},
	{#State 204
		ACTIONS => {
			")" => 272,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 273
		}
	},
	{#State 205
		ACTIONS => {
			"foreach my" => -157,
			'LITERAL_NUMBER' => 79,
			'VARIABLE_SYMBOL' => 78,
			'OP01_PRINT_VOID' => 77,
			'OP19_LOOP_CONTROL' => 80,
			'OP01_OPEN_CLOSE' => 82,
			"for my integer" => -157,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"}" => 275,
			"if (" => 86,
			"%{" => 87,
			"\@{" => 88,
			"while (" => -157,
			'OP01_NAMED_VOID' => 95,
			'OP22_LOGICAL_NOT' => 96,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			"(" => 102,
			'OP01_NAMED' => 97,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'OP01_NAMED_VOID_PAREN' => 108,
			"{" => 111,
			'OP10_NAMED_UNARY' => 117,
			'OP01_PRINT_VOID_PAREN' => 118,
			'LITERAL_STRING' => 114,
			"my" => 115,
			'WORD_SCOPED' => 23,
			'WORD' => 122
		},
		GOTOS => {
			'OPTIONAL-47' => 107,
			'Statement' => 81,
			'HashReference' => 110,
			'PAREN-46' => 83,
			'Operator' => 109,
			'OperatorVoid' => 112,
			'VariableDeclaration' => 106,
			'Operation' => 274,
			'Expression' => 120,
			'VariableModification' => 119,
			'LoopLabel' => 98,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 100,
			'Conditional' => 121,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'WordScoped' => 90,
			'Variable' => 89
		}
	},
	{#State 206
		DEFAULT => -45
	},
	{#State 207
		ACTIONS => {
			'VARIABLE_SYMBOL' => 276
		}
	},
	{#State 208
		DEFAULT => -41
	},
	{#State 209
		ACTIONS => {
			'WORD' => 277
		}
	},
	{#State 210
		ACTIONS => {
			'VARIABLE_SYMBOL' => 278
		}
	},
	{#State 211
		ACTIONS => {
			"}" => 279
		}
	},
	{#State 212
		ACTIONS => {
			";" => 280
		}
	},
	{#State 213
		DEFAULT => -130
	},
	{#State 214
		ACTIONS => {
			"%{" => 87,
			"\@{" => 88,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111
		},
		GOTOS => {
			'Variable' => 139,
			'WordScoped' => 90,
			'ArrayReference' => 103,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'Expression' => 281,
			'HashReference' => 110,
			'Operator' => 109
		}
	},
	{#State 215
		DEFAULT => -179
	},
	{#State 216
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'VARIABLE_SYMBOL' => 78,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP01_OPEN_CLOSE' => 82,
			"\@{" => 88,
			"%{" => 87,
			'WORD_SCOPED' => 23,
			'WORD' => 282,
			"(" => 102,
			'OP01_NAMED' => 97,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94
		},
		GOTOS => {
			'Expression' => 283,
			'HashReference' => 110,
			'Operator' => 109,
			'ArrayReference' => 103,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'WordScoped' => 90,
			'Variable' => 139
		}
	},
	{#State 217
		DEFAULT => -136
	},
	{#State 218
		DEFAULT => -96
	},
	{#State 219
		ACTIONS => {
			";" => 284
		}
	},
	{#State 220
		DEFAULT => -105
	},
	{#State 221
		DEFAULT => -94
	},
	{#State 222
		ACTIONS => {
			")" => 285
		}
	},
	{#State 223
		ACTIONS => {
			"{" => 287
		},
		GOTOS => {
			'CodeBlock' => 286
		}
	},
	{#State 224
		DEFAULT => -214
	},
	{#State 225
		DEFAULT => -215
	},
	{#State 226
		DEFAULT => -202
	},
	{#State 227
		DEFAULT => -203
	},
	{#State 228
		ACTIONS => {
			'OP13_BITWISE_AND' => 194,
			'OP09_BITWISE_SHIFT' => 189,
			'OP17_LIST_RANGE' => 197,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP06_REGEX_MATCH' => 187,
			'OP08_STRING_CAT' => 185,
			'OP16_LOGICAL_OR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => 188,
			'OP15_LOGICAL_AND' => 199,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP11_COMPARE_LT_GT' => 200,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => 192,
			";" => 288,
			'OP14_BITWISE_OR_XOR' => 198
		}
	},
	{#State 229
		ACTIONS => {
			";" => 289
		}
	},
	{#State 230
		DEFAULT => -154
	},
	{#State 231
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => 197,
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP08_STRING_CAT' => 185,
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP15_LOGICAL_AND' => 199,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP04_MATH_POW' => 190,
			'OP14_BITWISE_OR_XOR' => 198,
			";" => -153,
			'OP18_TERNARY' => 192
		}
	},
	{#State 232
		ACTIONS => {
			"(" => 290
		}
	},
	{#State 233
		DEFAULT => -137
	},
	{#State 234
		ACTIONS => {
			")" => 291
		}
	},
	{#State 235
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => 188,
			'OP16_LOGICAL_OR' => 186,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP17_LIST_RANGE' => 197,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP13_BITWISE_AND' => 194,
			'OP09_BITWISE_SHIFT' => 189,
			'OP18_TERNARY' => 192,
			";" => -197,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP04_MATH_POW' => 190,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP11_COMPARE_LT_GT' => 200,
			")" => -197,
			'OP21_LIST_COMMA' => -197,
			'OP15_LOGICAL_AND' => 199,
			"]" => -197
		}
	},
	{#State 236
		DEFAULT => -134
	},
	{#State 237
		ACTIONS => {
			'WORD' => 293
		},
		GOTOS => {
			'PLUS-56' => 292
		}
	},
	{#State 238
		DEFAULT => -198
	},
	{#State 239
		ACTIONS => {
			";" => -194,
			")" => -194,
			"]" => -194,
			'OP21_LIST_COMMA' => 294
		},
		GOTOS => {
			'PAREN-54' => 295
		}
	},
	{#State 240
		DEFAULT => -92
	},
	{#State 241
		ACTIONS => {
			")" => 296
		}
	},
	{#State 242
		DEFAULT => -152
	},
	{#State 243
		DEFAULT => -201
	},
	{#State 244
		ACTIONS => {
			'VARIABLE_SYMBOL' => 297
		}
	},
	{#State 245
		ACTIONS => {
			"(" => 298
		}
	},
	{#State 246
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 199,
			")" => 299,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP18_TERNARY' => 192,
			'OP04_MATH_POW' => 190,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => 197,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194,
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => 186
		}
	},
	{#State 247
		ACTIONS => {
			";" => 300
		}
	},
	{#State 248
		ACTIONS => {
			'OP01_OPEN_CLOSE' => -205,
			"{" => -205,
			'OP01_OPEN_CLOSE_PAREN' => -205,
			'OP05_MATH_NEG' => -205,
			'VARIABLE_SYMBOL' => -205,
			'LITERAL_NUMBER' => -205,
			"[" => -205,
			'OP10_NAMED_UNARY_STRINGIFY' => -205,
			"undef" => -205,
			'OP05_LOGICAL_NEG' => -205,
			'OP03_MATH_INC_DEC' => -205,
			'LITERAL_STRING' => -205,
			"my" => 76,
			'OP22_LOGICAL_NOT' => -205,
			'OP10_NAMED_UNARY' => -205,
			'OP01_NAMED' => -205,
			"(" => -205,
			'WORD' => -205,
			'WORD_SCOPED' => -205,
			"%{" => -205,
			"\@{" => -205
		},
		GOTOS => {
			'OPTIONAL-58' => 301,
			'TypeInner' => 302
		}
	},
	{#State 249
		ACTIONS => {
			"}" => 305,
			'OP21_LIST_COMMA' => 303
		},
		GOTOS => {
			'PAREN-59' => 304
		}
	},
	{#State 250
		ACTIONS => {
			";" => 306,
			'OP19_VARIABLE_ASSIGN' => 307
		}
	},
	{#State 251
		ACTIONS => {
			")" => 308
		}
	},
	{#State 252
		DEFAULT => -126
	},
	{#State 253
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			")" => -109,
			'OP15_LOGICAL_AND' => -109,
			'OP21_LIST_COMMA' => -109,
			"]" => -109,
			'OP18_TERNARY' => -109,
			";" => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			".." => -109,
			'OP04_MATH_POW' => 190,
			'OP17_LIST_RANGE' => -109,
			'OP12_COMPARE_EQ_NEQ' => -109,
			'OP08_MATH_ADD_SUB' => 195,
			"}" => -109,
			'OP13_BITWISE_AND' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP08_STRING_CAT' => -109,
			'OP06_REGEX_MATCH' => 187
		}
	},
	{#State 254
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP11_COMPARE_LT_GT' => 200,
			")" => -118,
			'OP15_LOGICAL_AND' => 199,
			'OP21_LIST_COMMA' => -118,
			"]" => -118,
			'OP18_TERNARY' => -118,
			";" => -118,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP04_MATH_POW' => 190,
			".." => -118,
			'OP17_LIST_RANGE' => -118,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP13_BITWISE_AND' => 194,
			"}" => -118,
			'OP09_BITWISE_SHIFT' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP06_REGEX_MATCH' => 187,
			'OP08_STRING_CAT' => 185
		}
	},
	{#State 255
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 309
		}
	},
	{#State 256
		ACTIONS => {
			'OP23_LOGICAL_AND' => -122,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => 197,
			'OP09_BITWISE_SHIFT' => 189,
			"}" => -122,
			'OP13_BITWISE_AND' => 194,
			'OP14_BITWISE_OR_XOR' => 198,
			";" => -122,
			'OP18_TERNARY' => 192,
			".." => -122,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP21_LIST_COMMA' => -122,
			'OP15_LOGICAL_AND' => 199,
			"]" => -122,
			")" => -122
		}
	},
	{#State 257
		ACTIONS => {
			"}" => -110,
			'OP13_BITWISE_AND' => -110,
			'OP09_BITWISE_SHIFT' => -110,
			'OP17_LIST_RANGE' => -110,
			'OP12_COMPARE_EQ_NEQ' => -110,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => -110,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => -110,
			")" => -110,
			'OP21_LIST_COMMA' => -110,
			"]" => -110,
			'OP15_LOGICAL_AND' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP11_COMPARE_LT_GT' => -110,
			".." => -110,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => -110,
			'OP14_BITWISE_OR_XOR' => -110,
			";" => -110
		}
	},
	{#State 258
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP06_REGEX_MATCH' => -103,
			'OP08_STRING_CAT' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP08_MATH_ADD_SUB' => -103,
			'OP12_COMPARE_EQ_NEQ' => -103,
			'OP13_BITWISE_AND' => -103,
			"}" => -103,
			'OP09_BITWISE_SHIFT' => -103,
			'OP18_TERNARY' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			";" => -103,
			'OP04_MATH_POW' => 190,
			".." => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP11_COMPARE_LT_GT' => -103,
			")" => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP21_LIST_COMMA' => -103,
			"]" => -103
		}
	},
	{#State 259
		ACTIONS => {
			'COLON' => 310
		}
	},
	{#State 260
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -107,
			";" => -107,
			'OP18_TERNARY' => -107,
			".." => -107,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP21_LIST_COMMA' => -107,
			'OP15_LOGICAL_AND' => -107,
			"]" => -107,
			")" => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP07_MATH_MULT_DIV_MOD' => -107,
			'OP08_STRING_CAT' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP06_REGEX_MATCH' => 187,
			'OP12_COMPARE_EQ_NEQ' => -107,
			'OP08_MATH_ADD_SUB' => -107,
			'OP17_LIST_RANGE' => -107,
			'OP09_BITWISE_SHIFT' => -107,
			"}" => -107,
			'OP13_BITWISE_AND' => -107
		}
	},
	{#State 261
		ACTIONS => {
			")" => -115,
			'OP21_LIST_COMMA' => -115,
			'OP15_LOGICAL_AND' => -115,
			"]" => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP11_COMPARE_LT_GT' => 200,
			'OP04_MATH_POW' => 190,
			".." => -115,
			'OP18_TERNARY' => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			";" => -115,
			'OP13_BITWISE_AND' => -115,
			"}" => -115,
			'OP09_BITWISE_SHIFT' => 189,
			'OP17_LIST_RANGE' => -115,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_STRING_CAT' => 185,
			'OP16_LOGICAL_OR' => -115,
			'OP06_REGEX_MATCH' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => -115
		}
	},
	{#State 262
		ACTIONS => {
			'OP04_MATH_POW' => 190,
			".." => -108,
			";" => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP18_TERNARY' => -108,
			"]" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP15_LOGICAL_AND' => -108,
			")" => -108,
			'OP11_COMPARE_LT_GT' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP06_REGEX_MATCH' => 187,
			'OP08_STRING_CAT' => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP09_BITWISE_SHIFT' => -108,
			'OP13_BITWISE_AND' => -108,
			"}" => -108,
			'OP08_MATH_ADD_SUB' => -108,
			'OP12_COMPARE_EQ_NEQ' => -108,
			'OP17_LIST_RANGE' => -108
		}
	},
	{#State 263
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP11_COMPARE_LT_GT' => 200,
			")" => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP21_LIST_COMMA' => -114,
			"]" => -114,
			'OP18_TERNARY' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			";" => -114,
			".." => -114,
			'OP04_MATH_POW' => 190,
			'OP17_LIST_RANGE' => -114,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP08_MATH_ADD_SUB' => 195,
			"}" => -114,
			'OP13_BITWISE_AND' => -114,
			'OP09_BITWISE_SHIFT' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => -114,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => -114
		}
	},
	{#State 264
		ACTIONS => {
			'OP13_BITWISE_AND' => 194,
			"}" => -119,
			'OP09_BITWISE_SHIFT' => 189,
			'OP17_LIST_RANGE' => undef,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_STRING_CAT' => 185,
			'OP16_LOGICAL_OR' => 186,
			'OP06_REGEX_MATCH' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => -119,
			")" => -119,
			'OP21_LIST_COMMA' => -119,
			'OP15_LOGICAL_AND' => 199,
			"]" => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP11_COMPARE_LT_GT' => 200,
			'OP04_MATH_POW' => 190,
			".." => -119,
			'OP18_TERNARY' => -119,
			";" => -119,
			'OP14_BITWISE_OR_XOR' => 198
		}
	},
	{#State 265
		ACTIONS => {
			"]" => -116,
			'OP21_LIST_COMMA' => -116,
			'OP15_LOGICAL_AND' => -116,
			")" => -116,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => -116,
			".." => -116,
			'OP04_MATH_POW' => 190,
			'OP14_BITWISE_OR_XOR' => -116,
			";" => -116,
			'OP18_TERNARY' => -116,
			'OP09_BITWISE_SHIFT' => 189,
			"}" => -116,
			'OP13_BITWISE_AND' => 194,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => -116,
			'OP08_STRING_CAT' => 185,
			'OP16_LOGICAL_OR' => -116,
			'OP06_REGEX_MATCH' => 187,
			'OP23_LOGICAL_AND' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 193
		}
	},
	{#State 266
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP21_LIST_COMMA' => -117,
			"]" => -117,
			'OP15_LOGICAL_AND' => -117,
			")" => -117,
			";" => -117,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP18_TERNARY' => -117,
			".." => -117,
			'OP04_MATH_POW' => 190,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => -117,
			'OP09_BITWISE_SHIFT' => 189,
			"}" => -117,
			'OP13_BITWISE_AND' => 194,
			'OP23_LOGICAL_AND' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP16_LOGICAL_OR' => -117,
			'OP06_REGEX_MATCH' => 187,
			'OP08_STRING_CAT' => 185
		}
	},
	{#State 267
		ACTIONS => {
			";" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP18_TERNARY' => -113,
			'OP04_MATH_POW' => 190,
			".." => -113,
			'OP11_COMPARE_LT_GT' => undef,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP15_LOGICAL_AND' => -113,
			"]" => -113,
			")" => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP06_REGEX_MATCH' => 187,
			'OP08_STRING_CAT' => 185,
			'OP16_LOGICAL_OR' => -113,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => -113,
			'OP17_LIST_RANGE' => -113,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => -113,
			"}" => -113
		}
	},
	{#State 268
		ACTIONS => {
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP08_STRING_CAT' => 185,
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194,
			"}" => -123,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP17_LIST_RANGE' => 197,
			'OP04_MATH_POW' => 190,
			".." => -123,
			'OP14_BITWISE_OR_XOR' => 198,
			";" => -123,
			'OP18_TERNARY' => 192,
			"]" => -123,
			'OP21_LIST_COMMA' => -123,
			'OP15_LOGICAL_AND' => 199,
			")" => -123,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => -123
		}
	},
	{#State 269
		DEFAULT => -63
	},
	{#State 270
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 311
		}
	},
	{#State 271
		ACTIONS => {
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 312
		}
	},
	{#State 272
		ACTIONS => {
			";" => 313
		}
	},
	{#State 273
		ACTIONS => {
			"%{" => 87,
			'WORD' => 315
		},
		GOTOS => {
			'HashDereferenced' => 314,
			'HashEntryTyped' => 316
		}
	},
	{#State 274
		DEFAULT => -44
	},
	{#State 275
		ACTIONS => {
			";" => 317
		}
	},
	{#State 276
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 318
		}
	},
	{#State 277
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 319
		}
	},
	{#State 278
		DEFAULT => -223
	},
	{#State 279
		DEFAULT => -222
	},
	{#State 280
		DEFAULT => -135
	},
	{#State 281
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP17_LIST_RANGE' => 197,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194,
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP16_LOGICAL_OR' => 186,
			'OP06_REGEX_MATCH' => 187,
			'OP08_STRING_CAT' => 185,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => 201,
			"]" => 320,
			'OP15_LOGICAL_AND' => 199,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP18_TERNARY' => 192,
			'OP04_MATH_POW' => 190
		}
	},
	{#State 282
		ACTIONS => {
			"}" => 321,
			"(" => -216
		}
	},
	{#State 283
		ACTIONS => {
			'OP15_LOGICAL_AND' => 199,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP11_COMPARE_LT_GT' => 200,
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => 192,
			'OP14_BITWISE_OR_XOR' => 198,
			"}" => 322,
			'OP13_BITWISE_AND' => 194,
			'OP09_BITWISE_SHIFT' => 189,
			'OP17_LIST_RANGE' => 197,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => 188
		}
	},
	{#State 284
		DEFAULT => -100
	},
	{#State 285
		ACTIONS => {
			";" => 323
		}
	},
	{#State 286
		DEFAULT => -165,
		GOTOS => {
			'STAR-49' => 324
		}
	},
	{#State 287
		ACTIONS => {
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			"my" => 115,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_PRINT_VOID_PAREN' => 118,
			'OP10_NAMED_UNARY' => 117,
			"while (" => -157,
			'OP01_NAMED_VOID' => 95,
			'OP01_NAMED' => 97,
			'WORD' => 122,
			"(" => 102,
			'WORD_SCOPED' => 23,
			"%{" => 87,
			"if (" => 86,
			"\@{" => 88,
			"for my integer" => -157,
			'OP01_NAMED_VOID_PAREN' => 108,
			'OP01_OPEN_CLOSE' => 82,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP05_MATH_NEG' => 84,
			'OP01_PRINT_VOID' => 77,
			'VARIABLE_SYMBOL' => 78,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"foreach my" => -157,
			'OP19_LOOP_CONTROL' => 80
		},
		GOTOS => {
			'OPTIONAL-47' => 107,
			'Statement' => 81,
			'HashReference' => 110,
			'PAREN-46' => 83,
			'Operator' => 109,
			'OperatorVoid' => 112,
			'PLUS-52' => 325,
			'VariableDeclaration' => 106,
			'Operation' => 326,
			'Expression' => 120,
			'LoopLabel' => 98,
			'VariableModification' => 119,
			'ArrayReference' => 103,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'Conditional' => 121,
			'WordScoped' => 90,
			'Variable' => 89
		}
	},
	{#State 288
		DEFAULT => -188
	},
	{#State 289
		DEFAULT => -187
	},
	{#State 290
		ACTIONS => {
			"\@{" => 88,
			"%{" => 87,
			'OP01_QW' => 157,
			'WORD_SCOPED' => 23,
			")" => -140,
			"(" => 102,
			'WORD' => 24,
			'OP01_NAMED' => 97,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			"my" => 76,
			"undef" => 94,
			'KEYS_OR_VALUES' => 159,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'VARIABLE_SYMBOL' => 78,
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP01_OPEN_CLOSE' => 82
		},
		GOTOS => {
			'TypeInner' => 154,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'ArrayReference' => 103,
			'OPTIONAL-45' => 328,
			'Operator' => 109,
			'HashReference' => 110,
			'Expression' => 155,
			'ListElement' => 160,
			'WordScoped' => 90,
			'Variable' => 139,
			'ListElements' => 327
		}
	},
	{#State 291
		DEFAULT => -150
	},
	{#State 292
		ACTIONS => {
			'WORD' => 329,
			")" => 330
		}
	},
	{#State 293
		DEFAULT => -193
	},
	{#State 294
		ACTIONS => {
			"%{" => 87,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			"my" => 76,
			'OP05_LOGICAL_NEG' => 91,
			'KEYS_OR_VALUES' => 159,
			"undef" => 94,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'OP01_NAMED' => 97,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'VARIABLE_SYMBOL' => 78,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111
		},
		GOTOS => {
			'TypeInner' => 154,
			'HashReference' => 110,
			'Expression' => 155,
			'Operator' => 109,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ListElement' => 331,
			'Variable' => 139,
			'WordScoped' => 90
		}
	},
	{#State 295
		DEFAULT => -190
	},
	{#State 296
		DEFAULT => -98
	},
	{#State 297
		ACTIONS => {
			"(" => 332
		}
	},
	{#State 298
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'VARIABLE_SYMBOL' => 78,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"%{" => 87,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			"undef" => 94,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			"(" => 102,
			'OP01_NAMED' => 97
		},
		GOTOS => {
			'ArrayReference' => 103,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'HashReference' => 110,
			'Expression' => 333,
			'Operator' => 109,
			'Variable' => 139,
			'WordScoped' => 90
		}
	},
	{#State 299
		ACTIONS => {
			"{" => 287
		},
		GOTOS => {
			'CodeBlock' => 334
		}
	},
	{#State 300
		DEFAULT => -132
	},
	{#State 301
		ACTIONS => {
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			"%{" => 87,
			"\@{" => 88,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79
		},
		GOTOS => {
			'WordScoped' => 90,
			'Variable' => 139,
			'HashReference' => 110,
			'Expression' => 335,
			'Operator' => 109,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Literal' => 101
		}
	},
	{#State 302
		DEFAULT => -204
	},
	{#State 303
		ACTIONS => {
			'WORD' => 177,
			"%{" => 87
		},
		GOTOS => {
			'HashEntry' => 336,
			'HashDereferenced' => 179
		}
	},
	{#State 304
		DEFAULT => -211
	},
	{#State 305
		DEFAULT => -213
	},
	{#State 306
		DEFAULT => -185
	},
	{#State 307
		ACTIONS => {
			"\@{" => 88,
			"%{" => 87,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			'WORD' => 24,
			"(" => 102,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			"<STDIN>" => 230,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP01_OPEN_CLOSE' => 82
		},
		GOTOS => {
			'ExpressionOrStdin' => 337,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'ArrayReference' => 103,
			'Operator' => 109,
			'Expression' => 231,
			'HashReference' => 110,
			'Variable' => 139,
			'WordScoped' => 90
		}
	},
	{#State 308
		ACTIONS => {
			";" => 338
		}
	},
	{#State 309
		ACTIONS => {
			"/" => 339
		}
	},
	{#State 310
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78
		},
		GOTOS => {
			'Variable' => 340
		}
	},
	{#State 311
		ACTIONS => {
			'LITERAL_NUMBER' => 343,
			"our" => 344
		},
		GOTOS => {
			'MethodOrSubroutine' => 345,
			'Subroutine' => 342,
			'Method' => 341
		}
	},
	{#State 312
		ACTIONS => {
			"%{" => 87,
			'WORD' => 315
		},
		GOTOS => {
			'HashDereferenced' => 314,
			'HashEntryTyped' => 346
		}
	},
	{#State 313
		ACTIONS => {
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 347
		}
	},
	{#State 314
		DEFAULT => -209
	},
	{#State 315
		ACTIONS => {
			'OP20_HASH_FATARROW' => 348
		}
	},
	{#State 316
		DEFAULT => -70,
		GOTOS => {
			'STAR-29' => 349
		}
	},
	{#State 317
		DEFAULT => -46
	},
	{#State 318
		ACTIONS => {
			")" => 352,
			'OP21_LIST_COMMA' => 350
		},
		GOTOS => {
			'PAREN-18' => 351
		}
	},
	{#State 319
		DEFAULT => -221
	},
	{#State 320
		DEFAULT => -182
	},
	{#State 321
		DEFAULT => -184
	},
	{#State 322
		DEFAULT => -183
	},
	{#State 323
		DEFAULT => -99
	},
	{#State 324
		ACTIONS => {
			'OP01_OPEN_CLOSE' => -168,
			"for my integer" => -168,
			"}" => -168,
			'OP01_OPEN_CLOSE_PAREN' => -168,
			'OP05_MATH_NEG' => -168,
			'LITERAL_NUMBER' => -168,
			"foreach my" => -168,
			'OP01_PRINT_VOID' => -168,
			'VARIABLE_SYMBOL' => -168,
			'OP19_LOOP_CONTROL' => -168,
			'OP22_LOGICAL_NOT' => -168,
			"elsif (" => 356,
			"while (" => -168,
			'OP01_NAMED_VOID' => -168,
			"undef" => -168,
			'OP03_MATH_INC_DEC' => -168,
			'OP05_LOGICAL_NEG' => -168,
			"(" => -168,
			'OP01_NAMED' => -168,
			"%{" => -168,
			"if (" => -168,
			"\@{" => -168,
			"else" => 355,
			'' => -168,
			'OP01_NAMED_VOID_PAREN' => -168,
			"{" => -168,
			"[" => -168,
			'OP10_NAMED_UNARY_STRINGIFY' => -168,
			'OP01_PRINT_VOID_PAREN' => -168,
			'OP10_NAMED_UNARY' => -168,
			'LITERAL_STRING' => -168,
			"my" => -168,
			'WORD' => -168,
			'WORD_SCOPED' => -168
		},
		GOTOS => {
			'PAREN-50' => 354,
			'PAREN-48' => 357,
			'OPTIONAL-51' => 353
		}
	},
	{#State 325
		ACTIONS => {
			'OP01_PRINT_VOID_PAREN' => 118,
			'OP10_NAMED_UNARY' => 117,
			"my" => 115,
			'LITERAL_STRING' => 114,
			'WORD' => 122,
			'WORD_SCOPED' => 23,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'OP01_NAMED_VOID_PAREN' => 108,
			"{" => 111,
			"%{" => 87,
			"if (" => 86,
			"\@{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			"while (" => -157,
			'OP01_NAMED_VOID' => 95,
			"undef" => 94,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			"(" => 102,
			'OP01_NAMED' => 97,
			'LITERAL_NUMBER' => 79,
			"foreach my" => -157,
			'VARIABLE_SYMBOL' => 78,
			'OP01_PRINT_VOID' => 77,
			'OP19_LOOP_CONTROL' => 80,
			'OP01_OPEN_CLOSE' => 82,
			"for my integer" => -157,
			"}" => 358,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84
		},
		GOTOS => {
			'Operation' => 359,
			'Expression' => 120,
			'VariableModification' => 119,
			'LoopLabel' => 98,
			'ArrayReference' => 103,
			'Conditional' => 121,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'Variable' => 89,
			'WordScoped' => 90,
			'OPTIONAL-47' => 107,
			'Statement' => 81,
			'HashReference' => 110,
			'Operator' => 109,
			'PAREN-46' => 83,
			'OperatorVoid' => 112,
			'VariableDeclaration' => 106
		}
	},
	{#State 326
		DEFAULT => -177
	},
	{#State 327
		DEFAULT => -139
	},
	{#State 328
		ACTIONS => {
			")" => 360
		}
	},
	{#State 329
		DEFAULT => -192
	},
	{#State 330
		DEFAULT => -195
	},
	{#State 331
		DEFAULT => -189
	},
	{#State 332
		ACTIONS => {
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'VARIABLE_SYMBOL' => 78,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE' => 82,
			"\@{" => 88,
			"%{" => 87,
			'OP01_QW' => 157,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 97,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 94,
			'KEYS_OR_VALUES' => 159,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			"my" => 76,
			'OP05_LOGICAL_NEG' => 91
		},
		GOTOS => {
			'ListElement' => 160,
			'Variable' => 139,
			'WordScoped' => 90,
			'ListElements' => 361,
			'TypeInner' => 154,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'ArrayReference' => 103,
			'Operator' => 109,
			'Expression' => 155,
			'HashReference' => 110
		}
	},
	{#State 333
		ACTIONS => {
			'OP17_LIST_RANGE' => 197,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP13_BITWISE_AND' => 194,
			'OP09_BITWISE_SHIFT' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => 188,
			'OP08_STRING_CAT' => 185,
			'OP16_LOGICAL_OR' => 186,
			'OP06_REGEX_MATCH' => 187,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP11_COMPARE_LT_GT' => 200,
			'OP15_LOGICAL_AND' => 199,
			'OP18_TERNARY' => 192,
			'OP14_BITWISE_OR_XOR' => 198,
			".." => 362,
			'OP04_MATH_POW' => 190
		}
	},
	{#State 334
		DEFAULT => -175
	},
	{#State 335
		ACTIONS => {
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP08_STRING_CAT' => 185,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP17_LIST_RANGE' => 197,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194,
			"}" => -206,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP18_TERNARY' => 192,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 199,
			'OP21_LIST_COMMA' => -206
		}
	},
	{#State 336
		DEFAULT => -210
	},
	{#State 337
		ACTIONS => {
			";" => 363
		}
	},
	{#State 338
		DEFAULT => -133
	},
	{#State 339
		DEFAULT => -106
	},
	{#State 340
		DEFAULT => -120
	},
	{#State 341
		DEFAULT => -88
	},
	{#State 342
		DEFAULT => -89
	},
	{#State 343
		ACTIONS => {
			";" => 364
		}
	},
	{#State 344
		ACTIONS => {
			'WORD' => 365
		},
		GOTOS => {
			'Type' => 53,
			'TypeMethod' => 366
		}
	},
	{#State 345
		DEFAULT => -65
	},
	{#State 346
		DEFAULT => -75,
		GOTOS => {
			'STAR-31' => 367
		}
	},
	{#State 347
		DEFAULT => -72
	},
	{#State 348
		ACTIONS => {
			"my" => 76
		},
		GOTOS => {
			'TypeInner' => 368
		}
	},
	{#State 349
		ACTIONS => {
			'OP21_LIST_COMMA' => 369,
			")" => 371
		},
		GOTOS => {
			'PAREN-28' => 370
		}
	},
	{#State 350
		ACTIONS => {
			"my" => 372
		}
	},
	{#State 351
		DEFAULT => -48
	},
	{#State 352
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 373
		}
	},
	{#State 353
		DEFAULT => -169
	},
	{#State 354
		DEFAULT => -167
	},
	{#State 355
		ACTIONS => {
			"{" => 287
		},
		GOTOS => {
			'CodeBlock' => 374
		}
	},
	{#State 356
		ACTIONS => {
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			"%{" => 87,
			"\@{" => 88,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 90,
			'Variable' => 139,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'ArrayReference' => 103,
			'Operator' => 109,
			'Expression' => 375,
			'HashReference' => 110
		}
	},
	{#State 357
		DEFAULT => -164
	},
	{#State 358
		DEFAULT => -178
	},
	{#State 359
		DEFAULT => -176
	},
	{#State 360
		DEFAULT => -151
	},
	{#State 361
		ACTIONS => {
			")" => 376
		}
	},
	{#State 362
		ACTIONS => {
			"%{" => 87,
			"\@{" => 88,
			'OP22_LOGICAL_NOT' => 96,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 94,
			'LITERAL_STRING' => 114,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			"(" => 102,
			'WORD' => 24,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 97,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'VARIABLE_SYMBOL' => 78,
			'OP01_OPEN_CLOSE' => 82,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP05_MATH_NEG' => 84
		},
		GOTOS => {
			'WordScoped' => 90,
			'Variable' => 139,
			'ArrayReference' => 103,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'HashReference' => 110,
			'Expression' => 377,
			'Operator' => 109
		}
	},
	{#State 363
		DEFAULT => -186
	},
	{#State 364
		DEFAULT => -67
	},
	{#State 365
		ACTIONS => {
			"__method" => 378,
			'VARIABLE_SYMBOL' => -219
		}
	},
	{#State 366
		ACTIONS => {
			'VARIABLE_SYMBOL' => 379
		}
	},
	{#State 367
		ACTIONS => {
			'OP21_LIST_COMMA' => 382,
			")" => 380
		},
		GOTOS => {
			'PAREN-30' => 381
		}
	},
	{#State 368
		ACTIONS => {
			"%{" => 87,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'OP01_NAMED' => 97,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'VARIABLE_SYMBOL' => 78,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85
		},
		GOTOS => {
			'Variable' => 139,
			'WordScoped' => 90,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'ArrayReference' => 103,
			'Operator' => 109,
			'HashReference' => 110,
			'Expression' => 383
		}
	},
	{#State 369
		ACTIONS => {
			"%{" => 87,
			'WORD' => 315
		},
		GOTOS => {
			'HashEntryTyped' => 384,
			'HashDereferenced' => 314
		}
	},
	{#State 370
		DEFAULT => -69
	},
	{#State 371
		ACTIONS => {
			";" => 385
		}
	},
	{#State 372
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 386
		}
	},
	{#State 373
		ACTIONS => {
			"\@_;" => 387
		}
	},
	{#State 374
		DEFAULT => -166
	},
	{#State 375
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 198,
			'OP18_TERNARY' => 192,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 199,
			")" => 388,
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP16_LOGICAL_OR' => 186,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => 197,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194
		}
	},
	{#State 376
		ACTIONS => {
			"{" => 287
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 377
		ACTIONS => {
			'OP04_MATH_POW' => 190,
			'OP18_TERNARY' => 192,
			'OP14_BITWISE_OR_XOR' => 198,
			")" => 390,
			'OP15_LOGICAL_AND' => 199,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP11_COMPARE_LT_GT' => 200,
			'OP06_REGEX_MATCH' => 187,
			'OP08_STRING_CAT' => 185,
			'OP16_LOGICAL_OR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => 188,
			'OP13_BITWISE_AND' => 194,
			'OP09_BITWISE_SHIFT' => 189,
			'OP17_LIST_RANGE' => 197,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195
		}
	},
	{#State 378
		DEFAULT => -220
	},
	{#State 379
		ACTIONS => {
			"= sub {" => 391
		}
	},
	{#State 380
		ACTIONS => {
			";" => 392
		}
	},
	{#State 381
		DEFAULT => -74
	},
	{#State 382
		ACTIONS => {
			"%{" => 87,
			'WORD' => 315
		},
		GOTOS => {
			'HashDereferenced' => 314,
			'HashEntryTyped' => 393
		}
	},
	{#State 383
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => 197,
			'OP08_STRING_CAT' => 185,
			'OP16_LOGICAL_OR' => 186,
			'OP06_REGEX_MATCH' => 187,
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP15_LOGICAL_AND' => 199,
			'OP21_LIST_COMMA' => -208,
			")" => -208,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP04_MATH_POW' => 190,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP18_TERNARY' => 192
		}
	},
	{#State 384
		DEFAULT => -68
	},
	{#State 385
		DEFAULT => -71
	},
	{#State 386
		ACTIONS => {
			'VARIABLE_SYMBOL' => 394
		}
	},
	{#State 387
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 395
		}
	},
	{#State 388
		ACTIONS => {
			"{" => 287
		},
		GOTOS => {
			'CodeBlock' => 396
		}
	},
	{#State 389
		DEFAULT => -174
	},
	{#State 390
		ACTIONS => {
			"{" => 287
		},
		GOTOS => {
			'CodeBlock' => 397
		}
	},
	{#State 391
		ACTIONS => {
			"%{" => -78,
			"if (" => -78,
			"\@{" => -78,
			'OP22_LOGICAL_NOT' => -78,
			"while (" => -78,
			'OP01_NAMED_VOID' => -78,
			"undef" => -78,
			'OP05_LOGICAL_NEG' => -78,
			'OP03_MATH_INC_DEC' => -78,
			"(" => -78,
			'OP01_NAMED' => -78,
			'LITERAL_NUMBER' => -78,
			"foreach my" => -78,
			'VARIABLE_SYMBOL' => -78,
			'OP01_PRINT_VOID' => -78,
			'OP19_LOOP_CONTROL' => -78,
			'OP01_OPEN_CLOSE' => -78,
			"for my integer" => -78,
			'OP01_OPEN_CLOSE_PAREN' => -78,
			'OP05_MATH_NEG' => -78,
			'OP01_PRINT_VOID_PAREN' => -78,
			'OP10_NAMED_UNARY' => -78,
			"my" => -78,
			'LITERAL_STRING' => -78,
			'WORD' => -78,
			'WORD_SCOPED' => -78,
			"[" => -78,
			'OP10_NAMED_UNARY_STRINGIFY' => -78,
			"( my" => 400,
			'OP01_NAMED_VOID_PAREN' => -78,
			"{" => -78
		},
		GOTOS => {
			'OPTIONAL-32' => 398,
			'MethodArguments' => 399
		}
	},
	{#State 392
		DEFAULT => -76
	},
	{#State 393
		DEFAULT => -73
	},
	{#State 394
		DEFAULT => -47
	},
	{#State 395
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -52,
			"[" => -52,
			'OP01_NAMED_VOID_PAREN' => -52,
			"{" => -52,
			'LITERAL_STRING' => -52,
			"my" => -52,
			'OP10_NAMED_UNARY' => -52,
			'OP01_PRINT_VOID_PAREN' => -52,
			'WORD_SCOPED' => -52,
			'WORD' => -52,
			'VARIABLE_SYMBOL' => -52,
			'OP01_PRINT_VOID' => -52,
			"foreach my" => -52,
			'LITERAL_NUMBER' => -52,
			'OP19_LOOP_CONTROL' => -52,
			"for my integer" => -52,
			'OP01_OPEN_CLOSE' => -52,
			'CHECK_OR_CHECKTRACE' => 401,
			'OP05_MATH_NEG' => -52,
			'OP01_OPEN_CLOSE_PAREN' => -52,
			"if (" => -52,
			"%{" => -52,
			"\@{" => -52,
			'OP05_LOGICAL_NEG' => -52,
			'OP03_MATH_INC_DEC' => -52,
			"undef" => -52,
			"while (" => -52,
			'OP01_NAMED_VOID' => -52,
			'OP22_LOGICAL_NOT' => -52,
			'OP01_NAMED' => -52,
			"(" => -52
		},
		GOTOS => {
			'ArgumentCheck' => 402
		}
	},
	{#State 396
		DEFAULT => -163
	},
	{#State 397
		DEFAULT => -173
	},
	{#State 398
		ACTIONS => {
			"if (" => 86,
			"%{" => 87,
			"\@{" => 88,
			'OP10_NAMED_UNARY' => 117,
			"while (" => -157,
			'OP01_NAMED_VOID' => 95,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_PRINT_VOID_PAREN' => 118,
			'LITERAL_STRING' => 114,
			"my" => 115,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			"undef" => 94,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 122,
			'OP01_NAMED' => 97,
			"foreach my" => -157,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP01_PRINT_VOID' => 77,
			'VARIABLE_SYMBOL' => 78,
			'OP19_LOOP_CONTROL' => 80,
			'OP01_NAMED_VOID_PAREN' => 108,
			'OP01_OPEN_CLOSE' => 82,
			"for my integer" => -157,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111
		},
		GOTOS => {
			'Statement' => 81,
			'OPTIONAL-47' => 107,
			'OperatorVoid' => 112,
			'PAREN-46' => 83,
			'PLUS-33' => 403,
			'Operator' => 109,
			'HashReference' => 110,
			'VariableDeclaration' => 106,
			'Operation' => 404,
			'Conditional' => 121,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayReference' => 103,
			'LoopLabel' => 98,
			'VariableModification' => 119,
			'Expression' => 120,
			'WordScoped' => 90,
			'Variable' => 89
		}
	},
	{#State 399
		DEFAULT => -77
	},
	{#State 400
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 405
		}
	},
	{#State 401
		ACTIONS => {
			"(" => 406
		}
	},
	{#State 402
		DEFAULT => -50
	},
	{#State 403
		ACTIONS => {
			"for my integer" => -157,
			'OP01_OPEN_CLOSE' => 82,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"}" => 408,
			'OP01_PRINT_VOID' => 77,
			'VARIABLE_SYMBOL' => 78,
			"foreach my" => -157,
			'LITERAL_NUMBER' => 79,
			'OP19_LOOP_CONTROL' => 80,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			"undef" => 94,
			'OP01_NAMED_VOID' => 95,
			"while (" => -157,
			'OP22_LOGICAL_NOT' => 96,
			'OP01_NAMED' => 97,
			"(" => 102,
			"if (" => 86,
			"%{" => 87,
			"\@{" => 88,
			'OP01_NAMED_VOID_PAREN' => 108,
			"{" => 111,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			"my" => 115,
			'LITERAL_STRING' => 114,
			'OP10_NAMED_UNARY' => 117,
			'OP01_PRINT_VOID_PAREN' => 118,
			'WORD_SCOPED' => 23,
			'WORD' => 122
		},
		GOTOS => {
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashDereferenced' => 99,
			'Conditional' => 121,
			'ArrayReference' => 103,
			'LoopLabel' => 98,
			'VariableModification' => 119,
			'Expression' => 120,
			'Operation' => 407,
			'WordScoped' => 90,
			'Variable' => 89,
			'OperatorVoid' => 112,
			'Operator' => 109,
			'PAREN-46' => 83,
			'HashReference' => 110,
			'Statement' => 81,
			'OPTIONAL-47' => 107,
			'VariableDeclaration' => 106
		}
	},
	{#State 404
		DEFAULT => -80
	},
	{#State 405
		DEFAULT => -84,
		GOTOS => {
			'STAR-35' => 409
		}
	},
	{#State 406
		ACTIONS => {
			'OP05_MATH_NEG' => 84,
			"{" => 111,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			'OP01_OPEN_CLOSE' => 82,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			'LITERAL_NUMBER' => 79,
			"[" => 105,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 91,
			'LITERAL_STRING' => 114,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			"\@{" => 88,
			"%{" => 87
		},
		GOTOS => {
			'Literal' => 101,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'ArrayReference' => 103,
			'Operator' => 109,
			'Expression' => 410,
			'HashReference' => 110,
			'Variable' => 139,
			'WordScoped' => 90
		}
	},
	{#State 407
		DEFAULT => -79
	},
	{#State 408
		ACTIONS => {
			";" => 411
		}
	},
	{#State 409
		ACTIONS => {
			")" => 412,
			'OP21_LIST_COMMA' => 414
		},
		GOTOS => {
			'PAREN-34' => 413
		}
	},
	{#State 410
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP11_COMPARE_LT_GT' => 200,
			")" => -55,
			'OP15_LOGICAL_AND' => 199,
			'OP21_LIST_COMMA' => 416,
			'OP18_TERNARY' => 192,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP04_MATH_POW' => 190,
			'OP17_LIST_RANGE' => 197,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP13_BITWISE_AND' => 194,
			'OP09_BITWISE_SHIFT' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP23_LOGICAL_AND' => 188,
			'OP16_LOGICAL_OR' => 186,
			'OP06_REGEX_MATCH' => 187,
			'OP08_STRING_CAT' => 185
		},
		GOTOS => {
			'PAREN-21' => 415,
			'OPTIONAL-22' => 417
		}
	},
	{#State 411
		DEFAULT => -81
	},
	{#State 412
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 418
		}
	},
	{#State 413
		DEFAULT => -83
	},
	{#State 414
		ACTIONS => {
			"my" => 419
		}
	},
	{#State 415
		DEFAULT => -54
	},
	{#State 416
		ACTIONS => {
			"\@{" => 88,
			"%{" => 87,
			'OP01_NAMED' => 97,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'VARIABLE_SYMBOL' => 78,
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP01_OPEN_CLOSE' => 82
		},
		GOTOS => {
			'ArrayReference' => 103,
			'HashDereferenced' => 99,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'Expression' => 420,
			'HashReference' => 110,
			'Operator' => 109,
			'Variable' => 139,
			'WordScoped' => 90
		}
	},
	{#State 417
		ACTIONS => {
			")" => 421
		}
	},
	{#State 418
		ACTIONS => {
			"\@_;" => 422
		}
	},
	{#State 419
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 423
		}
	},
	{#State 420
		ACTIONS => {
			'OP04_MATH_POW' => 190,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP18_TERNARY' => 192,
			'OP21_LIST_COMMA' => 424,
			'OP15_LOGICAL_AND' => 199,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP16_LOGICAL_OR' => 186,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194,
			'OP08_MATH_ADD_SUB' => 195,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP17_LIST_RANGE' => 197
		}
	},
	{#State 421
		ACTIONS => {
			";" => 425
		}
	},
	{#State 422
		DEFAULT => -86,
		GOTOS => {
			'STAR-36' => 426
		}
	},
	{#State 423
		ACTIONS => {
			'VARIABLE_SYMBOL' => 427
		}
	},
	{#State 424
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 104,
			"[" => 105,
			'LITERAL_NUMBER' => 79,
			'VARIABLE_SYMBOL' => 78,
			'OP05_MATH_NEG' => 84,
			'OP01_OPEN_CLOSE_PAREN' => 85,
			"{" => 111,
			'OP01_OPEN_CLOSE' => 82,
			"\@{" => 88,
			"%{" => 87,
			'WORD_SCOPED' => 23,
			"(" => 102,
			'WORD' => 24,
			'OP01_NAMED' => 97,
			'OP10_NAMED_UNARY' => 117,
			'OP22_LOGICAL_NOT' => 96,
			'OP05_LOGICAL_NEG' => 91,
			'OP03_MATH_INC_DEC' => 92,
			'LITERAL_STRING' => 114,
			"undef" => 94
		},
		GOTOS => {
			'WordScoped' => 90,
			'Variable' => 139,
			'ArrayReference' => 103,
			'HashDereferenced' => 99,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'Expression' => 428,
			'HashReference' => 110,
			'Operator' => 109
		}
	},
	{#State 425
		DEFAULT => -56
	},
	{#State 426
		ACTIONS => {
			'OP01_NAMED' => -87,
			"(" => -87,
			"undef" => -87,
			'OP05_LOGICAL_NEG' => -87,
			'OP03_MATH_INC_DEC' => -87,
			'OP22_LOGICAL_NOT' => -87,
			'OP01_NAMED_VOID' => -87,
			"while (" => -87,
			"\@{" => -87,
			"%{" => -87,
			"if (" => -87,
			'OP01_OPEN_CLOSE_PAREN' => -87,
			'OP05_MATH_NEG' => -87,
			"for my integer" => -87,
			'CHECK_OR_CHECKTRACE' => 401,
			'OP01_OPEN_CLOSE' => -87,
			'OP19_LOOP_CONTROL' => -87,
			'OP01_PRINT_VOID' => -87,
			'VARIABLE_SYMBOL' => -87,
			'LITERAL_NUMBER' => -87,
			"foreach my" => -87,
			'WORD' => -87,
			'WORD_SCOPED' => -87,
			"my" => -87,
			'LITERAL_STRING' => -87,
			'OP01_PRINT_VOID_PAREN' => -87,
			'OP10_NAMED_UNARY' => -87,
			"{" => -87,
			'OP01_NAMED_VOID_PAREN' => -87,
			"[" => -87,
			'OP10_NAMED_UNARY_STRINGIFY' => -87
		},
		GOTOS => {
			'ArgumentCheck' => 429
		}
	},
	{#State 427
		DEFAULT => -82
	},
	{#State 428
		ACTIONS => {
			'OP23_LOGICAL_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 193,
			'OP16_LOGICAL_OR' => 186,
			'OP08_STRING_CAT' => 185,
			'OP06_REGEX_MATCH' => 187,
			'OP12_COMPARE_EQ_NEQ' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP17_LIST_RANGE' => 197,
			'OP09_BITWISE_SHIFT' => 189,
			'OP13_BITWISE_AND' => 194,
			'OP14_BITWISE_OR_XOR' => 198,
			'OP18_TERNARY' => 192,
			'OP04_MATH_POW' => 190,
			'OP11_COMPARE_LT_GT' => 200,
			'OP24_LOGICAL_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 199,
			")" => -53
		}
	},
	{#State 429
		DEFAULT => -85
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5852 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5859 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5866 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 118 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5873 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5884 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5895 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5902 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5909 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5923 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5930 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5937 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5944 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5951 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5958 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5965 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5972 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 119 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5979 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5990 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5997 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6015 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6026 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6037 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6044 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6051 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6058 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6065 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6086 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6093 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6104 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6115 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6122 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6129 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6140 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6147 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6154 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6176 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6187 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6194 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6201 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6208 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6215 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6233 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6240 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6247 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6254 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6261 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6272 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-21', 4,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6279 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6286 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6293 lib/RPerl/Grammar.pm
	],
	[#Rule ArgumentCheck_56
		 'ArgumentCheck', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6304 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6311 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6318 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6325 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6332 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6339 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6346 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6353 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6360 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6367 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6374 lib/RPerl/Grammar.pm
	],
	[#Rule Class_67
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6385 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6392 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6399 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6406 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_71
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6417 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_72
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6428 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6442 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6449 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_76
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6460 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6467 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6474 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-33', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6481 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-33', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule Method_81
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 4,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6506 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6520 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6527 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6534 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_87
		 'MethodArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_88
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6556 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_89
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_90
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_91
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6596 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6603 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6610 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6617 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6624 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6631 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6642 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6653 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6664 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6675 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6686 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6697 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6708 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6719 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6752 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6763 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6774 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6785 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6796 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6840 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6862 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6873 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6884 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6895 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6906 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6917 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6924 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6931 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6938 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6945 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6952 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_132
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6984 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_133
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_134
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7006 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7017 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7028 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7035 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7042 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7049 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7056 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_141
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7067 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_142
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_143
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7089 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_144
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_145
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_146
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_147
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7133 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_148
		 'Expression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7144 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7155 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7177 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_153
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule ExpressionOrStdin_154
		 'ExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7210 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7217 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7224 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7231 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_158
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_159
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7253 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_160
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_161
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7275 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_162
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7286 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 4,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7293 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7300 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7307 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-50', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7314 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7321 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_169
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_170
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_171
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_172
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_173
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_174
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_175
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7405 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7412 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7419 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_178
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7430 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-53', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_181
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7455 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_182
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7466 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_183
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7477 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_184
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_185
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7499 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_186
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7510 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_187
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_188
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-54', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7539 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-55', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-55', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7553 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-56', 2,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7560 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-56', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7567 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_194
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7578 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_195
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7589 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_196
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7600 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_197
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7611 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_198
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7622 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7636 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_201
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7647 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_202
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7658 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_203
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7669 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7676 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7683 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_206
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7694 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_207
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_208
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7716 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_209
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7727 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-59', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7734 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-60', 2,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7741 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-60', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7748 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_213
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7759 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_214
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7770 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_215
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7781 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_216
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7792 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_217
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7803 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_218
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7814 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7825 lib/RPerl/Grammar.pm
	],
	[#Rule TypeMethod_220
		 'TypeMethod', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7836 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_221
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7847 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_222
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7858 lib/RPerl/Grammar.pm
	],
	[#Rule FileHandle_223
		 'FileHandle', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7869 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_224
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7880 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_225
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7891 lib/RPerl/Grammar.pm
	]
],
#line 7894 lib/RPerl/Grammar.pm
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
         '_PAREN', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CompileUnit_4', 
         'CompileUnit_5', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         'Program_18', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ModuleHeader_21', 
         'Module_22', 
         'Module_23', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Package_32', 
         'Header_33', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Critic_36', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Include_39', 
         'Include_40', 
         'Constant_41', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Subroutine_46', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_52', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArgumentCheck_56', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Class_67', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_71', 
         'Properties_72', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'PropertiesClass_76', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Method_81', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_87', 
         'MethodOrSubroutine_88', 
         'MethodOrSubroutine_89', 
         'Operation_90', 
         'Operation_91', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
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
         'Operator_121', 
         'Operator_122', 
         'Operator_123', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_132', 
         'OperatorVoid_133', 
         'OperatorVoid_134', 
         'OperatorVoid_135', 
         'OperatorVoid_136', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_141', 
         'Expression_142', 
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
         'ExpressionOrStdin_153', 
         'ExpressionOrStdin_154', 
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
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_194', 
         'ListElements_195', 
         'ListElement_196', 
         'ListElement_197', 
         'ListElement_198', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_201', 
         'ArrayDereferenced_202', 
         'ArrayDereferenced_203', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_206', 
         'HashEntry_207', 
         'HashEntryTyped_208', 
         'HashEntryTyped_209', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_213', 
         'HashDereferenced_214', 
         'HashDereferenced_215', 
         'WordScoped_216', 
         'WordScoped_217', 
         'LoopLabel_218', 
         'Type_219', 
         'TypeMethod_220', 
         'TypeInner_221', 
         'FileHandle_222', 
         'FileHandle_223', 
         'Literal_224', 
         'Literal_225', );
  $self;
}

#line 184 "lib/RPerl/Grammar.eyp"


{
# Rules from Grammar.output
# NEED FIX: UPDATE!?!
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


#line 8168 lib/RPerl/Grammar.pm



1;
